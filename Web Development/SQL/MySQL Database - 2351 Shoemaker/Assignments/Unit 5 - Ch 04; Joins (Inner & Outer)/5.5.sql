-- Marie Kelling
-- List Majors that have no students
USE college;
SELECT *
    -- Student.majorID as 'ID', 
    -- Major.Name as 'Major'
FROM
    Student INNER JOIN Major 
    ON student.majorID IS NULL;
       --  AND major.ID = student.majorID; 
    
