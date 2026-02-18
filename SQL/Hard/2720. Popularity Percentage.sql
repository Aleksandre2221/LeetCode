


         -- Approach 1. Using - CTE -- 
WITH bidir AS (
  SELECT user1, user2 FROM friends 
  UNION ALL  
  SELECT user2, user1 FROM friends
)
SELECT user1, 
	ROUND(COUNT(user2) * 100.0 / (SELECT COUNT(*) FROM friends), 2) percentage_popularity 
FROM bidir
GROUP BY user1 
ORDER BY user1;
