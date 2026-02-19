


         -- Approach 1. Using - RECURSIVE CTE -- 
WITH RECURSIVE
	entire_nov AS (
    SELECT '2023-11-01'::date d 
    UNION ALL 
    SELECT d + 1
    FROM entire_nov
    WHERE d + 1 <= '2023-11-30'::date
	),
  all_days AS (
    SELECT *, 
      EXTRACT(DOW FROM d) dow,
      CEIL(EXTRACT(DAY FROM d) / 7.0) week_of_month
    FROM entire_nov
)
SELECT 
	ad.week_of_month, 
  ad.d purchase_date, 
	COALESCE(SUM(p.amount_spend), 0) total_amount
FROM all_days ad  
LEFT JOIN purchases p ON ad.d = p.purchase_date   
WHERE ad.dow = 5
GROUP BY ad.week_of_month, ad.d
ORDER BY week_of_month;
