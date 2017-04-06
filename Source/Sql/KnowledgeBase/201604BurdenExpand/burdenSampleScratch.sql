


-- get sample properties by property
select * from SAMPLES_PROP_ID p where p.PROP like 'FAST%';

-- get sample properties by sample group
select * from SAMPLES_PROP_ID p where p.ID like '%Stroke%';

-- get covariates list
select PROP, SORT, MEANING from SAMPLES_PROP where lower(meaning) like '%covariate%' order by sort;

-- get covariates list by dataset
select prop.PROP, prop.SORT, prop.MEANING, prop_id.ID
from SAMPLES_PROP prop, SAMPLES_PROP_ID prop_id
where prop.PROP = prop_id.PROP and prop_id.ID = 'samples_17k_mdv2' and lower(meaning) like '%covariate%' order by sort;

select prop.PROP, prop.SORT, prop.MEANING, prop_id.ID
from SAMPLES_PROP prop, SAMPLES_PROP_ID prop_id
where prop.PROP = prop_id.PROP and prop_id.ID = 'samples_17k_mdv2' and lower(meaning) like '%covariate%' order by prop.PROP;


