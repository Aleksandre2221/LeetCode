

         -- Approach 1. Using - CTE with a Window Funcion - RANK() -- 
WITH ranking as (
  SELECT *, RANK() OVER(PARTITION BY type ORDER BY duration DESC) rnk
  FROM calls 
)
SELECT c.first_name, r.type,  
	TO_CHAR(INTERVAL '1 second' * duration, 'HH24:MI:SS')
FROM ranking r 
JOIN contacts c ON r.contact_id = c.id
WHERE rnk <= 3
