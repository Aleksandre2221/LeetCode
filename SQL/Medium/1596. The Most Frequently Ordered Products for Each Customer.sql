

         -- Approach 1. Using - CTE with Window Function - RANK() -- 
WITH ranking AS (
  SELECT customer_id, product_id,
  	 RANK() OVER(PARTITION BY customer_id ORDER BY COUNT(*) DESC) rnk 
  FROM orders 
  GROUP BY customer_id, product_id
)
SELECT r.customer_id, p.product_id, p.product_name 
FROM ranking r 
JOIN products p USING (product_id) 
WHERE r.rnk = 1;




