

         -- Approach 1. Using - UNION ALL and - SUM with - CASE...WHEN conditions -- 
SELECT 'bull' word, SUM(CASE WHEN content LIKE '% bull %' THEN 1 ELSE 0 END) "count"
FROM files
UNION ALL 
SELECT 'bear', SUM(CASE WHEN content LIKE '% bear %' THEN 1 ELSE 0 END) "count"
FROM files;
