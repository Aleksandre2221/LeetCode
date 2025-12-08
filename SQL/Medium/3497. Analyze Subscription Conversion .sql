

         -- Approach 1. Using - GROUP BY with - HAVING and aggregations with - CASE...WHEN conditions -- 
SELECT user_id,
    ROUND(AVG(CASE WHEN activity_type = 'free_trial' THEN activity_duration END), 2) trial_avg_duration,
    ROUND(AVG(CASE WHEN activity_type = 'paid' THEN activity_duration END), 2) paid_avg_duration
FROM useractivity
GROUP BY user_id
HAVING SUM(CASE WHEN activity_type = 'paid' THEN 1 ELSE 0 END) > 0
ORDER BY user_id;
