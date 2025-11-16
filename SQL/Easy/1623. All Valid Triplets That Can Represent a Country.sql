

         -- Approach 1. Using two - LEFT JOIN with multiple conditions -
SELECT a.student_name member_A, b.student_name member_B, c.student_name member_C
FROM schoola a 
LEFT JOIN schoolb b ON 
	a.student_id <> b.student_id AND a.student_name <> b.student_name
LEFT JOIN schoolc c ON 
	c.student_id <> b.student_id AND c.student_id <> a.student_id
	AND c.student_name <> a.student_name AND c.student_name <> b.student_name;



         -- Approach 2. Using two - CROSS JOIN with multiple - WHERE conditions --
SELECT a.student_name member_A, b.student_name member_B, c.student_name member_C
FROM 
    schoola a
    CROSS JOIN schoolb b
    CROSS JOIN schoolc c
WHERE
    a.student_id <> b.student_id 
    AND a.student_name <> b.student_name
    AND c.student_id <> b.student_id 
    AND c.student_id <> a.student_id
    AND c.student_name <> a.student_name 
    AND c.student_name <> b.student_name;
