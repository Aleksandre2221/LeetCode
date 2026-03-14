

-- Risolved: 2 times


         -- Approach 1. Using - CTE -- 
WITH ranking AS (
  SELECT *, 
  	RANK() OVER(PARTITION BY p.product_id ORDER BY o.order_date DESC) rnk
  FROM orders o 
  JOIN products p USING (product_id)
)
SELECT product_name, product_id, order_id, order_date 
FROM ranking 
WHERE rnk = 1
ORDER BY product_name, product_id, order_id;
