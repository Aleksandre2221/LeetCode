

         -- Approach 1. Using - JOIN and - GROUP BY -- 
WITH warehouse_product AS (
    SELECT 
        w.name, 
        p.product_id, 
        SUM(p.width * p.length * p.height * w.units) total
    FROM warehouse w 
    JOIN products p USING (product_id)
    GROUP BY w.name, p.product_id
)
SELECT 
    name warehouse_name, 
    SUM(total) volume
FROM warehouse_product
GROUP BY name;
