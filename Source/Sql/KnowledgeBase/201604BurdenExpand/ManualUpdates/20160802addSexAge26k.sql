
-- 13k
-- add sex readable column
alter table SAMPLE_13k add column SEX_readable varchar(10);


-- 17k
-- add sex column
alter table SAMPLE_17k add column SEX int;

-- add age column
alter table SAMPLE_17k add column Age int;

-- add sex readable column
alter table SAMPLE_17k add column SEX_readable varchar(10);


-- 26k
-- add sex column
alter table SAMPLE_26k add column SEX int;

-- add age column
alter table SAMPLE_26k add column Age int;

-- add sex readable column
alter table SAMPLE_26k add column SEX_readable varchar(10);


-- copy sex from temp table to 17k and 26k tables
update SAMPLE_17k t1
inner join samples_26kextra t2 on t2.IID = t1.ID
set t1.SEX = t2.SEX;

update SAMPLE_26k t1
inner join samples_26kextra t2  on t2.IID = t1.ID
set t1.SEX = t2.SEX;


-- copy sex from temp table to 26k tables
update SAMPLE_17k t1
inner join samples_26kextra t2 on t2.IID = t1.ID
set t1.Age = floor(t2.AGE);

update SAMPLE_26k t1
inner join samples_26kextra t2 on t2.IID = t1.ID
set t1.Age = floor(t2.AGE);


-- set readble values
update SAMPLE_13k set SEX_readable = if((SEX = 1), 'Male', if((SEX = 2), 'Female', null));
update SAMPLE_17k set SEX_readable = if((SEX = 1), 'Male', if((SEX = 2), 'Female', null));
update SAMPLE_26k set SEX_readable = if((SEX = 1), 'Male', if((SEX = 2), 'Female', null));


-- add the properties to the sample groups link table
insert into SAMPLES_PROP_ID values('Age', 'samples_17k_mdv2');
insert into SAMPLES_PROP_ID values('Age', 'samples_26k_mdv3');
insert into SAMPLES_PROP_ID values('SEX', 'samples_17k_mdv2');
insert into SAMPLES_PROP_ID values('SEX', 'samples_26k_mdv3');
insert into SAMPLES_PROP_ID values('SEX_readable', 'samples_13k_mdv1');
insert into SAMPLES_PROP_ID values('SEX_readable', 'samples_17k_mdv2');
insert into SAMPLES_PROP_ID values('SEX_readable', 'samples_26k_mdv3');






-- set meaning for
-- cancel
-- update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'HDL';







-- check
select * from SAMPLES_PROP_id where lower(PROP) like 'sex%' order by ID;



