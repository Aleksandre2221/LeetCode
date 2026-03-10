


         -- Approach 1. Using two - CTE -- 
WITH 
   hours_cnt AS (
      SELECT city,
          EXTRACT(HOUR FROM call_time) AS h,
          COUNT(*) AS cnt
      FROM calls
      GROUP BY city, EXTRACT(HOUR FROM call_time)
  ),
  ranking AS (
      SELECT city, h, cnt,
          RANK() OVER(PARTITION BY city ORDER BY cnt DESC) rnk
      FROM hours_cnt
)
SELECT 
	  city,
    h peak_calling_hour,
    cnt number_of_calls
FROM ranking
WHERE rnk = 1
ORDER BY peak_calling_hour DESC, city DESC;
