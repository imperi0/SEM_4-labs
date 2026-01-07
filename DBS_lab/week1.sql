--Week 1 PROGRAMS

--1. Create a table employee with ( emp_no, emp_name, emp_address) 
CREATE TABLE EMPLOYEE ( emp_no number(10), emp_name varchar(16), emp_address varchar(20));

--2. Insert five employees information.
INSERT INTO EMPLOYEE VALUES( 1, 'Emp1', 'MANIPAL' );
INSERT INTO EMPLOYEE VALUES( 2, 'Emp2', 'MANGALORE' );
INSERT INTO EMPLOYEE VALUES( 3, 'Emp3', 'MANIPAL' );
INSERT INTO EMPLOYEE VALUES( 4, 'Emp4', 'MANGALORE' );
INSERT INTO EMPLOYEE VALUES( 5, 'Emp5', 'BANGALORE' );

--3. Display names of all employees.
SELECT emp_name FROM EMPLOYEE;

--4. Display all the employees from ‘MANIPAL’.
SELECT * FROM EMPLOYEE WHERE emp_address='MANIPAL';

--5. Add a column named salary to employee table. 
ALTER TABLE EMPLOYEE ADD (salary NUMBER(10));

--6. Assign the salary for all employees. 
UPDATE EMPLOYEE SET salary=1200000 WHERE emp_no=1;
UPDATE EMPLOYEE SET salary=1400000 WHERE emp_no=2;
UPDATE EMPLOYEE SET salary=1500000 WHERE emp_no=3;
UPDATE EMPLOYEE SET salary=1600000 WHERE emp_no=4;
UPDATE EMPLOYEE SET salary=1800000 WHERE emp_no=5;

--7. View the structure of the table employee using describe.
DESC EMPLOYEE;

--8. Delete all the employees from ‘MANGALORE’.
DELETE FROM EMPLOYEE WHERE emp_address='MANGALORE';

--9. Rename employee as employee1. 
RENAME EMPLOYEE TO EMPLOYEE1;

--10. Drop the table employee1.
DROP TABLE employee1;
