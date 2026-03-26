


         -- Approach 1. Using - CTE -- 
SELECT 
    i.item_category "CATEGORY", 
    SUM(CASE WHEN EXTRACT(DOW FROM order_date) = 1 THEN o.quantity ELSE 0 END) "MONDAY",
    SUM(CASE WHEN EXTRACT(DOW FROM order_date) = 2 THEN o.quantity ELSE 0 END) "TUESDAY", 
    SUM(CASE WHEN EXTRACT(DOW FROM order_date) = 3 THEN o.quantity ELSE 0 END) "WEDNESDAY", 
    SUM(CASE WHEN EXTRACT(DOW FROM order_date) = 4 THEN o.quantity ELSE 0 END) "THURSDAY", 
    SUM(CASE WHEN EXTRACT(DOW FROM order_date) = 5 THEN o.quantity ELSE 0 END) "FRIDAY", 
    SUM(CASE WHEN EXTRACT(DOW FROM order_date) = 6 THEN o.quantity ELSE 0 END) "SATURDAY", 
    SUM(CASE WHEN EXTRACT(DOW FROM order_date) = 0 THEN o.quantity ELSE 0 END) "SUNDAY"
FROM items i 
LEFT JOIN orders o USING (item_id)
GROUP BY i.item_category
ORDER BY "CATEGORY";
