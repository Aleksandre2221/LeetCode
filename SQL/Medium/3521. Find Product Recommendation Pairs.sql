

         -- Approach 1. Using - CTE 
WITH valid_pairs AS (
  SELECT 
    p1.product_id product1_id, 
    p2.product_id product2_id, 
    COUNT(*) customer_count
  FROM productpurchases p1  
  JOIN productpurchases p2 ON p1.user_id = p2.user_id 
    AND p1.product_id < p2.product_id
  GROUP BY p1.product_id, p2.product_id
  HAVING COUNT(*) > 2
)
SELECT 
  vp.product1_id, 
  vp.product2_id, 
  pi1.category product1_category, 
  pi2.category product2_category,
  vp.customer_count
FROM valid_pairs vp 
JOIN productinfo pi1 ON vp.product1_id = pi1.product_id 
JOIN productinfo pi2 ON vp.product2_id = pi2.product_id
ORDER BY customer_count DESC, product1_id, product2_id;
