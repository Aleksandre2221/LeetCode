

         -- Approach 1. Using - Subquery with - CASE...WHEN condition -- 
SELECT DISTINCT user_id
FROM (
    SELECT 
        user_id,
        created_at - LAG(created_at) OVER(PARTITION BY user_id ORDER BY created_at) diff_days
    FROM users
) sub
WHERE diff_days <= 7;



         -- Approach 2. Using - WHERE EXISTS condition -- 
SELECT u1.user_id 
FROM users u1 
WHERE EXISTS ( 
  SELECT 1 
  FROM users u2 
  WHERE u1.user_id = u2.user_id 
  	AND u1.created_at < u2.created_at 
  	AND u2.created_at - u1.created_at <= 7
)
