


         -- Approach 1. Using - Subquery -- 
SELECT COALESCE(ROUND(AVG(cnt), 2), 0) AS average_sessions_per_user
FROM (
  SELECT COUNT(DISTINCT session_id) cnt 
  FROM activity 
  WHERE activity_date BETWEEN '2019-06-27'::date AND '2019-07-27'::date
  GROUP BY user_id
) sub;


         -- Approach 2. Using one query -- 
SELECT 
    COALESCE(
        ROUND(
                COUNT(DISTINCT session_id)::numeric 
                / NULLIF(COUNT(DISTINCT user_id), 0)
        , 2)
    , 0) average_sessions_per_user
FROM activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27';
