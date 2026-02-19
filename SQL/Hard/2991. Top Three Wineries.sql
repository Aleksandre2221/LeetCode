


         -- Approach 1. Using multiple - CTE -- 
WITH 
  total_points AS (
    SELECT country, winery, SUM(points) total
    FROM sessions 
    GROUP BY country, winery 
	),
  ranking AS (
    SELECT *, 
      ROW_NUMBER() OVER(PARTITION BY country ORDER BY total DESC, winery) rnk 
    FROM total_points
)
SELECT country, 
	MAX(CASE WHEN rnk = 1 THEN CONCAT(winery, ' (', total,  ')') END) top_winery,
  COALESCE(MAX(CASE WHEN rnk = 2 THEN CONCAT(winery, ' (', total,  ')') END), 'No Second Winery') second_winery,
	COALESCE(MAX(CASE WHEN rnk = 3 THEN CONCAT(winery, ' (', total,  ')') END), 'No Third Winery') third_winery
FROM ranking  
GROUP BY country
ORDER BY country;
