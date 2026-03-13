

         -- The Best Approach. Using - GROUP BY with - MAX() -- 
SELECT emp_id, firstname, lastname, MAX(salary) salary, department_id 
FROM salary
GROUP BY emp_id, firstname, lastname, department_id
ORDER BY emp_id;
