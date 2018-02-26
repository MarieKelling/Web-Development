-- 9.5 Marie Kelling
-- List all students majoring in nursing 
USE college;
CREATE OR REPLACE VIEW NursingStudents AS
    SELECT 
        *
    FROM
        StudentFlatten
    WHERE
        MajorID = 5;
        
SELECT 
    *
FROM
    NursingStudents
WHERE
    Scholarship > 0;