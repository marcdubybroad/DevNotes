

-- add new mdv21, 22 and 23 sample datasets
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_17k_mdv21', 'ExSeq_17k', 'mdv21', '17k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_17k', 40, 8379, 8478, 16857);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_17k_mdv22', 'ExSeq_17k', 'mdv22', '17k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_17k', 40, 8379, 8478, 16857);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_17k_mdv23', 'ExSeq_17k', 'mdv23', '17k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_17k', 40, 8379, 8478, 16857);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_camp_mdv21', 'ExChip_camp', 'mdv21', 'camp', 'ExChip', 'Mixed', 'Root', 'SAMPLE_camp', 70, 563, 3065, 3662);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_camp_mdv22', 'ExChip_camp', 'mdv22', 'camp', 'ExChip', 'Mixed', 'Root', 'SAMPLE_camp', 70, 563, 3065, 3662);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_camp_mdv23', 'ExChip_camp', 'mdv23', 'camp', 'ExChip', 'Mixed', 'Root', 'SAMPLE_camp', 70, 563, 3065, 3662);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_stroke_mdv70', 'ExSeq_stroke', 'mdv70', 'Stroke', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_STROKE', 60, 841, 900, 1741);


-- add in the sample properties
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_17k_mdv21', PROP from SAMPLES_PROP_ID where ID = 'samples_17k_mdv2';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_17k_mdv22', PROP from SAMPLES_PROP_ID where ID = 'samples_17k_mdv2';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_17k_mdv23', PROP from SAMPLES_PROP_ID where ID = 'samples_17k_mdv2';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_camp_mdv21', PROP from SAMPLES_PROP_ID where ID = 'samples_camp_mdv2';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_camp_mdv22', PROP from SAMPLES_PROP_ID where ID = 'samples_camp_mdv2';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_camp_mdv23', PROP from SAMPLES_PROP_ID where ID = 'samples_camp_mdv2';
insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_stroke_mdv70', PROP from SAMPLES_PROP_ID where ID = 'samples_stroke_mdv5';








