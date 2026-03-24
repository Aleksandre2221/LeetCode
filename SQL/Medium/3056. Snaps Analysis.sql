

         -- Approach 1. Using - SUM with - CASE...WHEN conditions -- 
SELECT 
	a.age_bucket,
    COALESCE( 
        ROUND( 
            SUM(CASE WHEN ac.activity_type = 'send' THEN time_spent END) * 100.0 
            / NULLIF(SUM(ac.time_spent), 0)
        ,2)
    ,0) send_perc, 
    COALESCE(
        ROUND( 
            SUM(CASE WHEN ac.activity_type = 'open' THEN time_spent END) * 100.0 
            / NULLIF(SUM(ac.time_spent), 0)
        ,2)
    ,0) open_perc
FROM age a  
LEFT JOIN activities ac ON a.user_id = ac.user_id 
GROUP BY a.age_bucket;
