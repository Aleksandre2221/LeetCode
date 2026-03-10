


         -- Approach 1. Using one - CTE with - ROW_NUMBER() and - WHERE EXISTS condition -- 
WITH ordered_sessions AS (
	SELECT *,
       ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY session_start) rn 
	FROM sessions
)
SELECT user_id, COUNT(*) sessions_count 
FROM sessions s  
WHERE session_type = 'Streamer' 
	AND EXISTS (
      SELECT 1 
      FROM ordered_sessions os  
      WHERE s.user_id = os.user_id 
      	AND os.rn = 1 
      	AND os.session_type = 'Viewer'
)
GROUP BY user_id 
HAVING COUNT(*) > 0 
ORDER BY sessions_count, user_id DESC; 



         -- Approach 2. Using - CTE and - NOT IN condition --  
WITH row_num AS (
  SELECT *, 
  	ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY session_start) rn
  FROM sessions 
)
SELECT user_id, COUNT(*) sessions_count
FROM sessions 
WHERE user_id IN (
  SELECT user_id 
  FROM row_num 
  WHERE rn = 1 AND session_type = 'Viewer'
)
AND session_type <> 'Viewer'
GROUP BY user_id
ORDER BY sessions_count DESC, user_id DESC






