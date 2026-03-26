


         -- Approach 1. Using - CTE -- 
WITH year_sales AS (
    SELECT 
        EXTRACT(YEAR FROM transaction_date) "Year", 
        product_id, 
        SUM(spend) curr_year_spend
    FROM user_transactions 
    GROUP BY EXTRACT(YEAR FROM transaction_date), product_id
)
SELECT 
	"Year", 
    product_id, 
    curr_year_spend, 
    LAG(curr_year_spend) OVER(PARTITION BY product_id ORDER BY "Year") prev_year_spend,
    ROUND(
	        (curr_year_spend - LAG(curr_year_spend) OVER(PARTITION BY product_id ORDER BY "Year")) * 100.0
	        / LAG(curr_year_spend) OVER(PARTITION BY product_id ORDER BY "Year") 
     , 2) yoy_rate
FROM year_sales  
GROUP BY "Year", product_id, curr_year_spend
ORDER BY product_id, "Year";
