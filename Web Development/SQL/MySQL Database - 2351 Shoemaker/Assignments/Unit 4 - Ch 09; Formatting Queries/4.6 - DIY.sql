-- 4.6 Marie Kelling
-- DIY - Holiday Dates and Week Number
USE starter;
SELECT 
    STR_TO_DATE('October 31, 2017', '%M %d, %Y') AS 'Halloween',
    weekofyear('2017-10-31') as 'Week Number',
    STR_TO_DATE('December 25, 2017', '%M %d, %Y') AS 'Christmas',
    WEEKOFYEAR('2017-12-25') AS 'Week Number'; 