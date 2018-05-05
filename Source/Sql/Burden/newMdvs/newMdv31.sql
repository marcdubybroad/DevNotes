
-- add new mdv31 sample datasets
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS, MEANING)
    values('samples_19k_mdv31', 'ExSeq_19k', 'mdv31', '19k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_19k', 40, 8379, 8478, 16857, 'GENE, VARIANT, DATASET_ExSeq_19k_mdv31');
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS, MEANING)
    values('samples_camp_mdv31', 'ExChip_camp', 'mdv31', 'camp', 'ExChip', 'Mixed', 'Root', 'SAMPLE_camp', 70, 563, 3065, 3662, 'VARIANT, DATASET_ExChip_CAMP_mdv31');
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS, MEANING)
    values('samples_biome_mdv31', 'ExChip_biome', 'mdv31', 'BioMe', 'ExChip', 'Mixed', 'Root', 'SAMPLE_biome', 91, 10354, 7403, 2951, 'VARIANT, DATASET_GWAS_BioMe_mdv31');
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS, MEANING)
    values('samples_metsim_mdv31', 'GWAS_metsim', 'mdv31', 'Metsim', 'GWAS', 'Mixed', 'Root', 'SAMPLE_metsim', 91, 1202, 7589, 8791, 'VARIANT, DATASET_GWAS_METSIM_eu_mdv31');


-- add in the sample properties
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_19k_mdv31', PROP from SAMPLES_PROP_ID where ID = 'samples_19k_mdv30' and PROP not in ('MID', 'FID', 'PID');
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_camp_mdv31', PROP from SAMPLES_PROP_ID where ID = 'samples_camp_mdv30';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_biome_mdv31', PROP from SAMPLES_PROP_ID where ID = 'samples_biome_mdv30';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_metsim_mdv31', PROP from SAMPLES_PROP_ID where ID = 'samples_metsim_mdv30';

