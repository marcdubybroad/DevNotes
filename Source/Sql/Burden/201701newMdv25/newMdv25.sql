
-- add new mdv25 sample datasets
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_17k_mdv25', 'ExSeq_17k', 'mdv25', '17k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_17k', 40, 8379, 8478, 16857);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_camp_mdv25', 'ExChip_camp', 'mdv25', 'camp', 'ExChip', 'Mixed', 'Root', 'SAMPLE_camp', 70, 563, 3065, 3662);


-- add in the sample properties
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_17k_mdv25', PROP from SAMPLES_PROP_ID where ID = 'samples_17k_mdv2';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_camp_mdv25', PROP from SAMPLES_PROP_ID where ID = 'samples_camp_mdv2';


