

-- Risolved: 2 times


         -- The Best Appraoch. Using two - CTE and - UNION ALL -- 
WITH 
	user_name AS (
      SELECT u.name results
      FROM movierating m 
      JOIN users u ON u.user_id = m.user_id
      GROUP BY u.name
      ORDER BY COUNT(*) DESC, u.name
      LIMIT 1
   	), 
  movie_name AS (
      SELECT m.title
      FROM movierating mr 
      JOIN movies m ON m.movie_id = mr.movie_id
      WHERE TO_CHAR(created_at, 'YYYY-MM') = '2020-02'
      GROUP BY m.title
      ORDER BY AVG(rating) DESC, m.title
      LIMIT 1
    )
SELECT * FROM user_name
UNION ALL
SELECT * FROM movie_name;
