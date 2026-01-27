-- leetcode problem number 183


SELECT c.name as Customers
FROM customers c
LEFT JOIN orders o
  ON c.id = o.customerID
WHERE o.id IS NULL;