

         -- Approach 1. CTE and - CASE...WHEN conditions -- 
WITH max_salaries AS (
  SELECT company_id, MAX(salary) ms 
  FROM salaries 
  GROUP BY company_id
)
SELECT s.company_id, s.employee_id, s.employee_name, 
	CASE  
      WHEN ms.ms BETWEEN 1000 AND 10000 THEN CAST(s.salary * (1 - 0.24) AS INT)
      WHEN ms.ms > 10000 THEN CAST(s.salary * (1 - 0.49) AS INT)
      ELSE s.salary 
	END salary
FROM salaries s 
JOIN max_salaries ms ON ms.company_id = s.company_id




         -- Approach 2. Without - CTE, using only - CASE...WHEN conditions with Window Function - MAX() -- 
SELECT company_id, employee_id, employee_name,
    CASE  
        WHEN MAX(salary) OVER (PARTITION BY company_id) BETWEEN 1000 AND 10000 
           THEN ROUND(s.salary * (1 - 0.24))
        WHEN MAX(salary) OVER (PARTITION BY company_id) > 10000 
            THEN ROUND(salary * (1 - 0.49))
        ELSE salary
    END salary
FROM salaries;
