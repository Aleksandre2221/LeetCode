


         -- Approach 1. Using two - CTE -- 
WITh 
	dist AS (
      SELECT DISTINCT l.id, l.login_date, a.name 
      FROM accounts a  
      LEFT JOIN logins l USING (id)
	),
    ranking AS (
      SELECT *, 
      	ROW_NUMBER() OVER(PARTITION BY name ORDER BY login_date)::int rn 
      FROM dist
)
SELECT DISTINCT id, name 
FROM ranking  
GROUP BY id, name, login_date - rn
HAVING COUNT(*) >= 5;




