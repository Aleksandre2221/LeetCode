

-- Risolved: 3 times


         -- Approach 1. Using - JOIN with multiple conditions --  
SELECT 
    p1.id p1, 
    p2.id p2,
    ABS(p1.x_value - p2.x_value) * ABS(p1.y_value - p2.y_value) area
FROM points p1 
JOIN points p2 
    ON p1.id < p2.id
    AND p1.x_value <> p2.x_value 
    AND p1.y_value <> p2.y_value
ORDER BY area DESC, p1, p2;


