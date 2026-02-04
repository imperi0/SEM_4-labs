--WEEK 3

--1. Find courses that ran in Fall 2009 or in Spring 2010
SQL> SELECT COURSE_ID FROM SECTION WHERE SEMESTER = 'Fall' AND YEAR = 2009 UNION ALL SELECT COURSE_ID FROM SECTION WHERE SEMESTER = 'Spring' AND YEAR = 2010;

COURSE_I
--------
CS-101
CS-347
PHY-101
CS-101
CS-315
CS-319
CS-319
FIN-201
HIS-351
MU-199

10 rows selected.

--2. Find courses that ran in Fall 2009 and in spring 2010 .

SQL> SELECT course_id FROM section WHERE semester = 'Fall' AND year = 2009
  2  INTERSECT
  3  SELECT course_id FROM section WHERE semester = 'Spring' AND year = 2010;

COURSE_I
--------
CS-101

--3. Find courses that ran in Fall 2009 but not in Spring 2010

SQL> SELECT course_id FROM section WHERE semester = 'Fall' AND year = 2009
  2  MINUS
  3  SELECT course_id FROM section WHERE semester = 'Spring' AND year = 2010;

COURSE_I
--------
CS-347
PHY-101

--4. Find the name of the course for which none of the students registered.

SQL> SELECT course_id FROM COURSE WHERE COURSE_ID NOT IN(SELECT DISTINCT COURSE_ID FROM TAKES);

COURSE_I
--------
BIO-399

--5. Find courses offered in Fall 2009 and in Spring 2010.

SQL> SELECT DISTINCT COURSE_ID FROM SECTION WHERE SEMESTER = 'Fall' AND YEAR=2009 AND COURSE_ID IN(SELECT COURSE_ID FROM SECTION WHERE SEMESTER = 'Spring' AND YEAR=2010);

COURSE_I
--------
CS-101

--6. Find the total number of students who have taken course taught by the instructor with ID 10101.

SQL> SELECT COUNT(DISTINCT t.ID)
  2  FROM takes t
  3  WHERE (t.course_id, t.sec_id, t.semester, t.year) IN (
  4  SELECT te.course_id, te.sec_id, te.semester, te.year
  5  FROM teaches te
  6  WHERE te.ID = 10101
  7  );

COUNT(DISTINCTT.ID)
-------------------
                  6

--7. Find courses offered in Fall 2009 but not in Spring 2010.

SQL> SELECT DISTINCT COURSE_ID FROM SECTION WHERE SEMESTER='Fall' AND YEAR=2009 AND COURSE_ID NOT IN(SELECT COURSE_ID FROM SECTION WHERE SEMESTER='Spring' AND YEAR=2010);


COURSE_I
--------
CS-347
PHY-101

--8. Find the names of all students whose name is same as the instructor’s name.

SQL> SELECT NAME FROM STUDENT WHERE NAME IN(SELECT NAME FROM INSTRUCTOR);

NAME
--------------------
Brandt

--9.Find names of instructors with salary greater than that of some (at least one) instructor in the Biology department

SQL> SELECT NAME FROM INSTRUCTOR WHERE SALARY > SOME ( SELECT SALARY FROM INSTRUCTOR WHERE DEPT_NAME='Biology');

NAME
--------------------
Wu
Einstein
Gold
Katz
Singh
Brandt
Kim

7 rows selected.

--10. Find the names of all instructors whose salary is greater than the salary of all instructors in the Biology department.

SQL> SELECT NAME FROM INSTRUCTOR WHERE SALARY > ALL ( SELECT SALARY FROM INSTRUCTOR WHERE DEPT_NAME='Biology');

NAME
--------------------
Katz
Singh
Kim
Gold
Wu
Brandt
Einstein

7 rows selected.

--11. Find the departments that have the highest average salary.

SQL> select d.dept_name from department d join instructor i using (dept_name) group by dept_name having
 avg(i.salary) >= all (select avg(salary) from instructor join department using (dept_name) group by dept_name);
+-----------+
| dept_name |
+-----------+
| Physics   |
+-----------+
1 row in set (0.00 sec)

--12. Find the names of those departments whose budget is lesser than the average salary of all instructors.

