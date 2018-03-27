

CREATE PROCEDURE CollationFixTest()
  BEGIN
     DECLARE done INT DEFAULT FALSE;
     DECLARE signatureCount INT;
     DECLARE tableName CHAR(100);

    DECLARE c1 CURSOR FOR select TABLE_NAME from information_schema.columns where TABLE_SCHEMA = 'digkb' and COLUMN_NAME = 'GEN_ID' and COLLATION_NAME != 'utf8mb4_unicode_ci';
    DECLARE CONTINUE HANDLER FOR not_found SET at_end = 1;
    OPEN c1;
  
    ins_loop: LOOP

      FETCH c1 INTO tableName;

      IF at_end = 1 THEN
        LEAVE ins_loop;
      END  IF;

        set @ddl = CONCAT('ALTER TABLE ', tableName, ' MODIFY GEN_ID text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci');
        select @ddl;
--        prepare stmt from @ddl;
--        execute stmt;
--        DEALLOCATE PREPARE stmt;

       
    
    END LOOP
    CLOSE c1
  END
  
  DELIMITER ;

