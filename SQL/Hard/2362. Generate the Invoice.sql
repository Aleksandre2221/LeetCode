


         -- Approach 1. Using two - CTE -- 
WITH 
	all_info AS (
      SELECT *  
      FROM products pr 
      JOIN purchases pu USING (product_id)
	), 
	valid_invoice AS (
      SELECT invoice_id, 
        SUM(price * quantity) total 
      FROM all_info 
      GROUP BY invoice_id 
      ORDER BY total DESC, invoice_id 
      LIMIT 1 
)
SELECT ai.product_id, ai.quantity,
	(ai.quantity * ai.price) price 
FROM all_info ai  
JOIN valid_invoice vi USING (invoice_id); 



         -- Approah 2. Using two - CTE with WIndow Functions -- 
WITH 
	total AS (
    SELECT *, 
      SUM(pu.quantity * pr.price) OVER(PARTITION BY pu.invoice_id ORDER BY pu.invoice_id) total
    FROM products pr 
    JOIN purchases pu USING (product_id)
	), 
  ranking AS (
    SELECT *, 
      DENSE_RANK() OVER(ORDER BY total DESC, invoice_id) rnk
    FROM total
)
SELECT product_id, quantity,
	(price * quantity) price 
FROM ranking 
WHERE rnk = 1;
