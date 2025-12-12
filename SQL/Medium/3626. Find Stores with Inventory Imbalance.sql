

         -- Approach 1. Using - CTE -- 
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
