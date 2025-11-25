

         -- Approach 1. Using - CTE and - WHERE NOT IN condition -- 
WITH all_combos AS (
	SELECT user_id1, user_id2 FROM Friends
	UNION ALL
	SELECT user_id2, user_id1 FROM Friends
)
SELECT user_id1, user_id2
FROM friends
WHERE (user_id1, user_id2) NOT IN (
	SELECT ac1.user_id1, ac2.user_id1
	FROM all_combos ac1
	JOIN all_combos ac2 ON ac1.user_id2 = ac2.user_id2
)
ORDER BY user_id1, user_id2;
