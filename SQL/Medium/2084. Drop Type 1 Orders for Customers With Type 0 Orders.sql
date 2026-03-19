

         -- Approach 1. Using - WHERE NOT EXISTS condition -- 
SELECT *
FROM orders o
WHERE 
  NOT EXISTS (
    SELECT 1
    FROM Orders o2
    WHERE o2.customer_id = o.customer_id AND o2.order_type = 0
  )
  OR o.order_type = 0;


