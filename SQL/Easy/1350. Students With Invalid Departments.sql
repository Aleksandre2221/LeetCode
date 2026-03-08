

-- Risovled: 2 times 

          -- Approach 1. Using - WHERE NOT IN condition --
SELECT id, name  
FROM students
WHERE department_id NOT IN (SELECT id FROM departments);



         -- Approach 2. Using - LEFT JOIN -- 
SELECT s.id, s.name
FROM students s
LEFT JOIN departments d ON s.department_id = d.id
WHERE d.id IS NULL;
