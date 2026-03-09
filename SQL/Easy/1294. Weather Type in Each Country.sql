

         -- Appraoch 1. Using - JOIN - WHERE - GROUP BY - CASE..WHEN -- 
SELECT c.country_name,
	CASE 
    	WHEN AVG(w.weather_state) <= 15 THEN 'Cold'
      	WHEN AVG(w.weather_state) >= 25 THEN 'Hot'
		ELSE 'Warm' 
	END weather_type 
FROM countries c 
JOIN weather w ON w.country_id = c.country_id
WHERE TO_CHAR(w.day, 'YYYY-MM') = '2019-11'
GROUP BY c.country_name;




         -- Approach 2. Using - Subquery -- 
SELECT country_name,
	CASE 
    	WHEN avg_temp <= 15 THEN 'Cold'
      	WHEN avg_temp >= 25 THEN 'Hot'
		ELSE 'Warm' 
	END weather_type 
FROM (
  SELECT c.country_name, AVG(weather_state) avg_temp  
  FROM countries c 
  JOIN weather w ON w.country_id = c.country_id
  WHERE TO_CHAR(w.day, 'YYYY-MM') = '2019-11'
  GROUP BY c.country_name
) sub;




         -- Approach 3. Using - CTE instead of - Subquery -- 
WITH avg_temp AS (
  SELECT c.country_name, AVG(weather_state) avg_temp  
  FROM countries c 
  JOIN weather w ON w.country_id = c.country_id
  WHERE TO_CHAR(w.day, 'YYYY-MM') = '2019-11'
  GROUP BY c.country_name
)
SELECT country_name,
	CASE 
    	WHEN avg_temp <= 15 THEN 'Cold'
      	WHEN avg_temp >= 25 THEN 'Hot'
		ELSE 'Warm' 
  END weather_type 
FROM avg_temp;





