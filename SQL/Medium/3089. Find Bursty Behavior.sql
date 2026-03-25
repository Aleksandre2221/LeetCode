

         -- Approach 1. Using two - CTE -- 
WITH 
	seven_day AS (
        SELECT p1.user_id,
            COUNT(*) cnt
        FROM Posts p1
        JOIN Posts p2 
            ON p1.user_id = p2.user_id
            AND p2.post_date >= p1.post_date 
            AND p2.post_date <= p1.post_date + INTERVAL '6 days'
        WHERE p1.post_date BETWEEN '2024-02-01' AND '2024-02-28'
        GROUP BY p1.user_id, p1.post_id          
    ),
	avg_weekly AS (
        SELECT user_id,
            COUNT(*)::numeric / 4 avg_weekly_posts
        FROM Posts
        WHERE post_date BETWEEN '2024-02-01' AND '2024-02-28'
        GROUP BY user_id
)
SELECT 
    s.user_id,
    MAX(s.cnt) max_7day_posts,
    a.avg_weekly_posts
FROM seven_day s
JOIN avg_weekly a ON s.user_id = a.user_id
GROUP BY s.user_id, a.avg_weekly_posts
HAVING MAX(s.cnt) >= a.avg_weekly_posts * 2
ORDER BY s.user_id;
