

-- Risolved: 2 times 


         -- Approach 1. Using multiple - CTE 
WITH 
    valid_stores AS (
      SELECT store_id 
      FROM inventory 
      GROUP BY store_id
      HAVING COUNT(DISTINCT product_name) >= 3
    ),
    max_min_rn AS (
      SELECT *, 
          ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY price DESC) max_rn, 
          ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY price) min_rn
      FROM inventory 
      WHERE store_id in (SELECT * FROM valid_stores) 
)
SELECT s.store_id, s.store_name, s.location, 
    max_rn.product_name most_exp_product, 
    min_rn.product_name cheapest_product, 
    ROUND(min_rn.quantity * 1.0 / max_rn.quantity, 2) imbalance_ratio  
FROM max_min_rn max_rn 
JOIN max_min_rn min_rn ON max_rn.store_id = min_rn.store_id 
JOIN stores s ON s.store_id = max_rn.store_id
WHERE max_rn.max_rn = 1 
  AND min_rn.min_rn = 1
  AND max_rn.quantity < min_rn.quantity
ORDER BY imbalance_ratio DESC, store_name;


         -- Approach 2. Using - CTE -- 
WITH valid_stores AS (
  SELECT store_id, 
      MAX(price) max_price, 
      MIN(price) min_price
  FROM Inventory
  GROUP BY store_id
  HAVING COUNT(1) >= 3
)
SELECT s.store_id, s.store_name, s.location,
    i_exp.product_name most_exp_product,
    i_cheap.product_name cheapest_product,
    ROUND(i_cheap.quantity / i_exp.quantity, 2) imbalance_ratio
FROM valid_stores vs
JOIN inventory i_exp ON i_exp.store_id = vs.store_id AND i_exp.price = vs.max_price
JOIN inventory i_cheap ON i_cheap.store_id = vs.store_id AND i_cheap.price = vs.min_price
JOIN stores s ON s.store_id = vs.store_id
WHERE i_exp.quantity < i_cheap.quantity
ORDER BY imbalance_ratio DESC, store_name; 
