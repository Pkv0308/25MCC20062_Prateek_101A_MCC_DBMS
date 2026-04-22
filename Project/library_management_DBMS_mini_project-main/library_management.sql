-- ==========================================
-- LIBRARY MANAGEMENT SYSTEM
-- ==========================================

-- ================================
-- 1. TABLE CREATION
-- ================================

-- Create users table
CREATE TABLE users (
user_id SERIAL PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100) UNIQUE,
membership_date DATE DEFAULT CURRENT_DATE
);

-- Create books table
CREATE TABLE books (
book_id SERIAL PRIMARY KEY,
title VARCHAR(200),
author VARCHAR(100),
genre VARCHAR(50),
published_year INT,
total_copies INT,
available_copies INT
);

-- Create loans table
CREATE TABLE loans (
loan_id SERIAL PRIMARY KEY,
user_id INT REFERENCES users(user_id),
book_id INT REFERENCES books(book_id),
issue_date DATE DEFAULT CURRENT_DATE,
return_date DATE,
status VARCHAR(20) DEFAULT 'ISSUED'
);

-- Create fines table
CREATE TABLE fines (
fine_id SERIAL PRIMARY KEY,
loan_id INT REFERENCES loans(loan_id),
amount DECIMAL(10,2),
paid BOOLEAN DEFAULT FALSE
);

-- ================================
-- 2. INSERT QUERIES
-- ================================

-- Insert users
INSERT INTO users (name, email) VALUES
('Aradhya Sharma', '[aradhya@gmail.com](mailto:aradhya@gmail.com)'),
('Jatin Tasoria', '[jatin@gmail.com](mailto:jatin@gmail.com)'),
('Prateek Verma', '[prateek@gmail.com](mailto:prateek@gmail.com)'),
('Amit Kumar', '[amit@gmail.com](mailto:amit@gmail.com)'),
('Neha Gupta', '[neha@gmail.com](mailto:neha@gmail.com)'),
('Rohan Das', '[rohan@gmail.com](mailto:rohan@gmail.com)'),
('Sneha Kapoor', '[sneha@gmail.com](mailto:sneha@gmail.com)'),
('Vikas Mehta', '[vikas@gmail.com](mailto:vikas@gmail.com)'),
('Anjali Jain', '[anjali@gmail.com](mailto:anjali@gmail.com)'),
('Karan Malhotra', '[karan@gmail.com](mailto:karan@gmail.com)');

-- Insert books
INSERT INTO books (title, author, genre, published_year, total_copies, available_copies) VALUES
('Clean Code', 'Robert Martin', 'Programming', 2008, 5, 5),
('The Pragmatic Programmer', 'Andrew Hunt', 'Programming', 1999, 4, 4),
('Design Patterns', 'Erich Gamma', 'Programming', 1994, 3, 3),
('Introduction to Algorithms', 'Thomas H. Cormen', 'Programming', 2009, 6, 6),
('Atomic Habits', 'James Clear', 'Self-help', 2018, 5, 5),
('Deep Work', 'Cal Newport', 'Self-help', 2016, 4, 4),
('Rich Dad Poor Dad', 'Robert Kiyosaki', 'Finance', 1997, 5, 5),
('The Psychology of Money', 'Morgan Housel', 'Finance', 2020, 5, 5),
('Harry Potter', 'J.K. Rowling', 'Fiction', 2001, 7, 7),
('The Alchemist', 'Paulo Coelho', 'Fiction', 1988, 6, 6);

-- Insert loans
INSERT INTO loans (user_id, book_id, issue_date, status) VALUES
(1, 1, CURRENT_DATE - INTERVAL '2 days', 'ISSUED'),
(2, 2, CURRENT_DATE - INTERVAL '5 days', 'ISSUED'),
(3, 3, CURRENT_DATE - INTERVAL '10 days', 'RETURNED'),
(4, 4, CURRENT_DATE - INTERVAL '8 days', 'ISSUED'),
(5, 5, CURRENT_DATE - INTERVAL '1 day', 'ISSUED'),
(6, 6, CURRENT_DATE - INTERVAL '15 days', 'RETURNED'),
(7, 7, CURRENT_DATE - INTERVAL '20 days', 'ISSUED'),
(8, 8, CURRENT_DATE - INTERVAL '3 days', 'ISSUED'),
(9, 9, CURRENT_DATE - INTERVAL '12 days', 'RETURNED'),
(10, 10, CURRENT_DATE - INTERVAL '7 days', 'ISSUED');

