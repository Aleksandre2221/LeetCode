

-- Risolved: 2 times


         -- Approach 1. Using - CTE with - UNION ALL - 
WITH all_friends AS (
  SELECT * FROM friendship 
  UNION ALL  
  SELECT user2_id, user1_id FROM friendship
)
SELECT a1.user1_id, a2.user1_id user2_id, COUNT(*) common_friend
FROM all_friends a1
JOIN all_friends a2 ON a1.user1_id < a2.user1_id AND a1.user2_id = a2.user2_id
GROUP BY a1.user1_id, a2.user1_id
HAVING COUNT(*) > 2;
