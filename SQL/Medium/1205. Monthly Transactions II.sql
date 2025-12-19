

-- Risolved: 2 times 


         -- Approach 1. Using two - CTE and - LEFT JOIN --  
WITH 
	chargebacks_monthly  AS (
      SELECT 
          t.country,
          DATE_TRUNC('month', c.charge_date)::date "month",
          SUM(t.amount) chargeback_amount, 
          COUNT(*) chargeback_count
      FROM transactions t
      JOIN chargebacks C ON t.id = c.trans_id
      GROUP BY DATE_TRUNC('month', c.charge_date)::date, t.country
    ),
  
	approved_monthly  AS (
      SELECT 
          DATE_TRUNC('month', trans_date)::DATE "month",
          country,
          COUNT(*) FILTER (WHERE state = 'approved') approved_count,
          SUM(amount) FILTER (WHERE state = 'approved') approved_amount
      FROM transactions
      GROUP BY DATE_TRUNC('month', trans_date), country
)
  
SELECT cm.month, cm.country, 
    COALESCE(am.approved_count, 0) approved_count,
    COALESCE(cm.chargeback_count, 0) chargeback_count,
    COALESCE(cm.chargeback_amount, 0) chargeback_amount
FROM chargebacks_monthly cm 
LEFT JOIN approved_monthly am ON cm.country = am.country AND cm.month = am.month
ORDER BY cm.month;



			 -- Approach 2. Using tow - CTE -- 
WITH 
	cb AS (
        SELECT TO_CHAR(c.trans_date, 'YYYY-MM') "month", t.country,
          COUNT(c.trans_id) chargeback_count, 
          SUM(t.amount) chargeback_amount
        FROM chargebacks c 
        LEFT JOIN transactions t ON t.id = c.trans_id
        GROUP BY TO_CHAR(c.trans_date, 'YYYY-MM'), t.country
	),
    approved AS (
    	SELECT TO_CHAR(c.trans_date, 'YYYY-MM') "month", t.country,
			SUM(CASE WHEN t.state = 'approved' THEN 1 ELSE 0 END) approved_count,
    		SUM(CASE WHEN t.state = 'approved' THEN t.amount ELSE 0 END) approved_amount
		FROM chargebacks c 
		LEFT JOIN transactions t ON TO_CHAR(c.trans_date, 'YYYY-MM') = TO_CHAR(t.trans_date, 'YYYY-MM')
		GROUP BY TO_CHAR(c.trans_date, 'YYYY-MM'), t.country
)
SELECT cb.month, cb.country, a.approved_count, a.approved_amount, cb.chargeback_count, cb.chargeback_amount
FROM cb  
JOIN approved a USING (month)





