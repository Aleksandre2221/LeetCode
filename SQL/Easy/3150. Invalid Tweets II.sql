

-- Risolved: 2 times


         -- Approach 1. Using - CTE with - UNNSET(STRING_TO_ARRAY(...))
WITH exploded AS (
  SELECT *, UNNEST(STRING_TO_ARRAY(content, ' ')) str
  FROM tweets
)
SELECT tweet_id 
FROM exploded 
GROUP BY tweet_id
HAVING COUNT(CASE WHEN LEFT(str, 1) = '@' THEN 1 END) > 3
	OR COUNT(CASE WHEN LEFT(str, 1) = '#' THEN 1 END) > 3
    OR LENGTH(MAX(content)) > 140
ORDER BY tweet_id;



         -- Approach 2. Using only - LENGTH and - REPLACE -- 
SELECT tweet_id
FROM tweets
WHERE LENGTH(content) > 140
    OR (LENGTH(content) - LENGTH(REPLACE(content, '@', ''))) > 3
    OR (LENGTH(content) - LENGTH(REPLACE(content, '#', ''))) > 3
ORDER BY tweet_id;
