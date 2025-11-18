

         -- Approach 1. Using - CTE -- 
WITH purchase_cnt AS (
  SELECT product_id, 
    EXTRACT(YEAR FROM purchase_date) p_date
  FROM orders  
  GROUP BY product_id, EXTRACT(YEAR FROM purchase_date)
  HAVING COUNT(*) >=3
)
SELECT DISTINCT pc1.product_id
FROM purchase_cnt pc1
JOIN purchase_cnt pc2 ON pc1.product_id = pc2.product_id AND pc1.p_date - pc2.p_date = 1;
