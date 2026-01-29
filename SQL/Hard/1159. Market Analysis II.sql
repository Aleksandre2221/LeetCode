


         -- Approach 1. Using - CTE with - ROW_NUMBER() -- 
WITH row_num AS (
	SELECT *, 
    ROW_NUMBER() OVER(PARTITION BY seller_id ORDER BY order_date) rn 
	FROM orders
)
SELECT u.user_id seller_id,
	CASE 
      WHEN u.favorite_brand = i.item_brand THEN 'yes'
      ELSE 'no'
	END "2nd_item_fav_brand"
FROM users u 
LEFT JOIN row_num rn ON u.user_id = rn.seller_id 
LEFT JOIN items i ON i.item_id = rn.item_id
WHERE rn.rn = 2 OR rn.rn IS NULL 
ORDER BY seller_id;
