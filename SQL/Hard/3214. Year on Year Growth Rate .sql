


         -- Approach 1. Using multiple - CTE -- 
WITH 
	cur_spends AS (
    SELECT 
        EXTRACT(YEAR FROM transaction_date) AS year, 
        product_id, 
        SUM(spend) current_year_spend
    FROM user_transactions 
    GROUP BY EXTRACT(YEAR FROM transaction_date), product_id
	),
  cur_prev_spends AS (
    SELECT *, 
        LAG(current_year_spend) OVER(PARTITION BY product_id ORDER BY YEAR) prev_year_spend
    FROM cur_spends
)
SELECT 
  	year, 
    product_id,
    current_year_spend, 
    prev_year_spend, 
    ROUND((current_year_spend - prev_year_spend) * 100.0 / prev_year_spend, 2) yoy_rate
FROM cur_prev_spends
ORDER BY product_id, year;
