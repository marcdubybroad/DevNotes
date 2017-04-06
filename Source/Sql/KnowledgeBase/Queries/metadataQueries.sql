

-- show the phenotypes for a dataset
select sprop.PROP, sprop.MEANING, sprop_id.ID
from SAMPLES_PROP sprop, SAMPLES_PROP_ID sprop_id
where sprop.PROP = sprop_id.PROP
  and sprop_id.ID in ('samples_17k_mdv2', 'samples_26k_mdv3')
  and lower(sprop.MEANING) like '%phenotype%'
group by sprop_id.ID, sprop.PROP;

select sprop.PROP, sprop.MEANING, sprop_id.ID
from SAMPLES_PROP sprop, SAMPLES_PROP_ID sprop_id
where sprop.PROP = sprop_id.PROP
  and sprop_id.ID in ('samples_17k_mdv2', 'samples_26k_mdv3')
  and lower(sprop.MEANING) like '%covariate%'
group by sprop_id.ID, sprop.PROP;

select sprop.PROP, sprop.MEANING, sprop_id.ID
from SAMPLES_PROP sprop, SAMPLES_PROP_ID sprop_id
where sprop.PROP = sprop_id.PROP
  and sprop_id.ID in ('samples_17k_mdv2', 'samples_26k_mdv3')
  and lower(sprop.MEANING) like '%filter%'
group by sprop_id.ID, sprop.PROP;


-- backup the old table
create table SAMPLES_PROP_backup20160623_digp371 as select * from SAMPLES_PROP;

-- DIGP-371: change the phenotypes or the t2d GAIT module
-- take old phenotypes out
update SAMPLES_PROP set meaning = 'FILTER' where PROP = 'FAST_GLU';
update SAMPLES_PROP set meaning = 'FILTER' where PROP = 'FAST_INS';
update SAMPLES_PROP set meaning = 'FILTER' where PROP = 'CHOL';
update SAMPLES_PROP set meaning = 'FILTER' where PROP = 'LDL';
update SAMPLES_PROP set meaning = 'FILTER' where PROP = 'HDL';
update SAMPLES_PROP set meaning = 'FILTER' where PROP = 'SBP';
update SAMPLES_PROP set meaning = 'FILTER' where PROP = 'DBP';
update SAMPLES_PROP set meaning = 'FILTER' where PROP = 'TG';

-- put new phenotypes in
update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'FAST_GLU_ANAL';
update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'FAST_INS_ANAL';
update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'CHOL_ANAL';
update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'LDL_ANAL';
update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'HDL_ANAL';
update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'SBP_ANAL';
update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'DBP_ANAL';
update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'TG_ANAL';

update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'X2H_GLU_ANAL';
update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'X2H_INS_ANAL';
update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'HBA1C_ANAL';
update SAMPLES_PROP set meaning = 'COVARIATE,PHENOTYPE' where PROP = 'CREATININE_ANAL';


-- adding t2d readable to the 26k dataset
insert into SAMPLES_PROP_ID values('T2D_readable', 'samples_26k_mdv3');
