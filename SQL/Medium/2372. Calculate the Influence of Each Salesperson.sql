

         -- Approach 1. Using two - LEFT JOIN -- 
SELECT sp.salesperson_id, sp.name, COALESCE(SUM(s.price), 0) total 
FROM salesperson sp 
LEFT JOIN customer c ON c.salesperson_id = sp.salesperson_id
LEFT JOIN sales s ON s.customer_id = c.customer_id
GROUP BY sp.salesperson_id, sp.name;



         -- Approach 2. Using - CTE -- 
WITH total AS (
  SELECT c.salesperson_id, SUM(price) total 
  FROM sales s 
  JOIN customer c ON c.customer_id = s.customer_id
  GROUP BY c.salesperson_id
)
SELECT sp.salesperson_id, sp.name, COALESCE(total, 0) total 
FROM salesperson sp 
LEFT JOIN total t ON t.salesperson_id = sp.salesperson_id
