-- LAB 2 queries

--1.Create Employee table with following constraints: 
--  Make EmpNo as Primary key. 
--  Do not allow EmpName, Gender, Salary and Address to have null values. 
--  Allow Gender to have one of the two values: ‘M’, ‘F’. 

CREATE TABLE Employee (EmpNo number(4) PRIMARY KEY, EmpName varchar(20) NOT NULL, Gender char(1) NOT NULL CHECK(Gender IN('M','F')), Salary number(8) NOT NULL, Address varchar(20) NOT NULL, Dno number(3);
--TABLE CREATED

--2.Create Department table with following: 
--  Make DeptNo as Primary key 
--  Make DeptName as candidate key 

CREATE TABLE Department (DeptNo number(3) PRIMARY KEY, DeptName varchar(20) UNIQUE, Location varchar(20));
--TABLE CREATED

--3. Make DNo of Employee as foreign key which refers to DeptNo of Department. 

ALTER TABLE Employee ADD CONSTRAINT FK_DeptNO FOREIGN KEY (Dno) REFERENCES Department (DeptNo);
-- Table altered.

--4. Insert few tuples into Employee and Department which satisfies the above constraints.

SQL> INSERT INTO Department VALUES (10, 'IT', 'BANGALORE');
--1 row created.
SQL> INSERT INTO Department VALUES (20, 'PRODUCTION', 'BANGALORE');
--1 row created.
SQL> INSERT INTO Department VALUES (50, 'HR', 'BANGALORE');
--1 row created.

SQL> INSERT INTO Employee VALUES (1,'Emp1', 'M', 1234567, 'MANIPAL', '10');
--1 row created.
SQL> INSERT INTO Employee VALUES (2,'Emp2', 'M', 1300000, 'MANIPAL', '10');
--1 row created.
SQL> INSERT INTO Employee VALUES (3,'Emp3', 'F', 1500000, 'MANGALORE', '20');
--1 row created.
SQL> INSERT INTO Employee VALUES (4,'Emp4', 'F', 1000000, 'CHENNAI', '50');
--1 row created.

--5. Try to insert few tuples into Employee and Department which violates some of the above constraints. 

SQL> INSERT INTO Department VALUES (30, 'IT', 'BANGALORE');
--INSERT INTO Department VALUES (30, 'IT', 'BANGALORE')
--*
--ERROR at line 1:
--ORA-00001: unique constraint (CCEB19.SYS_C0011453) violated
SQL> INSERT INTO Department VALUES (10, 'MARKETING', 'BANGALORE');
--INSERT INTO Department VALUES (10, 'MARKETING', 'BANGALORE')
--*
--ERROR at line 1:
--ORA-00001: unique constraint (CCEB19.SYS_C0011452) violated
SQL> INSERT INTO Employee VALUES (4,'Emp6', 'F', 1000000, 'CHENNAI', '10');
--INSERT INTO Employee VALUES (4,'Emp6', 'F', 1000000, 'CHENNAI', '10')
--*
--ERROR at line 1:
--ORA-00001: unique constraint (CCEB19.SYS_C0011426) violated
SQL> INSERT INTO Employee VALUES (6,NULL, 'M', 2000000, 'CHENNAI', '10');
--INSERT INTO Employee VALUES (6,NULL, 'M', 2000000, 'CHENNAI', '10')                               *
--ERROR at line 1:
--ORA-01400: cannot insert NULL into ("CCEB19"."EMPLOYEE"."EMPNAME")
SQL> INSERT INTO Employee VALUES (6, 'Emp6', 'X', 2000000, 'CHENNAI', '50');
--INSERT INTO Employee VALUES (6, 'Emp6', 'X', 2000000, 'CHENNAI', '50')
--*
--ERROR at line 1:
--ORA-02290: check constraint (CCEB19.SYS_C0011425) violated
SQL> INSERT INTO Employee VALUES (6, 'Emp6', 'M', 2000000, 'CHENNAI', '60');
--INSERT INTO Employee VALUES (6, 'Emp6', 'M', 2000000, 'CHENNAI', '60')
--*
--ERROR at line 1:
--ORA-02291: integrity constraint (CCEB19.FK_DEPTNO) violated - parent key not found

--6. Try to modify/delete a tuple which violates a constraint.
SQL> DELETE FROM Department WHERE DeptNo=50;
--DELETE FROM Department WHERE DeptNo=50
--*
--ERROR at line 1:
--ORA-02292: integrity constraint (CCEB19.FK_DEPTNO) violated - child record found

--7. Modify the foreign key constraint of Employee table such that whenever a department tuple is deleted, the employees belonging to that department will also be deleted. 

SQL> ALTER TABLE Employee DROP CONSTRAINT FK_DeptNo;
--Table altered.
SQL> ALTER TABLE Employee ADD CONSTRAINT FK_DeptNo FOREIGN KEY (Dno) REFERENCES Department (DeptNo) ON DELETE CASCADE;
--Table altered.

--8. Create a named constraint to set the default salary to 10000 and test the constraint by inserting a new record.
SQL> ALTER TABLE Employee MODIFY Salary DEFAULT 100000;
--Table altered.
SQL> INSERT INTO EmplOyee (EmpNo, EmpName, Gender, Address, DNo) VALUES (5, 'Emp50', 'M', 'MUMBAI' ,10);
--1 row created.

SQL> INSERT INTO EmplOyee (EmpNo, EmpName, Gender, Address, DNo) VALUES (5, 'Emp5', 'M', 'MUMBAI' ,10);
--1 row created.
SQL> SELECT * FROM Employee;
     EMPNO EMPNAME              G     SALARY ADDRESS                     DNO
---------- -------------------- - ---------- -------------------- ----------
         1 Emp1                 M    1234567 MANIPAL                      10
         2 Emp2                 M    1300000 MANIPAL                      10
         3 Emp3                 F    1500000 MANGALORE                    20
         4 Emp4                 F    1000000 CHENNAI                      50
         5 Emp5                 M     100000 MUMBAI                       10
