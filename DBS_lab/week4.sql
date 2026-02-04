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

SQL> SELECT course_id, sec_id, COUNT(*) AS enrolment FROM takes WHERE semester = 'Spring' AND year = 2009 GROUP BY course_id, sec_id;
+-----------+--------+-----------+
| course_id | sec_id | enrolment |
+-----------+--------+-----------+
| CS-190    | 2      |         2 |
| EE-181    | 1      |         1 |
+-----------+--------+-----------+
2 rows in set (0.00 sec)
 
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
SQL> select d as dept_name,s as average from (select dept_name as d, avg(salary) as s from instructor group by dept_name) as smtg where s>42000;

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

 SQL> SELECT course_id, sec_id
    -> FROM (
    ->     SELECT course_id, sec_id, COUNT(*) AS enrolment
    ->     FROM takes
    ->     WHERE semester = 'Spring' AND year = 2010
    ->     GROUP BY course_id, sec_id
    -> ) AS section_enrolment
    -> WHERE enrolment = (
    ->     SELECT MAX(enrolment)
    ->     FROM (
    ->         SELECT COUNT(*) AS enrolment
    ->         FROM takes
    ->         WHERE semester = 'Spring' AND year = 2010
    ->         GROUP BY course_id, sec_id
    ->     ) AS max_enrol
    -> );
+-----------+--------+
| course_id | sec_id |
+-----------+--------+
| CS-315    | 1      |
+-----------+--------+
1 row in set (0.00 sec)

-- 11. Find the names of all instructors who teach all students that belong to ‘CSE’ department.

SQL> SELECT i.name
    -> FROM instructor i
    -> WHERE NOT EXISTS (
    ->     SELECT s.ID
    ->     FROM student s
    ->     WHERE s.dept_name = 'Comp. Sci.'
    ->       AND NOT EXISTS (
    ->           SELECT *
    ->           FROM teaches t
    ->           JOIN takes tk
    ->             ON t.course_id = tk.course_id
    ->            AND t.sec_id = tk.sec_id
    ->            AND t.semester = tk.semester
    ->            AND t.year = tk.year
    ->           WHERE t.ID = i.ID
    ->             AND tk.ID = s.ID
    ->       )
    -> );
+------------+
| name       |
+------------+
| Srinivasan |
+------------+
1 row in set (0.00 sec)

 
-- 12.Find the average salary of those department where the average salary is greater than 50000 and total number of instructors in the department are more than 5.

SQL> SELECT dept_name, AVG(salary) AS avg_salary FROM instructor GROUP BY dept_name HAVING AVG(salary)>50000 AND COUNT(*) > 5;
Empty set (0.00 sec)

SQL> SELECT dept_name, AVG(salary) AS avg_salary FROM instructor GROUP BY dept_name HAVING AVG(salary)>50000 AND COUNT(*) > 1;
+------------+--------------+
| dept_name  | avg_salary   |
+------------+--------------+
| Comp. Sci. | 77333.333333 |
| Finance    | 85000.000000 |
| History    | 61000.000000 |
| Physics    | 91000.000000 |
+------------+--------------+
4 rows in set (0.00 sec)

-- 13. Find all departments with the maximum budget.

 SQL> WITH max_budget AS (
    ->     SELECT MAX(budget) AS max_bud
    ->     FROM department
    -> )
    -> SELECT dept_name, budget
    -> FROM department
    -> WHERE budget = (SELECT max_bud FROM max_budget);
+-----------+-----------+
| dept_name | budget    |
+-----------+-----------+
| Finance   | 120000.00 |
+-----------+-----------+
1 row in set (0.00 sec)

-- 14. Find all departments where the total salary is greater than the average of the total salary at all departments

SQL> SELECT dept_name, SUM(salary) AS total_salary
    -> FROM instructor
    -> GROUP BY dept_name
    -> HAVING SUM(salary) > (
    ->     SELECT AVG(total_salary)
    ->     FROM (
    ->         SELECT SUM(salary) AS total_salary
    ->         FROM instructor
    ->         GROUP BY dept_name
    ->     ) AS dept_totals
    -> );
