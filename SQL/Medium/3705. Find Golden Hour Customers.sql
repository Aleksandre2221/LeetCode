

         -- Approach 1. Using - CTE and multiple conditions in - HAVING -- 
WITH peak_hours AS (
    SELECT *,
      CASE 
          WHEN order_timestamp::time BETWEEN '11:00'::time AND '14:00'::time
              OR order_timestamp::time BETWEEN '18:00'::time AND '21:00'::time
          THEN 1
          ELSE 0
      END AS is_peak
    FROM restaurant_orders
)
SELECT customer_id,
  COUNT(*) total_orders,
  (SUM(is_peak)::numeric * 100 / COUNT(*))::int peak_hour_percentage,
  ROUND(AVG(order_rating), 2) average_rating
FROM peak_hours
GROUP BY customer_id
HAVING 
  COUNT(*) >= 3
  AND SUM(is_peak)::numeric / COUNT(*) >= 0.6
  AND AVG(order_rating) >= 4
  AND COUNT(order_rating)::numeric / COUNT(*) >= 0.5
ORDER BY average_rating DESC, customer_id DESC;
