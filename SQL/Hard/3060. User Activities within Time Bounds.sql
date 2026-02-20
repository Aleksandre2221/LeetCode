


         -- Approach 1. Using - CTE with - LAG() -- 
WITH prev_end_time AS (
  SELECT *, 
  	LAG(session_end) OVER(PARTITION BY user_id, session_type ORDER BY session_start) prev_end
  FROM sessions 
)
SELECT user_id  
FROM prev_end_time
WHERE session_start - prev_end <= INTERVAL '12 hours'
ORDER BY user_id;



         -- Approach 2. Using - Self-Join -- 
SELECT DISTINCT s1.user_id
FROM sessions s1
JOIN sessions s2 
  ON s1.user_id = s2.user_id 
  AND s1.session_type = s2.session_type 
  AND s2.session_start >= s1.session_end
  AND s2.session_start - s1.session_end <= INTERVAL '12 hours'
ORDER BY user_id;
