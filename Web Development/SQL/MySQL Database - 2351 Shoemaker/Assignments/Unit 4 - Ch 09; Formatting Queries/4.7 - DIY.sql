-- 4.7 Marie Kelling
-- DIY - Replaces F for Female and inserts zeros into Emails 
USE starter;
SELECT 
    LastName AS 'Last Name',
    INSERT(Email, '1', '2', '00') AS 'Email',
    REPLACE(Sex, 'F', 'Female') AS 'Sex'
FROM
    student; 

