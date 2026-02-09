

-- Risolved: 3 times


         -- Approach 1. Using - JOIN with - WHERE conditions --  
SELECT p1.id p1, p2.id p2,
    ABS(p1.x_value - p2.x_value) * ABS(p1.y_value - p2.y_value) area
FROM points p1 
JOIN points p2 ON p1.id < p2.id
WHERE p1.x_value <> p2.x_value AND p1.y_value <> p2.y_value
ORDER BY area DESC, p2;


         -- Approach 2. Using - CTE -- 
WITH area AS (
  SELECT p1.id p1, p2.id p2, 
      ABS(p1.x_value - p2.x_value) * abs(p1.y_value - p2.y_value) area 
  FROM points p1 
  JOIN points p2 ON p1.id < p2.id
) 
SELECT * 
FROM area  
WHERE area > 0 
ORDER BY area DESc, p1, p2;


