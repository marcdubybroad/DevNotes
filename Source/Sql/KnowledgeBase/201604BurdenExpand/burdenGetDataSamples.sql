

-- modify the samples tables
alter table SAMPLE_13k modify column ID varchar(100) primary key;
alter table SAMPLE_17k modify column ID varchar(100) primary key;
alter table SAMPLE_26k modify column ID varchar(100) primary key;
alter table SAMPLE_STROKE modify column ID varchar(100) primary key;


-- common table
-- drop table if exists
drop table if exists SAMPLES_common_dv1;

-- create table
create table SAMPLES_common_dv1 (ID varchar(100) not null primary key);

-- delete from table
delete from SAMPLES_common_dv1;

-- add in the rows from the samples tables
insert into SAMPLES_common_dv1 (select ID from SAMPLE_13k s13 where not exists (select * from SAMPLES_common_dv1 where ID = s13.ID));
insert into SAMPLES_common_dv1 (select ID from SAMPLE_17k s13 where not exists (select * from SAMPLES_common_dv1 where ID = s13.ID));
insert into SAMPLES_common_dv1 (select ID from SAMPLE_26k s13 where not exists (select * from SAMPLES_common_dv1 where ID = s13.ID));
insert into SAMPLES_common_dv1 (select ID from SAMPLE_STROKE s13 where not exists (select * from SAMPLES_common_dv1 where ID = s13.ID));



-- DATASET
-- drop table if exists
drop table if exists SAMPLES_DATASET;

-- create table
create table SAMPLES_DATASET select * from DATASET;

-- remove all old rows
delete from SAMPLES_DATASET;

-- add in the samples rows
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT) values('samples_common_dv1', 'NULL', 'mdv1', 'NULL', 'NULL', 'NULL', 'Root', 'SAMPLES_common_dv1', 60);
-- insert into SAMPLES_DATASET (ID, EXP, VER, PARENT, TBL, SORT) values('samples_13k_mdv2', 'ExSeq_13k', 'mdv2', 'Root', 'SAMPLE_13k', 40);
-- insert into SAMPLES_DATASET (ID, EXP, VER, PARENT, TBL, SORT) values('samples_26k_mdv3', 'ExSeq_16k', 'mdv3', 'Root', 'SAMPLE_26k', 50);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_13k_mdv1', 'ExSeq_13k', 'mdv1', '13k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_13k', 30, 6514, 6440, 12954);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_17k_mdv2', 'ExSeq_17k', 'mdv2', '17k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_17k', 40, 8379, 8478, 16857);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_26k_mdv3', 'ExSeq_26k', 'mdv3', '26k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_26k', 50, 10234, 13267, 23501);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_stroke_mdv5', 'ExSeq_stroke', 'mdv5', 'Stroke', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_STROKE', 60, 841, 900, 1741);

-- add in subjects, controls etc
-- update SAMPLES_DATASET da set da.CASES = 6514, da.CONTROLS = 6440, da.SUBJECTS = 12954 where da.ID = 'samples_13k_mdv2';
-- update SAMPLES_DATASET da set da.CASES = 10234, da.CONTROLS = 13267, da.SUBJECTS = 23501 where da.ID = 'samples_26k_mdv3';


-- PROP
-- drop table if exists
drop table if exists SAMPLES_PROP;

-- create table
create table SAMPLES_PROP select * from PROP;

-- remove all old rows
delete from SAMPLES_PROP;

-- add in the samples rows
insert into SAMPLES_PROP
select info.column_name, 'FALSE', 'TRUE', info.column_name, if(info.column_type like '%text' or column_type like '%varchar%', 'STRING', if(info.column_type = 'double', 'FLOAT', 'INTEGER')), 'TRUE', 'TRUE', 60, 'NULL'
    FROM INFORMATION_SCHEMA.COLUMNS info WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_STROKE'
    and not exists (select PROP from SAMPLES_PROP where PROP = info.column_name);
    
