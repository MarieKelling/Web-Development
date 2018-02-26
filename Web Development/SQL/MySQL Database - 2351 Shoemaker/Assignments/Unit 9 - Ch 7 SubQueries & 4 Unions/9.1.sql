-- 9.1 Marie Kelling
-- List students with a scholarship greater than the average scholarship for the school

USE college; 
SELECT 
    LastName AS 'Last',
    FirstName AS 'First',
    Major.Name AS 'Major',
    Scholarship
FROM
    Student
        INNER JOIN
    Major ON Student.MajorID = MajorID
WHERE
    Scholarship > (SELECT 
            AVG(Scholarship)
        FROM
            Student)
ORDER BY LastName; 