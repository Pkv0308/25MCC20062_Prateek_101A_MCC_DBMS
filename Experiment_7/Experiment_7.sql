set search_path to 'Experiment_7';

CREATE TABLE Departments (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50)
);

CREATE TABLE Students (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Departments(Dept_ID)
);

CREATE TABLE Courses (
    Course_ID VARCHAR(10) PRIMARY KEY,
    Course_Name VARCHAR(100)
);

CREATE TABLE Enrollments (
    Student_ID INT,
    Course_ID VARCHAR(10),
    PRIMARY KEY (Student_ID, Course_ID),
    FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
);

INSERT INTO Departments (Dept_ID, Dept_Name) VALUES (10, 'Computer Science'),
(20, 'Electrical Engineering'),
(30, 'Mechanical Engineering'),
(40, 'Civil Engineering');

INSERT INTO Students (Student_ID, Name, Dept_ID) VALUES (101, 'Aarav Sharma', 10),
(102, 'Vihaan Iyer', 10),
(103, 'Aditi Rao', 20),
(104, 'Ananya Singh', 20),
(105, 'Ishaan Gupta', 30),
(106, 'Kavya Nair', 30),
(107, 'Rahul Verma', 40),
(108, 'Sanya Malhotra', 40),
(109, 'Arjun Reddy', NULL),
(110, 'Siddharth Jain', NULL);

INSERT INTO Courses (Course_ID, Course_Name) VALUES ('CS101', 'Artificial Intelligence'),
('EE201', 'Power Systems'),
('ME301', 'Thermodynamics'),
('CE401', 'Structural Analysis'),
('GE101', 'Environmental Studies'),
('MA501', 'Advanced Calculus'); 

INSERT INTO Enrollments (Student_ID, Course_ID) VALUES 
 (101, 'CS101'),
 (102, 'CS101'), 
 (103, 'EE201'),
 (104, 'EE201'),
 (105, 'ME301'),
 (106, 'ME301'),
 (107, 'CE401'),
 (108, 'CE401'),
 (101, 'GE101'),
 (103, 'GE101'),
 (105, 'GE101'),
 (107, 'GE101');


 SELECT 
    S.Name AS Student_Name, 
    C.Course_Name
FROM Students S
INNER JOIN Enrollments E ON S.Student_ID = E.Student_ID
INNER JOIN Courses C ON E.Course_ID = C.Course_ID
ORDER BY S.Name;

SELECT S.Name AS Unenrolled_Student
FROM Students S
LEFT JOIN Enrollments E ON S.Student_ID = E.Student_ID
WHERE E.Course_ID IS NULL;

SELECT 
    C.Course_Name, 
    S.Name AS Student_Name
FROM Enrollments E
JOIN Students S ON E.Student_ID = S.Student_ID
RIGHT JOIN Courses C ON E.Course_ID = C.Course_ID;

SELECT 
    S.Name AS Student, 
    D.Dept_Name, 
    C.Course_Name
FROM Students S
INNER JOIN Departments D ON S.Dept_ID = D.Dept_ID
INNER JOIN Enrollments E ON S.Student_ID = E.Student_ID
INNER JOIN Courses C ON E.Course_ID = C.Course_ID;

SELECT 
    S.Name AS Student, 
    C.Course_Name AS Potential_Course
FROM Students S
CROSS JOIN Courses C;

select * from Students;
select * from Departments;
select * from Enrollments;
select * from Courses;