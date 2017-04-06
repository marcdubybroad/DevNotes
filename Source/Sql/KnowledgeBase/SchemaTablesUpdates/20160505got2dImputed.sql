

-- update the got2d inputed to gwas type
update DATASET set TECH = 'GWAS' where EXP = 'WGS_GoT2Dimputed';

-- change the got2d subjects
update DATASET set SUBJECTS = 47071 where EXP = 'WGS_GoT2Dimputed';


