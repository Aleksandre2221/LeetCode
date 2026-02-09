

-- Risolved: 4 times 


         -- Approach 1. Using - CTE -- 
WITH total_spends AS (
  SELECT c.customer_id, c.name,
      DATE_TRUNC('month', o.order_date) "month",
      SUM(p.price * o.quantity) total
  FROM orders o
  JOIN product p ON p.product_id = o.product_id
  JOIN customers c ON c.customer_id = o.customer_id
  WHERE o.order_date >= '2020-06-01'
    AND o.order_date <  '2020-08-01'
  GROUP BY c.customer_id, c.name, DATE_TRUNC('month', o.order_date)
)
SELECT customer_id, name
FROM total_spends
GROUP BY customer_id, name
HAVING COUNT(*) = 2 AND MIN(total) >= 100;



         -- Approach 2. Using - SUM with - CASE...WHEN condiotns within - HAVING -- 
SELECT c.customer_id, c.name
FROM orders o
JOIN product p ON o.product_id = p.product_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2020
GROUP BY c.customer_id, c.name
HAVING 
    SUM(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 6 THEN o.quantity * p.price ELSE 0 END) >= 100
    AND SUM(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 7 THEN o.quantity * p.price ELSE 0 END) >= 100;



         -- Approach 3. Using - CTE with - JOIN / WHERE / GROUP BY / HAVING -- 
WITH total_spends AS (
  SELECT c.customer_id, c.name, 
  	TO_CHAR(o.order_date, 'YYYY-MM') order_date,
    SUM(o.quantity * p.price) total_spend
  FROM orders o 
  JOIN customers c ON c.customer_id = o.customer_id
  JOIN product p ON p.product_id = o.product_id
  WHERE o.order_date BETWEEN '2020-06-01' AND '2020-07-31'
  GROUP BY c.customer_id, c.name, TO_CHAR(o.order_date, 'YYYY-MM')
  HAVING SUM(o.quantity * p.price) >= 100
)
SELECT customer_id, name  
FROM total_spends 
GROUP BY customer_id, name 
HAVING COUNT(*) = 2;






