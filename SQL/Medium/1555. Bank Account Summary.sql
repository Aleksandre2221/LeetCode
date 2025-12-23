

-- Risolved: 3 times


         -- Approach 1. Using - UNION ALL within - LEFT JOIN -- 
SELECT u.user_id, u.user_name,
    u.credit + COALESCE(SUM(t.amount_change), 0) credit,
    CASE 
        WHEN u.credit + COALESCE(SUM(t.amount_change), 0) < 0 THEN 'Yes'
        ELSE 'No'
    END credit_limit_breached
FROM users u
LEFT JOIN (
    SELECT paid_by AS user_id, -amount amount_change FROM transaction
    UNION ALL
    SELECT paid_to AS user_id,  amount amount_change FROM transaction
) t ON t.user_id = u.user_id
GROUP BY u.user_id, u.user_name;




         -- Approach 2. Using two - CTE -- 
WITH 
    paid AS (
        SELECT paid_by user_id, SUM(amount) total_paid
        FROM transaction 
        GROUP BY paid_by
    ),
    received AS (
        SELECT paid_to user_id, SUM(amount) total_received
        FROM transaction 
        GROUP BY paid_to
)
SELECT u.user_id, u.user_name,
	u.credit - COALESCE(p.total_paid, 0) + COALESCE(r.total_received, 0) credit,
    CASE 
        WHEN (u.credit - COALESCE(p.total_paid, 0) + COALESCE(r.total_received, 0)) < 0 
        THEN 'Yes'
        ELSE 'No'
    END credit_limit_breached
FROM users u
LEFT JOIN paid p ON p.user_id = u.user_id
LEFT JOIN received r ON r.user_id = u.user_id;
