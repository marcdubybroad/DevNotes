

DELIMITER $$

CREATE PROCEDURE `delete_table`()
BEGIN
    -- reset @tables variable
    drop table if exists delete_tables;
    
    -- find all the tables that have a VAR_ID column
    create table delete_tables SELECT DISTINCT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS  WHERE table_name like 'ExSeq_13k%'  AND TABLE_SCHEMA = 'dig_qa';
    
    -- set statement variables
    set @drop_table_statement = 'drop table ';

    -- set the count of tables to be pruned
    select count(*) into @table_count from delete_tables;
    
    -- loop through the tables and remove any rows that are not chromosome 20
    WHILE (@table_count > 0)
    DO
    
      -- get the table name
      SELECT TABLE_NAME into @table_name FROM delete_tables limit 1;
  
      -- prepend the delete statement
      set @stat = concat(@drop_table_statement, @table_name);
      
      -- create and execute the statement
      PREPARE stmt1 FROM @stat;
      EXECUTE stmt1;
      DEALLOCATE PREPARE stmt1;
  
      -- delete the table name from the listing table
      delete from delete_tables where TABLE_NAME = @table_name;
      
      -- set the count of tables to be pruned
      select count(*) into @table_count from delete_tables;
    END WHILE;
END $$

-- reset statement delimiter
delimiter ;

-- call routine
call delete_table;





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


