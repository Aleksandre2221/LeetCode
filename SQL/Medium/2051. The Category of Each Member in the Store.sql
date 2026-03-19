

         -- Approach 1. Using two - LEFT JOIN and - CASE...WHEN conditions -- 
SELECT m.member_id, m.name, 
    CASE 
        WHEN COUNT(p.charged_amount) * 100.0 / NULLIF(COUNT(v.visit_id), 0) >= 80 THEN 'Diamond'
        WHEN COUNT(p.charged_amount) * 100.0 / NULLIF(COUNT(v.visit_id), 0) BETWEEN 50 AND 79 THEN 'Gold'
        WHEN COUNT(p.charged_amount) * 100.0 / NULLIF(COUNT(v.visit_id), 0) < 50 THEN 'Silver'
        WHEN COUNT(v.visit_id) = 0 THEN 'Bronze' 
    END category
FROM members m 
LEFT JOIN visits v USING (member_id) 
LEFT JOIN purchases p USING (visit_id)
GROUP BY m.member_id, m.name;
