

-- Risolved: 3 times 


         -- Approach 1. Using two - CTE and - FULL JOIN --  
WITH 
	approved AS ( 
      SELECT 
      		TO_CHAR(trans_date, 'YYYY-MM') "month", 
      		country,
      		SUM(amount) amount,
      		COUNT(id) cnt
      FROM transactions 
      WHERE state = 'approved' 
      GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), country
	), 
    charged_b AS (
      SELECT 
      		TO_CHAR(c.trans_date, 'YYYY-MM') "month", 
      		t.country,
			SUM(t.amount) amount,
      		COUNT(c.trans_id) cnt 
      FROM chargebacks c  
      JOIN transactions t ON c.trans_id = t.id 
      GROUP BY TO_CHAR(c.trans_date, 'YYYY-MM'), t.country
)
SELECT 
	COALESCE(a.month, cb.month) "month", 
    COALESCE(a.country, cb.country) country, 
    COALESCE(a.cnt, 0) approved_count, 
    COALESCE(a.amount, 0) approved_amount, 
    COALESCE(cb.cnt, 0) chargeback_count, 
    COALESCE(cb.amount, 0) chargeback_amount
FROM approved a 
FULL JOIN charged_b cb ON a.month = cb.month AND a.country = cb.country;
WHERE COALESCE(a.amount, 0) <> 0
	OR COALESCE(cb.amount, 0) <> 0;



			-- Approach 2. Using - UNION ALL -- 
WITH all_events AS (
  SELECT id, country, state, amount, trans_date FROM transactions
  UNION ALL  
  SELECT t.id, t.country, 'chargeback' state, t.amount, c.trans_date 
  FROM transactions t  
  JOIN chargebacks c ON t.id = c.trans_id
)
SELECT 
	TO_CHAR(trans_date, 'YYYY-MM') "month", 
    country, 
    SUM(CASE WHEN state = 'approved' THEN 1 else 0 END) approved_count,
    SUM(CASE WHEN state = 'approved' THEN amount else 0 END) approved_amount,
    SUM(CASE WHEN state = 'chargeback' THEN 1 else 0 END) chargeback_count,
    SUM(CASE WHEN state = 'chargeback' THEN amount else 0 END) chargeback_amount
FROM all_events
GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), country
HAVING 
	SUM(CASE WHEN state = 'approved' THEN amount else 0 END) <> 0 
    OR SUM(CASE WHEN state = 'chargeback' THEN amount else 0 END) <> 0;




