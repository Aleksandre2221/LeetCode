


         -- Approach 1. 
SELECT l1.user_id, l2.user_id AS reccomended_id
FROM listens l1  
JOIN listens l2 ON l1.user_id < l2.user_id AND l1.song_id = l2.song_id AND l1.day = l2.day
WHERE (l1.user_id, l2.user_id) IN (SELECT user1_id, user2_id FROM friendship)
GROUP BY l1.user_id, l2.user_id, l1.day
HAVING COUNT(DISTINCT l1.song_id) >= 3; 
