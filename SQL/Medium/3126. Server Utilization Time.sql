

         -- Approach 1. Using two - CTE -- 
WITH 
	prev_values AS (
    	SELECT *, 
        	LAG(status_time) OVER(PARTITION BY server_id ORDER BY status_time) prev_time,
        	LAG(session_status) OVER(PARTITION BY server_id ORDER BY status_time) prev_status
    	FROM servers
	),
	diff AS (
    	SELECT server_id,
        	CASE 
            	WHEN session_status = 'stop' AND prev_status = 'start'
            	THEN status_time - prev_time
        	END interval_diff
   		 FROM prev_values
)
SELECT ROUND(SUM(EXTRACT(EPOCH FROM interval_diff)) / 86400.0, 0) total_uptime_days
FROM diff;
