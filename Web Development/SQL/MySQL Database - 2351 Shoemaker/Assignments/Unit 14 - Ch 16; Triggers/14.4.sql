-- 14.4 Marie Kelling
-- Create SysLog Table
DROP TABLE IF EXISTS SysLog ;

CREATE TABLE IF NOT EXISTS SysLog 
(
  ID INT NOT NULL AUTO_INCREMENT,
  TableName VARCHAR(255) NOT NULL COMMENT 'The table that is being logged',
  Message VARCHAR(255)  NOT NULL COMMENT 'The logging message',
  Created DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (ID)  
)
ENGINE = InnoDB
 COMMENT 'The system log table' ;
CREATE UNIQUE INDEX SysLog_UNIQUE ON SysLog (ID ASC)  ;

-- Create After Update Trigger that creates a record in the new SysLog table whenever a record in the Student table is changed 
USE College ;
DROP TRIGGER IF EXISTS  Student_After_Update; 
DELIMITER $$

CREATE TRIGGER Student_After_Update 
AFTER UPDATE ON Student
FOR EACH ROW 
	BEGIN 
		INSERT INTO SysLog (TableName, Message, Created) 
		VALUES ('Student', CONCAT('Updated ID = ', New.ID), NOW());
	END $$
DELIMITER ;

UPDATE Student 
SET Scholarship = 5000
WHERE ID = 5; 

UPDATE Student 
SET Scholarship = 10000
WHERE ID = 10; 

UPDATE Student 
SET Scholarship = 15000
WHERE ID = 15; 

SELECT * FROM SysLog
ORDER BY ID DESC; 

