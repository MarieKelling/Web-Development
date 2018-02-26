-- 12.5 Marie Kelling
-- Create & call a function that takes a StudentID as the IN and returns the # of sections that student is registered for
USE college;
DROP FUNCTION IF EXISTS Student_Section_Count;
DELIMITER $$ 
CREATE FUNCTION Student_Section_Count(StudentID INT)
RETURNS INT
BEGIN
    DECLARE sectionCount INT;

    SET sectionCount = 
		 (SELECT COUNT(SectionID)
		  FROM
            Registration
		  WHERE Registration.StudentID = StudentID);
    
    RETURN sectionCount; 
END
$$
DELIMITER ; 

SELECT STUDENT_SECTION_COUNT(1) AS Sections; 
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    STUDENT_SECTION_COUNT(ID) AS Sections
FROM
    Student
    LIMIT 6;
    
    