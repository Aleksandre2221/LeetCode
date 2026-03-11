

         -- Approach 1. Using - SUM with - CASW...WHEN conditions -- 
SELECT 
    order_date,
    ROUND(
        SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
    ,2) immediate_percentage
FROM delivery
GROUP BY order_date
ORDER BY order_date;
