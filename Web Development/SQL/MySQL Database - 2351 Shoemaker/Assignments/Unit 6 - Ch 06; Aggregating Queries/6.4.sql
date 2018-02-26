-- 6.4 - Marie Kelling
-- List Faculty members who teach at least 15 students, the number of students, and the average grade
USE college;
SELECT 
    CONCAT(Faculty.LastName,
            ', ',
            Faculty.FirstName) AS 'Faculty',
    COUNT(*) AS 'Students',
    ROUND(AVG(grade), 1) AS 'Average Grade'
FROM
    Student
        INNER JOIN
    Registration ON Student.ID = Registration.StudentID
        INNER JOIN
    Section ON Registration.SectionID = Section.ID
        INNER JOIN
    Faculty ON Section.TaughtByID = Faculty.ID
GROUP BY Faculty.LastName
HAVING MIN(Section.TaughtByID) >= 15 
ORDER BY Faculty.LastName; 
    
