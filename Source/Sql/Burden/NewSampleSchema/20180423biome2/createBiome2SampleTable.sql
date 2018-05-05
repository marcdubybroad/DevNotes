
-- smaller table
drop table if exists SAMPLE_biome_20180423_with_adj;
create table SAMPLE_biome_20180423_with_adj AS
select ID,
  (T2D_OTHER + 1) as t2d,
  if((T2D_OTHER = 0), 'No', if((T2D_OTHER = 1), 'Yes', 'NA')) as T2D_readable,
  SEX,
  if((SEX = 1), 'Male', if((SEX = 2), 'Female', 'NA')) as SEX_readable,
  (2016 - YOB) as Age,
  DBP10 as DBP_ADJ,
  DBP,
  SBP15 as SBP_ADJ,
  SBP,
  GLU_FAST_invn_AGE_GLU_INS_FAST_SEX as FAST_GLU_ADJ,
  GLU_FAST as FAST_GLU,
--   INS_FAST_invn_Age as FAST_INS_ADJ,
--   INS_FAST as FAST_INS,
  HBA1C_invn_AGE_HBA1C_SEX as HBA1C_ADJ,
  HBA1C,
  HDL_invn_AGE_LIPIDS_AGE_LIPIDS2_SEX AS HDL_ADJ,
  HDL,
  LDL_DIRECT_invn_AGE_LIPIDS_AGE_LIPIDS2_SEX as LDL_ADJ,
  LDL_DIRECT as LDL,
  BMI_strat_invn_AGE_ANTHRO_AGE_ANTHRO2_SEX as BMI_ADJ,
  BMI,
  eGFR_invn_PC1_PC2_PC3_PC4 as eGFR_ADJ,
  eGFR,
  SERUM_CREATININE_invn_AGE_SERUM_CREATININE_SEX as SERUM_CREATININE_ADJ,
  SERUM_CREATININE,
  CHOL,
  TG,
  HEIGHT_CM,
  WEIGHT_KG,
  ANCESTRY_INFERRED as ANCESTRY,
  CASE ANCESTRY_INFERRED WHEN 'EUR' THEN 'European' WHEN 'AFR' THEN 'African-American' WHEN 'AMR' THEN 'Hispanic' WHEN 'EAS' THEN 'East-Asian' WHEN 'SAS' THEN 'South-Asian' ELSE 'Other' END as origin,
  PC1 as C1, PC2 as C2, PC3 as C3, PC4 as C4, PC5 as C5, PC6 as C6, PC7 as C7, PC8 as C8, PC9 as C9, PC10 as C10
from biome2New;



