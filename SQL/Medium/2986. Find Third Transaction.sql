

         -- Approach 1. Using two - CTE -- 
WITH 
	row_num AS (
      SELECT *, 
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) rn 
      FROM transactions
    ), 
    valid_users AS (
      SELECT *, 
      	CASE  
      		WHEN LAG(spend) OVER(PARTITION BY user_id ORDER BY transaction_date) < spend 
      			AND LAG(spend, 2) OVER(PARTITION BY user_id ORDER BY transaction_date) < spend
      		THEN 1 
      		ELSE 0 
      	END valid_id
	  FROM row_num 
	  WHERE rn <= 3
)
SELECT 
	user_id, 
    spend third_transaction_spend, 
    transaction_date third_transaction_date
FROM valid_users 
WHERE valid_id = 1
ORDER BY user_id;
