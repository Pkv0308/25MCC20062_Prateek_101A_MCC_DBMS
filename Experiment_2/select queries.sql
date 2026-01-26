-- set search_path to "Experiment_2";

-- select * from customer_orders;

-- SELECT
-- 	ORDER_ID,
-- 	CUSTOMER_NAME AS NAME,
-- 	PRICE AS SHOPPING_VALUE
-- FROM
-- 	CUSTOMER_ORDERS
-- ORDER BY
-- 	SHOPPING_VALUE DESC;

-- SELECT
-- 	ORDER_ID,
-- 	CUSTOMER_NAME AS NAME,
-- 	PRICE AS SHOPPING_VALUE
-- FROM
-- 	CUSTOMER_ORDERS
-- ORDER BY
-- 	SHOPPING_VALUE DESC,
-- 	ORDER_ID;

-- SELECT
-- 	*
-- FROM
-- 	CUSTOMER_ORDERS
-- WHERE
-- 	PRICE > 45000;


-- SELECT
-- 	PRODUCT,
-- 	sum(quantity) AS QUANTITY_SOLD,
-- 	SUM(QUANTITY * PRICE) AS TOTAL_SALES
-- FROM
-- 	CUSTOMER_ORDERS
-- GROUP BY
-- 	PRODUCT;


-- SELECT
-- 	PRODUCT,
-- 	SUM(QUANTITY) AS QUANTITY_SOLD,
-- 	SUM(QUANTITY * PRICE) AS TOTAL_SALES
-- FROM
-- 	CUSTOMER_ORDERS
-- GROUP BY
-- 	PRODUCT
-- HAVING
-- 	SUM(QUANTITY) >= 5;


-- SELECT 
--     product,
--     SUM(quantity * price) AS total_sales
-- FROM customer_orders
-- WHERE quantity >= 2
-- GROUP BY product;

-- -- SELECT 
-- --     product,
-- --     SUM(quantity * price) AS total_sales
-- -- FROM customer_orders
-- -- GROUP BY product
-- -- HAVING SUM(quantity) > 2;


