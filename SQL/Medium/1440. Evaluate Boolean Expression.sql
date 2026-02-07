

-- Risolved: 2 times 


         -- Approach 1. Using two - JOIN and - CASE...WHEN conditions -- 
SELECT e.*,
	CASE  
		WHEN e.operator = '=' AND lv.value <> rv.value THEN FALSE  
		WHEN e.operator = '>' AND lv.value < rv.value THEN FALSE  
		WHEN e.operator = '<' AND lv.value > rv.value THEN FALSE  
		ELSE TRUE
	END value 
FROM expressions e 
JOIN variables lv ON e.left_operand = lv.name
JOIN variables rv ON e.right_operand = rv.name;



		-- Approach 2. Compact version of CASE...WHEN -- 
SELECT e.*,
    CASE e.operator
        WHEN '>' THEN v1.value > v2.value
        WHEN '<' THEN v1.value < v2.value
        WHEN '=' THEN v1.value = v2.value
        ELSE TRUE
    END value
FROM expressions e
JOIN variables v1 ON e.left_operand = v1.name
JOIN variables v2 ON e.right_operand = v2.name;




