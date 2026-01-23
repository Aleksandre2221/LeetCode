

-- Risolved: 2 times


         -- Approach 1. Using two - CTE -- 
WITH 
	dist AS (
      SELECT DISTINCT a.id, a.name, l.login_date
      FROM logins l
      JOIN accounts a USING (id)
    ),
	grp AS (
      SELECT *, 
        login_date - ROW_NUMBER() OVER (PARTITION BY id ORDER BY login_date)::int AS grp
      FROM dist
)
SELECT id, name
FROM grp
GROUP BY id, name, grp
HAVING COUNT(*) >= 5;