insert into SAMPLES_PROP
select info.column_name, 'FALSE', 'TRUE', info.column_name, if(info.column_type like '%text' or column_type like '%varchar%', 'STRING', if(info.column_type = 'double', 'FLOAT', 'INTEGER')), 'TRUE', 'TRUE', 60, 'NULL'
    FROM INFORMATION_SCHEMA.COLUMNS info WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_17k'
    and not exists (select PROP from SAMPLES_PROP where PROP = info.column_name);
    
insert into SAMPLES_PROP
select info.column_name, 'FALSE', 'TRUE', info.column_name, if(info.column_type like '%text' or column_type like '%varchar%', 'STRING', if(info.column_type = 'double', 'FLOAT', 'INTEGER')), 'TRUE', 'TRUE', 60, 'NULL'
    FROM INFORMATION_SCHEMA.COLUMNS info WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_26k'
    and not exists (select PROP from SAMPLES_PROP where PROP = info.column_name);

insert into SAMPLES_PROP
select info.column_name, 'FALSE', 'TRUE', info.column_name, if(info.column_type like '%text' or column_type like '%varchar%', 'STRING', if(info.column_type = 'double', 'FLOAT', 'INTEGER')), 'TRUE', 'TRUE', 60, 'NULL'
    FROM INFORMATION_SCHEMA.COLUMNS info WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k'
    and not exists (select PROP from SAMPLES_PROP where PROP = info.column_name);
    


-- PROP_ID
-- drop table if exists
drop table if exists SAMPLES_PROP_ID;

-- create table
create table SAMPLES_PROP_ID select * from PROP_ID;

-- remove all old rows
delete from SAMPLES_PROP_ID;

-- TODO: need to pull in from mysql tables
-- add in the samples rows
insert into SAMPLES_PROP_ID
    select pr.PROP, sa.ID from SAMPLES_DATASET sa, SAMPLES_PROP pr, INFORMATION_SCHEMA.COLUMNS info
    where (sa.ID != 'samples_common_dv1' and sa.TBL = info.TABLE_NAME and pr.PROP = info.COLUMN_NAME and TABLE_SCHEMA = 'dig_qa');
    
insert into SAMPLES_PROP_ID values('samples_common_dv1','ID');



-- ID_PH
-- drop table if exists
drop table if exists SAMPLES_ID_PH;

-- create table
create table SAMPLES_ID_PH select * from ID_PH;

-- remove all old rows
delete from SAMPLES_ID_PH;



-- PROP_ID_PH
-- drop table if exists
drop table if exists SAMPLES_PROP_ID_PH;

-- create table
create table SAMPLES_PROP_ID_PH select * from PROP_ID_PH;

-- remove all old rows
delete from SAMPLES_PROP_ID_PH;


-- add in sort
update SAMPLES_PROP set SORT = 1, PROP_TYPE = 'FLOAT' where PROP = 'Age';
update SAMPLES_PROP set SORT = 2, PROP_TYPE = 'INTEGER' where PROP = 'SEX';




-- add covariate/phenotype/filter meaning to properties
-- t2d data sets
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'HDL';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'LDL';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'CHOL';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'BMI';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'WHR';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'HDL';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'SBP';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'DBP';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'WAISTC';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'HIPC';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'FAST_GLU';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'FAST_INS';
update SAMPLES_PROP set MEANING = 'PHENOTYPE, DICHOTOMOUS' where PROP = 'T2D';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'pheno_T2D';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'pheno_SEX';

-- stroke data sets
update SAMPLES_PROP set MEANING = 'NULL' where PROP = 'ln_ICH_Volume';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'Hemorrhage_Location';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'Number_of_Previous_Hemhorrhages';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'Hours_from_Symptoms_to_CT';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER' where PROP = 'Site';

-- mix data sets
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER' where PROP = 'ANCESTRY';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, DEFAULT_COVARIATE' where PROP = 'AGE';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, DEFAULT_COVARIATE' where PROP = 'Age';
update SAMPLES_PROP set MEANING = 'NULL' where PROP = 'Age_Orig';
update SAMPLES_PROP set MEANING = 'NULL' where PROP = 'Sex_Orig';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER' where PROP = 'HEIGHT';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER' where PROP = 'WEIGHT';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'origin';