SQL> SELECT dept_name
  2  FROM department
  3  WHERE budget < (
  4  SELECT AVG(salary)
  5  FROM instructor
  6  );

DEPT_NAME
--------------------
History
Physics

--13. Find all courses taught in both the Fall 2009 semester and in the Spring 2010 semester

SQL> SELECT DISTINCT c.course_id
  2  FROM course c
  3  WHERE EXISTS (
  4  SELECT *
  5  FROM section s
  6  WHERE s.course_id = c.course_id
  7  AND s.semester = 'Fall'
  8  AND s.year = 2009
  9  )
 10  AND EXISTS (
 11  SELECT *
 12  FROM section s
 13  WHERE s.course_id = c.course_id
 14  AND s.semester = 'Spring'
 15  AND s.year = 2010
 16  );

COURSE_I
--------
CS-101

-- 14. Find all courses that were offered at most once in 2009.
SQL> SELECT course_id
  2  FROM section
  3  WHERE year = 2009
  4  GROUP BY course_id
  5  HAVING COUNT(*) <= 1;

SQL> select s.course_id from section s where s.year = 2009 and (select count(*) from section c where c.course_id=s.course_id and c.year=2009) <=1;

COURSE_I
--------
BIO-101
CS-101
CS-347
EE-181
PHY-101

--15. Find all the students who have opted at least two courses offered by CSE department.

SELECT s.name
FROM student s
WHERE (
    SELECT COUNT(*)
    FROM takes t
    JOIN course c ON t.course_id = c.course_id
    WHERE t.id = s.id
    AND c.dept_name = 'Comp. Sci.'
) >= 2;

+----------+
| name     |
+----------+
| Zhang    |
| Shankar  |
| Levy     |
| Williams |
| Brown    |
| Bourikas |
+----------+
6 rows in set (0.00 sec)

-- 16.Find all the students who have opted at least two courses offered by CSE department.

SQL> SELECT s.id, s.name
    -> FROM student s
    -> JOIN takes t ON s.id = t.id
    -> JOIN course c ON t.course_id = c.course_id
    -> WHERE c.dept_name = 'Comp. Sci.'
    -> GROUP BY s.id, s.name
    -> HAVING COUNT(DISTINCT t.course_id) >= 2;
+-------+----------+
| id    | name     |
+-------+----------+
| 00128 | Zhang    |
| 12345 | Shankar  |
| 45678 | Levy     |
| 54321 | Williams |
| 76543 | Brown    |
| 98765 | Bourikas |
+-------+----------+
6 rows in set (0.00 sec)

--17. Find the average instructors salary of those departments where the average salary is greater than 42000 

SELECT dept_name, AVG(salary) AS avg_salary
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) > 42000;

--18. Create a view all_courses consisting of course sections offered by Physics department in the Fall 2009, with the building and room number of each section.

CREATE VIEW all_courses AS
SELECT 
    s.course_id,
    s.sec_id,
    s.semester,
    s.year,
    s.building,
    s.room_number
FROM section s
JOIN course c ON s.course_id = c.course_id
WHERE c.dept_name = 'Physics'
  AND s.semester = 'Fall'
  AND s.year = 2009;

-- 19. Select all the courses from all_courses view.
  
SQL> select * from all_courses;
+-----------+--------+----------+------+----------+-------------+
| course_id | sec_id | semester | year | building | room_number |
+-----------+--------+----------+------+----------+-------------+
| PHY-101   | 1      | Fall     | 2009 | Watson   | 100         |
+-----------+--------+----------+------+----------+-------------+
1 row in set (0.00 sec)

-- 20. Create a view department_total_salary consisting of department name and total salary of that department.

SQL> CREATE VIEW department_total_salary AS
    -> SELECT dept_name, SUM(salary) AS total_salary
    -> FROM instructor
    -> GROUP BY dept_name;
Query OK, 0 rows affected (0.01 sec)

SQL> SELECT * FROM department_total_salary;
+------------+--------------+
| dept_name  | total_salary |
+------------+--------------+
| Biology    |     72000.00 |
| Comp. Sci. |    232000.00 |
| Elec. Eng. |     80000.00 |
| Finance    |    170000.00 |
| History    |    122000.00 |
| Music      |     40000.00 |
| Physics    |    182000.00 |
+------------+--------------+
7 rows in set (0.00 sec)
