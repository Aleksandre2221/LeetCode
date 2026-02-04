

-- Risvoled: 2 times


         -- Approach 1. Using multiple - CASE....WHEN conditions within - SUM -- 
SELECT id,
    SUM(CASE WHEN month = 'Jan' THEN revenue END) AS Jan_Revenue,
    SUM(CASE WHEN month = 'Feb' THEN revenue END) AS Feb_Revenue,
    SUM(CASE WHEN month = 'Mar' THEN revenue END) AS Mar_Revenue,
    SUM(CASE WHEN month = 'Apr' THEN revenue END) AS Apr_Revenue,
    SUM(CASE WHEN month = 'May' THEN revenue END) AS May_Revenue,
    SUM(CASE WHEN month = 'Jun' THEN revenue END) AS Jun_Revenue,
    SUM(CASE WHEN month = 'Jul' THEN revenue END) AS Jul_Revenue,
    SUM(CASE WHEN month = 'Aug' THEN revenue END) AS Aug_Revenue,
    SUM(CASE WHEN month = 'Sep' THEN revenue END) AS Sep_Revenue,
    SUM(CASE WHEN month = 'Oct' THEN revenue END) AS Oct_Revenue,
    SUM(CASE WHEN month = 'Nov' THEN revenue END) AS Nov_Revenue,
    SUM(CASE WHEN month = 'Dec' THEN revenue END) AS Dec_Revenue
FROM department
GROUP BY id;



         -- Approach 2. Using - FILTER insted of - CASE...WHEN -- (Only PostgreSQL0
SELECT id,
  SUM(revenue) FILTER (WHERE month = 'Jan') AS Jan_Revenue,
  SUM(revenue) FILTER (WHERE month = 'Feb') AS Feb_Revenue,
  SUM(revenue) FILTER (WHERE month = 'Mar') AS Mar_Revenue,
  SUM(revenue) FILTER (WHERE month = 'Apr') AS Apr_Revenue,
  SUM(revenue) FILTER (WHERE month = 'May') AS May_Revenue,
  SUM(revenue) FILTER (WHERE month = 'Jun') AS Jun_Revenue,
  SUM(revenue) FILTER (WHERE month = 'Jul') AS Jul_Revenue,
  SUM(revenue) FILTER (WHERE month = 'Aug') AS Aug_Revenue,
  SUM(revenue) FILTER (WHERE month = 'Sep') AS Sep_Revenue,
  SUM(revenue) FILTER (WHERE month = 'Oct') AS Oct_Revenue,
  SUM(revenue) FILTER (WHERE month = 'Nov') AS Nov_Revenue,
  SUM(revenue) FILTER (WHERE month = 'Dec') AS Dec_Revenue
FROM department
GROUP BY id;



         -- Approach 3. Using - IF statement (Only MySQL) -- 
SELECT id,
  sum(if(month = 'Jan', revenue, null)) Jan_Revenue,
  sum(if(month = 'Feb', revenue, null)) Feb_Revenue,
  sum(if(month = 'Mar', revenue, null)) Mar_Revenue,
  sum(if(month = 'Apr', revenue, null)) Apr_Revenue,
  sum(if(month = 'May', revenue, null)) May_Revenue,
  sum(if(month = 'Jun', revenue, null)) Jun_Revenue,
  sum(if(month = 'Jul', revenue, null)) Jul_Revenue,
  sum(if(month = 'Aug', revenue, null)) Aug_Revenue,
  sum(if(month = 'Sep', revenue, null)) Sep_Revenue,
  sum(if(month = 'Oct', revenue, null)) Oct_Revenue,
  sum(if(month = 'Nov', revenue, null)) Nov_Revenue,
  sum(if(month = 'Dec', revenue, null)) Dec_Revenue
FROM department 
GROUP BY id;



         -- Approach 4. Using - PIVOT (Only MSSQL) -- 
SELECT id, 
  JAN AS Jan_Revenue,
  FEB AS Feb_Revenue, 
  MAR AS Mar_Revenue, 
  APR AS Apr_Revenue, 
  MAY AS May_Revenue,
  JUN AS Jun_Revenue,
  JUL AS Jul_Revenue, 
  AUG AS Aug_Revenue,
  SEP AS Sep_Revenue, 
  OCT AS Oct_Revenue,
  NOV AS Nov_Revenue,
  DEC AS Dec_Revenue
FROM Department
PIVOT
(
    SUM(revenue)
    FOR month IN (JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC)
) p;





