

         -- The Best Approach. Using - LEFT JOIN -- 
SELECT 
    SUM(b.apple_count + COALESCE(c.apple_count, 0)) apple_count, 
    SUM(b.orange_count + COALESCE(c.orange_count, 0)) orange_count
FROM boxes b 
LEFT JOIN chests c USING (chest_id);

