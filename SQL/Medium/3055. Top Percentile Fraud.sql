

         -- Approach 1. Using - PERCENTILE_DISC -- 
WITH percentile AS (
  SELECT state,
      PERCENTILE_DISC(0.95) WITHIN GROUP (ORDER BY fraud_score) p95
  FROM Fraud
  GROUP BY state
)
SELECT f.*
FROM fraud f  
JOIN percentile p ON p.state = f.state 
WHERE p.p95 <= f.fraud_score
ORDER BY state, fraud_score DESC, policy_id




         -- Approach 2. Without using built-in functions -- 
WITH ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY state ORDER BY fraud_score DESC) rn,
        COUNT(*) OVER (PARTITION BY state) total
    FROM Fraud
)
SELECT policy_id, state, fraud_score
FROM ranked
WHERE rn <= CEIL(0.05 * total)
ORDER BY state, fraud_score DESC, policy_id;
