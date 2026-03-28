


         -- Approach 1. Using - CTE -- 
WITH valid_users AS (
  SELECT 
    l1.user_id, 
    l2.user_id recommended_id, 
    l1.day
  FROM listens l1  
  JOIN listens l2 
    ON l1.user_id < l2.user_id 
    AND l1.song_id = l2.song_id 
    AND l1.day = l2.day
  WHERE (l1.user_id, l2.user_id) NOT IN (SELECT user1_id, user2_id FROM friendship)
  GROUP BY l1.user_id, l2.user_id, l1.day
  HAVING COUNT(DISTINCT l1.song_id) >= 3
)
SELECT user_id, recommended_id FROM valid_users 
UNION 
SELECT recommended_id, user_id FROM valid_users; 
