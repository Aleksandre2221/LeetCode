

    -- Approach 1. Using - WHERE NOT IN - condition --  
SELECT name Customers 
FROM customers 
WHERE id NOT IN (SELECT customerid FROM orders)

        -- WARNING: When using-NOT IN - you need to be sure that there are no NULL values, otherwis NOT IN  returns an empty table (because of 3VL)


    -- Approach 2. Using - WHERE NOT EXISTS - condition -- 
SELECT c.name Customers
FROM customers c
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customerid = c.id)


    -- Approach 3. Using - LEFT JOIN -- 
SELECT c.name Customers 
FROM customers c
LEFT JOIN orders o ON c.id = o.customerid
WHERE o.customerId IS NULL 






