-- 6.7 - Marie Kelling
-- DIY - Join 3 tables, aggregate 2 statistics, use GROUP BY and the Semester table
USE college;
SELECT 
    Semester.Name AS 'Semester',
    COUNT(Course.Name) AS 'Number of Courses Offered',
    AVG(Course.CreditHours) AS 'Average Credit Hours',
    MIN(Course.CreditHours) AS 'Lowest Credit Hour',
    MAX(Course.CreditHours) AS 'Highest Credit Hour'
FROM
    Course
        INNER JOIN
    Section ON Course.ID = Section.CourseID
        INNER JOIN
    Semester ON Section.SemesterID = Semester.ID
GROUP BY Semester.Name
ORDER BY Semester; 