

         -- Approach 1. Using - Self-Join with multiple - WHERE conditions --
SELECT p.patient_id, p.patient_name, p.age,
  MIN(ct2.test_date) - MIN(ct1.test_date) recovery_time
FROM covid_tests ct1 
JOIN covid_tests ct2 ON ct1.patient_id = ct2.patient_id 
JOIN patients p ON p.patient_id = ct1.patient_id
WHERE ct1.test_date < ct2.test_date 
  AND ct1.result = 'Positive' 
  AND ct2.result = 'Negative'
GROUP BY p.patient_id, p.patient_name, p.age
ORDER BY recovery_time, patient_name;
