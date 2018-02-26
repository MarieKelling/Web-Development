-- 6.5 - Marie Kelling
-- List all students on the Dean's List
USE college;
SELECT 
    CONCAT(Student.LastName,
            ', ',
            Student.FirstName) AS 'Student',
    Major.Name AS 'Major',
    ROUND(AVG(Grade), 2) AS 'GPA'
FROM
    Registration
        INNER JOIN
    Student ON Registration.StudentID = Student.ID
        INNER JOIN
    Major ON Student.MajorID = Major.ID
GROUP BY Student.LastName
HAVING AVG(Registration.Grade) >= 3.5
ORDER BY Student.LastName , Student.FirstName;
    