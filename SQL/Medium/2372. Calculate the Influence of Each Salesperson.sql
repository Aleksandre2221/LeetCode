

         -- Approach 1. Using two - LEFT JOIN -- 
SELECT sp.salesperson_id , sp.name,     
    COALESCE(SUM(s.price), 0) total
FROM salesperson sp 
LEFT JOIN customer c USING (salesperson_id)
LEFT JOIN sales s USING (customer_id)
GROUP BY sp.salesperson_id , sp.name;
