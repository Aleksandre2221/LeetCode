


         -- Approach 1. Using multiple - HAVING conditions -- 
SELECT
	session_id, 
  user_id, 
  ROUND(EXTRACT(EPOCH FROM MAX(event_timestamp) - min(event_timestamp)) / 60) session_duration_minutes, 
	SUM(CASE WHEN event_type = 'scroll' THEN 1 ELSE 0 END) scroll_count
FROM app_events
GROUP BY session_id, user_id 
HAVING 
	EXTRACT(EPOCH FROM MAX(event_timestamp) - min(event_timestamp)) / 60 > 30
	AND SUM(CASE WHEN event_type = 'scroll' THEN 1 ELSE 0 END) >= 5
  AND SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) = 0
	AND SUM(CASE WHEN event_type = 'click' THEN 1.0 ELSE 0 END)
		/ SUM(CASE WHEN event_type = 'scroll' THEN 1.0 ELSE 0 END) < 0.20
ORDER BY scroll_count DESC, session_id; 
