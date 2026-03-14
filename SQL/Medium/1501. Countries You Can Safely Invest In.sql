

          -- The Best Approach. Using - CTE with - UNION ALL -- 
WITH bidir AS (
    SELECT caller_id, callee_id, duration FROM calls 
    UNION ALL 
    SELECT callee_id, caller_id, duration FROM calls
)
SELECT c.name country
FROM person p 
JOIN country c ON c.country_code = LEFT(p.phone_number, 3)
JOIN bidir b ON b.caller_id = p.id
GROUP BY c.name
HAVING AVG(duration) > (SELECT AVG(duration) FROM bidir);
