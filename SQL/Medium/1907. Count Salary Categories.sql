

-- Risolved: 3 times


         -- Approach 1. Using - UNION ALL -- 
SELECT 'Low Salary' category, 
	SUM(CASE WHEN income < 20000 THEN 1 ELSE 0 END) accounts_count 
FROM accounts
UNION ALL 
SELECT 'Average Salary' category, 
	SUM(CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 ELSE 0 END) accounts_count 
FROM accounts 
UNION ALL  
SELECT 'High Salary' category, 
	SUM(CASE WHEN income > 50000 THEN 1 ELSE 0 END) accounts_count 
FROM accounts
ORDER BY accounts_count DESC;




		 -- Approach 2. Using two - CTE -- 
WITH 
	all_cats AS (
      SELECT 'Low Salary' category 
      UNION ALL 
      SELECT 'Average Salary' 
      UNION ALL 
      SELECT 'High Salary'
  ), 
  available_cats AS (
    SELECT 
    	CASE  
    		WHEN income < 20000 THEN 'Low Salary' 
    		WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary' 
    		ELSE 'High Salary'
		END category
	 FROM accounts 
) 
SELECT alc.category, COUNT(avc.category) accounts_count 
FROM all_cats alc 
LEFT JOIN available_cats avc USING (category)
GROUP BY alc.category;



         -- Approach 3. Using - UNNEST(ARRAY(...)) -- 
WITH 
	categories AS (
  		SELECT UNNEST(ARRAY['Low Salary', 'Average Salary', 'High Salary']) category
	), 
  flagged AS (
    SELECT 
      CASE 
          WHEN income < 20000 THEN 'Low Salary'
          WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
          ELSE 'High Salary'
      END category
    FROM accounts
)
SELECT c.category, COUNT(f.category) accounts_count 
FROM categories c  
LEFT JOIN flagged f ON c.category = f.category
GROUP BY c.category
ORDER BY accounts_count DESC;




