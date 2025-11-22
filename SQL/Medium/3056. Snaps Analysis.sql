

         -- Approach 1. Using - SUM with - CASE...WHEN conditions -- 
SELECT age.age_bucket, 
	ROUND(SUM(CASE WHEN act.activity_type = 'send' THEN act.time_spent END) * 100.0 / SUM(act.time_spent), 2) send_perc,
	ROUND(SUM(CASE WHEN act.activity_type = 'open' THEN act.time_spent END) * 100.0 / SUM(act.time_spent), 2) open_perc
FROM activities act  
JOIN age ON age.user_id = act.user_id
GROUP BY age.age_bucket;
