

-- Risolved: 4 times


         -- Approach 1. Using - CTE with - UNION ALL - 
WITH 
    bidir AS (
        SELECT user1_id, user2_id FROM friendship 
        UNION ALL 
        SELECT user2_id, user1_id FROM friendship
    ), 
    com_fr AS ( 
      SELECT b1.user1_id, b2.user2_id, COUNT(*) common_friend
      FROM bidir b1  
      JOIN bidir b2 ON b1.user2_id = b2.user1_id AND b1.user1_id < b2.user2_id
      GROUP BY b1.user1_id, b2.user2_id
      HAVING COUNT(*) >= 3
)
SELECT * 
FROM com_fr 
WHERE (user1_id, user2_id) IN (SELECT * FROM bidir);



         -- Approach 2. Using two - JOIN -- 
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
