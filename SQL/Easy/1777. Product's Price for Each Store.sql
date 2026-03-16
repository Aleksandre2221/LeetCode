

-- Risolved: 5 times


         -- Approach 1. Using - MAX with - CASE...WHEN condition -- 
SELECT product_id,
	MAX(CASE WHEN store = 'store1' THEN price end) as store1,
    MAX(CASE WHEN store = 'store2' THEN price end) as store2,
    MAX(CASE WHEN store = 'store3' THEN price end) as store3
FROM products 
GROUP BY product_id; 

