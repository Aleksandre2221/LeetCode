


         -- Approach 1. Using two - CTE -- 
WITH 
 	valid_users AS (
      SELECT user_id, COUNT(*) total_cnt
      FROM reactions 
      GROUP by user_id 
      HAVING COUNT(DISTINCT content_id) >= 5
	),
    react_stats AS (
		SELECT user_id, reaction, 
      COUNT(reaction) react_cnt,
      ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY COUNT(reaction) DESC) rnk
		FROM reactions 
		GROUP BY user_id, reaction 
)
SELECT vu.user_id, 
	MAX(CASE WHEN rnk = 1 THEN reaction END) dominant_reaction, 
	ROUND(MAX(CASE WHEN rnk = 1 THEN react_cnt END) * 1.0 / vu.total_cnt , 2) reaction_ratio
FROM valid_users vu 
JOIN react_stats rs USING(user_id)
GROUP BY vu.user_id, vu.total_cnt
HAVING MAX(CASE WHEN rnk = 1 THEN react_cnt END) * 1.0 / vu.total_cnt > 0.60
ORDER BY reaction_ratio DESC, user_id
