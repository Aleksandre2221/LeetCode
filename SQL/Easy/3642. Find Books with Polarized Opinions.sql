

-- Risolved: 3 times 

         -- Approach 1. Using multiple - HAVING conditions -- 
SELECT b.book_id, b.title, b.author, b.genre, b.pages, 
    MAX(rs.session_rating) - MIN(rs.session_rating) rating_spread,
    ROUND(SUM(CASE WHEN rs.session_rating >= 4 OR rs.session_rating <= 2 THEN 1 ELSE 0 END) * 1.0 / COUNT(DISTINCT rs.session_id), 2) polarization_score
FROM reading_sessions rs
JOIN books b ON b.book_id = rs.book_id
GROUP BY b.book_id, b.title, b.author, b.genre, b.pages
HAVING 
    COUNT(rs.session_id) >= 5
    AND SUM(CASE WHEN rs.session_rating >= 4 THEN 1 ELSE 0 END) > 0
    AND SUM(CASE WHEN rs.session_rating <= 2 THEN 1 ELSE 0 END) > 0
    AND ROUND(SUM(CASE WHEN rs.session_rating >= 4 OR rs.session_rating <= 2 THEN 1 ELSE 0 END) * 1.0 / COUNT(DISTINCT rs.session_id), 2) >= 0.6
ORDER BY polarization_score DESC, title DESC;
