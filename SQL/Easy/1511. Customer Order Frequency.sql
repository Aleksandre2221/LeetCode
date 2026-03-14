

-- Risolved: 4 times 


         -- Approach 1. Using - SUM with - CASE...WHEN condiotns within - HAVING -- 
SELECT c.customer_id, c.name
FROM orders o
JOIN product p ON o.product_id = p.product_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2020
GROUP BY c.customer_id, c.name
HAVING 
    SUM(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 6 THEN o.quantity * p.price ELSE 0 END) >= 100
    AND SUM(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 7 THEN o.quantity * p.price ELSE 0 END) >= 100;






