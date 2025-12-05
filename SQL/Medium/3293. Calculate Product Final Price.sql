

         -- Approach 1. Using - LEFT JOIN --
SELECT p.product_id, p.category, 
  COALESCE(p.price * (1 - d.discount/100.0), p.price) price
FROM products p 
LEFT JOIN discounts d ON d.category = p.category
ORDER BY p.product_id;
