

         -- Approach 1. Using two CTE with - UNION ALL and - ROW_NUMBER() -- 
WITH 
  all_events AS (
    SELECT success_date ev_date, 'succeeded' period_state
    FROM succeeded
    WHERE success_date BETWEEN '2019-01-01' AND '2019-12-31'

    UNION ALL

    SELECT fail_date ev_date, 'failed' period_state
    FROM failed
    WHERE fail_date BETWEEN '2019-01-01' AND '2019-12-31'
  ),
  grp_calc AS (
    SELECT *, 
        ev_date - ROW_NUMBER() OVER (PARTITION BY period_state ORDER BY ev_date)::int grp
    FROM all_events
)
SELECT period_state,
    MIN(ev_date) start_date,
    MAX(ev_date) end_date
FROM grp_calc
GROUP BY period_state, grp
ORDER BY start_date;
