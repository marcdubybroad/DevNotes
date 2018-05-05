
-- smaller table
drop table if exists SAMPLE_metsim_20180419_with_adj;
create table SAMPLE_metsim_20180419_with_adj AS
select ID,
  (T2D_UNKNOWN + 1) as t2d,
  if((T2D_UNKNOWN = 0), 'No', if((T2D_UNKNOWN = 1), 'Yes', null)) as T2D_readable,
  SEX,
  if((SEX = 1), 'Male', if((SEX = 2), 'Female', 'NA')) as SEX_readable,
  Age,
  DBP10 as DBP_ADJ,
  DBP,
  SBP15 as SBP_ADJ,
  SBP,
  GLU_FAST_invn_Age as FAST_GLU_ADJ,
  GLU_FAST as FAST_GLU,
  INS_FAST_invn_Age as FAST_INS_ADJ,
  INS_FAST as FAST_INS,
  HBA1C_invn_Age as HBA1C_ADJ,
  HBA1C,
  HDL_invn_Age_Age2 AS HDL_ADJ,
  HDL,
  LDL_DIRECT_invn_Age_Age2 as LDL_ADJ,
  LDL_DIRECT as LDL,
  BMI_invn_Age_Age2 as BMI_ADJ,
  BMI,
  eGFR_invn_PC1_PC2_PC3_PC4 as eGFR_ADJ,
  eGFR,
  SERUM_CREATININE_invn_Age as SERUM_CREATININE_ADJ,
  SERUM_CREATININE,
  CHOL,
  TG,
  HEIGHT_CM,
  WEIGHT_KG,
  ANCESTRY_INFERRED as ANCESTRY,
  CASE ANCESTRY_INFERRED WHEN 'EUR' THEN 'European' WHEN 'AFR' THEN 'African-American' WHEN 'AMR' THEN 'Hispanic' WHEN 'EAS' THEN 'East-Asian' WHEN 'SAS' THEN 'South-Asian' ELSE 'Other' END as origin,
  PC1 as C1, PC2 as C2, PC3 as C3, PC4 as C4, PC5 as C5, PC6 as C6, PC7 as C7, PC8 as C8, PC9 as C9, PC10 as C10
from metsim3;



