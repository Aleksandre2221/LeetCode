

         -- Approach 1. Using - 
WITH grouped AS (
  SELECT user_id, TO_CHAR(post_date, 'Week'), COUNT(*) cnt  
  FROM posts 
  WHERE post_date BETWEEN '2024-02-01' AND '2024-02-28'
  GROUP BY user_id, TO_CHAR(post_date, 'Week')
)
SELECT user_id, 
	MAX(cnt) max_7day_posts, 
  SUM(cnt)::numeric / 4 avg_weekly_posts
FROM grouped 
GROUP BY user_id
HAVING MAX(cnt) >= SUM(cnt)::numeric / 2
ORDER BY user_id;
