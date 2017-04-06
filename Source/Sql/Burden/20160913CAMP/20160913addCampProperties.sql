

-- DIGAE-219: adding CAMP properties to SAMPLES_PROP table
-- modify the samples tables
alter table SAMPLE_camp modify column ID varchar(100) primary key;


-- common table
-- add in the rows from the samples tables
insert into SAMPLES_common_dv1 (select ID from SAMPLE_camp camp where not exists (select * from SAMPLES_common_dv1 where ID = camp.ID));


-- DATASET
-- add in the samples rows
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS)
values('samples_camp_mdv2', 'ExChip_camp', 'mdv2', 'camp', 'ExChip', 'Mixed', 'Root', 'SAMPLE_camp', 70, 563, 3065, 3662);

-- add t2d readable field
alter table SAMPLE_camp add column T2D_readable varchar(100); 
update SAMPLE_camp set T2D_readable = if((T2D = 0), 'No', if((T2D = 1), 'Yes', null));


-- SAMPLES PROP
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','ID');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','Age');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','SEX');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','t2d');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','T2D_readable');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','BMI');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','FAST_INS');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','FAST_GLU');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','C1');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','C2');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','C3');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','C4');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','C5');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','C6');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','C7');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','C8');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','C9');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_camp_mdv2','C10');






-- report scratch queries

select count(ID), t2d, t2d_readable from SAMPLE_camp group by t2d;


