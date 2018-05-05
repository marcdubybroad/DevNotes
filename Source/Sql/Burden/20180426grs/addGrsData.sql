
-- select phenotypes
select * from SAMPLES_PROP where PROP in
  ('t2d', 'SEX', 'Age', 'T2D_readable', 'SEX_readable',
  'BMI', 'DBP', 'SBP', 'FAST_GLU', 'FAST_INS', 'HBA1C', 'HDL', 'LDL', 'eGFR', 'CHOL', 'TG',
  'BMI_ADJ', 'DBP_ADJ', 'SBP_ADJ', 'FAST_GLU_ADJ', 'FAST_INS_ADJ', 'HBA1C_ADJ', 'HDL_ADJ', 'LDL_ADJ', 'eGFR_ADJ', 'CHOL_ADJ', 'TG_ADJ',
  'SERUM_CREATININE', 'HEIGHT_CM', 'WEIGHT_KG', 'origin',
  'C1', 'C2', 'C3', 'C4', 'C5', 'C6') order by PROP;

-- should be 34 rows




-- add new adjusted properties
insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('BMI_ADJ', 'BMI_ADJ', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'COVARIATE,PHENOTYPE');
insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('DBP_ADJ', 'DBP_ADJ', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'COVARIATE,PHENOTYPE');
insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('SBP_ADJ', 'SBP_ADJ', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'COVARIATE,PHENOTYPE');
insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('FAST_GLU_ADJ', 'FAST_GLU_ADJ', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'COVARIATE,PHENOTYPE');
insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('FAST_INS_ADJ', 'FAST_INS_ADJ', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'COVARIATE,PHENOTYPE');
insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('HBA1C_ADJ', 'HBA1C_ADJ', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'COVARIATE,PHENOTYPE');
insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('HDL_ADJ', 'HDL_ADJ', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'COVARIATE,PHENOTYPE');
insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('LDL_ADJ', 'LDL_ADJ', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'COVARIATE,PHENOTYPE');
insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('eGFR_ADJ', 'eGFR_ADJ', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'COVARIATE,PHENOTYPE');
insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('CHOL_ADJ', 'CHOL_ADJ', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'COVARIATE,PHENOTYPE');
insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('TG_ADJ', 'TG_ADJ', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'COVARIATE,PHENOTYPE');

insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
values('WEIGHT_KG', 'WEIGHT_KG', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'FILTER');
-- insert into SAMPLES_PROP (PROP, DB_COL, COM_DS, COM_PH, PROP_TYPE, SEARCHABLE, DISPLAYABLE, SORT, MEANING)
-- values('SERUM_CREATININE', 'SERUM_CREATININE', 'FALSE', 'TRUE', 'FLOAT', 'TRUE', 'TRUE', 60, 'FILTER');


-- update properties that are mischaracterized
update SAMPLES_PROP set MEANING = 'FILTER' where PROP in ('BMI', 'BMI', 'DBP', 'SBP', 'FAST_GLU', 'FAST_INS', 'HBA1C', 'HDL', 'LDL', 'eGFR', 'CHOL', 'TG', 'SERUM_CREATININE', 'HEIGHT_CM');



-- add phenotypes to camp GRS
insert into SAMPLES_DATASET (ID, EXP, SG, VER, PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS, MEANING)
values('camp_grs_dv1', 'ExChip_camp', 'camp', 'mdv31', 'Root', 'Mixed', 'ExChip', 'SAMPLE_camp_20180426_with_adj', 70, 563, 3065, 3662, 'GRS');

