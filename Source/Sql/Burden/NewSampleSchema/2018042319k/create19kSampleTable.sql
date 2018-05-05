
-- smaller table
drop table if exists SAMPLE_19k_20180423_with_adj;
create table SAMPLE_19k_20180423_with_adj AS
select ID,
  t2d,
  T2D_readable,
  SEX,
  SEX_readable,
  Age,
  DBP_ANAL as DBP_ADJ,
  DBP,
  SBP_ANAL as SBP_ADJ,
  SBP,
  FAST_GLU_ANAL as FAST_GLU_ADJ,
  FAST_GLU as FAST_GLU,
  FAST_INS_ANAL as FAST_INS_ADJ,
  FAST_INS as FAST_INS,
  HDL_ANAL AS HDL_ADJ,
  HDL,
  LDL_ANAL as LDL_ADJ,
  LDL,
  CHOL_ANAL as CHOL_ADJ,
  CHOL,
  TG_ANAL as TG_ADJ,
  TG,
  BMI,
  origin,
  C1 as C1, C2 as C2, C3 as C3, C4 as C4, C5 as C5, C6 as C6, C7 as C7, C8 as C8, C9 as C9, C10 as C10
from SAMPLE_19k;


