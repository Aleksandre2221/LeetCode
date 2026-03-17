

         -- Approach 1. Using - WHERE conditions -- 
CREATE OR REPLACE FUNCTION getUserIDs(startDate TIMESTAMP, endDate TIMESTAMP, minAmount INT) RETURNS INT AS $$
BEGIN
  RETURN (
    SELECT COUNT(DISTINCT user_id) AS user_count
    FROM Purchases
    WHERE 
        time_stamp >= startDate 
        AND time_stamp BETWEEN startDate AND endDate
        AND amount >= minAmount
  );
END;
$$ LANGUAGE plpgsql;