+------------+--------------+
| dept_name  | total_salary |
+------------+--------------+
| Comp. Sci. |    232000.00 |
| Finance    |    170000.00 |
| Physics    |    182000.00 |
+------------+--------------+
3 rows in set (0.00 sec)

SQL> WITH dept_total AS (
    ->     SELECT dept_name, SUM(salary) AS total_salary
    ->     FROM instructor
    ->     GROUP BY dept_name
    -> ),
    -> avg_total AS (
    ->     SELECT AVG(total_salary) AS avg_salary
    ->     FROM dept_total
    -> )
    -> SELECT dept_name, total_salary
    -> FROM dept_total
    -> WHERE total_salary > (SELECT avg_salary FROM avg_total);
+------------+--------------+
| dept_name  | total_salary |
+------------+--------------+
| Comp. Sci. |    232000.00 |
| Finance    |    170000.00 |
| Physics    |    182000.00 |
+------------+--------------+
3 rows in set (0.00 sec)

-- 15. Transfer all the students from CSE department to IT department.

SAVEPOINT sp_transfer;

UPDATE student
SET dept_name = 'IT'
WHERE dept_name = 'Comp. Sci.';

ROLLBACK TO sp_transfer;

-- 16. Increase salaries of instructors whose salary is over $100,000 by 3%, and all others receive a 5% raise

SAVEPOINT sp_salary;

UPDATE instructor
SET salary = salary * 1.03
WHERE salary > 100000;

UPDATE instructor
SET salary = salary * 1.05
WHERE salary <= 100000;

ROLLBACK TO sp_salary;

-- ADDITIONAL EXERCISE:
-- 1. Display lowest paid instructor details under each department.

SQL> select * from instructor i where (i.dept_name,i.salary) in (select dept_name,min(salary) from instructor group by dept_name);
+-------+------------+------------+----------+
| ID    | name       | dept_name  | salary   |
+-------+------------+------------+----------+
| 10101 | Srinivasan | Comp. Sci. | 65000.00 |
| 15151 | Mozart     | Music      | 40000.00 |
| 32343 | El Said    | History    | 60000.00 |
| 33456 | Gold       | Physics    | 87000.00 |
| 76543 | Singh      | Finance    | 80000.00 |
| 76766 | Crick      | Biology    | 72000.00 |
| 98345 | Kim        | Elec. Eng. | 80000.00 |
+-------+------------+------------+----------+
7 rows in set (0.00 sec)

-- 2. Find the sum of the salaries of all instructors of the ‘CSE’ department, as well as maximum salary, the minimum salary, and the average salary in this department.

SQL> SELECT
    ->     SUM(salary) AS total_salary,
    ->     MAX(salary) AS max_salary,
    ->     MIN(salary) AS min_salary,
    ->     AVG(salary) AS avg_salary
    -> FROM instructor
    -> WHERE dept_name = 'Comp. Sci.';
+--------------+------------+------------+--------------+
| total_salary | max_salary | min_salary | avg_salary   |
+--------------+------------+------------+--------------+
|    232000.00 |   92000.00 |   65000.00 | 77333.333333 |
+--------------+------------+------------+--------------+
1 row in set (0.00 sec)


-- 3.Retrieve the name of each student who registered for all the subjects offered by ‘CSE’ department

SQL> SELECT s.name
    -> FROM student s
    -> WHERE NOT EXISTS (
    ->     SELECT c.course_id
    ->     FROM course c
    ->     WHERE c.dept_name = 'Comp. Sci.'
    ->       AND NOT EXISTS (
    ->           SELECT *
    ->           FROM takes t
    ->           WHERE t.ID = s.ID
    ->             AND t.course_id = c.course_id
    ->       )
    -> );
Empty set (0.00 sec)


SQL> SELECT dept_name
    -> FROM (
    ->     SELECT c.dept_name, c.course_id, COUNT(t.ID) AS student_count
    ->     FROM course c
    ->     JOIN takes t ON c.course_id = t.course_id
    ->     GROUP BY c.dept_name, c.course_id
    -> ) AS dept_course_counts
    -> GROUP BY dept_name
    -> HAVING AVG(student_count) > 10;
Empty set (0.01 sec)

