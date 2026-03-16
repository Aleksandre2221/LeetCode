

         -- Approach 1. Using - TO_CHAR (For Postgre/Oracle) -- 
SELECT TO_CHAR(day, 'FMDay, FMMonth FMDD, YYYY') "day"
FROM days;


         -- Approach 2. Using - DATE_FORMAT (For MySQL) -- 
SELECT DATE_FORMAT(day, '%W, %M %e, %Y') AS day
FROM days;
