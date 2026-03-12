

         -- Approach 1. Using - UNION ALL -- 
WITH bidir AS (
    SELECT user1_id user_id, user2_id friend_id FROM friendship
    UNION ALL 
    SELECT user2_id, user1_id FROM friendship
)     
SELECT DISTINCT l.page_id recommended_page 
FROM likes l 
JOIN bidir b ON l.user_id = b.friend_id
WHERE b.user_id = 1 
    AND l.page_id NOT IN (
        SELECT page_id 
        FROM likes 
        WHERE user_id = 1
)









