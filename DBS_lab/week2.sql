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
		 
-- Adding all the tables

SQL> SELECT table_name FROM user_tables;

TABLE_NAME
--------------------------------------------------------------------------------
CLASSROOM
DEPARTMENT
COURSE
INSTRUCTOR
SECTION
TEACHES
STUDENT
TAKES
ADVISOR
TIME_SLOT
PREREQ

11 rows selected.

--9. List all Students with names and their department names. 
SQL> SELECT NAME,DEPT_NAME FROM STUDENT;

NAME                 DEPT_NAME
-------------------- --------------------
Zhang                Comp. Sci.
Shankar              Comp. Sci.
Brandt               History
Chavez               Finance
Peltier              Physics
Levy                 Physics
Williams             Comp. Sci.
Sanchez              Music
Snow                 Physics
Brown                Comp. Sci.
Aoi                  Elec. Eng.

NAME                 DEPT_NAME
-------------------- --------------------
Bourikas             Elec. Eng.
Tanaka               Biology

13 rows selected.

--10. List all instructors in CSE department.

SQL> SELECT * FROM Instructor WHERE DEPT_NAME = 'Comp. Sci.';

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
10101 Srinivasan           Comp. Sci.                65000
45565 Katz                 Comp. Sci.                75000
83821 Brandt               Comp. Sci.                92000

--11. Find the names of courses in CSE department which have 3 credits.

SQL> SELECT TITLE FROM COURSE WHERE DEPT_NAME =  'Comp. Sci.' AND CREDITS=3;

TITLE
--------------------------------------------------
Robotics
Image Processing
Database System Concepts

--12. For the student with ID 12345 (or any other value), show all course-id and title of all courses registered for by the student.

SQL> SELECT DISTINCT C.COURSE_ID, C.TITLE
  2  FROM COURSE C
  3  JOIN TAKES T
  4  ON C.COURSE_ID = T.COURSE_ID
  5  WHERE T.ID = 45678;

COURSE_I TITLE
-------- --------------------------------------------------
CS-101   Intro. to Computer Science
CS-319   Image Processing

--13. List all the instructors whose salary is in between 40000 and 90000. Retrieving records from multiple tables:

SQL> SELECT * FROM INSTRUCTOR WHERE SALARY BETWEEN 40000 AND 90000;

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
10101 Srinivasan           Comp. Sci.                65000
12121 Wu                   Finance                   90000
15151 Mozart               Music                     40000
32343 El Said              History                   60000
33456 Gold                 Physics                   87000
45565 Katz                 Comp. Sci.                75000
58583 Califieri            History                   62000
76543 Singh                Finance                   80000
76766 Crick                Biology                   72000
98345 Kim                  Elec. Eng.                80000

--14. Display the IDs of all instructors who have never taught a course.

SQL> SELECT ID FROM INSTRUCTOR WHERE ID NOT IN (SELECT ID FROM TEACHES);

ID
-----
33456
58583
76543

--15. Find the student names, course names, and the year, for all students those who have attended classes in room-number 303

SQL> SELECT s.name, c.title, course_id, semester
  2  FROM Student s
  3  JOIN Takes t USING (ID)
  4  JOIN Section sec USING (course_id, sec_id, semester, year)
  5  JOIN Course c USING (course_id)
  6  WHERE room_number = '101';

NAME                 TITLE                                              COURSE_I
-------------------- -------------------------------------------------- --------
SEMEST
------
Zhang                Intro. to Computer Science                         CS-101
Fall

Shankar              Intro. to Computer Science                         CS-101
Fall

Chavez               Investment Banking                                 FIN-201
Spring


NAME                 TITLE                                              COURSE_I
-------------------- -------------------------------------------------- --------
SEMEST
------
Levy                 Intro. to Computer Science                         CS-101
Fall

Levy                 Intro. to Computer Science                         CS-101
Spring

Williams             Intro. to Computer Science                         CS-101
Fall


NAME                 TITLE                                              COURSE_I
-------------------- -------------------------------------------------- --------
SEMEST
------
Sanchez              Music Video Production                             MU-199
Spring

Brown                Intro. to Computer Science                         CS-101
Fall

Bourikas             Intro. to Computer Science                         CS-101
Fall

--16. For all students who have opted courses in 2015, find their names and course id’s with the attribute course title replaced by c-name.


SQL> SELECT s.name AS student_name,
  2         t.course_id,
  3         c.title AS c_name
  4  FROM Student s,   -- Removed 'AS'
  5       Takes t,     -- Removed 'AS'
  6       Course c     -- Removed 'AS'
  7  WHERE s.ID = t.ID
  8    AND t.course_id = c.course_id
  9    AND t.year = 2009;

STUDENT_NAME         COURSE_I C_NAME
-------------------- -------- --------------------------------------------------
Zhang                CS-101   Intro. to Computer Science
Zhang                CS-347   Database System Concepts
Shankar              CS-101   Intro. to Computer Science
Shankar              CS-190   Game Design
Shankar              CS-347   Database System Concepts
Peltier              PHY-101  Physical Principles
Levy                 CS-101   Intro. to Computer Science
Williams             CS-101   Intro. to Computer Science
Williams             CS-190   Game Design
Brown                CS-101   Intro. to Computer Science
Aoi                  EE-181   Intro. to Digital Systems

