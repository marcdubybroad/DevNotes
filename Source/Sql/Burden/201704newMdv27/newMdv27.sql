
-- add new mdv25 sample datasets
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS)
    values('samples_19k_mdv27', 'ExSeq_19k', 'mdv27', '19k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_19k', 40, 8379, 8478, 16857);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS)
    values('samples_camp_mdv27', 'ExChip_camp', 'mdv27', 'camp', 'ExChip', 'Mixed', 'Root', 'SAMPLE_camp', 70, 563, 3065, 3662);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS)
    values('samples_biome_mdv27', 'ExChip_biome', 'mdv27', 'BioMe', 'ExChip', 'Mixed', 'Root', 'SAMPLE_biome', 91, 10354, 7403, 2951);


-- add in the sample properties
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_19k_mdv27', PROP from SAMPLES_PROP_ID where ID = 'samples_17k_mdv25' and PROP not in ('MID', 'FID', 'PID');
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_camp_mdv27', PROP from SAMPLES_PROP_ID where ID = 'samples_camp_mdv25';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_biome_mdv27', PROP from SAMPLES_PROP_ID where ID = 'samples_biome_mdv25';



