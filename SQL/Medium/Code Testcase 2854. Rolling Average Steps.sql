


         -- Approach 1. Using - LEFT JOIN -- 
SELECT 
    s1.user_id, 
    s1.steps_date, 
    ROUND(AVG(s2.steps_count), 2) rolling_average
FROM steps s1 
LEFT JOIN steps s2 
    ON s1.user_id = s2.user_id 
    AND s2.steps_date BETWEEN s1.steps_date-2 AND s1.steps_date
GROUP BY s1.user_id, s1.steps_date
HAVING COUNT(s2.steps_date) = 3
ORDER BY s1.user_id, s1.steps_date;