update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP regexp '^C[0-9]';
update SAMPLES_PROP set SORT = 3, MEANING = 'COVARIATE, DEFAULT_COVARIATE' where PROP = 'C1';
update SAMPLES_PROP set SORT = 4, MEANING = 'COVARIATE, DEFAULT_COVARIATE' where PROP = 'C2';
update SAMPLES_PROP set SORT = 5, MEANING = 'COVARIATE, DEFAULT_COVARIATE' where PROP = 'C3';
update SAMPLES_PROP set SORT = 6, MEANING = 'COVARIATE, DEFAULT_COVARIATE' where PROP = 'C4';


-- t2d specific readable fiedls
update SAMPLES_PROP set MEANING = 'PHENOTYPE' where PROP = 'T2D';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'T2D_readable';

-- stroke specific readable fields
update SAMPLES_PROP set MEANING = 'PHENOTYPE' where PROP = 'ICH_Status';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'ICH_Status_readable';
update SAMPLES_PROP set MEANING = 'PHENOTYPE' where PROP = 'Lobar_ICH';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Lobar_ICH_readable';
update SAMPLES_PROP set MEANING = 'PHENOTYPE' where PROP = 'Deep_ICH';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Deep_ICH_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE, PHENOTYPE' where PROP = 'History_of_Hypertension';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'History_of_Hypertension_readable';
update SAMPLES_PROP set MEANING = 'PHENOTYPE' where PROP = 'INR_gt_2';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'INR_gt_2_readable';
update SAMPLES_PROP set MEANING = 'PHENOTYPE' where PROP = 'Follow_up_mRS_gt_2';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Follow_up_mRS_gt_2_readable';
update SAMPLES_PROP set MEANING = 'PHENOTYPE' where PROP = 'Discharge_mRS_gt_2';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Discharge_mRS_gt_2_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'Aspirin';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Aspirin_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'Warfarin';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Warfarin_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'Statins';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Statins_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'Other_Antiplatelet';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Other_Antiplatelet_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'History_of_Diabetes_mellitus';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'History_of_Diabetes_mellitus_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'History_of_Hypercholesterolemia';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'History_of_Hypercholesterolemia_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'Coronary_Artery_Disease';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Coronary_Artery_Disease_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'History_of_TIA_Ischemic_Stroke';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'History_of_TIA_Ischemic_Stroke_readable';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'MRI_Available_readable';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Admission_CT_Available_readable';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'SEX_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE, DEFAULT_COVARIATE' where PROP = 'SEX';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'Race';
update SAMPLES_PROP set MEANING = 'FILTER, CATEGORICAL' where PROP = 'Race_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'Ethnicity';
update SAMPLES_PROP set MEANING = 'FILTER, CATEGORICAL' where PROP = 'Ethnicity_readable';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Number_of_Previous_Hemhorrhages_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'Number_of_Previous_Hemhorrhages';
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'Hemorrhage_Location_readable';
update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP = 'Hemorrhage_Location';







-- t2d mdv2/17k specific filters/covariates
alter table SAMPLE_17k add column T2D_readable varchar(100); 
update SAMPLE_17k set T2D_readable = if((T2D = 1), 'No', if((T2D = 2), 'Yes', null));




-- stroke specific filters/covariates
alter table SAMPLE_STROKE add column MRI_Available_readable varchar(100); 
update SAMPLE_STROKE set MRI_Available_readable = if((MRI_Available = 1), 'No', if((MRI_Available = 2), 'Yes', null));

alter table SAMPLE_STROKE add column Admission_CT_Available_readable varchar(100); 
update SAMPLE_STROKE set Admission_CT_Available_readable = if((Admission_CT_Available = 1), 'No', if((Admission_CT_Available = 2), 'Yes', null));

alter table SAMPLE_STROKE add column History_of_Diabetes_mellitus_readable varchar(100); 
update SAMPLE_STROKE set History_of_Diabetes_mellitus_readable = if((History_of_Diabetes_mellitus = 1), 'No', if((History_of_Diabetes_mellitus = 2), 'Yes', null));

