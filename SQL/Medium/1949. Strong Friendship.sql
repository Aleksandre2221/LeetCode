

-- Risolved: 3 times


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
WHERE (user1_id, user2_id) IN (SELECT * FROM friendship);
