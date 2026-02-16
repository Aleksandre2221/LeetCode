


         -- Approach 1. Using - RICORSIVE CTE -- 
WITH RECURSIVE 
	years AS (
    SELECT customer_id, 
      EXTRACT(YEAR FROM MIN(order_date)) min_y,
      EXTRACT(YEAR FROM MAX(order_date)) max_y 
    FROM orders 
    GROUP BY customer_id

    UNION ALL  

    SELECT customer_id, 
      min_y + 1,
      max_y
    FROM years  
    WHERE min_y + 1 <= max_y
  ), 
  grps AS ( 
    SELECT y.customer_id, 
      y.min_y order_year, 
      COALESCE(SUM(o.price), 0) total
    FROM years y  
    LEFT JOIN orders o ON o.customer_id = y.customer_id 
      AND EXTRACT(YEAR FROM o.order_date) = y.min_y 
    GROUP BY y.customer_id, y.min_y
	), 
  is_increased AS (
    SELECT *, 
      CASE 
        	WHEN lag(total) OVER(PARTITION BY customer_id ORDER BY order_year) < total 
        		OR LEAD(total) OVER(PARTITION BY customer_id ORDER BY order_year) > total 
        	THEN 1 
          ELSE 0 
      END is_incr
      FROM grps
)
SELECT customer_id   
FROM is_increased 
GROUP BY customer_id
HAVING COUNT(customer_id) = SUM(is_incr);
