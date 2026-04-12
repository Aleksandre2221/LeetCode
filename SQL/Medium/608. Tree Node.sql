


           -- Approach 1. The BEST one Using only - CASE....WHEN -- 
SELECT id, 
    CASE 
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT p_id FROM Tree) THEN 'Inner'
        ELSE 'Leaf'
    END Type 
FROM Tree;


