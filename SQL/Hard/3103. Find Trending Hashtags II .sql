


         -- Approach 1. Using - REGEXP_MATHCES -- (ONLY PostgreSQL) 
WITH extracted AS (
    SELECT tweet_id, 
        REGEXP_MATCHES(tweet, '(#[A-Za-z0-9_]+)', 'g') hashtag
    FROM tweets
)
SELECT hashtag,
    COUNT(*) AS count
FROM extracted
GROUP BY hashtag
ORDER BY count DESC, hashtag DESC
LIMIT 3;


         -- Approach 2. Using - UNNEST -- (ONLY PostgreSQL)
WITH explode AS (
  SELECT *, 
      UNNEST(STRING_TO_ARRAY(SUBSTRING(tweet FROM POSITION ('#' IN tweet)), ' ')) hashtag
  FROM tweets
)
SELECT hashtag, 
    COUNT(*) AS count
FROM explode  
WHERE LEFT(hashtag, 1) = '#' 
GROUP BY hashtag
ORDER BY count DESC, hashtag DESC
LIMIT 3;
