


         -- Approach 1. Using multiple - CTE -- 
WITH  
	bidir AS (
      SELECT user1_id AS user_id, user2_id AS friend_id FROM friendship 
      UNION ALL 
      SELECT user2_id, user1_id FROM friendship
	), 
    friends_like AS (
      SELECT b.user_id, l.page_id
      FROM likes l  
      JOIN bidir b ON l.user_id = b.friend_id
	), 
    excluded AS (
      SELECT f1.user_id, f1.page_id 
      FROM friends_like f1 
      WHERE NOT EXISTS (
        SELECT 1 
        FROM likes l 
        WHERE l.user_id = f1.user_id  
        	AND l.page_id = f1.page_id)
)
SELECT user_id, page_id, 
	COUNT(*) friends_likes
FROM excluded
GROUP BY user_id, page_id;


