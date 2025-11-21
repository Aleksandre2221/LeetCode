

         -- Approach 1. Using - MAX / MIN -- 
SELECT
    MAX(assignment1 + assignment2 + assignment3) 
    	- MIN(assignment1 + assignment2 + assignment3) difference_in_score
FROM Scores;



         -- Approach 2. Using two - Subqueries without - MAX / MIN -- 
SELECT 
(
  SELECT assignment1 + assignment2 + assignment3 
  FROM scores 
  ORDER BY assignment1 + assignment2 + assignment3 DESC
  LIMIT 1
)
	- 
(
  SELECT assignment1 + assignment2 + assignment3 
  FROM scores 
  ORDER BY assignment1 + assignment2 + assignment3 
  LIMIT 1
)  
	difference_in_scores
