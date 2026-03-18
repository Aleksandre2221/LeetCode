

         -- Approach 1. Using one - CTE with Window Function - LAG() -- 
WITH diff AS (
  SELECT user_id,   
      COALESCE(LAG(visit_date) OVER(PARTITION BY user_id ORDER BY visit_date DESC), '2021-01-01'::date) 
	  - visit_date AS diff
  FROM uservisits 
)
SELECT user_id, MAX(diff) biggest_window 
FROM diff 
GROUP BY user_id
ORDER BY user_id;



