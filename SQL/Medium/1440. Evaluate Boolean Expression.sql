

-- Risolved: 2 times 


         -- Approach 1. Using two - JOIN and - CASE...WHEN conditions -- 
SELECT e.*,
	CASE  
		WHEN e.operator = '=' AND lv.value <> rv.value THEN 'false'  
		WHEN e.operator = '>' AND lv.value < rv.value  THEN 'false'  
		WHEN e.operator = '<' AND lv.value > rv.value  THEN 'false'  
		ELSE 'true'
	END value 
FROM expressions e 
JOIN variables lv ON e.left_operand = lv.name
JOIN variables rv ON e.right_operand = rv.name;





