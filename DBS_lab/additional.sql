--1
ALTER TABLE Employee
ADD CONSTRAINT chk_salary
CHECK (Salary > 5000);

--2
SELECT TO_CHAR(DATE '2024-08-15', 'Q') AS quarter
FROM dual;

--3
SELECT
    FLOOR(sec/3600) AS hours,
    FLOOR(MOD(sec,3600)/60) AS minutes,
    MOD(sec,60) AS seconds
FROM (SELECT 3661 sec FROM dual);

--4
SELECT TO_CHAR(DATE '2024-08-15', 'WW') AS week_of_year
FROM dual;

--5
SELECT DISTINCT dept_name
FROM instructor;

--6 
SELECT DISTINCT i.name, t.course_id
FROM instructor i
JOIN teaches t ON i.ID = t.ID;

--7
SELECT i.name, t.course_id
FROM instructor i
LEFT JOIN teaches t ON i.ID = t.ID;

--8
SELECT
    s.name AS student_name,
    s.dept_name,
    i.name AS advisor_name,
    COUNT(t.course_id) AS course_count
FROM student s
LEFT JOIN advisor a ON s.ID = a.s_ID
LEFT JOIN instructor i ON a.i_ID = i.ID
LEFT JOIN takes t ON s.ID = t.ID
GROUP BY s.name, s.dept_name, i.name;
