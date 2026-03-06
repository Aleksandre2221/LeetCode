


         -- Approach 1. Using - CTE -- 
WITH daily_rate AS (
    SELECT a.action_date,
        COUNT(DISTINCT r.post_id) * 100.0 / COUNT(DISTINCT a.post_id) remove_rate
    FROM actions a
    LEFT JOIN removals r ON r.post_id = a.post_id
    WHERE a.extra = 'spam'
    GROUP BY a.action_date
)
SELECT ROUND(AVG(remove_rate), 2) average_daily_percent  
FROM daily_rate;
