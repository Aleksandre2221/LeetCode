

         -- Approach 1. Using two - CROSS JOIN --  
SELECT 
    CONCAT(t1.topping_name, ',', t2.topping_name, ',', t3.topping_name) AS pizza, 
    (t1.cost + t2.cost + t3.cost) AS total_cost
FROM toppings t1 
CROSS JOIN toppings t2
CROSS JOIN toppings t3
WHERE t1.topping_name < t2.topping_name
  AND t1.topping_name < t3.topping_name
  AND t2.topping_name < t3.topping_name
ORDER BY total_cost DESC, pizza;
