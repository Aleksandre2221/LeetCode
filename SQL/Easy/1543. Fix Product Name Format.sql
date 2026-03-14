

         -- Approach 1. Using - GROUP BY with - LOWER(TRIM(...)) and - DATE_FORMAT -- (MySQL)
SELECT 
    TRIM(LOWER(product_name)) product_name,
    DATE_FORMAT(sale_date, '%Y-%m') sale_date, 
    COUNT(*) total 
FROM sales
GROUP BY TRIM(LOWER(product_name)), DATE_FORMAT(sale_date, '%Y-%m') 
ORDER BY product_name, sale_date;






