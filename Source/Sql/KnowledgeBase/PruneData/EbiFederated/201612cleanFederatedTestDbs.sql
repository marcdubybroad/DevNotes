
-- delete any prop_id row that does not exist in the prop_id table
select * from PROP_ID where ID in (select ID from DATASET);

select * from PROP_ID where ID not in (select ID from DATASET);

delete from PROP_ID where ID not in (select ID from DATASET);


-- delete any prop_id_ph row that does not exist in the prop_id table
select * from PROP_ID_PH where ID not in (select ID from DATASET);

delete from PROP_ID_PH where ID not in (select ID from DATASET);


-- delete any id_ph row that does not exist in the prop_id table
select * from ID_PH where ID not in (select ID from DATASET);

delete from ID_PH where ID not in (select ID from DATASET);



-- delete 2 dataset families
delete from DATASET where ID like 'ExSeq_34k%';
delete from DATASET where ID like 'GWAS_MAGIC%';
delete from DATASET where ID like 'GWAS_DIAGRAM_mdv5';


-- rename datasets
update DATASET set ID = 'ExSeq_ebi_mdv11', EXP = 'ExSeq_ebi', SG = 'ebiSeq', VER = 'mdv11', PARENT = 'Root' where ID = 'ExSeq_17k_mdv2';
update DATASET set ID = 'ExSeq_ebi_hs_mdv11', EXP = 'ExSeq_ebi_hs', SG = 'ebiSeq_hs', VER = 'mdv11', PARENT = 'ebiSeq' where ID = 'ExSeq_17k_eu_mdv2';

update DATASET set ID = 'GWAS_EBI_mdv11', EXP = 'GWAS_EBI', SG = 'EBI', VER = 'mdv11', PARENT = 'Root' where ID = 'GWAS_DIAGRAM_mdv2';

-- update the prop_id table
update PROP_ID set ID = 'ExSeq_ebi_mdv11' where ID = 'ExSeq_17k_mdv2';
update PROP_ID set ID = 'ExSeq_ebi_hs_mdv11' where ID = 'ExSeq_17k_eu_mdv2';


-- update the prop_id_ph table
update PROP_ID_PH set ID = 'ExSeq_ebi_mdv11' where ID = 'ExSeq_17k_mdv2';
update PROP_ID_PH set ID = 'ExSeq_ebi_hs_mdv11' where ID = 'ExSeq_17k_eu_mdv2';
update PROP_ID_PH set ID = 'GWAS_EBI_mdv11' where ID = 'GWAS_DIAGRAM_mdv2';

-- update the id_ph table
update ID_PH set ID = 'ExSeq_ebi_mdv11' where ID = 'ExSeq_17k_mdv2';
update ID_PH set ID = 'ExSeq_ebi_hs_mdv11' where ID = 'ExSeq_17k_eu_mdv2';
update ID_PH set ID = 'GWAS_EBI_mdv11' where ID = 'GWAS_DIAGRAM_mdv2';


-- fix
update DATASET set EXP = 'ExSeq_ebi', PARENT = 'ebiSeq' where ID = 'ExSeq_ebi_hs_mdv11';


