

-- Risolved: 4 times


         -- Approach 1. Using two - JOIN -- 
WITH bidir AS (
  SELECT user1_id user, user2_id friend FROM friendship
  UNION ALL
  SELECT user2_id, user1_id FROM friendship
)
SELECT 
    b1.user user1_id,
    b2.user user2_id,
    COUNT(*) common_friend
FROM bidir b1
JOIN bidir b2 
    ON b1.friend = b2.friend
    AND b1.user < b2.user
JOIN friendship f
    ON f.user1_id = b1.user 
    AND f.user2_id = b2.user
GROUP BY b1.user, b2.user
HAVING COUNT(*) >= 3;
