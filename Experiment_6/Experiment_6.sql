-- Create Departments Table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50),
    budget INT
);

-- Create Employees Table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    salary INT,
    status VARCHAR(20), 
    dept_id INT REFERENCES Departments(dept_id),
    hire_date DATE
);

-- Insert Departments
INSERT INTO Departments (dept_id, dept_name, location, budget) VALUES
(1, 'Engineering', 'San Francisco', 500000),
(2, 'Marketing', 'New York', 250000),
(3, 'HR', 'Chicago', 150000),
(4, 'Sales', 'Austin', 300000);

-- Insert Employees
INSERT INTO Employees (emp_id, name, role, salary, status, dept_id, hire_date) VALUES
(101, 'Anay Verma', 'Senior Dev', 95000, 'Active', 1, '2025-01-10'),
(102, 'Bhavna Singh', 'Manager', 82000, 'Active', 2, '2024-05-15'),
(103, 'Chaitanya K.', 'Intern', 35000, 'Inactive', 1, '2026-02-01'),
(104, 'Deepak Raj', 'Analyst', 60000, 'Active', 3, '2023-11-20'),
(105, 'Esha Gupta', 'Lead Designer', 88000, 'Active', 2, '2024-08-12'),
(106, 'Fahad Khan', 'Sales Exec', 55000, 'Active', 4, '2025-03-01'),
(107, 'Gauri Mehta', 'DevOps', 92000, 'Active', 1, '2024-12-05'),
(108, 'Hitesh Shah', 'Recruiter', 48000, 'Inactive', 3, '2023-09-18');

-- creating active employee view
CREATE VIEW Active_Employees_List AS
SELECT 
    emp_id, 
    name, 
    role, 
    dept_id 
FROM Employees
WHERE status = 'Active';


-- querying the view
SELECT * FROM Active_Employees_List;


-- creating a view for joining tables
CREATE VIEW Employee_Department_Details AS
SELECT 
    e.emp_id,
    e.name AS employee_name,
    e.role,
    d.dept_name,
    d.location,
    e.salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;

-- querying the view
SELECT * FROM Employee_Department_Details 


-- creating department summary view
CREATE VIEW Department_Summary AS
SELECT 
    d.dept_name,
    d.location,
    COUNT(e.emp_id) AS total_employees,
    SUM(e.salary) AS total_salary_payout
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name, d.location, d.budget;

-- querying summary view
SELECT * FROM Department_Summary ORDER BY total_salary_payout DESC;

