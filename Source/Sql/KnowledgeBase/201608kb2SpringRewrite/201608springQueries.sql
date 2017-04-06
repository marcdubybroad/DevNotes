
-- current KB 1.0 query
SELECT common_dv1.CHROM AS CHROM_common_dv1,
    common_dv1.CLOSEST_GENE AS CLOSEST_GENE_common_dv1, common_dv1.Consequence AS Consequence_common_dv1,
    common_dv1.DBSNP_ID AS DBSNP_ID_common_dv1, common_dv1.POS AS POS_common_dv1, common_dv1.VAR_ID AS VAR_ID_common_dv1,
    ExSeq_17k_dv2.MAC AS MAC_ExSeq_17k_dv2, ExSeq_17k_dv2__T2D.P_FIRTH_FE_IV AS P_FIRTH_FE_IV_ExSeq_17k_dv2__T2D,
    ExSeq_17k_dv2__T2D.OR_FIRTH_FE_IV AS OR_FIRTH_FE_IV_ExSeq_17k_dv2__T2D, ExSeq_17k_dv2__T2D.MINA AS MINA_ExSeq_17k_dv2__T2D,
    ExSeq_17k_dv2__T2D.MINU AS MINU_ExSeq_17k_dv2__T2D
FROM common_dv1
    LEFT JOIN ExSeq_17k_dv2 ON common_dv1.VAR_ID = ExSeq_17k_dv2.VAR_ID
    LEFT JOIN ExSeq_17k_dv2__T2D ON common_dv1.VAR_ID = ExSeq_17k_dv2__T2D.VAR_ID
WHERE ExSeq_17k_dv2.MAC >5 AND ExSeq_17k_dv2__T2D.P_FIRTH_FE_IV <0.0001 AND common_dv1.MOST_DEL_SCORE =2 LIMIT 1000

SELECT common_dv1.CHROM AS CHROM_common_dv1, common_dv1.CLOSEST_GENE AS CLOSEST_GENE_common_dv1, common_dv1.Consequence AS Consequence_common_dv1,
    common_dv1.DBSNP_ID AS DBSNP_ID_common_dv1, common_dv1.POS AS POS_common_dv1, common_dv1.VAR_ID AS VAR_ID_common_dv1,
    ExSeq_17k_dv2.MAC AS MAC_ExSeq_17k_dv2, ExSeq_17k_dv2__T2D.P_FIRTH_FE_IV AS P_FIRTH_FE_IV_ExSeq_17k_dv2__T2D,
    ExSeq_17k_dv2__T2D.OR_FIRTH_FE_IV AS OR_FIRTH_FE_IV_ExSeq_17k_dv2__T2D, ExSeq_17k_dv2__T2D.MINA AS MINA_ExSeq_17k_dv2__T2D,
    ExSeq_17k_dv2__T2D.MINU AS MINU_ExSeq_17k_dv2__T2D, GWAS_DIAGRAM_dv2__T2D.DIR AS DIR_GWAS_DIAGRAM_dv2__T2D
FROM common_dv1
    LEFT JOIN GWAS_DIAGRAM_dv2__T2D ON common_dv1.VAR_ID = GWAS_DIAGRAM_dv2__T2D.VAR_ID
    LEFT JOIN ExSeq_17k_dv2 ON common_dv1.VAR_ID = ExSeq_17k_dv2.VAR_ID
    LEFT JOIN ExSeq_17k_dv2__T2D ON common_dv1.VAR_ID = ExSeq_17k_dv2__T2D.VAR_ID
WHERE ExSeq_17k_dv2.MAC >5 AND ExSeq_17k_dv2__T2D.P_FIRTH_FE_IV <0.0001 AND common_dv1.MOST_DEL_SCORE =2 LIMIT 1000

