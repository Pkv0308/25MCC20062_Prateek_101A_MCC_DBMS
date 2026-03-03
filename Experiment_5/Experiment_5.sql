set search_path to 'Experiment_5';

-- -- Table Creation
-- CREATE TABLE Employee (
--     emp_id int PRIMARY KEY,
--     emp_name VARCHAR(100),
--     experience_years INT,
--     performance_rating NUMERIC(3,2), 
--     salary NUMERIC(10,2)
-- );

-- Data Insertion
-- INSERT INTO Employee (emp_id, emp_name, experience_years, performance_rating, salary) VALUES
-- (1,'Anay', 2, 4.5, 20000),   
-- (2, 'Bhavna', 10, 3.0, 50000),
-- (3, 'Chaitanya', 5, 4.0, 35000),
-- (4, 'Deepak', 0, 3.5, 25000),   
-- (5, 'Esha', 8, 4.8, 60000);    

-- select * from employee;


-- simple forward only cursor to display data
-- DO $$ 
-- DECLARE 
--     emp_cursor CURSOR FOR SELECT emp_id, emp_name, salary FROM Employee;
--     emp_record RECORD;
-- BEGIN 
--     FOR emp_record IN emp_cursor LOOP
--         RAISE NOTICE 'Employee ID: %, Name: %, Salary: %', 
--                      emp_record.emp_id, 
--                      emp_record.emp_name, 
--                      emp_record.salary;
--     END LOOP;
    
-- END $$;



-- explicit cursor to perform row by row manipulation
-- DO $$ 
-- DECLARE 
--     emp_cursor CURSOR FOR SELECT emp_id, emp_name, experience_years, performance_rating, salary FROM Employee;
--     emp_record RECORD;
--     v_ratio NUMERIC;
--     v_bonus_multiplier NUMERIC;
-- BEGIN 
--     FOR emp_record IN emp_cursor LOOP
        
--         v_ratio := emp_record.performance_rating / (emp_record.experience_years + 1);

--         IF v_ratio >= 1.5 THEN
--             v_bonus_multiplier := 1.20; 
--         ELSIF v_ratio >= 0.8 THEN
--             v_bonus_multiplier := 1.10; 
--         ELSE
--             v_bonus_multiplier := 1.05; 
--         END IF;

-- 		UPDATE Employee 
--         SET salary = salary * v_bonus_multiplier
--         WHERE emp_id = emp_record.emp_id;

--         RAISE NOTICE 'Employee: % salary incremented by multiplier of %', 
--                      emp_record.emp_name,  v_bonus_multiplier;
                     
--     END LOOP; 
-- END $$;


-- -- This will trigger the "Invalid experience" check (experience < 0)
-- INSERT INTO Employee (emp_id, emp_name, experience_years, performance_rating, salary) 
-- VALUES (6, 'Failing_Fred', -5, 4.0, 30000);

-- -- This will trigger a "Division by Zero" or "Null Value" error if not handled
-- INSERT INTO Employee (emp_id, emp_name, experience_years, performance_rating, salary) 
-- VALUES (7, 'Null_Nancy', 3, NULL, 40000);


--exception and status handling in cursors
-- DO $$ 
-- DECLARE 
--     emp_cursor CURSOR FOR SELECT * FROM Employee;
--     emp_record RECORD;
--     v_ratio NUMERIC;
-- BEGIN 
--     OPEN emp_cursor;
    
--     LOOP
--         FETCH emp_cursor INTO emp_record;
--         EXIT WHEN NOT FOUND; 

--         BEGIN
--             IF emp_record.experience_years < 0 THEN
--                 RAISE EXCEPTION 'Invalid experience for employee %', emp_record.emp_name;
--             END IF;

--             v_ratio := emp_record.performance_rating / (emp_record.experience_years + 1);
            
--             UPDATE Employee 
--             SET salary = salary * (1 + (v_ratio / 10)) -- Dynamic 10% scaled raise
--             WHERE emp_id = emp_record.emp_id;

--             RAISE NOTICE 'Success: Updated %', emp_record.emp_name;

--         EXCEPTION 
--             WHEN OTHERS THEN
--                 RAISE WARNING 'Skipping Employee % due to error: %', emp_record.emp_name, SQLERRM;
--         END;

--     END LOOP;

--     CLOSE emp_cursor;

-- EXCEPTION 
--     WHEN OTHERS THEN 
--         RAISE EXCEPTION 'Critical Failure in Cursor Processing: %', SQLERRM;
-- END $$;



truncate employee;