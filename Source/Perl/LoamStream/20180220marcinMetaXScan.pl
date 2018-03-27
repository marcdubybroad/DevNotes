#!/usr/bin/perl -w

#set up the parameters

$WHAT2DO = "LOAMSTREAM";

$inputFileNamesRegEx   = "*.txt.gz";
$inputFileNamesDir     = "/humgen/diabetes2/users/mvg/portal/scripts/GENES/MetaXcan/inputs";
$resultsMetaXcanDir    = "/humgen/diabetes2/users/mvg/portal/scripts/GENES/MetaXcan/results";
$pathToMetaXcan        = "/humgen/diabetes2/users/mvg/portal/MetaXcan/software/MetaXcan.py";
$MetaXcanDBFilesDir    = "/humgen/diabetes2/users/mvg/portal/MetaXcan/GTEx-V7_HapMap-2017-11-29";
$MetaXcanDBFilesPrefix = "gtex_v7_";
$genesModelsPostfix    = "_imputed_europeans_tw_0.5_signif.db";
$covariancesPostfix    = "_imputed_eur_covariances.txt.gz"; 


#read the list of user input file names
open(IN,"ls $inputFileNamesDir/$inputFileNamesRegEx |") || die "Cannot read input file names list\n";
while(<IN>) {
	chomp;
	s/^$inputFileNamesDir\/// || die "Something is not right !!!";
	push @inputFileNames, $_;
	s/\.txt\.gz$//            || die "Something is not right !!!";
	push @outputFileNamePrefix, $_;
}

#read the list of MetaXcan inout fle names
open(IN,"ls $MetaXcanDBFilesDir/$MetaXcanDBFilesPrefix*$genesModelsPostfix |") || die "Cannot read genes models file names list\n";
while(<IN>) {
	chomp;
	push @geneModelsFileNames, $_;
	s/$genesModelsPostfix$/$covariancesPostfix/ || die "Something is not right !!!";
	die "Covariance file does not exists: $_"   if ! -e $_;
	push @covariancesFileNames, $_;
	s/^$MetaXcanDBFilesDir\///                  || die "Something is not right !!!";
	s/$covariancesPostfix$//                    || die "Something is not right !!!";
	s/^$MetaXcanDBFilesPrefix//                 || die "Something is not right !!!";
	push @outputFileNamePostfix, $_; 
}

#generate the list of commands/jobs to be run
for($i = 0; $i < @inputFileNames; $i++) {

	$inputFileName        = $inputFileNames[$i];
	$outputFileNamePrefix = $outputFileNamePrefix[$i];
	$outputDir            = "$resultsMetaXcanDir/$outputFileNamePrefix";
	$runLogDir            = "$resultsMetaXcanDir/$outputFileNamePrefix/logs";

	if(!-e $outputDir) { system "mkdir $outputDir" || die "Uncable to create $outputDir DIR\n" } elsif(! -d $outputDir){ die "$outputDir IS NOT DIR\n" }
	if(!-e $runLogDir) { system "mkdir $runLogDir" || die "Uncable to create $runLogDir DIR\n" } elsif(! -d $runLogDir){ die "$runLogDir IS NOT DIR\n" }

	for($j = 0; $j < @geneModelsFileNames; $j++) {
		
		$outFileName = "$outputFileNamePrefix.$outputFileNamePostfix[$j].csv";
		$logFileName = "$outputFileNamePrefix.$outputFileNamePostfix[$j].log";
		

		$job = "$pathToMetaXcan".
		       " --model_db_path $geneModelsFileNames[$j] --covariance $covariancesFileNames[$j]".
		       " --gwas_folder $inputFileNamesDir --gwas_file_pattern $inputFileName".
		       " --snp_column rsID --effect_allele_column ALT --non_effect_allele_column REF --beta_column BETA --pvalue_column PVALUE".
		       " --output_file $outputDir/$outFileName 2> $runLogDir/$logFileName";

		if($WHAT2DO eq "LOAMSTREAM") {
			print "cmd\"$job\"\n";
		}
		elsif($WHAT2DO eq "RUNME") {
			next if -e "$outputDir/$outFileName";
			push @jobs, $job;
		}
		else { 
			die "Unknown WHAT2DO: $WHAT2DO\n";  
		}
	}
}

exit if $WHAT2DO ne "RUNME";

#run all of the jobs
use POSIX ":sys_wait_h";
my $maxThreads=24;

my$i;
my @pid;
for($i=0;$i<$maxThreads&& $i<@jobs;$i++) {
	push @pid, fork() || exec($jobs[$i]);
	sleep(1);
}

while($i<@jobs) {
	for(my $j=0;$j<@pid && $i<@jobs;$j++) {
		if(waitpid($pid[$j],WNOHANG)<0) {
			$pid[$j] = fork() || exec($jobs[$i]);
			$i++;
		}
	}
	sleep(3);
}

for($i=0;$i<@pid;) {
	if(waitpid($pid[$i],WNOHANG)<0) { $i++ }
	else { sleep(3) }
}