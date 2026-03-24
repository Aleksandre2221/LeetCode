

         -- Approach 1. Using - CTE -- 
WITH row_num AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY server_id, session_status ORDER BY status_time) rn
    FROM servers
)
SELECT 
	FLOOR(SUM(EXTRACT(EPOCH FROM (rn1.status_time - rn2.status_time))) / 86400) total_uptime_days
FROM row_num rn1
JOIN row_num rn2 
    ON rn1.server_id = rn2.server_id
    AND rn1.rn = rn2.rn
    AND rn1.session_status = 'stop'
    AND rn2.session_status = 'start';
