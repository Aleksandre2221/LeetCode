

         -- Approach 1. Using - CTE -- 
WITH weekly_cnt AS (
  SELECT user_id, post_date, 
  	 COUNT(*) OVER(
    		 	PARTITION BY user_id
    			ORDER BY post_date
    		 	RANGE BETWEEN INTERVAL '6 days' PRECEDING AND CURRENT ROW) cnt
  FROM posts 
  WHERE DATE_TRUNC('month', post_date) = '2024-02-01'
)
SELECT 
	user_id,
    MAX(cnt) max_7day_posts, 
    (COUNT(*) * 1.0 / 4) avg_weekly_posts  
FROM weekly_cnt  
GROUP BY user_id
HAVING 
	(COUNT(*) * 1.0 / 4) * 2 <= MAX(cnt)

