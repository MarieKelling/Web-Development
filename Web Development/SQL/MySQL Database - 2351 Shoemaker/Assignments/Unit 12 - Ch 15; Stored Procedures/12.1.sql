-- 12.1 Marie Kelling
-- Create procedure that lists all student with a scholarship
USE college;
DROP PROCEDURE IF EXISTS Students_With_Scholarships;
DELIMITER $$ 
CREATE PROCEDURE Students_With_Scholarships()
BEGIN 
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Scholarship
FROM
    Student
WHERE
    Scholarship > 0
ORDER BY LastName;
END
$$
DELIMITER ;

CALL Students_With_Scholarships; 


 