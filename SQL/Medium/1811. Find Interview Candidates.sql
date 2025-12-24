

-- Risolved: 2 times 


         -- Approach 1. Using multiple - CTE -- 
WITH 
    unpivot AS (
      SELECT contest_id, gold_medal user_id FROM contests
      UNION ALL 
      SELECT contest_id, silver_medal FROM contests 
      UNION ALL 
      SELECT contest_id, bronze_medal FROM contests
	),
    consecutive_contests AS (
		SELECT user_id, 
			contest_id - ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY contest_id) group_id
		FROM unpivot
	),
   consecutive_cnt AS (
     SELECT DISTINCT user_id 
	   FROM consecutive_contests
     GROUP BY user_id, group_id
     HAVING COUNT(*) >= 3
	),
    gold_medals AS (
      SELECT gold_medal user_id
      FROM contests
      GROUP BY gold_medal
      HAVING COUNT(*) >= 3
)
SELECT name, mail 
FROM users 
WHERE user_id IN (SELECT user_id FROM consecutive_cnt) 
	OR user_id IN (SELECT user_id FROM gold_medals);





