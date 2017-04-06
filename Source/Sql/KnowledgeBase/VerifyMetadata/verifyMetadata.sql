-- set the schema that you are testing
SET @schema = 'dig_dev';

-- check PROP_ID_PH table
-- make sure all phenotypes linked to phenotype sample group tables are in the phenotypes table
select * from PROP_ID_PH prop_id where prop_id.PH not in (select PH from PH);
-- make sure all properties linked to phenotype sample group tables are in the properties table
select * from PROP_ID_PH prop_id where prop_id.PROP not in (select PROP from PROP);
-- make sure all datasets referenced from the phenotype sample group tables are in the datasets table
select * from PROP_ID_PH prop_id where prop_id.ID not in (select ID from DATASET);


-- check PROP_ID table
-- make sure all properties linked to non phenotype sample group tables are in the properties table
select * from PROP_ID prop_id where prop_id.PROP not in (select PROP from PROP);
-- make sure all datasets referenced from the non phenotype sample group tables are in the datasets table
select * from PROP_ID prop_id where prop_id.ID not in (select ID from DATASET);


-- check ID_PH table
-- make sure all phenotypes linked to phenotype sample group tables are in the phenotypes table
select * from ID_PH prop_id where prop_id.PH not in (select PH from PH);
-- make sure all datasets referenced from the non phenotype sample group tables are in the datasets table
select * from ID_PH prop_id where prop_id.ID not in (select ID from DATASET);
-- make sure all databasde tables linked to phenotype sample group tables are in the central mysql dig_dev schema table
select * from ID_PH prop_id where prop_id.TBL not in (select TABLE_NAME from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = @schema);


-- check DATASET table
-- make sure all parents of datasets exist
select * from DATASET dataset where dataset.PARENT != 'Root' and dataset.PARENT NOT IN (select SG from DATASET);
-- make sure all tables exist in the central mysql dig_dev scehma table
select * from DATASET dataset where dataset.TBL not in (select TABLE_NAME from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = @schema);