alter table SAMPLE_STROKE add column History_of_Hypercholesterolemia_readable varchar(100); 
update SAMPLE_STROKE set History_of_Hypercholesterolemia_readable = if((History_of_Hypercholesterolemia = 1), 'No', if((History_of_Hypercholesterolemia = 2), 'Yes', null));

alter table SAMPLE_STROKE add column Coronary_Artery_Disease_readable varchar(100); 
update SAMPLE_STROKE set Coronary_Artery_Disease_readable = if((Coronary_Artery_Disease = 1), 'No', if((Coronary_Artery_Disease = 2), 'Yes', null));

alter table SAMPLE_STROKE add column History_of_TIA_Ischemic_Stroke_readable varchar(100); 
update SAMPLE_STROKE set History_of_TIA_Ischemic_Stroke_readable = if((History_of_TIA_Ischemic_Stroke = 1), 'No', if((History_of_TIA_Ischemic_Stroke = 2), 'Yes', null));

alter table SAMPLE_STROKE add column Statins_readable varchar(100); 
update SAMPLE_STROKE set Statins_readable = if((Statins = 1), 'No', if((Statins = 2), 'Yes', null));

alter table SAMPLE_STROKE add column Other_Antiplatelet_readable varchar(100); 
update SAMPLE_STROKE set Other_Antiplatelet_readable = if((Other_Antiplatelet = 1), 'No', if((Other_Antiplatelet = 2), 'Yes', null));

alter table SAMPLE_STROKE add column Aspirin_readable varchar(100); 
update SAMPLE_STROKE set Aspirin_readable = if((Aspirin = 1), 'No', if((Aspirin = 2), 'Yes', null));

alter table SAMPLE_STROKE add column Warfarin_readable varchar(100); 
update SAMPLE_STROKE set Warfarin_readable = if((Warfarin = 1), 'No', if((Warfarin = 2), 'Yes', null));

alter table SAMPLE_STROKE add column Follow_up_mRS_gt_2_readable varchar(100); 
update SAMPLE_STROKE set Follow_up_mRS_gt_2_readable = if((Follow_up_mRS_gt_2 = 1), 'No', if((Follow_up_mRS_gt_2 = 2), 'Yes', null));

alter table SAMPLE_STROKE add column Discharge_mRS_gt_2_readable varchar(100); 
update SAMPLE_STROKE set Discharge_mRS_gt_2_readable = if((Discharge_mRS_gt_2 = 1), 'No', if((Discharge_mRS_gt_2 = 2), 'Yes', null));

alter table SAMPLE_STROKE add column ICH_Status_readable varchar(100); 
update SAMPLE_STROKE set ICH_Status_readable = if((ICH_Status = 1), 'No', if((ICH_Status = 2), 'Yes'), null);

alter table SAMPLE_STROKE add column Lobar_ICH_readable varchar(100); 
update SAMPLE_STROKE set Lobar_ICH_readable = if((Lobar_ICH = 1), 'No', if((Lobar_ICH = 2), 'Yes', null));

alter table SAMPLE_STROKE add column Deep_ICH_readable varchar(100); 
update SAMPLE_STROKE set Deep_ICH_readable = if((Deep_ICH = 1), 'No', if((Deep_ICH = 2), 'Yes', null));

alter table SAMPLE_STROKE add column History_of_Hypertension_readable varchar(100); 
update SAMPLE_STROKE set History_of_Hypertension_readable = if((History_of_Hypertension = 1), 'No', if((History_of_Hypertension = 2), 'Yes', null));

alter table SAMPLE_STROKE add column INR_gt_2_readable varchar(100); 
update SAMPLE_STROKE set INR_gt_2_readable = if((INR_gt_2 = 1), 'No', if((INR_gt_2 = 2), 'Yes', null));

alter table SAMPLE_STROKE add column SEX_readable varchar(100); 
update SAMPLE_STROKE set SEX_readable = if((SEX = 1), 'Male', if((SEX = 2), 'Female', null));

