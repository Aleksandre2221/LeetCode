

         -- Approach 1. Using two - CTE and - CROSS JOIN -- 
WITH 
    platforms AS (
        SELECT 'Android' platform
        UNION ALL
        SELECT 'IOS' 
        UNION ALL
        SELECT 'Web' 
    ),
    activities AS (
        SELECT 'Reading' experiment_name
        UNION ALL
        SELECT 'Sports' 
        UNION ALL
        SELECT 'Programming' 
)
SELECT
    p.platform,
    a.experiment_name experiment_name,
    COUNT(ep.experiment_id) num_experiments
FROM platforms p
CROSS JOIN activities a
LEFT JOIN experiments ep USING (platform, experiment_name)
GROUP BY p.platform, a.experiment_name;
