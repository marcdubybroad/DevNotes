

-- Marc Duby
-- 02/03/2016
-- File for scripts to load test data

-- create the dummy test tables
drop table if exists ExSeq_39k_dv9;
create table ExSeq_39k_dv9 select * from ExSeq_17k_dv2;

drop table if exists ExSeq_39k_eu_dv9;
create table ExSeq_39k_eu_dv9 select * from ExSeq_17k_eu_dv2;

drop table if exists ExSeq_39k_dv9__STRK;
create table ExSeq_39k_dv9__STRK select * from ExSeq_17k_dv2__T2D;

drop table if exists ExSeq_39k_eu_dv9__STRK;
create table ExSeq_39k_eu_dv9__STRK select * from ExSeq_17k_eu_dv2__T2D;


-- add in to phenotype table
delete from PH where PH = 'STRK';
insert into PH (PH, GRP, SORT) values('STRK', 'RENAL', 30);

-- add in phenotype table link
delete from ID_PH where lower(ID) like '%39k%';
insert into ID_PH (ID, PH, TBL) values('ExSeq_39k_mdv9', 'STRK', 'ExSeq_39k_dv9__STRK');
insert into ID_PH (ID, PH, TBL) values('ExSeq_39k_eu_mdv9', 'STRK', 'ExSeq_39k_eu_dv9__STRK');

-- add dataset properties for the stroke mdv
delete from PROP_ID where lower(ID) like '%39k%';
insert into PROP_ID (PROP, ID) select PROP, 'ExSeq_39k_mdv9' from PROP_ID where ID = 'ExSeq_17k_mdv2';
insert into PROP_ID (PROP, ID) select PROP, 'ExSeq_39k_eu_mdv9' from PROP_ID where ID = 'ExSeq_17k_eu_mdv2';

-- add phenotype properties for the stroke mdv
delete from PROP_ID_PH where lower(ID) like '%39k%';
insert into PROP_ID_PH (PROP, ID, PH, TRUST_COL) select PROP, 'ExSeq_39k_mdv9', 'STRK', TRUST_COL from PROP_ID_PH where ID = 'ExSeq_17k_mdv2';
insert into PROP_ID_PH (PROP, ID, PH, TRUST_COL) select PROP, 'ExSeq_39k_eu_mdv9', 'STRK', TRUST_COL from PROP_ID_PH where ID = 'ExSeq_17k_eu_mdv2';

-- add in tables to dataset
delete from DATASET where lower(ID) like '%39k%';
insert into DATASET (ID, EXP, SG, VER, PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS) 
select 'ExSeq_39k_mdv9', 'ExSeq_39k', '39k', 'mdv9', 'Root', ANCESTRY, TECH, 'ExSeq_39k_dv9', 98, CASES, CONTROLS, SUBJECTS from DATASET where ID = 'ExSeq_17k_mdv2';
insert into DATASET (ID, EXP, SG, VER, PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS) 
select 'ExSeq_39k_eu_mdv9', 'ExSeq_39k', '39k_eu', 'mdv9', '39k', ANCESTRY, TECH, 'ExSeq_39k_eu_dv9', 99, CASES, CONTROLS, SUBJECTS from DATASET where ID = 'ExSeq_17k_eu_mdv2';


-- add in GWAS tables to the phenotype link table for the mdv9 as well
delete from ID_PH where lower(ID) like 'gwas%mdv9';
insert into ID_PH (ID, PH, TBL) select replace(ID, 'mdv2', 'mdv9'), PH, TBL from ID_PH where lower(ID) like 'gwas%mdv2';

-- add in gwas to PROP_ID table for mdv9
delete from PROP_ID where lower(ID) like 'gwas%mdv9';
insert into PROP_ID (PROP, ID) select PROP, replace(ID, 'mdv2', 'mdv9') from PROP_ID where lower(ID) like 'gwas%mdv2';

-- add in gwas to PROP_ID_PH table for mdv9
delete from PROP_ID_PH where lower(ID) like 'gwas%mdv9';
insert into PROP_ID_PH (PROP, ID, PH, TRUST_COL) select PROP, replace(ID, 'mdv2', 'mdv9'), PH, TRUST_COL from PROP_ID_PH where lower(ID) like 'gwas%mdv2';


-- add in GWAS tables to dataset for the mdv9 as well
delete from DATASET where lower(ID) like 'gwas%' and VER = 'mdv9';
insert into DATASET (ID, EXP, SG, VER, PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS) 
select replace(ID, 'mdv2', 'mdv9'), EXP, SG, 'mdv9', PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS
from DATASET where lower(ID) like 'gwas%mdv2';


-- seed data for testing
-- dummy test
-- update common_dv1 set closest_gene = 'HDAC9' where closest_gene = 'ZMAT4';

--update common_dv1 set dbsnp_id = 'rs17346073' where var_id = '20_3684426_C_T';

--update ExSeq_39k_dv9 set VAR_ID = 'rs17346073' where VAR_ID = '20_3684426_C_T';
--update ExSeq_39k_eu_dv9 set VAR_ID = 'rs17346073' where VAR_ID = '20_3684426_C_T';
--update ExSeq_39k_dv9__STRK set VAR_ID = 'rs17346073' where VAR_ID = '20_3684426_C_T';
--update ExSeq_39k_eu_dv9__STRK set VAR_ID = 'rs17346073' where VAR_ID = '20_3684426_C_T';
