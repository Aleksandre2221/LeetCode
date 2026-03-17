

         -- Approach 1. Using - WHERE condtions -- 
SELECT e.user_id
FROM emails e 
JOIN texts t 
    ON e.email_id = t.email_id 
    AND t.signup_action = 'Verified'
    AND t.action_date > e.signup_date
    AND t.action_date <= e.signup_date + INTERVAL '1 Day'
ORDER BY e.user_id;
  
