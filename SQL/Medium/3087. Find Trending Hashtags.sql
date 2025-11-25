

         -- Approach 1. Using - REGEX (For PostgreSQL) -- 
SELECT 
    '#' || (regexp_matches(tweet, '#([^ ]+)'))[1] hashtag,
    COUNT(*) hashtag_count
FROM tweets
WHERE TO_CHAR(tweet_date, 'YYYY-MM') = '2024-02'
GROUP BY hashtag
ORDER BY hashtag_count DESC, hashtag DESC
LIMIT 3;



         -- Approach 2. Using - SUBSTRING_INDEX (For MySQL) -- 
SELECT
    CONCAT('#', SUBSTRING_INDEX(SUBSTRING_INDEX(tweet, '#', -1), ' ', 1)) hashtag,
    COUNT(1) hashtag_count
FROM Tweets
WHERE DATE_FORMAT(tweet_date, '%Y%m') = '202402'
GROUP BY 1
ORDER BY hashtag_count DESC, hashtag DESC
LIMIT 3;
