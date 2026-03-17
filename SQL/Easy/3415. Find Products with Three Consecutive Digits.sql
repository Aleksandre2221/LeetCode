

         -- Approach 1. Using - REGEX (For PostgreSQL) -- 
SELECT product_id, name
FROM Products
WHERE REGEXP_LIKE('X'||name||'X', '([^0-9])([0-9]{3})([^0-9])');