delete from SAMPLES_PROP_ID where ID = 'camp_grs_dv1';
insert into SAMPLES_PROP_ID (ID, PROP)
select 'camp_grs_dv1', PROP from SAMPLES_PROP
where PROP in
  ('ID', 't2d', 'SEX', 'T2D_readable', 'SEX_readable', 'Age',
  'BMI', 'DBP', 'SBP', 'FAST_GLU', 'FAST_INS', 'HBA1C', 'HDL', 'LDL',
  'BMI_ADJ', 'DBP_ADJ', 'SBP_ADJ', 'FAST_GLU_ADJ', 'FAST_INS_ADJ', 'HBA1C_ADJ', 'HDL_ADJ', 'LDL_ADJ',
  'HEIGHT_CM', 'WEIGHT_KG', 'origin', 'CHOL', 'TG',
  'C1', 'C2', 'C3', 'C4', 'C5', 'C6') order by PROP;


-- add phenotypes to biome GRS
insert into SAMPLES_DATASET (ID, EXP, SG, VER, PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS, MEANING)
values('biome_grs_dv1', 'ExChip_biome', 'BioMe', 'mdv31', 'Root', 'Mixed', 'ExChip', 'SAMPLE_biome_20180423_with_adj', 70, 2951, 7403, 10354, 'GRS');

delete from SAMPLES_PROP_ID where ID = 'biome_grs_dv1';
insert into SAMPLES_PROP_ID (ID, PROP)
select 'biome_grs_dv1', PROP from SAMPLES_PROP
where PROP in
  ('ID', 't2d', 'SEX', 'T2D_readable', 'SEX_readable', 'Age',
  'BMI', 'DBP', 'SBP', 'FAST_GLU', 'HBA1C', 'HDL', 'LDL', 'eGFR',
  'BMI_ADJ', 'DBP_ADJ', 'SBP_ADJ', 'FAST_GLU_ADJ', 'HBA1C_ADJ', 'HDL_ADJ', 'LDL_ADJ', 'eGFR_ADJ',
  'SERUM_CREATININE', 'HEIGHT_CM', 'WEIGHT_KG', 'origin','CHOL', 'TG',
  'C1', 'C2', 'C3', 'C4', 'C5', 'C6') order by PROP;


-- add phenotypes to metsim GRS
insert into SAMPLES_DATASET (ID, EXP, SG, VER, PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS, MEANING)
values('metsim_grs_dv1', 'GWAS_metsim', 'Metsim', 'mdv31', 'Root', 'Mixed', 'GWAD', 'SAMPLE_metsim_20180419_with_adj', 70, 1202, 7589, 8791, 'GRS');

delete from SAMPLES_PROP_ID where ID = 'metsim_grs_dv1';
insert into SAMPLES_PROP_ID (ID, PROP)
select 'metsim_grs_dv1', PROP from SAMPLES_PROP
where PROP in
  ('ID', 't2d', 'SEX', 'T2D_readable', 'SEX_readable', 'Age',
  'BMI', 'DBP', 'SBP', 'FAST_GLU', 'FAST_INS', 'HBA1C', 'HDL', 'LDL', 'eGFR',
  'BMI_ADJ', 'DBP_ADJ', 'SBP_ADJ', 'FAST_GLU_ADJ', 'FAST_INS_ADJ', 'HBA1C_ADJ', 'HDL_ADJ', 'LDL_ADJ', 'eGFR_ADJ',
  'SERUM_CREATININE', 'HEIGHT_CM', 'WEIGHT_KG', 'origin','CHOL', 'TG',
  'C1', 'C2', 'C3', 'C4', 'C5', 'C6') order by PROP;


-- update phenotypes to 19k mdv31
update SAMPLES_DATASET set TBL = 'SAMPLE_19k_20180423_with_adj' where ID = 'samples_19k_mdv31';

