

-- DIGAE-219: adding CAMP properties to SAMPLES_PROP table
-- modify the samples tables
alter table SAMPLE_mi modify column ID varchar(100) primary key;


-- common table
-- add in the rows from the samples tables
insert into SAMPLES_common_dv1 (select ID from SAMPLE_mi mi where not exists (select * from SAMPLES_common_dv1 where ID = mi.ID));


-- DATASET
-- add in the samples rows
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS)
values('samples_mi_mdv90', 'ExChip_mi', 'mdv90', 'MI', 'ExChip', 'Mixed', 'Root', 'SAMPLE_mi', 90, 10022, 12043, 22065);

-- add eomi readable field
alter table SAMPLE_mi add column eomi_readable varchar(100); 
update SAMPLE_mi set eomi_readable = if((eomi = 1), 'No', if((eomi = 2), 'Yes', null));

-- add properties to the SAMPLES_PROPS table
insert into SAMPLES_PROP values('eomi', 'FALSE', 'TRUE', 'eomi', 'INTEGER', 'TRUE', 'TRUE', 60, 'PHENOTYPE');
insert into SAMPLES_PROP values('eomi_readable', 'FALSE', 'TRUE', 'eomi_readable', 'STRING', 'TRUE', 'TRUE', 60, 'FILTER');


-- SAMPLES PROP
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','ID');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','eomi');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','eomi_readable');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','origin');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','C1');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','C2');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','C3');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','C4');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','C5');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','C6');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','C7');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','C8');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','C9');
insert into SAMPLES_PROP_ID (ID, PROP) values('samples_mi_mdv90','C10');






-- BUGS
-- fix eomi_readable column
update SAMPLES_PROP set DB_COL = 'eomi_readable' where PROP = 'eomi_readable';



-- report scratch queries

select count(ID), eomi, eomi_readable from SAMPLE_mi group by eomi;


