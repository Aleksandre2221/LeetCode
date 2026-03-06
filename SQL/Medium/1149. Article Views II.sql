

         -- Approach 1. Using - GROUP BY with - HAVING -- 
SELECT DISTINCT viewer_id id 
FROM views 
GROUP BY viewer_id, view_date 
HAVING COUNT(DISTINCT article_id) > 1
ORDER BY id;
