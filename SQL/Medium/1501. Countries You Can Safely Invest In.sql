

          -- The Best Approach. Using two - JOIN and - GROUP BY with - HAVING condition -- 
SELECT co.name  
FROM person p 
JOIN country co ON LEFT(p.phone_number, 3) = co.country_code
JOIN calls ca ON p.id IN (ca.caller_id, ca.callee_id)
GROUP BY co.name
HAVING AVG(ca.duration) > (SELECT AVG(duration) from calls);
