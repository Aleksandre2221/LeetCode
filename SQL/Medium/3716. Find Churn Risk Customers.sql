

         -- Approach 1. Using - CTE -- 
WITH sub_period AS (
  SELECT user_id, 
      MAX(event_date) - MIN(event_date) days_as_subscriber,
      MAX(monthly_amount) max_historical_amount, 
      MAX(event_date) event_date
  FROM subscription_events
  WHERE 
    user_id IN (
      SELECT DISTINCT user_id  
      FROM subscription_events
      WHERE event_type = 'downgrade'
    )
    AND	user_id NOT IN (
      SELECT DISTINCT user_id  
      FROM subscription_events
      WHERE event_type = 'cancel'
    )
  GROUP BY user_id
  HAVING MAX(event_date) - MIN(event_date) >= 60
)
SELECT 
  se.user_id,
  se.plan_name current_plan, 
  se.monthly_amount current_monthly_amount,
  sp.max_historical_amount, 
  sp.days_as_subscriber 
FROM sub_period sp 
JOIN subscription_events se ON sp.user_id = se.user_id
WHERE se.monthly_amount / sp.max_historical_amount < 0.5
ORDER BY days_as_subscriber DESC, user_id;
