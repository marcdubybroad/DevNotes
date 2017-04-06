

SELECT COUNT(*)
FROM common_dv1 LEFT JOIN ExChip_82k_dv1__T2D ON common_dv1.VAR_ID = ExChip_82k_dv1__T2D.VAR_ID
WHERE common_dv1.MOST_DEL_SCORE <4 AND ExChip_82k_dv1__T2D.P_VALUE <0.000050 AND common_dv1.GENE = 'HDAC9' LIMIT 1000;

SELECT COUNT(*)
FROM common_dv1 LEFT JOIN ExChip_82k_dv1__T2D ON common_dv1.VAR_ID = ExChip_82k_dv1__T2D.VAR_ID
WHERE common_dv1.MOST_DEL_SCORE <4 AND ExChip_82k_dv1__T2D.P_VALUE <0.1 AND common_dv1.GENE = 'HDAC9' LIMIT 1000;


SELECT COUNT(*)
FROM common_dv1 LEFT JOIN ExChip_82k_dv1__T2D ON common_dv1.VAR_ID = ExChip_82k_dv1__T2D.VAR_ID
WHERE common_dv1.GENE = 'HDAC9' LIMIT 1000;


select count(com.var_id), com.closest_gene
from common_dv1 com, gwas_sigma1_dv1 diag
where com.var_id = diag.var_id
group by com.closest_gene;


select count(com.var_id), com.closest_gene
from common_dv1 com, ExSeq_39k_dv9 diag
where com.var_id = diag.var_id
group by com.closest_gene;





Jason Flannick
Mar-15 10:03 AM
Gocha: 774
Europe: 1058
Gerhfs: 1201
Race: 5463
Malmo: 571
Total: 9067



update DATASET set SUBJECTS = 774 where ID = 'GWAS_Stroke_gocha_mdv5';
update DATASET set SUBJECTS = 1058 where ID = 'GWAS_Stroke_europe_mdv5';
update DATASET set SUBJECTS = 1201 where ID = 'GWAS_Stroke_gerfhs_mdv5';
update DATASET set SUBJECTS = 5463 where ID = 'GWAS_Stroke_race_mdv5';
update DATASET set SUBJECTS = 571 where ID = 'GWAS_Stroke_malmo_mdv5';
update DATASET set SUBJECTS = 9067 where ID = 'GWAS_Stroke_mdv5';



-- changes requested 20160420
update DATASET set SUBJECTS = 773 where ID = 'GWAS_Stroke_gocha_mdv5';
update DATASET set SUBJECTS = 967 where ID = 'GWAS_Stroke_europe_mdv5';
update DATASET set SUBJECTS = 1336 where ID = 'GWAS_Stroke_gerfhs_mdv5';
update DATASET set SUBJECTS = 3076 where ID = 'GWAS_Stroke_mdv5';

