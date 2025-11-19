

         -- Approach 1. Using - CTE with a Window Function - RANK() -- 
WITH ranking AS (
  SELECT s.user_id, s.product_id, 
    RANK() OVER(PARTITION BY user_id ORDER BY SUM(s.quantity * p.price) DESC) rnk
  FROM product p  
  JOIN sales s ON s.product_id = p.product_id
  GROUP BY s.user_id, s.product_id	
)
SELECT user_id, product_id 
FROM ranking 
WHERE rnk = 1;



         -- Approach 2. Without using any Window Function -- 
WITH 
  totals AS (
    SELECT s.user_id, s.product_id,
      SUM(s.quantity * p.price) total_spent
    FROM sales s
    JOIN product p ON p.product_id = s.product_id
    GROUP BY s.user_id, s.product_id
	),
  max_spent AS (
    SELECT user_id, MAX(total_spent) max_value
    FROM totals  
    GROUP BY user_id
)
SELECT t.user_id, t.product_id
FROM totals t
JOIN max_spent m ON t.user_id = m.user_id 
  AND t.total_spent = m.max_value;



