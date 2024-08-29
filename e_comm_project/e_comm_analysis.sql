-- Checking all the tables 

SELECT * FROM aisles

SELECT * FROM departments

SELECT * FROM order_products

SELECT * FROM orders

SELECT * FROM products

-- Analysis 

SELECT DISTINCT order_id
FROM order_products
WHERE order_id NOT IN (SELECT order_id FROM orders);


SELECT DISTINCT op.order_id
FROM order_products op
LEFT JOIN orders o ON op.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Ecomm Analysis Project 



-- #1 Create a temporary table that joins the orders, order_products, and products tables to get information about each order, 
--including the products that were purchased and their department and aisle information
CREATE TEMPORARY TABLE order_info AS
    SELECT o.order_id, o.order_number, o.order_dow, o.order_hour_of_day, o.days_since_prior_order,
           op.product_id, op.add_to_cart_order, op.reordered,
           p.product_name, p.aisle_id, p.department_id
    FROM orders AS o
    JOIN order_products AS op ON o.order_id = op.order_id
    JOIN products AS p ON op.product_id = p.product_id


SELECT * FROM order_info


-- #2Create a temporary table that groups the orders by product and finds the total number of times each product was purchased, 
--the total number of times each product was reordered, and the average number of times each product was added to a cart.

CREATE TEMPORARY TABLE product_order_summary AS (
SELECT p.product_id,p.product_name, count(order_id) As order_count , SUM(reordered) AS total_reorders , avg(add_to_cart_order)
AS avg_times_product
FROM order_products op
JOIN products p ON op.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY p.product_id DESC
)

SELECT * FROM product_order_summary


-- JOINING Both the Temp Tables [order_info , product_order_summary]

SELECT * 
FROM order_info oi
JOIN product_order_summary pos ON oi.product_id = pos.product_id


-- #3 Create a temporary table that groups the orders by department and finds the total number of products purchased, the total number of unique products purchased, 
--the total number of products purchased on weekdays vs weekends, and the average time of day that products in each department are ordered.

CREATE TEMPORARY TABLE department_order_summary AS(

	SELECT d.department_id, product_name , department, SUM(p.product_id) AS Total_products_purchased , COUNT(DISTINCT p.product_id) AS Unique_Total_products_purchased , 
	AVG(order_hour_of_day) AS Avg_time_of_day , COUNT(CASE WHEN order_dow < 6 THEN 1 ELSE NULL END) AS total_weekday_purchase,
	COUNT(CASE WHEN order_dow >= 6 THEN 1 ELSE NULL END) AS total_weekend_purchases
	FROM orders o 
	JOIN order_products op ON o.order_id = op.order_id
	JOIN products p ON p.product_id = op.product_id
	JOIN departments d ON d.department_id = p.department_id
	GROUP BY d.department_id ,product_name , department
	ORDER BY SUM(p.product_id) DESC
) ; 

SELECT * FROM department_order_summary

-- #4 Create a temporary table that groups the orders by aisle and finds the top 10 most popular aisles, 
--including the total number of products purchased and the total number of unique products purchased from each aisle.

CREATE TEMPORARY TABLE aisle_order_summary AS (
SELECT a.aisle_id ,COUNT(*) AS total_products_purchased , COUNT(DISTINCT p.product_id) AS Total_Unique_products_purchased
	FROM orders o 
	JOIN order_products op ON o.order_id = op.order_id
	JOIN products p ON p.product_id = op.product_id
	JOIN aisles a ON a.aisle_id = p.aisle_id
	GROUP BY a.aisle_id
	ORDER BY COUNT(*) DESC
	LIMIT 10
);

SELECT * FROM aisle_order_summary



-- #5 Combine the information from the previous temporary tables into a final table that shows the product ID, product name, 
--department ID, department name, aisle ID, aisle name, total number of times purchased, total number of times reordered, average number of times added to cart, 
--total number of products purchased, total number of unique products purchased, 
--total number of products purchased on weekdays, total number of products purchased on weekends, and average time of day products are ordered in each department.

SELECT pi.product_id, pi.product_name, pi.department_id , d.department, a.aisle_id , ailse,
	pos.total_reorders, pos.avg_times_product,
	dos.total_products_purchased, dos.unique_total_products_purchased,
	dos.total_weekday_purchase,
	dos.total_weekend_purchases,
	dos.avg_time_of_day
FROM product_order_summary pos
JOIN products pi ON pos.product_id = pi.product_id
JOIN departments d ON pi.department_id = d.department_id
JOIN aisles a ON pi.aisle_id = a.aisle_id
JOIN department_order_summary dos ON pi.department_id = dos.department_id