delete from SAMPLES_PROP_ID where ID = 'samples_19k_mdv31';
insert into SAMPLES_PROP_ID (ID, PROP)
select 'samples_19k_mdv31', PROP from SAMPLES_PROP
where PROP in
  ('ID', 't2d', 'SEX', 'T2D_readable', 'SEX_readable',
  'DBP', 'SBP', 'FAST_GLU', 'FAST_INS', 'HDL', 'LDL', 'CHOL', 'TG',
  'DBP_ADJ', 'SBP_ADJ', 'FAST_GLU_ADJ', 'FAST_INS_ADJ', 'HDL_ADJ', 'LDL_ADJ', 'CHOL_ADJ', 'TG_ADJ',
  'BMI', 'origin',
  'C1', 'C2', 'C3', 'C4', 'C5', 'C6') order by PROP;


-- update phenotypes for camp mdv31
update SAMPLES_DATASET set TBL = 'SAMPLE_camp_20180426_with_adj' where ID = 'samples_camp_mdv31';

delete from SAMPLES_PROP_ID where ID = 'samples_camp_mdv31';
insert into SAMPLES_PROP_ID (ID, PROP)
select 'samples_camp_mdv31', PROP from SAMPLES_PROP``
where PROP in
  ('ID', 't2d', 'SEX', 'T2D_readable', 'SEX_readable', 'Age',
  'BMI', 'DBP', 'SBP', 'FAST_GLU', 'FAST_INS', 'HBA1C', 'HDL', 'LDL',
  'BMI_ADJ', 'DBP_ADJ', 'SBP_ADJ', 'FAST_GLU_ADJ', 'FAST_INS_ADJ', 'HBA1C_ADJ', 'HDL_ADJ', 'LDL_ADJ',
  'HEIGHT_CM', 'WEIGHT_KG', 'origin', 'CHOL', 'TG',
  'C1', 'C2', 'C3', 'C4', 'C5', 'C6') order by PROP;


-- update phenotypes for biome mdv31
update SAMPLES_DATASET set TBL = 'SAMPLE_biome_20180423_with_adj' where ID = 'samples_biome_mdv31';

delete from SAMPLES_PROP_ID where ID = 'samples_biome_mdv31';
insert into SAMPLES_PROP_ID (ID, PROP)
select 'samples_biome_mdv31', PROP from SAMPLES_PROP
where PROP in
  ('ID', 't2d', 'SEX', 'T2D_readable', 'SEX_readable', 'Age',
  'BMI', 'DBP', 'SBP', 'FAST_GLU', 'HBA1C', 'HDL', 'LDL', 'eGFR',
  'BMI_ADJ', 'DBP_ADJ', 'SBP_ADJ', 'FAST_GLU_ADJ', 'HBA1C_ADJ', 'HDL_ADJ', 'LDL_ADJ', 'eGFR_ADJ',
  'SERUM_CREATININE', 'HEIGHT_CM', 'WEIGHT_KG', 'origin','CHOL', 'TG',
  'C1', 'C2', 'C3', 'C4', 'C5', 'C6') order by PROP;


-- update phenotypes for metsim mdv31
update SAMPLES_DATASET set TBL = 'SAMPLE_metsim_20180419_with_adj' where ID = 'samples_metsim_mdv31';

delete from SAMPLES_PROP_ID where ID = 'samples_metsim_mdv31';
insert into SAMPLES_PROP_ID (ID, PROP)
select 'samples_metsim_mdv31', PROP from SAMPLES_PROP
where PROP in
  ('ID', 't2d', 'SEX', 'T2D_readable', 'SEX_readable', 'Age',
  'BMI', 'DBP', 'SBP', 'FAST_GLU', 'FAST_INS', 'HBA1C', 'HDL', 'LDL', 'eGFR',
  'BMI_ADJ', 'DBP_ADJ', 'SBP_ADJ', 'FAST_GLU_ADJ', 'FAST_INS_ADJ', 'HBA1C_ADJ', 'HDL_ADJ', 'LDL_ADJ', 'eGFR_ADJ',
  'SERUM_CREATININE', 'HEIGHT_CM', 'WEIGHT_KG', 'origin','CHOL', 'TG',
  'C1', 'C2', 'C3', 'C4', 'C5', 'C6') order by PROP;

