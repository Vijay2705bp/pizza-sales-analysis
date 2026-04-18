-- Question 1.
-- Top 5 and bottom 5 pizzas by revenue
SELECT * FROM orders LIMIT 10;
SELECT * FROM order_details LIMIT 10;
SELECT * FROM pizzas LIMIT 10;
SELECT * FROM pizza_types LIMIT 10;

-- TOP 5 By Revenue
SELECT pt.name,
	SUM(o.quantity * p.price) AS total_revenue
FROM order_details o
JOIN pizzas p
	ON o.pizza_id = p.pizza_id
JOIN pizza_types pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC 
LIMIT 5;

-- Bottom 5 By Revenue
SELECT pt.name,
	SUM(o.quantity * p.price) AS total_revenue
FROM order_details o
JOIN pizzas p
	ON o.pizza_id = p.pizza_id
JOIN pizza_types pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue ASC 
LIMIT 5;

--QUESTION 2.
-- Peak order day and time
SELECT to_char(o.date,'Day') AS day_of_week,
	EXTRACT(HOUR FROM o.time) AS hour_of_day,
	COUNT(od.quantity) as total_quantity
FROM orders o
JOIN order_details od
	ON o.order_id = od.order_id
GROUP BY day_of_week,hour_of_day
ORDER BY total_quantity DESC 
LIMIT 10;

--QUESTION 3.
-- Average order value trend month over month
SELECT 
	TO_CHAR(o.date,'YYYY-MM') AS month,
	ROUND((SUM(od.quantity * p.price)/COUNT(DISTINCT o.order_id)),2) AS avg_order_value
FROM orders o
JOIN order_details od
	ON o.order_id = od.order_id
JOIN pizzas p
	ON od.pizza_id = p.pizza_id
GROUP BY month
ORDER BY month;

--QUESTION 4.
-- Revenue by pizza category
SELECT 
	pt.category,
	SUM(od.quantity * p.price) AS total_revenue,
	ROUND(SUM(od.quantity * p.price)*100.0 /
		 SUM(SUM(od.quantity * p.price)) OVER(),1) AS pct_of_total
FROM pizza_types pt
JOIN pizzas p
	ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od
	ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY total_revenue DESC
LIMIT 10;

--QUESTION 5.
-- Store Manager Recommendation
SELECT 
	(SELECT pt.name FROM pizza_types pt JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id 
	 	JOIN order_details od ON p.pizza_id = od.pizza_id GROUP BY pt.name ORDER BY SUM(od.quantity * p.price) DESC
	 	LIMIT 1) AS top_pizza,
	(SELECT TO_CHAR(date,'Day') FROM orders GROUP BY date ORDER BY COUNT(*) DESC LIMIT 1) AS peak_day,
	(SELECT EXTRACT(HOUR FROM time) FROM orders GROUP BY EXTRACT(HOUR FROM time) ORDER BY COUNT(*) DESC LIMIT 1) AS peak_hour,
	(SELECT pt.category FROM pizza_types pt JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
		JOIN order_details od ON p.pizza_id = od.pizza_id GROUP BY pt.category ORDER BY SUM(od.quantity * p.price) DESC
		LIMIT 1) AS top_category
;

--COPYING TABLES INTO .CSV FILES


-- Result: Thai Chicken Pizza leads with ₹43,434 in revenue