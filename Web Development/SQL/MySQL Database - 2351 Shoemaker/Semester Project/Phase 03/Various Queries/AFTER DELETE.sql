-- Phase 3 Marie Kelling
-- 14. AFTER DELETE that writes a record into a log/audit table
DROP TABLE IF EXISTS CustomerLog ;

CREATE TABLE IF NOT EXISTS CustomerLog 
(
  ID INT NOT NULL AUTO_INCREMENT,
  TableName VARCHAR(255) NOT NULL COMMENT 'The table that is being logged',
  Message VARCHAR(255)  NOT NULL COMMENT 'The logging message',
  Created DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (ID)  
)
ENGINE = InnoDB
 COMMENT 'The system log table' ;
CREATE UNIQUE INDEX CustomerLog_UNIQUE ON CustomerLog (ID ASC)  ;
-- --------------------------------------------------------------------------------------
USE brendasmek;
DROP TRIGGER IF EXISTS  Customer_After_Update; 
DELIMITER $$

CREATE TRIGGER Customer_After_Update 
AFTER UPDATE ON Customer
FOR EACH ROW 
	BEGIN 
		INSERT INTO CustomerLog (TableName, Message, Created) 
		VALUES ('Customer', CONCAT('Updated Email = ', New.Email), NOW());
	END $$
DELIMITER ;

UPDATE Customer 
SET Email = 'LexyVost@BrendasBakery.com'
WHERE ID = 5; 

UPDATE Customer 
SET Email = 'LennaMcGiffie@BrendasBakery.com'
WHERE ID = 6; 

UPDATE Customer 
SET Email = 'NorbieMorse@BrendasBakery.com'
WHERE ID = 7; 

SELECT * FROM CustomerLog
ORDER BY ID DESC; 