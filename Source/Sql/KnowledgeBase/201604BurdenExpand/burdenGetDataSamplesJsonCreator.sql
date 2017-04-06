


select
concat('[{ "ID": { "SAMPLES_13k_mdv2": "', ifnull(ID, 'null'), '"}},') as id,
concat('{ "ANCESTRY": { "SAMPLES_13k_mdv2": "', ifnull(ANCESTRY, 'null'), '"}},') as ancestry,
concat('{ "T2D": { "SAMPLES_13k_mdv2": ', ifnull(T2D, 'null'), '}},') as t2d,
concat('{ "AGE": { "SAMPLES_13k_mdv2": ', ifnull(AGE, 'null'), '}},') as age,
concat('{ "FAST_GLU": { "SAMPLES_13k_mdv2": ', ifnull(FAST_GLU, 'null'), '}},') as fast_glu,
concat('{ "FAST_INS": { "SAMPLES_13k_mdv2": ', ifnull(FAST_INS, 'null'), '}},') as fast_ins,
concat('{ "BMI": { "SAMPLES_13k_mdv2": ', ifnull(BMI, 'null'), '}},') as bmi,
concat('', '{ "WEIGHT": { "SAMPLES_13k_mdv2": ', ifnull(WEIGHT, 'null'), '}},') as weight,
concat('', '{ "HDL": { "SAMPLES_13k_mdv2": ', ifnull(HDL, 'null'), '}},') as hdl,
concat('', '{ "LDL": { "SAMPLES_13k_mdv2": ', ifnull(LDL, 'null'), '}}],') as ldl
from SAMPLE_13k 
limit 1000;




--  where BMI != null and HDL != null and LDL != null
--  '{ "BMI": { "SAMPLES_13k_mdv2": ' | BMI | '}},'
--  {
--    "MAF": {
--        "SAMPLES_13k_mdv2": 0.127025738798856
--    }
-- },




 