

         -- Approach 1. Using - HAVING with multiple conditions and - STRING_AGG -- 
SELECT state, 
  STRING_AGG(city, ', ') cities,
  COUNT(CASE WHEN LEFT(city, 1) = LEFT(state, 1) THEN 1 END) matching_letter_count
FROM cities
GROUP BY state
HAVING 
  COUNT(*) > 2 
  AND COUNT(CASE WHEN LEFT(city, 1) = LEFT(state, 1) THEN 1 END) > 0
ORDER BY matching_letter_count DESC, state;