-- Insert fines
INSERT INTO fines (loan_id, amount, paid) VALUES
(3, 20.00, FALSE),
(6, 50.00, TRUE),
(9, 30.00, FALSE),
(3, 10.00, TRUE),
(6, 15.00, FALSE),
(9, 25.00, TRUE),
(3, 5.00, FALSE),
(6, 20.00, TRUE),
(9, 10.00, FALSE),
(3, 12.00, TRUE);


-- ================================
-- 3. SELECT QUERIES
-- ================================

-- Fetch all tables
SELECT * FROM books;
SELECT * FROM users;
SELECT * FROM loans;
SELECT * FROM fines;

-- Fetch books by genre
SELECT title, author FROM books WHERE genre = 'Programming';

-- Fetch books after 2010
SELECT * FROM books WHERE published_year > 2010;

-- ================================
-- 4. JOINS
-- ================================

-- Get users with borrowed books
SELECT u.name, b.title
FROM loans l
JOIN users u ON l.user_id = u.user_id
JOIN books b ON l.book_id = b.book_id;

-- Get all users including non-borrowers
SELECT u.name, l.loan_id
FROM users u
LEFT JOIN loans l ON u.user_id = l.user_id;

-- ================================
-- 5. AGGREGATE FUNCTIONS
-- ================================

-- Count books
SELECT COUNT(*) FROM books;

-- Count books by genre
SELECT genre, COUNT(*) FROM books GROUP BY genre;

-- Average published year
SELECT AVG(published_year)::NUMERIC(20, 2) FROM books;

-- ================================
-- 6. WINDOW FUNCTIONS
-- ================================

-- Rank books by popularity
SELECT book_id, COUNT(*) AS borrow_count,
RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
FROM loans
GROUP BY book_id;

-- Running loan count
SELECT loan_id,
COUNT(*) OVER (ORDER BY issue_date) AS running_loans
FROM loans;

-- ================================
-- 7. SUBQUERIES
-- ================================

-- Books never borrowed
SELECT * FROM books
WHERE book_id NOT IN (SELECT DISTINCT book_id FROM loans);

-- Users with more than 3 loans
SELECT name FROM users
WHERE user_id IN (
SELECT user_id FROM loans
GROUP BY user_id
HAVING COUNT(*) > 3
);

-- ================================
-- 8. UPDATE QUERIES
-- ================================

-- Reduce available copies
UPDATE books SET available_copies = available_copies - 1 WHERE book_id = 1;

-- Mark return
UPDATE loans SET status = 'RETURNED', return_date = CURRENT_DATE WHERE loan_id = 1;
select * from loans;

-- ================================
-- 9. DELETE QUERIES
-- ================================

-- Delete loan
DELETE FROM loans WHERE loan_id = 5;

-- ================================
-- 10. VIEWS
-- ================================

-- View for active loans
CREATE VIEW active_loans AS
SELECT l.loan_id, u.name, b.title, l.issue_date
FROM loans l
JOIN users u ON l.user_id = u.user_id
JOIN books b ON l.book_id = b.book_id
WHERE l.status = 'ISSUED';

select * from active_loans;

-- View for overdue books
CREATE VIEW overdue_loans AS
SELECT l.loan_id, u.name, b.title, l.issue_date
FROM loans l
JOIN users u ON l.user_id = u.user_id
JOIN books b ON l.book_id = b.book_id
WHERE l.status = 'ISSUED'
AND l.issue_date < CURRENT_DATE - INTERVAL '7 days';

select * from overdue_loans;

