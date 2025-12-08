

         -- Approach 1. Using two - CTE -- 
WITH 
    seasons AS (
        SELECT *,
            CASE 
                WHEN EXTRACT(MONTH FROM sale_date) IN (12, 1, 2) THEN 'Winter'
                WHEN EXTRACT(MONTH FROM sale_date) IN (3, 4, 5) THEN 'Spring' 
                WHEN EXTRACT(MONTH FROM sale_date) IN (6, 7, 8) THEN 'Summer'
                ELSE 'Fall' 
            END season
        FROM sales
    ),
    ranking AS (
        SELECT s.season, p.category, 
            SUM(s.quantity) total_quantity, 
            SUM(s.price * s.quantity) total_revenue,
            ROW_NUMBER() OVER(
                        PARTITION BY s.season 
                        ORDER BY SUM(s.quantity) DESC, SUM(s.price * s.quantity) DESC) rnk
        FROM seasons s 
        JOIN products p USING (product_id)
        GROUP BY s.season, p.category
)
SELECT season, category, total_quantity, total_revenue
FROM ranking 
WHERE rnk = 1
ORDER BY season;
