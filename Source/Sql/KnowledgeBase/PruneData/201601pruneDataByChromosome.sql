

DELIMITER $$

CREATE PROCEDURE `prune_table`()
BEGIN
    -- reset @tables variable
    drop table if exists prune_20k;
    
    -- find all the tables that have a VAR_ID column
    create table prune_20k SELECT DISTINCT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS  WHERE column_name = 'VAR_ID'  AND TABLE_SCHEMA = 'dig_qa';
    
    -- set statement variables
    set @delete_statement = 'delete from ';
    set @where_statement = ' where VAR_ID not like \'20_%\'';

    -- set the count of tables to be pruned
    select count(*) into @table_count from prune_20k;
    
    -- loop through the tables and remove any rows that are not chromosome 20
    WHILE (@table_count > 0)
    DO
    
      -- get the table name
      SELECT TABLE_NAME into @table_name FROM prune_20k limit 1;
  
      -- prepend the delete statement
      set @stat = concat(@delete_statement, @table_name);
      
      -- append the where statement
      set @stat = concat(@stat, @where_statement);
      
      -- create and execute the statement
      PREPARE stmt1 FROM @stat;
      EXECUTE stmt1;
      DEALLOCATE PREPARE stmt1;
  
      -- delete the table name from the listing table
      delete from prune_20k where TABLE_NAME = @table_name;
      
      -- set the count of tables to be pruned
      select count(*) into @table_count from prune_20k;
    END WHILE;
END $$

-- reset statement delimiter
delimiter ;

-- call routine
call prune_table;





-- scratch
-- SELECT DISTINCT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS  WHERE column_name = 'VAR_ID'  AND TABLE_SCHEMA = 'tad_test';


-- SELECT GROUP_CONCAT('`', table_name,'`') INTO @tables FROM INFORMATION_SCHEMA.COLUMNS WHERE column_name = 'VAR_ID'  AND TABLE_SCHEMA = 'tad_test';

--select VAR_ID from ExChip_SIGMA1_dv1__T2D where VAR_ID not like '20_%' limit 5;
-- select VAR_ID from ExChip_SIGMA1_dv1__T2D where VAR_ID like '20_%' limit 5;

-- select VAR_ID from ExChip_SIGMA1_dv1 where VAR_ID not like '20_%' limit 5;
-- select VAR_ID from ExChip_SIGMA1_dv1 where VAR_ID like '20_%' limit 5;

-- select VAR_ID from ExChip_82k_dv1__T2D where VAR_ID not like '20_%' limit 5;
-- select VAR_ID from ExChip_82k_dv1__T2D where VAR_ID like '20_%' limit 5;

-- select VAR_ID from ExChip_82k_dv1 where VAR_ID not like '20_%' limit 5;
-- select VAR_ID from ExChip_82k_dv1 where VAR_ID like '20_%' limit 5;


