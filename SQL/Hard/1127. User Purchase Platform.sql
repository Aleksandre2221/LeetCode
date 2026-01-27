


         -- Approach 1. Using two - CTE -- 
WITH 
	all_cat AS (
    SELECT DISTINCT spend_date, 'mobile' platform FROM spending
    UNION ALL 
    SELECT DISTINCT spend_date, 'desktop' FROM spending 
    UNION ALL  
    SELECT DISTINCT spend_date, 'both' FROM spending
	),
  calc AS (
    SELECT spend_date, user_id, 
        SUM(amount) total, 
        CASE  
          WHEN COUNT(platform) = 1 
          THEN MIN(platform) 
          ELSE 'both'
        END platform 
    FROM spending 
    GROUP BY spend_date, user_id 
)
SELECT ac.spend_date, ac.platform, 
	COALESCE(SUM(c.total), 0) total_amount, 
  COALESCE(COUNT(c.user_id), 0) total_users
FROM all_cat ac  
LEFT JOIN calc c ON ac.spend_date = c.spend_date AND ac.platform = c.platform 
GROUP BY ac.spend_date, ac.platform
ORDER BY ac.spend_date, ac.platform;
