

-- Risolved: 2 times


         -- Approach 1. Using two - LIKE conditons -- 
SELECT * 
FROM patients 
WHERE conditions LIKE '% DIAB1%' OR conditions LIKE 'DIAB1%';



         -- Appraoch 2. Using - UNNEST(STRING_TO_ARRAY....) -- 
SELECT patient_id, patient_name, conditions
FROM (SELECT *, UNNEST(STRING_TO_ARRAY(conditions, ' ')) pref FROM patients) sub 
WHERE LEFT(pref, 5) = 'DIAB1';
