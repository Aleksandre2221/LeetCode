

-- Risolved: 2 times


         -- Approach 1. Using - SPLIT_PART (Only in PostgreSQL) -- 
SELECT SPLIT_PART(email, '@', 2) email_domain, COUNT(*) 
FROM emails
WHERE RIGHT(email, 4) = '.com'
GROUP BY SPLIT_PART(email, '@', 2);



         -- Approach 2. Using - SUBTRING(... FROM POSITION (...)) -- SQL Standard
SELECT SUBSTRING(email FROM POSITION('@' IN email) + 1), COUNT(*)
FROM emails
WHERE RIGHT(email, 4) = '.com'
GROUP BY SUBSTRING(email FROM POSITION('@' IN email) + 1);
