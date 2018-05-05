

-- add the dataset
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS, MEANING)
  values('samples_stroke_mdv72', 'ExSeq_stroke', 'mdv72', 'Stroke', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_STROKE', 60, 841, 900, 1741, 'VARIANT, DATASET_GWAS_Stroke_mdv72');

-- insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS, MEANING)
--     values('samples_metsim_mdv31', 'GWAS_metsim', 'mdv31', 'Metsim', 'GWAS', 'Mixed', 'Root', 'SAMPLE_metsim', 91, 1202, 7589, 8791, 'VARIANT, DATASET_GWAS_METSIM_eu_mdv31');

insert into SAMPLES_PROP_ID (ID, PROP) select 'samples_stroke_mdv72', PROP from SAMPLES_PROP_ID where ID = 'samples_stroke_mdv70';




