

DELIMITER $$

CREATE PROCEDURE `prune_table_by_chromosome`()
BEGIN
    -- reset @tables variable
    drop table if exists prune_chromosome;
    
    -- find all the tables that have a VAR_ID column
    create table prune_chromosome SELECT DISTINCT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS  WHERE column_name = 'VAR_ID'  AND TABLE_SCHEMA = 'dig_qa';
    
    -- set statement variables
--    set @delete_statement = 'delete from ';
    set @where_statement = ' where VAR_ID like \'8_%\'';
    set @drop_statement = 'drop table ';
    set @rename_statement = 'rename table ';
    set @create_statement = 'create table ';
    set @from_statement = ' as select * from ';
    set @to_word = ' to ';
    set @new_table_prefix = 'dude_';
    
    -- set the count of tables to be pruned
    select count(*) into @table_count from prune_chromosome;
    
    -- loop through the tables and remove any rows that are not chromosome 20
    WHILE (@table_count > 0)
    DO
    
      -- get the table names (@table_name, @new_table_name)
      SELECT TABLE_NAME into @table_name FROM prune_chromosome limit 1;
      set @new_table_name = concat(@new_table_prefix, @table_name);
      
      -- create the new table
      -- create the new statement
      set @stat = concat(@create_statement, @new_table_name);
      set @stat = concat(@stat, @from_statement);
      set @stat = concat(@stat, @table_name);
      set @stat = concat(@stat, @where_statement);      
      -- create and execute the statement
      PREPARE stmt1 FROM @stat;
      EXECUTE stmt1;
      DEALLOCATE PREPARE stmt1;

      -- drop the old table
      set @stat = concat(@drop_statement, @table_name);
      -- create and execute the statement
      PREPARE stmt1 FROM @stat;
      EXECUTE stmt1;
      DEALLOCATE PREPARE stmt1;

      -- rename the new table to the old one
      set @stat = concat(@rename_statement, @new_table_name);
      set @stat = concat(@stat, @to_word);
      set @stat = concat(@stat, @table_name);
      -- create and execute the statement
      PREPARE stmt1 FROM @stat;
      EXECUTE stmt1;
      DEALLOCATE PREPARE stmt1;
      
      -- delete the table name from the listing table
      delete from prune_chromosome where TABLE_NAME = @table_name;
      
      -- set the count of tables to be pruned
      select count(*) into @table_count from prune_chromosome;
    END WHILE;
END $$

-- reset statement delimiter
delimiter ;

-- call routine
call prune_table_by_chromosome;





-- scratch

-- to verify counts of variants by chromosome
-- select count(var_id), substring(var_id, 1,2) as chrom from ExChip_82k_dv1 group by chrom;





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


