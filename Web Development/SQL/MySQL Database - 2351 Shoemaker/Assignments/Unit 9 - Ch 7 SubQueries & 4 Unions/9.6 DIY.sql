-- 9.6 Marie Kelling
-- DIY Create view of your choice using 3 joins, one being an outer join
USE college;
CREATE OR REPLACE VIEW StudentClubMembership AS
    SELECT 
        LastName AS 'Last',
        FirstName AS 'First',
        Membership.DateJoined AS 'Membership',
        Club.Name AS 'Club'
    FROM
        Student
            INNER JOIN
        Membership ON Student.ID = Membership.StudentID
            LEFT OUTER JOIN
        Club ON Membership.ClubID = Club.ID
    ORDER BY Last , First;
    
SELECT 
    *
FROM
    StudentClubMembership;