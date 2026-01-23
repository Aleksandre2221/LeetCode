

         -- Approach 1. Using two - CTE -- 
WITH 
	com_avg AS (
    SELECT 
        TO_CHAR(pay_date, 'YYYY-MM') pay_month, 
        AVG(amount) avg_com_salary
    FROM salary 
    GROUP BY TO_CHAR(pay_date, 'YYYY-MM')
	), 
  dep_avg AS (
    SELECT 
        TO_CHAR(s.pay_date, 'YYYY-MM') pay_month,
        e.department_id,
        AVG(s.amount) avg_dep_salary
    FROM salary s 
    JOIN employee e USING (employee_id)
    GROUP BY e.department_id, TO_CHAR(s.pay_date, 'YYYY-MM')
)
SELECT da.pay_month, da.department_id, 
    CASE  
        WHEN ca.avg_com_salary < da.avg_dep_salary THEN 'Higher'
        WHEN ca.avg_com_salary > da.avg_dep_salary THEN 'Lower'
        ELSE 'Same'
    END comparison
FROM com_avg ca  
JOIN dep_avg da USING(pay_month);



