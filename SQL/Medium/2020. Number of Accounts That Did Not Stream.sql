

         -- Approach 1. Using multiple  - WHERE conditions -- 
SELECT COUNT(*) accounts_count 
FROM subscriptions sub 
WHERE NOT EXISTS (
    SELECT 1 
    FROM streams str
    WHERE str.account_id = sub.account_id
        AND EXTRACT(YEAR FROM stream_date) = 2021
)
AND (EXTRACT(YEAR FROM start_date) = 2021 OR EXTRACT(YEAR FROM end_date) = 2021);
