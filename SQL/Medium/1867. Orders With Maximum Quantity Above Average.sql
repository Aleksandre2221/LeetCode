

         -- Approach 1. Using - CTE --   
WITH calcs AS (
    SELECT order_id, product_id, 
        AVG(quantity) OVER(PARTITION BY order_id) avg_q, 
        MAX(quantity) OVER(PARTITION BY order_id) max_q
    FROM ordersdetails
)
SELECT DISTINCT order_id 
FROM calcs 
WHERE max_q > (SELECT MAX(avg_q) FROM calcs);
