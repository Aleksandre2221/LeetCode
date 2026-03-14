

-- Risolved: 4 times


         -- Approach 1. Using - RECURSIVE CTE -- 
WITH RECURSIVE all_ids AS (
    SELECT 1 AS id, MAX(customer_id) max_id 
    FROM customers 
    UNION ALL 
    SELECT id + 1, max_id
    FROM all_ids
    WHERE id + 1 <= max_id
)
SELECT ai.id ids 
FROM all_ids ai
LEFT JOIN customers c ON c.customer_id = ai.id
WHERE c.customer_id IS NULL
ORDER BY ids;




         -- Approach 2. Using - generate_series (ONLY PostgreSQL) -- 
SELECT g.ids
FROM generate_series(1, (SELECT MAX(customer_id) FROM customers)) g(ids)
WHERE g.ids NOT IN (SELECT customer_id FROM customers)
ORDER BY ids;

