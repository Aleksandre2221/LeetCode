

         -- Approach 1. Using - CTE with Window Functions --
WITH ranking AS (
    SELECT activity, 
        RANK() OVER(ORDER BY COUNT(*)) min,  
        RANK() OVER(ORDER BY COUNT(*) DESC) max
    FROM friends 
    GROUP BY activity
)
SELECT activity 
FROM ranking 
WHERE min <> 1 AND max <> 1;
