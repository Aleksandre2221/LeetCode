

         -- Approach 1. Using - CASE...WHEN conditions --
SELECT n N,
       CASE
           WHEN NOT EXISTS (SELECT 1 FROM tree t2 WHERE t2.p = t1.n) THEN 'Leaf'
           WHEN p IS NULL THEN 'Root'
           ELSE 'Inner'
       END Type
FROM tree t1
ORDER BY n;