alter table SAMPLE_STROKE add column Race_readable varchar(100); 
update SAMPLE_STROKE set Race_readable = if((Race = 1), 'White', if((Race = 2), 'Black', if((Race = 3), 'Asian', if((Race = 4), 'Hispanic', 'Other'))));

alter table SAMPLE_STROKE add column Ethnicity_readable varchar(100); 
update SAMPLE_STROKE set Ethnicity_readable = if((Ethnicity = 1), 'Hispanic/Latino', if((Ethnicity = 2), 'Not Hispanic/Latino', null));

alter table SAMPLE_STROKE add column Number_of_Previous_Hemhorrhages_readable int(11); 
update SAMPLE_STROKE set Number_of_Previous_Hemhorrhages_readable = if((Number_of_Previous_Hemhorrhages = -9), null, Number_of_Previous_Hemhorrhages);

alter table SAMPLE_STROKE add column Hemorrhage_Location_readable varchar(100); 
update SAMPLE_STROKE set Hemorrhage_Location_readable = if((Hemorrhage_Location = '-9'), null, Hemorrhage_Location);





-- scratch
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';
SELECT COLUMN_NAME, COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';

select * from SAMPLES_PROP_ID where id = 'samples_stroke_mdv5' order by PROP;

select * from SAMPLES_PROP sp, SAMPLES_PROP_ID sprop where sp.PROP = sprop.PROP and sprop.ID = 'samples_26k_mdv3' and lower(sp.MEANING) like '%phenotype%';

select Lobar_ICH, count(ID) from SAMPLE_STROKE group by Lobar_ICH;
select History_of_Hypertension, count(ID) from SAMPLE_STROKE group by History_of_Hypertension;
select INR_gt_2, count(ID) from SAMPLE_STROKE group by INR_gt_2;
select Discharge_mRS_gt_2, count(ID) from SAMPLE_STROKE group by Discharge_mRS_gt_2;
select Follow_up_mRS_gt_2, count(ID) from SAMPLE_STROKE group by Follow_up_mRS_gt_2;
select Warfarin, count(ID) from SAMPLE_STROKE group by Warfarin;
select Aspirin, count(ID) from SAMPLE_STROKE group by Aspirin;
select Other_Antiplatelet, count(ID) from SAMPLE_STROKE group by Other_Antiplatelet;
select Statins, count(ID) from SAMPLE_STROKE group by Statins;
select History_of_Diabetes_mellitus, count(ID) from SAMPLE_STROKE group by History_of_Diabetes_mellitus;
select History_of_Hypercholesterolemia, count(ID) from SAMPLE_STROKE group by History_of_Hypercholesterolemia;
select Coronary_Artery_Disease, count(ID) from SAMPLE_STROKE group by Coronary_Artery_Disease;
select History_of_TIA_Ischemic_Stroke, count(ID) from SAMPLE_STROKE group by History_of_TIA_Ischemic_Stroke;
select MRI_Available, count(ID) from SAMPLE_STROKE group by MRI_Available;
select Admission_CT_Available, count(ID) from SAMPLE_STROKE group by Admission_CT_Available;
select Site, count(ID) from SAMPLE_STROKE group by Site;
select SEX, count(ID) from SAMPLE_STROKE group by SEX;
select Number_of_Previous_Hemhorrhages, count(ID) from SAMPLE_STROKE group by Number_of_Previous_Hemhorrhages;
select Hemorrhage_Location, count(ID) from SAMPLE_STROKE group by Hemorrhage_Location;

select Race, count(ID) from SAMPLE_STROKE group by Race;

select Ethnicity, count(ID) from SAMPLE_STROKE group by Ethnicity;





-- history of manual fixes
-- 20160426 tuesday; remove erroneous column from t2d mdv2 table
delete from SAMPLES_PROP_ID where PROP = 'ICH_Status_readable' and ID = 'samples_17k_mdv2';
alter table SAMPLE_17k drop column ICH_Status_readable;


