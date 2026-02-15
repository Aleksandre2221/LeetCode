

-- Risolved: 4 times


         -- Approach 1. Using - LEFT JOIN and - COALESCE -- 
SELECT DISTINCT e1.employee_id,
       COALESCE(e2.department_id, e1.department_id) department_id
FROM employee e1
LEFT JOIN employee e2 ON e1.employee_id = e2.employee_id AND e2.primary_flag = 'Y';




         -- Approach 2. Using - LEFT JOIN and - CASE...WHEN condition -- 
SELECT DISTINCT e1.employee_id, 
	CASE 
    	WHEN e2.department_id IS NOT NULL THEN e2.department_id
      	ELSE e1.department_id
    END department_id
FROM employee e1 
LEFT JOIN employee e2 ON e1.employee_id = e2.employee_id AND e2.primary_flag = 'Y';




           -- Approach 3. Using only - WHERE condition -- 
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag='Y' 
	OR employee_id IN (
        SELECT employee_id
        FROM Employee
        GROUP BY employee_id
        HAVING COUNT(employee_id) = 1
);
