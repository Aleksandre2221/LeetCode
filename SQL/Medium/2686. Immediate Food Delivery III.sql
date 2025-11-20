

         -- Approach 1. Using - SUM with - CASW...WHEN conditions -- 
SELECT order_date,
  COALESCE(
      ROUND(
            SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 END) * 100.0 / COUNT(*)
        , 2)
    , 0) immediate_percentage 
FROM delivery 
GROUP BY order_date; 
