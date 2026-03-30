


         -- Approach 1. Using - CTE -- 
WITH ranking AS (
    SELECT country, winery, 
      	SUM(points) points,
        ROW_NUMBER() OVER(PARTITION BY country ORDER BY SUM(points) DESC, winery) rnk
    FROM wineries
    GROUP BY country, winery
)
SELECT country, 
	MAX(CASE WHEN rnk = 1 THEN CONCAT(winery, ' (', points,  ')') END) top_winery,
    COALESCE(MAX(CASE WHEN rnk = 2 THEN CONCAT(winery, ' (', points,  ')') END), 'No second winery') second_winery,
	COALESCE(MAX(CASE WHEN rnk = 3 THEN CONCAT(winery, ' (', points,  ')') END), 'No third winery') third_winery
FROM ranking  
GROUP BY country
ORDER BY country;