STUDENT_NAME         COURSE_I C_NAME
-------------------- -------- --------------------------------------------------
Bourikas             CS-101   Intro. to Computer Science
Tanaka               BIO-101  Intro. to Biology

13 rows selected.

--17) . Find the names of all instructors whose salary is greater than the salary of at least one instructor of CSE department and salary replaced by inst-salary.

SQL> SELECT i.name,
  2  i.salary inst_salary
  3  FROM Instructor i
  4  WHERE i.salary > ANY (
  5  SELECT c.salary
  6  FROM Instructor c
  7  WHERE c.dept_name = 'Comp. Sci.'
  8  );

NAME                 INST_SALARY
-------------------- -----------
Wu                         90000
Einstein                   95000
Gold                       87000
Katz                       75000
Singh                      80000
Crick                      72000
Brandt                     92000
Kim                        80000

8 rows selected.

--18) Find the names of all instructors whose department name includes the substring‘ch’.

SQL> SELECT name
  2  FROM Instructor
  3  WHERE dept_name LIKE '%ch%';

no rows selected

SQL> SELECT name, dept_name
  2  FROM Instructor
  3  WHERE UPPER(dept_name) LIKE '%H%';

NAME                 DEPT_NAME
-------------------- --------------------
Einstein             Physics
El Said              History
Gold                 Physics
Califieri            History

--19. List the student names along with the length of the student names. 

SQL> SELECT name, LENGTH(name) AS name_length
  2  FROM student;

NAME                 NAME_LENGTH
-------------------- -----------
Zhang                          5
Shankar                        7
Brandt                         6
Chavez                         6
Peltier                        7
Levy                           4
Williams                       8
Sanchez                        7
Snow                           4
Brown                          5
Aoi                            3

NAME                 NAME_LENGTH
-------------------- -----------
Bourikas                       8
Tanaka                         6

13 rows selected

--20. List the department names and 3 characters from 3rd position of each department name 

SQL> SELECT dept_name,
  2         SUBSTR(dept_name, 3, 3) AS sub_name
  3  FROM department;

DEPT_NAME            SUB_NAME
-------------------- ------------
Biology              olo
Comp. Sci.           mp.
Elec. Eng.           ec.
Finance              nan
History              sto
Music                sic
Physics              ysi

7 rows selected.

--21. List the instructor names in upper case. 

SQL> SELECT UPPER(name) AS instructor_name FROM INSTRUCTOR
  2  ;

INSTRUCTOR_NAME
--------------------
SRINIVASAN
WU
MOZART
EINSTEIN
EL SAID
GOLD
KATZ
CALIFIERI
SINGH
CRICK
BRANDT

INSTRUCTOR_NAME
--------------------
KIM

12 rows selected.

--22. Replace NULL with value1(say 0) for a column in any of the table    

SQL> SELECT ID, NAME, COALESCE(salary, 9) AS salary FROM INSTRUCTOR;

ID    NAME                     SALARY
----- -------------------- ----------
10101 Srinivasan                65000
12121 Wu                        90000
15151 Mozart                    40000
22222 Einstein                  95000
32343 El Said                   60000
33456 Gold                      87000
45565 Katz                      75000
58583 Califieri                 62000
76543 Singh                     80000
76766 Crick                     72000
83821 Brandt                    92000

ID    NAME                     SALARY
----- -------------------- ----------
98345 Kim                       80000

12 rows selected.

--23. Display the salary and salary/3 rounded to nearest hundred from Instructor. 

SQL> SELECT salary,
  2         ROUND(salary / 3, -2) AS rounded_salary
  3  FROM instructor;

    SALARY ROUNDED_SALARY
---------- --------------
     65000          21700
     90000          30000
     40000          13300
     95000          31700
     60000          20000
     87000          29000
     75000          25000
     62000          20700
     80000          26700
     72000          24000
     92000          30700

    SALARY ROUNDED_SALARY
---------- --------------
     80000          26700

12 rows selected.

--24. Display the birth date of all the employees in the following format: 
-- ‘DD-MON-YYYY’ 
-- ‘DD-MON-YY’ 
-- ‘DD-MM-YY’ 

SQL> SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY') AS format_1,
  2         TO_CHAR(SYSDATE, 'DD-MON-YY')   AS format_2,
  3         TO_CHAR(SYSDATE, 'DD-MM-YY')    AS format_3
  4  FROM DUAL;

FORMAT_1             FORMAT_2           FORMAT_3
-------------------- ------------------ --------
21-JAN-2026          21-JAN-26          21-01-26

--25. List the employee names and the year (fully spelled out) in which they are born 
-- ‘YEAR’ 
-- ‘Year’ 
-- ‘year'

SQL> SELECT TO_CHAR(SYSDATE, 'YEAR') AS all_caps,
  2         TO_CHAR(SYSDATE, 'Year') AS title_case,
  3         TO_CHAR(SYSDATE, 'year') AS all_lower
  4  FROM DUAL;

ALL_CAPS
------------------------------------------
TITLE_CASE
------------------------------------------
ALL_LOWER
------------------------------------------
TWENTY TWENTY-SIX
Twenty Twenty-Six
twenty twenty-six
