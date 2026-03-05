

         -- Approach 1. Using - Subquery with Window Function - ROW_NUMBER() -- 
SELECT activity_date login_date, COUNT(*) user_count
FROM (
  SELECT *, ROW_NUMBER() OVER(PARTITION BY user_id, activity ORDER BY activity_date) rn
  FROM traffic
  WHERE activity = 'login'
) sub
WHERE rn = 1 
    AND activity_date BETWEEN ('2019-06-30'::date - INTERVAL '90 DAYS') AND '2019-06-30'::date
GROUP BY activity_date;




        -- Appraoch 2. Using - Subquery with Window Function - FIRST_VALUES() -- 
SELECT activity_date login_date, COUNT(*) user_count
FROM (
    SELECT user_id, activity_date,
		    FIRST_VALUE(activity_date) OVER(PARTITION BY user_id ORDER BY activity_date) first_login
    FROM traffic
    WHERE activity = 'login'
) sub
WHERE activity_date = first_login 
	AND activity_date BETWEEN ('2019-06-30'::date - INTERVAL '90 DAYS') AND '2019-06-30'::date
GROUP BY activity_date;




         -- Approach 3. Withou using Window Functions -- 
SELECT first_login login_date, COUNT(*) AS user_count
FROM (
    SELECT user_id, MIN(activity_date) AS first_login
    FROM traffic
    WHERE activity = 'login'
    GROUP BY user_id
) sub
WHERE first_login BETWEEN ('2019-06-30'::date - INTERVAL '90 DAYS') AND '2019-06-30'::date
GROUP BY first_login;






