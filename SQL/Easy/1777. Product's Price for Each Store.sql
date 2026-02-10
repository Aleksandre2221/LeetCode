

-- Risolved: 5 times


         -- Approach 1. Using - MAX with - CASE...WHEN condition -- 
SELECT product_id,
	MAX(CASE WHEN store = 'store1' THEN price end) as store1,
    MAX(CASE WHEN store = 'store2' THEN price end) as store2,
    MAX(CASE WHEN store = 'store3' THEN price end) as store3
FROM products 
GROUP BY product_id; 


         -- Approach 2. Using two - LEFT JOIN and - WHERE condition --  
SELECT p1.product_id,
	p1.price store1,
	p2.price store2,
	p3.price store3
FROM products p1
LEFT JOIN products p2 ON p1.product_id = p2.product_id AND p2.store = 'store2'
LEFT JOIN products p3 ON p1.product_id = p3.product_id AND p3.store = 'store3'
WHERE p1.store = 'store1';
