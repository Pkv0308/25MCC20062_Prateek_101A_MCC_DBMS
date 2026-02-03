-- simple for loop 
DO $$
BEGIN
  FOR i IN 1..5 LOOP
    RAISE NOTICE 'Number: %', i;
  END LOOP;
END $$;

-- for loop with query processing
DO $$
DECLARE
	rec RECORD;
BEGIN
	FOR rec in SELECT id, marks FROM "Experiment_3".students LOOP
		RAISE NOTICE 'ID: %, Marks: %',rec.id, rec.marks;
	END LOOP;
END $$;

-- while loop
DO $$
DECLARE
	i int:=1;
BEGIN
	WHILE i<=5 LOOP
		RAISE NOTICE 'WHILE LOOP turn %',i;
		i:=i+1;
	END LOOP;
END $$

-- simple loop with exit when condition
DO $$
DECLARE
	i int :=1;
BEGIN
	LOOP
		RAISE NOTICE 'i=%',i;
		i:=i+1;
		EXIT WHEN i>5;
	END LOOP;
END $$;

-- set search_path to 'Experiment_4';
-- create table salaries(id int primary key, salary decimal(10,2));
-- insert into salaries values(1,35000),(2,55000),(3,45000);
-- select * from salaries;

--Salary increment using for loop
DO $$
DECLARE
	rec RECORD;
BEGIN
  FOR rec IN (SELECT id, salary from salaries) 
  LOOP
    UPDATE salaries
    SET salary = rec.salary * 1.10
    WHERE id = rec.id;
  END LOOP;
END $$;

-- combining LOOP with if condition
DO $$
DECLARE
	rec RECORD;
BEGIN
	For rec in (select id, marks from "Experiment_3".students)
	LOOP
		IF rec.marks>50 THEN
			RAISE NOTICE 'ID: %, Marks: %',rec.id,rec.marks;
		END IF;
	END LOOP;
END $$;