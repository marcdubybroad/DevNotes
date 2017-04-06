

-- set the schema
SET @schema = 'federated';


-- insert root node to DATASET table
insert into DATASET (ID, EXP, SG, EXPTYPE, VER, PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS)
    values('ExSeq_34k_mdv2', 'ExSeq_34k', '34k', 'ExSeq', 'mdv2', 'Root', 'Mixed', 'ExSeq', 'ExSeq_34k_dv2', 67, 101010, 202020, 303030);

-- add the new sample group's properties links
SET @table_name = 'ExSeq_34k_dv2';

insert into PROP_ID (ID, PROP)
select 'ExSeq_34k_mdv2', COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS cols, PROP properties
where cols.TABLE_NAME = @table_name
    and cols.TABLE_SCHEMA= @schema
    and cols.COLUMN_NAME = properties.DB_COL
    and cols.COLUMN_NAME != 'VAR_ID';


-- insert European node to DATASET table
insert into DATASET (ID, EXP, SG, EXPTYPE, VER, PARENT, ANCESTRY, TECH, TBL, SORT, CASES, CONTROLS, SUBJECTS)
    values('ExSeq_34k_eu_mdv2', 'ExSeq_34k', '34k_eu', 'ExSeq', 'mdv2', '34k', 'European', 'ExSeq', 'ExSeq_34k_eu_dv2', 67, 51010, 102020, 153030);

-- add the new sample group's properties links
SET @table_name = 'ExSeq_34k_eu_dv2';

insert into PROP_ID (ID, PROP)
select 'ExSeq_34k_eu_mdv2', COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS cols, PROP properties
where cols.TABLE_NAME = @table_name
    and cols.TABLE_SCHEMA= @schema
    and cols.COLUMN_NAME = properties.DB_COL
    and cols.COLUMN_NAME != 'VAR_ID';

    

-- insert T2D phenotype dataset for the root node
SET @table_name = 'ExSeq_34k_dv2__T2D';

insert into ID_PH (ID, PH, TBL) values('ExSeq_34k_mdv2', 'T2D', @table_name);

-- add the new sample group's properties links
insert into PROP_ID_PH (ID, PROP, PH, TRUST_COL)
select 'ExSeq_34k_mdv2', COLUMN_NAME, 'T2D', 'NULL'
from INFORMATION_SCHEMA.COLUMNS cols, PROP properties
where cols.TABLE_NAME = @table_name
    and cols.TABLE_SCHEMA= @schema
    and cols.COLUMN_NAME = properties.DB_COL
    and cols.COLUMN_NAME != 'VAR_ID';










-- scratch pad below

SET @table_name = 'ExSeq_34k_dv2';

select 'ExSeq_34k_mdv2', COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS cols, PROP properties
where cols.TABLE_NAME = @table_name
    and cols.TABLE_SCHEMA= @schema
    and cols.COLUMN_NAME = properties.DB_COL
    and cols.COLUMN_NAME != 'VAR_ID';

-- scratch create table scripts for testing
create table ExSeq_34k_dv2 as select * from ExSeq_17k_dv2;

create table ExSeq_34k_eu_dv2 as select * from ExSeq_17k_eu_dv2;

create table ExSeq_34k_dv2__T2D as select * from ExSeq_17k_dv2__T2D;


