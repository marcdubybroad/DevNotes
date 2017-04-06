
-- create the SAMPLES_biome tables
drop table if exists SAMPLE_biome;
create table SAMPLE_biome as
  select ID, ORIGIN, BMI, SEX_ORIG, YOB, CHOL, HDL, TG, LDL_DIRECT AS LDL, LDL_CALCULATED, HEIGHT_CM, WEIGHT_KG,
    AGE_ANTHRO as AGE, SBP, DBP, SMOKING_STATUS_QT as SMOKING,
    T2D_OTHER_STRICT_IGNORET1D as T2D_original, AGE_T2D_OTHER as AGE_T2D, GLU_FAST_STRICT_ILL_CLUSTERED_RAW_RES_INVN as FAST_GLU,
    HBA1C_STRICT_ILL_CLUSTERED_RAW_RES_INVN as HBA1C,
    T1D, ILL_CLUSTERED_PC1 as C1, ILL_CLUSTERED_PC2 as C2, ILL_CLUSTERED_PC3 as C3, ILL_CLUSTERED_PC4 as C4, ILL_CLUSTERED_PC5 as C5,
    ILL_CLUSTERED_PC6 as C6, ILL_CLUSTERED_PC7 as C7, ILL_CLUSTERED_PC8 as C8, ILL_CLUSTERED_PC9 as C9, ILL_CLUSTERED_PC10 as C10
  from biome;



-- DIGAE-225: adding Biome properties to SAMPLES_PROP table
-- modify the samples tables
alter table SAMPLE_biome modify column ID varchar(100) primary key;


-- common table
-- add in the rows from the samples tables
insert into SAMPLES_common_dv1 (select ID from SAMPLE_biome biome where not exists (select * from SAMPLES_common_dv1 where ID = biome.ID));


-- DATASET
-- add in the samples rows
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS)
values('samples_biome_mdv25', 'ExChip_biome', 'mdv25', 'BioMe', 'ExChip', 'Mixed', 'Root', 'SAMPLE_biome', 91, 10354, 7403, 2951);

-- add updated T2D field
alter table SAMPLE_biome add column T2D int(9); 
update SAMPLE_biome set T2D = 1 where T2D_original = 0;
update SAMPLE_biome set T2D = 2 where T2D_original = 1;
-- add T2D readable field
alter table SAMPLE_biome add column T2D_readable varchar(100); 
update SAMPLE_biome set T2D_readable = if((T2D = 1), 'No', if((T2D = 2), 'Yes', null));
-- add SEX readable field
alter table SAMPLE_biome add column SEX_readable varchar(100); 
update SAMPLE_biome set SEX_readable = SEX_ORIG;
-- add SEX integer field
alter table SAMPLE_biome add column SEX int(9); 
update SAMPLE_biome set SEX = if((SEX_ORIG = 'Male'), 1, if((SEX_ORIG = 'Female'), 2, null));


-- add properties to the SAMPLES_PROPS table
-- NONE needed

-- SAMPLES PROP
-- delete first
delete from SAMPLES_PROP_ID where ID = 'samples_biome_mdv25';
-- add new properties
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','ID');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','t2d');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','T2D_readable');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','HBA1C');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','FAST_GLU');
-- insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','origin');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','SEX_readable');
-- insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','BMI');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','CHOL');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','HDL');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','LDL');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','TG');
-- insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','DBP');
-- insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','SBP');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','C1');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','C2');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','C3');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','C4');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','C5');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','C6');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','C7');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','C8');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','C9');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_biome_mdv25','C10');






-- BUGS

-- report scratch queries

select count(ID), T2D_original, T2D, T2D_readable from SAMPLE_biome group by T2D_original, T2D, T2D_readable;



