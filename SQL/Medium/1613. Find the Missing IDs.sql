

-- Risolved: 4 times


         -- Approach 1. Using - RECURSIVE CTE -- 
WITH RECURSIVE all_ids AS (
  SELECT 1 ids, MAX(customer_id) max_id
  FROM customers
  UNION ALL  
  SELECT ids + 1, max_id
  FROM all_ids
  WHERE ids < max_id
) 
SELECT ids
FROM all_ids
WHERE ids NOT IN (SELECT customer_id FROM customers)
ORDER BY ids;




         -- Approach 2. Using - generate_series (ONLY PostgreSQL) -- 
SELECT g.ids
FROM generate_series(1, (SELECT MAX(customer_id) FROM customers)) g(ids)
WHERE g.ids NOT IN (SELECT customer_id FROM customers)
ORDER BY ids;

