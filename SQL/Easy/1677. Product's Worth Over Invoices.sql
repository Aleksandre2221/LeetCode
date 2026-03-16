

         -- The Best Approach. Using - LEFT JOIN / GROUP BY / SUM / COALESCE --  
SELECT p.name,
	SUM(COALESCE(i.rest, 0)) rest, 
    SUM(COALESCE(i.paid, 0)) paid, 
    SUM(COALESCE(i.canceled, 0)) canceled, 
    SUM(COALESCE(i.refunded, 0)) refunded
FROM product p 
LEFT JOIN invoice i ON i.product_id = p.product_id
GROUP BY p.name
ORDER BY p.name;
