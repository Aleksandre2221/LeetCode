

         -- Approach 1. Using multiple conditions in - HAVING -- 
SELECT 
    customer_id,
    COUNT(*) total_orders,
    (SUM(CASE 
            WHEN order_timestamp::time BETWEEN '11:00'::time AND '14:00'::time 
              OR order_timestamp::time BETWEEN '18:00'::time AND '21:00'::time 
            THEN 1.0 
            ELSE 0 
         END) * 100 / COUNT(*))::int peak_hour_percentage,
    ROUND(AVG(order_rating), 2) average_rating
FROM restaurant_orders
GROUP BY customer_id
HAVING 
    COUNT(*) >= 3
    AND SUM(CASE 
                WHEN order_timestamp::time BETWEEN '11:00'::time AND '14:00'::time 
                  OR order_timestamp::time BETWEEN '18:00'::time AND '21:00'::time 
                THEN 1.0 
                ELSE 0 
            END) / COUNT(*) >= 0.6
    AND COUNT(order_rating) * 1.0 / COUNT(*) >= 0.5
    AND ROUND(AVG(order_rating), 2) >= 4.0
ORDER BY average_rating DESC, customer_id DESC;
