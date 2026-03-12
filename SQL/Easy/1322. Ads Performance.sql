


           -- Approach 1. Using - CTE and - COUNT with (CASE....WHEN) condionts -- 
WITH ad_stats AS (
    SELECT ad_id,
        COUNT(CASE WHEN action = 'Clicked' THEN 1 END) total_clicked,
        COUNT(CASE WHEN action = 'Viewed'  THEN 1 END) total_viewed
    FROM ads
    GROUP BY ad_id
)
SELECT ad_id,
    CASE 
        WHEN total_clicked = 0 THEN 0
        ELSE ROUND(total_clicked * 100.0 / (total_clicked + total_viewed), 2)
    END AS ctr
FROM ad_stats
ORDER BY ctr DESC, ad_id;




