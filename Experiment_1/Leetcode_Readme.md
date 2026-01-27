# 🧩 LeetCode 183: Customers Who Never Order

## 📌 Problem Statement

Write an SQL query to find the **names of customers who never placed any orders**.

## 🗂️ Database Schema

### **Customers** Table

| Column | Type    |
| ------ | ------- |
| id     | int     |
| name   | varchar |

### **Orders** Table

| Column     | Type |
| ---------- | ---- |
| id         | int  |
| customerId | int  |

* `orders.customerId` is a **foreign key** referencing `customers.id`.


## 🎯 Expected Output

A single-column result showing the **names of customers** who do **not** appear in the `Orders` table.

| Customers |
| --------- |
| Henry     |
| Max       |


## ✅ Solution 

```sql
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
ON c.id = o.customerId
WHERE o.customerId IS NULL;
```

## ✅ Submission Proof
<img src="output/leetcode_183.png" width="500"> 
