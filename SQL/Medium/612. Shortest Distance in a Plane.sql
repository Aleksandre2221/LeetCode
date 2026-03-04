

         -- Approach 1. Using - LEFT JOIN -- 
SELECT ROUND(
  	MIN(SQRT(POWER((p1.x - p2.x)::numeric, 2) + POWER((p1.y - p2.y)::numeric, 2))) 
    , 2) shortest  
FROM Point2D p1
LEFT JOIN Point2D p2 ON (p1.x, p1.y) < (p2.x, p2.y); 

