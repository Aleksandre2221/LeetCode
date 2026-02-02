


         -- Approach 1. Using - RECURSIVE CTE -- 
WITH RECURSIVE entire_period AS (
  SELECT MIN(period_start) min_period_date, MAX(period_end) max_period_date FROM sales  
  UNION ALL  
  SELECT (min_period_date + INTERVAL '1 day')::date, max_period_date FROM entire_period
  WHERE min_period_date + INTERVAL '1 day' <= max_period_date
)
SELECT s.product_id, p.product_name, 
	  EXTRACT(YEAR FROM ep.min_period_date) report_year, 
	  SUM(s.average_daily_sales) total_amount  
FROM entire_period ep  
JOIN sales s ON ep.min_period_date >= s.period_start AND ep.min_period_date <= s.period_end
JOIN product p ON p.product_id = s.product_id
GROUP BY s.product_id, p.product_name, EXTRACT(YEAR FROM ep.min_period_date)



         -- Approach 2. Using - generate_series (ONLY PostgreSQL) -- 
SELECT s.product_id, p.product_name,
    EXTRACT(YEAR FROM gs.day) report_year,
    SUM(s.average_daily_sales) total_amount
FROM sales s
JOIN product p ON p.product_id = s.product_id
JOIN LATERAL generate_series(s.period_start, s.period_end, INTERVAL '1 day') AS gs(day) ON TRUE
GROUP BY s.product_id, p.product_name, EXTRACT(YEAR FROM gs.day)
ORDER BY s.product_id, report_year;
