insert into variant (var_id, var_id_first_characters, db_snp_id, db_snp_id_first_characters, position, chromosome, version) select var_id, substring(var_id, 1, 5), dbsnp_id, substring(dbsnp_id, 1, 4), pos, chrom, 0 from common_dv1 where pos is not null and chrom is not null and length(var_id) < 758;


