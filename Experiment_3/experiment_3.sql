-- create table 
CREATE TABLE SCHEMA_VIOLATIONS (
	SCHEMA_ID INT PRIMARY KEY,
	SCHEMA_NAME VARCHAR(50) NOT NULL,
	VIOLATION_COUNT INT NOT NULL CHECK (VIOLATION_COUNT >= 0)
);

-- inserting records into the table
INSERT INTO
	SCHEMA_VIOLATIONS
VALUES
	(1, 'Finance_Schema', 0),
	(2, 'HR_Schema', 2),
	(3, 'Sales_Schema', 5),
	(4, 'Inventory_Schema', 9),
	(5, 'Audit_Schema', 12),
	(6, 'Compliance_Schema', 20);

-- select query to display inserted records
SELECT
	*
FROM
	SCHEMA_VIOLATIONS;

-- select query to categorize schemas according to violation count using case statement
SELECT
	*,
	CASE
		WHEN VIOLATION_COUNT = 0 THEN 'No Violation'
		WHEN VIOLATION_COUNT BETWEEN 1 AND 3  THEN 'Minor Violation'
		WHEN VIOLATION_COUNT BETWEEN 4 AND 7  THEN 'Moderate Violation'
		ELSE 'Critical Violation'
	END AS VIOLATION_CATEGORY
FROM
	SCHEMA_VIOLATIONS;

-- adding new column status: to denote schema status
ALTER TABLE SCHEMA_VIOLATIONS
ADD COLUMN APPROVAL_STATUS VARCHAR(20);

-- updating status column using case statement
UPDATE SCHEMA_VIOLATIONS
SET
	APPROVAL_STATUS = CASE
		WHEN VIOLATION_COUNT = 0 THEN 'Approved'
		WHEN VIOLATION_COUNT BETWEEN 1 AND 7  THEN 'Needs Review'
		ELSE 'Rejected'
	END;

-- select query to display records after adding and updating status records
SELECT
	*
FROM
	SCHEMA_VIOLATIONS;

-- using case statement for custom sorting
SELECT
	*
FROM
	SCHEMA_VIOLATIONS
ORDER BY
	CASE
		WHEN APPROVAL_STATUS = 'Rejected' THEN 1
		WHEN APPROVAL_STATUS = 'Needs Review' THEN 2
		WHEN APPROVAL_STATUS = 'Approved' THEN 3
	END;

-- real world classification scenario (grading system)
-- create table
CREATE TABLE STUDENTS (
	ID INT PRIMARY KEY,
	NAME VARCHAR(30) NOT NULL,
	MARKS INT NOT NULL CHECK (
		MARKS <> 0
		AND MARKS <= 100
	)
);

-- inserting sample records
INSERT INTO
	STUDENTS (ID, NAME, MARKS)
VALUES
	(1, 'Aarav', 95),
	(2, 'Meera', 82),
	(3, 'Rohit', 68),
	(4, 'Sneha', 54),
	(5, 'Kunal', 40),
	(6, 'Priya', 25);

-- adding grade column
ALTER TABLE STUDENTS
ADD COLUMN GRADE VARCHAR(2);

-- update grade column to reflect student grade based on marks using case statement
UPDATE STUDENTS
SET
	GRADE = CASE
		WHEN MARKS >= 90 THEN 'A+'
		WHEN MARKS >= 80 THEN 'A'
		WHEN MARKS >= 70 THEN 'B'
		WHEN MARKS >= 60 THEN 'C'
		WHEN MARKS >= 50 THEN 'D'
		ELSE 'F'
	END;

-- select query to display student records with grade
SELECT
	*
FROM
	STUDENTS;

-- PL/pgSQL BLOCK to implement IF-ELSE logic
DO $$
DECLARE
    i INT := 7;
BEGIN
    IF i = 0 THEN
        RAISE NOTICE 'NO VIOLATION';
    ELSIF i <= 3 THEN
        RAISE NOTICE 'MINOR VIOLATION';
    ELSIF i <= 7 THEN
        RAISE NOTICE 'MODERATE VIOLATION';
    ELSE
        RAISE NOTICE 'CRITICAL VIOLATION';
    END IF;
END $$;