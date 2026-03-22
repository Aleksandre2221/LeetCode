

         -- Approach 1. Using - CTE with - UNNEST --  
WITH single_word AS (
    SELECT UNNEST(STRING_TO_ARRAY(tweet, ' ')) word
    FROM tweets
    WHERE TO_CHAR(tweet_date, 'YYYY-MM') = '2024-02'
)        
SELECT word "HASHTAG", COUNT(*) "HASHTAG_COUNT"
FROM single_word 
WHERE LEFT(word, 1) = '#'
GROUP BY word
ORDER BY "HASHTAG_COUNT" DESC, "HASHTAG" desc
LIMIT 3;
