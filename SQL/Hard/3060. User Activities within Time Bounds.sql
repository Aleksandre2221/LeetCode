


         -- Approach 1. Using - CTE with - LAG() -- 
WITH ordered_sessions AS (
    SELECT *,
        LAG(session_end) OVER (PARTITION BY user_id, session_type ORDER BY session_start) prev_session_end
    FROM sessions
)
SELECT DISTINCT user_id
FROM ordered_sessions
WHERE prev_session_end IS NOT NULL
  AND session_start - prev_session_end <= INTERVAL '12 hours'
ORDER BY user_id;
