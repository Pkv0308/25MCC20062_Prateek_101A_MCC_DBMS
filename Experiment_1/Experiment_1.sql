

--create table queries

CREATE TABLE DEPARTMENT (
	DEPT_ID INT PRIMARY KEY,
	DEPT_NAME VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE PROJECT (
	PROJ_ID INT PRIMARY KEY,
	PROJ_NAME VARCHAR(50) NOT NULL,
	DEPT_ID int not null,
	foreign key (dept_Id) references department(Dept_id)
);

CREATE TABLE EMPLOYEE (
	EMP_ID VARCHAR(10) PRIMARY KEY,	
	EMP_NAME VARCHAR(30) NOT NULL,
	DEPT_ID INT NOT NULL,
	PROJ_ID INT NOT NULL,
	FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT (DEPT_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (PROJ_ID) REFERENCES PROJECT (PROJ_ID) ON DELETE CASCADE ON UPDATE CASCADE
);


-- insert queries

INSERT INTO
	DEPARTMENT
VALUES
	(1, 'Sales'),
	(2, 'Marketing'),
	(3, 'Legal'),
	(4, 'IT'),
	(5, 'Accounts'),
	(6, 'HR');

INSERT INTO
	PROJECT
VALUES
	(1000, 'Lead Gen Campaign', 1),
	(1001, 'CRM CleanUP', 1),
	(2000, 'Content Campaign', 2),
	(2001, 'Influencer Marketing', 2),
	(3000, 'Contract Audits', 3),
	(3001, 'Litigation Tools', 3),
	(4000, 'Cloud Migration', 4),
	(4001, 'Cybersecurity Setup', 4),
	(5000, 'Financial Audits', 5),
	(5001, 'Forcasting Models', 5),
	(6000, 'Wellness Programs', 6),
	(6001, 'Onboarding Surveys', 6);

INSERT INTO
	EMPLOYEE (EMP_ID, EMP_NAME, DEPT_ID, PROJ_ID)
VALUES
	('E100', 'Vikram Singh', 1, 1000),
	('E101', 'Ritu Das', 5, 5000),
	('E102', 'Sonia Patel', 6, 6001),
	('E103', 'Kavita Sharma', 6, 6001),
	('E104', 'Arjun Gupta', 1, 1000),
	('E105', 'Sonia Gupta', 1, 1000),
	('E106', 'Arjun Singh', 3, 3001),
	('E107', 'Neha Gupta', 6, 6001),
	('E108', 'Vikram Patel', 1, 1000),
	('E109', 'Kavita Gupta', 4, 4000),
	('E110', 'Arjun Das', 2, 2000),
	('E111', 'Amit Yadav', 1, 1001),
	('E112', 'Raj Mehta', 3, 3000),
	('E113', 'Amit Sharma', 6, 6000),
	('E114', 'Vikram Sharma', 5, 5000),
	('E115', 'Vikram Kumar', 1, 1000),
	('E116', 'Deepak Yadav', 6, 6000),
	('E117', 'Kavita Das', 2, 2000),
	('E118', 'Sonia Das', 1, 1001),
	('E119', 'Deepak Kumar', 3, 3000);


-- DML UPDATE and DELETE
UPDATE EMPLOYEE
SET
	PROJ_ID = 6000
WHERE
	PROJ_ID = 6001;

DELETE FROM PROJECT
WHERE
	DEPT_ID = 3;


-- Access Control and Security
-- creating a user

create user reporter with password 'reporter@123';

-- granting select privileges
grant select on employee, department, project to reporter;

-- explicitly revoking create privilige on the DB
revoke create on schema public from reporter;


--schema modification

--alter table
alter table employee add column base_sal int;

--alter table to remove foreign key constraint further to drop project table
alter table employee drop constraint employee_proj_id_fkey;

--drop table
drop table project;


select * from employee order by emp_id;