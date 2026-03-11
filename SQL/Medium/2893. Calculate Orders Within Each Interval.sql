


         -- Approach 1. Using - CEIL -- 
SELECT 
    CEIL(minute / 6) interval_no, 
    SUM(order_count) total_orders 
FROM orders 
GROUP BY CEIL(minute / 6)
ORDER BY interval_no;
