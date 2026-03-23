

         -- Approach 1. Using - CTE -- 
WITH calc AS (
    SELECT 
        a.account_id,
        DATE_TRUNC('month', t.day) tr_month, 
        SUM(t.amount) month_total, 
        a.max_income
    FROM transactions t  
    JOIN accounts a USING (account_id)
    WHERE t.type = 'Creditor'
    GROUP BY a.account_id, DATE_TRUNC('month', t.day), a.max_income
    HAVING SUM(t.amount) > a.max_income
)
SELECT DISTINCT c1.account_id 
FROM calc c1 
JOIN calc c2 
    ON c1.account_id = c2.account_id
    AND c2.tr_month = c1.tr_month + INTERVAL '1 MONTH';
