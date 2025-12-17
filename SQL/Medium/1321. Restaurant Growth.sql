
-- Risolved: 2 times


         -- Approach 1. Using - CTE and Window Functions - SUM(), - AVG() with - ROWS BETWEEN condition -- 
WITH day_sum AS (
  SELECT visited_on, SUM(amount) amount 
  FROM customer
  GROUP BY visited_on
  ORDER BY visited_on
)
SELECT visited_on, 
	SUM(amount) OVER(ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) amount, 
	ROUND(
      		AVG(amount) OVER(ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
      	, 2) average_amount 
FROM day_sum 
OFFSET 6;


         -- Approach 2. Without using Window Funciotns -- 
WITH valid_dates AS (
  SELECT DISTINCT visited_on 
  FROM customer 
  ORDER BY visited_on 
  OFFSET 6
)
SELECT vd.visited_on, 
	SUM(c.amount) amount,
    ROUND(AVG(c.amount)::numeric, 2) average_amount
FROM customer c 
JOIN valid_dates vd ON c.visited_on BETWEEN vd.visited_on - INTERVAL '6 days' AND vd.visited_on 
GROUP BY vd.visited_on;






