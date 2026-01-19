

-- Risolved: 2 times


         -- Approach 1. Using - CTE with multiple Window Functions -- 
WITH max_min_date AS (
    SELECT *, 
        MAX(event_date) OVER(PARTITION BY user_id) max_date, 
        MAX(monthly_amount) OVER(PARTITION BY user_id) max_amount,
        MAX(event_date) OVER(PARTITION BY user_id) - MIN(event_date) OVER(PARTITION BY user_id) sub_days 
    FROM subscription_events 
    WHERE user_id IN (
         SELECT DISTINCT user_id 
         FROM subscription_events 
         WHERE event_type = 'downgrade')
)
SELECT user_id, 	
    plan_name current_plan,
    monthly_amount current_monthly_amount, 
    max_amount max_historical_amount, 
    sub_days days_as_subscriber
FROM max_min_date 
WHERE event_date = max_date
    AND sub_days >= 60 
    AND monthly_amount / max_amount < 0.5
    AND monthly_amount > 0
ORDER BY days_as_subscriber, user_id;
