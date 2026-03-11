

         -- Approach 1. Using - CONCAT -- 
SELECT person_id,
    CONCAT(name, '(', LEFT(profession::text, 1), ')') name
FROM person
ORDER BY peson_id DESC;


         -- Approach 2. Using - || operator -- 
SELECT person_id, 
    name || '(' || LEFT(profession::text, 1) || ')' name 
FROM person
ORDER BY peson_id DESC;

