


         -- Approach 1. Using two - CTE -- 
WITH 
	streaks AS (
    SELECT *, 
        CASE  
        		WHEN amount > LAG(amount) OVER(PARTITION BY customer_id ORDER BY transaction_date) 
        			AND transaction_date - LAG(transaction_date) OVER(PARTITION BY customer_id ORDER BY transaction_date) = 1
        		THEN 0 
        		ELSE 1 
      	END streak_id
    FROM transactions
	), 
  grps AS (
    SELECT customer_id, transaction_date, amount, 
      	SUM(streak_id) OVER(PARTITION BY customer_id ORDER BY transaction_date) grp_id
    FROM streaks
) 
SELECT customer_id, 
	MAX(transaction_date) consecutive_start, 
	MIN(transaction_date) consecutive_end
FROM grps  
GROUP BY customer_id, grp_id
HAVING COUNT(grp_id) >= 3;
