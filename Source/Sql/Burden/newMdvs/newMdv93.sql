

-- add the dataset
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS, MEANING)
  values('samples_mi_mdv93', 'ExChip_mi', 'mdv93', 'MI', 'ExChip', 'Mixed', 'Root', 'SAMPLE_mi', 90, 10022, 12043, 22065, 'GENE, VARIANT, DATASET_ExSeq_EOMI_mdv93');

-- insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS, MEANING)
--     values('samples_metsim_mdv31', 'GWAS_metsim', 'mdv31', 'Metsim', 'GWAS', 'Mixed', 'Root', 'SAMPLE_metsim', 91, 1202, 7589, 8791, 'VARIANT, DATASET_GWAS_METSIM_eu_mdv31');

insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_mi_mdv93', PROP from SAMPLES_PROP_ID where ID = 'samples_mi_mdv90';




