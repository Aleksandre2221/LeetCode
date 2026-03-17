

         -- Approach 1. Using - WHERE conditions -- 
SELECT DISTINCT p.user_id
FROM purchases p
WHERE 
    time_stamp BETWEEN startDate AND endDate
    AND amount >= minAmount
