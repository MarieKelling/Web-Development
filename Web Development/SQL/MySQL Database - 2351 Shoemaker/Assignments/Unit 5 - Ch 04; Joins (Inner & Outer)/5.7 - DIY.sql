-- 5.7 Marie Kelling
-- DIY - Uses at least one outer join and shows at least one record that doesn't match on the join
USE college;
SELECT 
    Course.Name as 'Course',
    Section.Name as 'Section'
FROM
    Course
        LEFT OUTER JOIN
    Section ON Course.ID = Section.CourseID; 
    