-- ================================
-- 11. STORED PROCEDURES (FUNCTIONS)
-- ================================

-- Function to issue a book
CREATE OR REPLACE FUNCTION issue_book(p_user_id INT, p_book_id INT)
RETURNS VOID AS $$
BEGIN
INSERT INTO loans(user_id, book_id) VALUES (p_user_id, p_book_id);
END;
$$ LANGUAGE plpgsql;

select issue_book(1, 3);
select * from loans;

-- Function to return a book
CREATE OR REPLACE FUNCTION return_book(p_loan_id INT)
RETURNS VOID AS $$
BEGIN
UPDATE loans
SET status = 'RETURNED', return_date = CURRENT_DATE
WHERE loan_id = p_loan_id;
END;
$$ LANGUAGE plpgsql;

select return_book(2);

-- Function to calculate total fines for a user
CREATE OR REPLACE FUNCTION get_total_fines(p_user_id INT)
RETURNS DECIMAL AS $$
DECLARE total DECIMAL;
BEGIN
SELECT COALESCE(SUM(f.amount),0) INTO total
FROM fines f
JOIN loans l ON f.loan_id = l.loan_id
WHERE l.user_id = p_user_id;
RETURN total;
END;
$$ LANGUAGE plpgsql;

select get_total_fines(3);

-- ================================
-- 12. TRIGGERS
-- ================================

-- Function to decrease copies on issue
CREATE OR REPLACE FUNCTION decrease_copies()
RETURNS TRIGGER AS $$
BEGIN
UPDATE books
SET available_copies = available_copies - 1
WHERE book_id = NEW.book_id;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for issuing book
CREATE TRIGGER issue_book_trigger
AFTER INSERT ON loans
FOR EACH ROW
EXECUTE FUNCTION decrease_copies();

INSERT INTO loans (user_id, book_id)
VALUES (1, 2);

select * from books;

-- Function to increase copies on return
CREATE OR REPLACE FUNCTION increase_copies()
RETURNS TRIGGER AS $$
BEGIN
UPDATE books
SET available_copies = available_copies + 1
WHERE book_id = NEW.book_id;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for returning book
CREATE TRIGGER return_book_trigger
AFTER UPDATE ON loans
FOR EACH ROW
WHEN (NEW.status = 'RETURNED')
EXECUTE FUNCTION increase_copies();

UPDATE loans
SET status = 'RETURNED', return_date = CURRENT_DATE
WHERE loan_id = 1;

-- Function to calculate fine
CREATE OR REPLACE FUNCTION calculate_fine()
RETURNS TRIGGER AS $$
BEGIN
IF NEW.return_date > NEW.issue_date + INTERVAL '7 days' THEN
INSERT INTO fines (loan_id, amount)
VALUES (NEW.loan_id,
(NEW.return_date - NEW.issue_date - 7) * 10);
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for fine calculation
CREATE TRIGGER fine_trigger
AFTER UPDATE ON loans
FOR EACH ROW
WHEN (NEW.status = 'RETURNED')
EXECUTE FUNCTION calculate_fine();

UPDATE loans
SET status = 'RETURNED', return_date = CURRENT_DATE
WHERE loan_id = 3;

select * from fines;

-- ================================
-- 13. ADVANCED QUERIES
-- ================================

-- Top 5 users by loans
SELECT u.name, COUNT(l.loan_id) AS total_loans
FROM users u
JOIN loans l ON u.user_id = l.user_id
GROUP BY u.name
ORDER BY total_loans DESC
LIMIT 5;

-- Most popular books
SELECT b.title, COUNT(*) AS borrow_count
FROM loans l
JOIN books b ON l.book_id = b.book_id
GROUP BY b.title
ORDER BY borrow_count DESC;

-- Overdue users and books
SELECT u.name, b.title, l.issue_date
FROM loans l
JOIN users u ON l.user_id = u.user_id
JOIN books b ON l.book_id = b.book_id
WHERE l.status = 'ISSUED'
AND l.issue_date < CURRENT_DATE - INTERVAL '7 days';
