
-- find sample group tables
select ID, EXP, SG, PARENT, TBL from DATASET limit 10;

select ID, EXP, SG, PARENT, TBL from DATASET where lower(ID) like '%17%';

select ID, EXP, SG, PARENT, TBL from DATASET where lower(ID) like '%17%' and lower(parent) in ('17k', 'root');

select * from ID_PH limit 10;

select ID, PH, TBL from ID_PH where lower(ID) like '%17k%';

select * from PROP_ID_PH limit 10;

select ID, PH, TBL from PROP_ID_PH where lower(ID) like '%diagram%';


-- backup all metadata tables
delete from DATASET where TBL not in (select table_name from information_schema.tables where table_schema = 'federated');
delete from ID_PH where TBL not in (select table_name from information_schema.tables where table_schema = 'federated');
delete from PROP_ID where ID not in (select ID from DATASET);
delete from PROP_ID_PH where ID not in (select ID from ID_PH);


DELETE common FROM BLOB b 
  LEFT JOIN FILES f ON f.id = b.fileid 
      WHERE f.id IS NULL
      
insert into primary(col1, . . .)
    select col1, . . .
    from secondary
    where not exists (select 1 from primary where primary.keycol = secondary.keycol);


insert into common_dump
    select com.*
    from common_dv1 com, ExSeq_17k_eu_dv2 other
    where com.VAR_ID = other.VAR_ID and
        not exists (select 1 from common_dump dump2 where dump2.VAR_ID = com.VAR_ID);


insert into common_dump
    select com.*
    from common_dv1 com
        right join ExSeq_17k_eu_dv2 other on com.VAR_ID = other.VAR_ID
        left join common_dump dump on com.VAR_ID = dump.VAR_ID
    where dump.VAR_ID is null;

select com.VAR_ID, other.VAR_ID
from ExSeq_17k_dv2 other
    left join common_dv1 com on com.VAR_ID = other.VAR_ID
    where com.VAR_ID is null;

    
create table common_dump select * from common_dv1 where 0=1;

INSERT INTO this_table_archive
SELECT t.*
FROM this_table t
LEFT JOIN this_table_archive a on a.id=t.id
WHERE t.entry_date < '2011-01-01 00:00:00'
  AND a.id is null  # does not yet exist in archive
  
  

  
  
      