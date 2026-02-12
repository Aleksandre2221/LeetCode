

-- Rosolved: 4 times


         -- Approach 1. Using - CTE with a Window Function - ROW_NUMBER() and - CASE...WHEN conditions -- 
WITH row_num AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY gender ORDER BY user_id) rn1, 
        CASE
            WHEN gender = 'female' THEN 1
            WHEN gender = 'other' THEN 2	
            ELSE 3
       END rn2
    FROM genders
)
SELECT user_id, gender 
FROM row_num
ORDER BY rn1, rn2;
