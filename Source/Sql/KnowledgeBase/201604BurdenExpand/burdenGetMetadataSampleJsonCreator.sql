

select
concat('{ "name": "', ifnull(prop.PROP, 'null'), '",') as name,
concat('"type": "', ifnull(prop.PROP_TYPE, 'null'), '",') as prop_type,
concat('"searchable": "FALSE",') as searchable,
concat('"meaning": ', if(lower(prop.PROP) regexp('c[1-9]'), '["COVARIATE"],', '["PHENOTYPE", "COVARIATE", "FILTER"],')) as meaning,
concat('"displayable": "TRUE",') as displayable,
concat('"sort_order": ', ifnull(prop.SORT, 'null'), '},') as sort_order
from SAMPLES_PROP prop, SAMPLES_PROP_ID prop_id
where prop.PROP = prop_id.PROP and prop_id.ID = 'SAMPLES_26k_mdv2';

-- where prop.PROP = prop_id.PROP and prop_id.ID = 'SAMPLES_13k_mdv2';


-- select * 
-- from SAMPLES_PROP prop, SAMPLES_PROP_ID prop_id
-- where prop.PROP = prop_id.PROP and prop_id.ID = 'SAMPLES_13k_mdv2';


-- select * from SAMPLES_PROP where lower(prop) regexp('c[1-9]');

