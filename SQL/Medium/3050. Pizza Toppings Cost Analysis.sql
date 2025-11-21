

         -- Approach 1. Using two - JOIN and - CONCAT_WS -- 
SELECT CONCAT_WS(', ', t1.topping_name, t2.topping_name,  t3.topping_name) pizza, 
	t1.cost + t2.cost + t3.cost total_cost 
FROM toppings t1 
JOIN toppings t2 ON t1.topping_name < t2.topping_name
JOIN toppings t3 ON t2.topping_name < t3.topping_name
ORDER BY total_cost DESC, pizza; 
