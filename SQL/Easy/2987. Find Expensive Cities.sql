

         -- Approach 1. Using - CTE -- 
WITH averages AS (
    SELECT city, 
        AVG(price) OVER() national_avg,
        AVG(price) OVER(PARTITION BY city) city_avg
    FROM listings
)
SELECT DISTINCT city
FROM averages 
WHERE national_avg < city_avg
ORDER BY city;
