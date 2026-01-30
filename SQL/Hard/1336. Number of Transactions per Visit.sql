

         
         -- Approach 1. Using - RECURSIVE CTE -- 
WITH RECURSIVE
	grp AS (
    SELECT v.visit_date, v.user_id, COUNT(t.user_id) tr_cnt  
    FROM visits v 
    LEFT JOIN transactions t ON t.transaction_date = v.visit_date AND v.user_id = t.user_id
    GROUP BY v.visit_date, v.user_id
	),
  cnt AS (
    SELECT tr_cnt, COUNT(*) vis_cnt 
    FROM grp 
    GROUP BY tr_cnt
	), 
  series AS (
    SELECT MIN(tr_cnt) transactions_count, MAX(tr_cnt) max_tr_cnt
    FROM cnt
      
    UNION ALL 
      
    SELECT transactions_count + 1, max_tr_cnt
    FROM series  
    WHERE transactions_count + 1 <= max_tr_cnt
) 
SELECT s.transactions_count, COALESCE(cnt.vis_cnt, 0) visits_count 
FROM series s  
LEFT JOIN cnt ON cnt.tr_cnt = s.transactions_count
ORDER BY transactions_count;



         -- Approach 2. Using - generate_series (ONLY PostgreSQL) -- 
WITH 
  grp AS (
    SELECT v.visit_date, v.user_id, COUNT(t.user_id) tr_cnt  
    FROM visits v 
    LEFT JOIN transactions t ON t.transaction_date = v.visit_date AND v.user_id = t.user_id
    GROUP BY v.visit_date, v.user_id
	),
  cnt AS (
    SELECT tr_cnt, COUNT(*) vis_cnt 
    FROM grp 
    GROUP BY tr_cnt
	), 
  series AS (
    SELECT generate_series(
    	(SELECT MIN(tr_cnt) FROM cnt),
    	(SELECT MAX(tr_cnt) FROM cnt), 1) transactions_count
)
SELECT s.transactions_count, COALESCE(cnt.vis_cnt, 0) visits_count 
FROM series s  
LEFT JOIN cnt ON cnt.tr_cnt = s.transactions_count
ORDER BY transactions_count,
