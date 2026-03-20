


         -- Approach 1. Using - CTE and - Self-Join -- 
WITH row_num AS (
    SELECT *, ROW_NUMBER() OVER() rn
    FROM coordinates
)
SELECT rn1.x, rn1.y 
FROM row_num rn1 
JOIN row_num rn2 
    ON rn1.x = rn2.y
    AND rn1.y = rn2.x
    AND rn1.x <= rn1.y
    AND rn1.rn <> rn2.rn
GROUP BY rn1.x, rn1.y 
HAVING COUNT(*) >= 1
ORDER BY x, y;
