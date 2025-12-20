

-- Risolved: 2 times 


         -- The Best Approach. Using two - JOIN and - CASE...WHEN conditions -- 
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
