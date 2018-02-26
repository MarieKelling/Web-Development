-- 6.6 - Marie Kelling
-- List the Clubs, the number of members in each club, and the date the first member joined each club
USE college;
SELECT 
    Club.Name AS 'Club',
    COUNT(*) AS 'Number of Members',
    MIN(DateJoined) AS 'Earliest Member'
FROM
    Membership
        INNER JOIN
    Club ON Membership.ClubID = Club.ID
GROUP BY Club.Name
ORDER BY Club.Name; 