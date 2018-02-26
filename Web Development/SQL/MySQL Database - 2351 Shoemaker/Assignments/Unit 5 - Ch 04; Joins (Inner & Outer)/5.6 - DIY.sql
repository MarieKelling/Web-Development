-- 5.6 Marie Kelling
-- DIY - Inner joins at least 4 tables  
USE college;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    registration.Grade AS 'Grade',
    semester.Name AS 'Semester'
FROM
    Student
        INNER JOIN
    Registration ON Student.ID = registration.StudentID
        INNER JOIN
    Section ON registration.SectionID = sectionID
        INNER JOIN
    Semester ON section.SemesterID = semester.ID
ORDER BY LastName , FirstName , semester, Grade; 