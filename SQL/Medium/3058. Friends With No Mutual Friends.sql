

-- Risolved: 4 times 


         -- Approach 1. Using - CTE and - WHERE NOT IN condition -- 
WITH two_way_friends AS (
	SELECT user_id1, user_id2 FROM friends
	UNION ALL
	SELECT user_id2, user_id1 FROM friends
)
SELECT user_id1, user_id2
FROM friends
WHERE (user_id1, user_id2) NOT IN (
	SELECT ac1.user_id1, ac2.user_id1
	FROM all_combos ac1
	JOIN all_combos ac2 ON ac1.user_id2 = ac2.user_id2
)
ORDER BY user_id1, user_id2;


		-- Approach 2. Using - WHERE NOT EXISTS condition -- 
WITH two_way_friends AS (
	SELECT user_id1 user_id, user_id2 friend FROM friends 
	UNION 
	SELECT user_id2, user_id1 FROM friends
)
SELECT f.user_id1, f.user_id2 
FROM friends f
WHERE NOT EXISTS (
	SELECT 1 
	FROM two_way_friends twf1 
	JOIN two_way_friends twf2 USING (friend)
	WHERE twf1.user_id = f.user_id1 AND twf2.user_id = f.user_id2
)
ORDER BY user_id1, user_id2;
	


	



