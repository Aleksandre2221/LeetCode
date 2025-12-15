-- Risolved: 4 times



         -- Approach 1. Using - CTE with Window Functions -- 
WITH t1 AS (
  SELECT *, 
  	COUNT(*) OVER(PARTITION BY tiv_2015) tiv_cnt,
  	COUNT(*) OVER(PARTITION BY lat, lon) lat_lon_cnt
  FROM insurance
)
SELECT ROUND(SUM(tiv_2016)::numeric, 2) tiv_2016 
FROM t1 
WHERE tiv_cnt > 1 AND lat_lon_cnt = 1;




         -- Approach 2. Using - Subquery with Window Functions -- 
SELECT ROUND(SUM(tiv_2016)::numeric, 2) tiv_2016 
FROM (
  SELECT *, 
    COUNT(*) OVER(PARTITION BY tiv_2015) tiv_cnt,
    COUNT(*) OVER(PARTITION BY lat, lon) lat_lon_cnt
  FROM insurance
) sub
WHERE tiv_cnt > 1 AND lat_lon_cnt = 1;




		 -- Approach 3. Using - WHERE IN - conditions -- 
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
)




         -- Approach 4. Using multiple - CTE and - JOIN -- 
WITH 
	t1 AS (
      SELECT tiv_2015 
      FROM insurance 
      GROUP BY tiv_2015 
      HAVING COUNT(*) > 1), 
      
    t2 AS (
      SELECT lat, lon 
      FROM insurance
      GROUP BY lat, lon 
      HAVING COUNT(*) = 1)
      
SELECT ROUND(SUM(tiv_2016)::numeric, 2) tiv_2016
FROM insurance i 
JOIN t1 ON t1.tiv_2015 = i.tiv_2015
JOIN t2 ON t2.lat = i.lat AND t2.lon = i.lon; 






