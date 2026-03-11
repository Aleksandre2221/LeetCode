

         -- Approach 1. Using - LEFT JOIN --
SELECT 
    p.product_id,
    p.price - COALESCE((p.price / 100.0 * d.discount), 0) final_price, 
    p.category 
FROM products p 
LEFT JOIN discounts d USING (category)
ORDER BY product_id;
