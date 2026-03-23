


         -- Approach 1. Using - CTE -- 
WITH sales AS (
  SELECT o.seller_id,
  	  COUNT(DISTINCT i.item_id) num_items, 
  	  RANK() OVER(ORDER BY COUNT(DISTINCT i.item_id) DESC) rnk
  FROM orders o
  JOIN items i USING (item_id)
  WHERE NOT EXISTS (
      SELECT 1 
      FROM users u 
      WHERE u.seller_id = o.seller_id
      	AND u.favorite_brand = i.item_brand
  )
  GROUP BY o.seller_id
)
SELECT seller_id, num_items
FROM sales  
WHERE rnk = 1 
ORDER BY seller_id;
