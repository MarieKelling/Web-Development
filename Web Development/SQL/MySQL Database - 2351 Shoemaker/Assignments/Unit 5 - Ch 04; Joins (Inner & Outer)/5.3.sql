-- 5.3 Marie Kelling
-- List students, their courses, and their grades
USE college;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    course.Name AS 'Course',
    registration.Grade AS 'Grade'
FROM
    Student
        INNER JOIN
    Registration ON Student.ID = registration.StudentID
        INNER JOIN 
    Section ON registration.SectionID = sectionID
        INNER JOIN
    Course ON Section.CourseID = Course.ID
ORDER BY LastName , FirstName , course;    