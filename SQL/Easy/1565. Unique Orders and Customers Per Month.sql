

         -- Approach 1. Using - GROUP BY with - WHERE condition --  
SELECT 
    TO_CHAR(order_date, 'YYYY-MM') "month", 
    COUNT(DISTINCT order_id) order_count, 
    COUNT(DISTINCT customer_id) customer_count
FROM orders 
WHERE invoice > 20 
GROUP BY TO_CHAR(order_date, 'YYYY-MM');



         -- Approach 2. Without using - WHERE condition -- 

  SELECT 
      TO_CHAR(order_date, 'YYYY-MM') "month",
      COUNT(customer_id) FILTER(WHERE invoice > 20) order_count,
      COUNT(DISTINCT customer_id) FILTER(WHERE invoice > 20) customer_count
  FROM orders
  GROUP BY TO_CHAR(order_date, 'YYYY-MM')
  HAVING COUNT(DISTINCT customer_id) FILTER(WHERE invoice > 20) > 0;
