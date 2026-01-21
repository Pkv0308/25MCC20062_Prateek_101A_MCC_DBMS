
-- create table command
CREATE TABLE CUSTOMER_ORDERS (
	ORDER_ID INT PRIMARY KEY,
	CUSTOMER_NAME VARCHAR(30) NOT NULL,
	PRODUCT VARCHAR(50) NOT NULL,
	QUANTITY INT NOT NULL CHECK (QUANTITY > 0),
	PRICE DECIMAL(8, 2) NOT NULL CHECK (PRICE >= 0),
	ORDER_DATE DATE NOT NULL
);


--insert command
INSERT INTO CUSTOMER_ORDERS VALUES
(1023, 'Amit Sharma', 'Laptop', 1, 55000.00, '2024-01-05'),
(2045, 'Neha Verma',    'Mouse',        2,  750.00, '2024-01-06'),
(3098, 'Ravi Kumar',    'Keyboard',     1, 1500.00, '2024-01-07'),
(4121, 'Priya Singh',   'Laptop',       2, 52000.00, '2024-01-08'),
(5876, 'Ankit Patel',   'Monitor',      1, 12000.00, '2024-01-09'),
(6234, 'Sneha Iyer',    'Mouse',        3,  700.00, '2024-01-10'),
(7459, 'Rahul Mehta',   'Keyboard',     2, 1400.00, '2024-01-11'),
(8562, 'Pooja Nair',    'Monitor',      2, 11500.00, '2024-01-12'),
(9187, 'Vikas Gupta',   'Laptop',       1, 58000.00, '2024-01-13'),
(9904, 'Kiran Rao',     'Mouse',        1,  800.00, '2024-01-14'),
(1115, 'Suresh Reddy',  'Keyboard',     3, 1350.00, '2024-01-15'),
(2678, 'Meena Joshi',   'Monitor',      1, 12500.00, '2024-01-16'),
(1357, 'Arjun Malhotra', 'Mouse',     2,  750.00, '2024-01-18'),
(2468, 'Kavita Menon',  'Mouse',     1,  750.00, '2024-01-19'),
(3579, 'Nitin Bansal',  'Keyboard',  1, 1500.00, '2024-01-20'),
(4680, 'Rohit Arora',   'Keyboard',  2, 1500.00, '2024-01-21'),
(5791, 'Divya Kapoor',  'Monitor',   1, 12000.00, '2024-01-22'),
(6802, 'Manoj Kulkarni','Monitor',   2, 12000.00, '2024-01-23');


-- sql query to retrieve selected attributes orderered in ascending order according to one attribute
SELECT
	ORDER_ID,
	CUSTOMER_NAME AS NAME,
	PRICE AS SHOPPING_VALUE
FROM
	CUSTOMER_ORDERS
ORDER BY
	SHOPPING_VALUE DESC;


-- sql query to retrieve selected attributes with priority based sorting
SELECT
	ORDER_ID,
	CUSTOMER_NAME AS NAME,
	PRICE AS SHOPPING_VALUE
FROM
	CUSTOMER_ORDERS
ORDER BY
	SHOPPING_VALUE DESC,
	ORDER_ID;


-- sql query to retrieve attributes according to certain conditions
SELECT
	*
FROM
	CUSTOMER_ORDERS
WHERE
	PRICE > 45000;


-- sql query to retrieve attributes grouped by one of the attributes
SELECT
	PRODUCT,
	sum(quantity) AS QUANTITY_SOLD,
	SUM(QUANTITY * PRICE) AS TOTAL_SALES
FROM
	CUSTOMER_ORDERS
GROUP BY
	PRODUCT;


-- sql query to retrieve grouped attributed having certain conditions
SELECT
	PRODUCT,
	SUM(QUANTITY) AS QUANTITY_SOLD,
	SUM(QUANTITY * PRICE) AS TOTAL_SALES
FROM
	CUSTOMER_ORDERS
GROUP BY
	PRODUCT
HAVING
	SUM(QUANTITY) >= 5;