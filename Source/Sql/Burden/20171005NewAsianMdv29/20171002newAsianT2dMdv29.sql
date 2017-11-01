

-- add row to SAMPLES_DATASET table
-- use 'federated' localhost DB
insert into SAMPLES_DATASET
select 'samples_19k_mdv29', EXP, SG, 'mdv29', PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS, 'GENE, VARIANT, DATASET_ExSeq_19k_mdv29'
  from SAMPLES_DATASET
  where VER = 'mdv27' and ID = 'samples_19k_mdv27';

insert into SAMPLES_DATASET
select 'samples_camp_mdv29', EXP, SG, 'mdv29', PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS, 'VARIANT, DATASET_ExChip_CAMP_mdv29'
  from SAMPLES_DATASET
  where VER = 'mdv27' and ID = 'samples_camp_mdv27';

insert into SAMPLES_DATASET
select 'samples_biome_mdv29', EXP, SG, 'mdv29', PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS, 'VARIANT, DATASET_GWAS_BioMe_mdv29'
  from SAMPLES_DATASET
  where VER = 'mdv27' and ID = 'samples_biome_mdv27';

  
-- add in the sample properties
-- NOTE: this will be unnecessary when datasets can have duplicate names
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_19k_mdv29', PROP from SAMPLES_PROP_ID where ID = 'samples_19k_mdv27';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_camp_mdv29', PROP from SAMPLES_PROP_ID where ID = 'samples_camp_mdv27';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_biome_mdv29', PROP from SAMPLES_PROP_ID where ID = 'samples_biome_mdv27';

  
-- select to compare
select * from SAMPLES_DATASET where VER in ('mdv27', 'mdv28', 'mdv29') order by VER;
 
select * from SAMPLES_DATASET where VER in ('mdv27', 'mdv28', 'mdv29') order by ID;
 