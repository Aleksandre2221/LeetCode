

         -- Approach 1. Using - Self-Join - MIN - ABS -- 
SELECT MIN(ABS(p1.x - p2.x)) AS shortest
FROM point p1
JOIN point p2 ON p1.x < p2.x;




         -- Approach 2. Without - MIN using - ORDER BY with - LIMIT 1 --
SELECT ABS(p1.x - p2.x) shortest
FROM point p1 
JOIN point p2 ON p1.x < p2.x
ORDER BY shortest 
LIMIT 1;




          -- Approach 3. Without - Self-Join using Window Function - LAG() --
SELECT MIN(distance) shortest
FROM (
  SELECT ABS(x - LAG(x) OVER()) distance 
  FROM point
);
