



SET @tables = NULL;
SELECT GROUP_CONCAT('`', table_schema, '`.`', table_name,'`') INTO @tables FROM information_schema.tables  WHERE table_schema = 'dig_kb' AND table_name LIKE BINARY '%RAW';

SET @tables = CONCAT('DROP TABLE ', @tables);
PREPARE stmt1 FROM @tables;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;



