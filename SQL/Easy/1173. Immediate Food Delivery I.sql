

         -- Approach 1. Using - COUNT with - FILTER -- 
SELECT ROUND
          (COUNT(*) FILTER(WHERE order_date = customer_pref_delivery_date)::numeric / COUNT(*) 
      , 2) AS immediate_percentage
FROM Delivery;



         -- Approach 2. CASE WHEN conditions -- 
SELECT 
    ROUND(
        SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
    , 2) immediate_percentage 
FROM delivery;

