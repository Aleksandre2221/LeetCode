

         -- Approach 1. Using - GROUP BY with two - HAVING conditions --
SELECT s.buyer_id
FROM sales s 
JOIN product p USING (product_id)
GROUP BY s.buyer_id
HAVING 
    SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0
    AND SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0;





