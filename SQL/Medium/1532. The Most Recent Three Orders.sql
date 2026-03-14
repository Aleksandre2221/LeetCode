

         -- Approach 1. Using - CTE with Window Function - ROW_NUMBER() -- 
WITH row_num AS (
    SELECT *,
       ROW_NUMBER() OVER(PARTITION BY c.customer_id ORDER BY o.order_date DESC) rn 
    FROM orders o 
    JOIN customers c USING (customer_id)
)
SELECT name customer_name, customer_id, order_id, order_date  
FROM row_num 
WHERE rn <= 3
ORDER BY customer_name, customer_id, order_date DESC;
