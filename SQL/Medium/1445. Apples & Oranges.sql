


         -- Approach 1. Using - SUM with - CASE..WHEN condition -- (SQL Standard) 
SELECT sale_date,
    SUM(
        CASE  
            WHEN fruit = 'apples' 
            THEN sold_num 
            ELSE -sold_num 
        END 
    ) diff 
FROM sales 
GROUP BY sale_date
ORDER BY sale_date;
