-- 9.3 Marie Kelling
-- Create a view that shows all students receiving a non-zero scholarship

USE college;

CREATE OR REPLACE VIEW StudentScholarships AS
    SELECT 
        LastName AS 'Last', FirstName AS 'First', Email, Scholarship
    FROM
        Student
    WHERE
        Scholarship > 0; 
        
        SELECT 
    *
FROM
    StudentScholarships;  