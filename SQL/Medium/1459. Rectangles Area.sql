

-- Risolved: 2 times


         -- Approach 1. Using - JOIN with - WHERE conditions --  
SELECT p1.id p1, p2.id p2,
    ABS(p1.x_value - p2.x_value) * ABS(p1.y_value - p2.y_value) area
FROM points p1 
JOIN points p2 ON p1.id < p2.id
WHERE p1.x_value <> p2.x_value AND p1.y_value <> p2.y_value
ORDER BY area DESC, p2;


         -- Approach 2. Using - CTE -- 
WITH calc AS (
  SELECT 
      LEAST(
        ABS(po1.x_value - po2.x_value),
        ABS(po1.y_value - po2.y_value)
      ) p1,
      GREATEST(
        ABS(po1.x_value - po2.x_value),
        ABS(po1.y_value - po2.y_value)
      ) p2,
      ABS(po1.x_value - po2.x_value) * ABS(po1.y_value - po2.y_value) area
  FROM points po1
  JOIN points po2 ON po1.id < po2.id
)
SELECT *
FROM calc
WHERE area > 0
ORDER BY area DESC, p1, p2;

