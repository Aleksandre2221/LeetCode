

-- Risolved: 4 times


         -- Approach 1. Using - UNION ALL --  
WITH 
	all_trans AS (
      SELECT paid_by AS user_id, -amount AS amount FROM transactions 
      UNION ALL 
      SELECT paid_to, amount FROM transactions 
	),
    total_amount AS (
      SELECT user_id, SUM(amount) total 
      FROM all_trans  
      GROUP BY user_id
)
SELECT u.user_id, u.user_name, 
	COALESCE(SUM(u.credit + ta.total), u.credit) credit, 
	CASE 
    	WHEN SUM(u.credit + ta.total) < 0 
        THEN 'Yes' 
        ELSE 'No' 
	END credit_limit_breached
FROM users u 
LEFT JOIN total_amount ta USING (user_id)
GROUP BY u.user_id, u.user_name, u.credit;
