-- 11.1 Marie Kelling
-- Update student information
USE college; 
UPDATE student 
SET 
    LastName = 'Nelson', MajorID = 2, Email = 'DeborahNelson@college.edu'
WHERE
    ID = 48; 
    
SELECT 
    *
FROM
    student
WHERE
    id = 48;