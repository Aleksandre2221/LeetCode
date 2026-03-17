

         -- Approach 1. Using - MAX with - CASE...WHEN conditions -- 
SELECT
    ABS(
        MAX(CASE WHEN department = 'Engineering' THEN salary END) 
        - MAX(CASE WHEN department = 'Marketing' THEN salary END)
    ) salary_difference
FROM salaries;
