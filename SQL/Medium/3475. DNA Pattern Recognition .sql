

         -- Approach 1. Using multiple - CASE...WHEN conditions -- 
SELECT *,
  CASE WHEN LEFT(dna_sequence, 3) = 'ATG' THEN 1 ELSE 0 END has_start,
  CASE WHEN RIGHT(dna_sequence, 3) IN ('TAA', 'TAG', 'TGA') THEN 1 ELSE 0 END has_stop,
  CASE WHEN dna_sequence LIKE '%ATAT%' THEN 1 ELSE 0 END has_atat,
  CASE WHEN dna_sequence LIKE '%GGG%' THEN 1 ELSE 0 END has_ggg
FROM samples;
