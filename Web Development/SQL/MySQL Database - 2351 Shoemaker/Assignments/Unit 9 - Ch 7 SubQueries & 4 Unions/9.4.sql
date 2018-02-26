-- 9.4 Marie Kelling
-- Create view that produces the required student information with an outer join 
USE college;
CREATE OR REPLACE VIEW StudentFlatten AS
    SELECT 
        Student.ID,
        CONCAT(FirstName, ', ', LastName) AS Name,
        Major.Name AS 'Major',
        Email,
        Sex,
        DateOfBirth,
        EnrolledDate AS 'Enrolled',
        Scholarship,
        MajorID
    FROM
        Student
            LEFT OUTER JOIN
        Major ON Student.MajorID = Major.ID
    ORDER BY Name; 
    
SELECT 
    *
FROM
    StudentFlatten;