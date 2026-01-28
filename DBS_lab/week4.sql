-- Week 4 complex queris

-- 1. Find the number of students in each course

SQL> select count(id),course_id as total_count from takes group by course_id;

 COUNT(ID) TOTAL_CO
---------- --------
         1 FIN-201
         2 CS-190
         1 MU-199
         7 CS-101
         1 HIS-351
         2 CS-319
         2 CS-347
         1 PHY-101
         1 EE-181
         2 CS-315
         1 BIO-101
         1 BIO-301

12 rows selected.

--2. Find those departments where the average number of students are greater than 10.

SQL> SELECT dept_name FROM Student GROUP BY dept_name HAVING COUNT(ID) > 10;

no rows selected

SQL> SELECT dept_name FROM Student GROUP BY dept_name HAVING COUNT(ID) > 2;

DEPT_NAME
--------------------
Comp. Sci.
Physics

--3. Find the total number of courses in each department.

SQL> select dept_name, count(course_id) as number_of_courses from course group by dept_name;

DEPT_NAME            NUMBER_OF_COURSES
-------------------- -----------------
Comp. Sci.                           5
Biology                              3
History                              1
Elec. Eng.                           1
Finance                              1
Music                                1
Physics                              1

7 rows selected.

--4. Find the names and average salaries of all departments whose average salary is greater than 42000

SQL> select dept_name, avg(salary) from instructor group by dept_name having avg(salary)>42000;

DEPT_NAME            AVG(SALARY)
-------------------- -----------
Comp. Sci.            77333.3333
Biology                    72000
History                    61000
Finance                    85000
Elec. Eng.                 80000
Physics                    91000

6 rows selected.

--5. Find the enrolment of each section that was offered in Spring 2009.
--6. List all the courses with prerequisite courses, then display course id in increasing order.

SQL> SELECT course_id, prereq_id FROM Prereq ORDER BY course_id ASC;

COURSE_I PREREQ_I
-------- --------
BIO-301  BIO-101
BIO-399  BIO-101
CS-190   CS-101
CS-315   CS-101
CS-319   CS-101
CS-347   CS-101
EE-181   PHY-101

7 rows selected

--7. Display the details of instructors sorting the salary in decreasing order.

SQL> select * from instructor order by salary desc;

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
22222 Einstein             Physics                   95000
83821 Brandt               Comp. Sci.                92000
12121 Wu                   Finance                   90000
33456 Gold                 Physics                   87000
98345 Kim                  Elec. Eng.                80000
76543 Singh                Finance                   80000
45565 Katz                 Comp. Sci.                75000
76766 Crick                Biology                   72000
10101 Srinivasan           Comp. Sci.                65000
58583 Califieri            History                   62000
32343 El Said              History                   60000

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
15151 Mozart               Music                     40000

12 rows selected.

--8. Find the maximum total salary across the departments.

SQL> select max(s) as max_sum from (select sum(salary) as s from instructor group by dept_name);

   MAX_SUM
----------
    232000

--9. Find the average instructors’ salaries of those departments where the average salary is greater than 42000.

SQL> select dept_name, avg(salary) from instructor group by dept_name having avg(salary) > 42000;

DEPT_NAME            AVG(SALARY)
-------------------- -----------
Comp. Sci.            77333.3333
Biology                    72000
History                    61000
Finance                    85000
Elec. Eng.                 80000
Physics                    91000

6 rows selected.

--10.  Find the sections that had the maximum enrolment in Spring 2010

