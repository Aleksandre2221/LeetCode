

-- Risolved: 2 times


         -- Approach 1. Using - CTE -- 
WITH valid_dates AS (
  SELECT p.product_name, MAX(order_date) order_date
  FROM orders o 
  JOIN products p ON p.product_id = o.product_id
  GROUP BY p.product_name
)
SELECT vd.product_name, o.product_id, o.order_id, vd.order_date  
FROM orders o 
JOIN valid_dates vd ON vd.order_date = o.order_date
ORDER BY product_name, product_id, order_date; 



         -- Approach 2. Using - Subquery within - WHERE condition -- 
SELECT p.product_name, o.product_id, o.order_id, o.order_date
FROM orders o
JOIN products p ON p.product_id = o.product_id
WHERE o.order_date = (
    SELECT MAX(o2.order_date)
    FROM orders o2
    WHERE o2.product_id = o.product_id
)
ORDER BY p.product_name, o.product_id, o.order_date;
