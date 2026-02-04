--1. Retrieve the birth date and address of the employee(s) whose name is ‘John B. Smith’. Retrieve the name and address of all employees who work for the  ‘Research’ department. 

SQL> SELECT TO_DATE(BDATE, 'DD-MON-YYYY') as BIRTH_Date, ADDRESS FROM EMPLOYEE1 WHERE (FNAME, LNAME) IN (('John', 'Smith'));

BIRTH_DAT ADDRESS
--------- ------------------------------
09-JAN-65 731 Fondren, Houston, TX

SQL> select * from employee1 e join department1 d on e.dno=d.dnumber where dname='Research';

FNAME      M LNAME      SSN       BDATE       ADDRESS                   S  SALARY SUPER_SSN DNO DNAME                DNUMBER MGR_SSN   MGR_START
---------- - ---------- --------- ----------- ------------------------- - ------- --------- --- --------------- ---------- --------- ---------
John       B Smith      123456789 09-JAN-65   731 Fondren, Houston, TX  M  $30000 333445555   5 Research           5 333445555 22-MAY-88
Franklin   T Wong       333445555 08-DEC-65   638 Voss, Houston, TX     M  $40000 888665555   5 Research           5 333445555 22-MAY-88
Ramesh     K Narayan    666884444 15-SEP-62   975 Fire Oak, Humble, TX  M  $38000 333445555   5 Research           5 333445555 22-MAY-88
Joyce      A English    453453453 31-JUL-72   5631 Rice, Houston, TX    F  $25000 333445555   5 Research           5 333445555 22-MAY-88

--2. For every project located in ‘Stanford’, list the project number, the controlling department number, and the department manager’s last name, address, and birth date.

SQL> select p.pnumber,d.dnumber,e.lname,e.address,e.bdate from project p join department1 d on p.dnum=d.dnumber join employee1 e on d.mgr_ssn=e.ssn where p.plocation='Stafford';

   PNUMBER    DNUMBER LNAME      ADDRESS                   BDATE
---------- ---------- ---------- ------------------------- -----------
        10          4 Wallace    291 Berry, Bellaire, TX   20-JUN-41
        30          4 Wallace    291 Berry, Bellaire, TX   20-JUN-41

6 rows selected.

--3. For each employee, retrieve the employee’s first and last name and the first and last name of his or her immediate supervisor.

SQL> select e.fname,e.lname,e2.fname as sfname,e2.lname as slname from employee1 e join employee1 e2 on e.super_ssn=e2.ssn;

FNAME      LNAME      SFNAME          SLNAME
---------- ---------- --------------- ---------------
Richard    Marini     Richard         Marini
John       Smith      Franklin        Wong
Ramesh     Narayan    Franklin        Wong
Joyce      English    Franklin        Wong
Alicia     Zelaya     Jennifer        Wallace
Ahmad      Jabbar     Jennifer        Wallace
Franklin   Wong       James           Borg
Jennifer   Wallace    James           Borg

--4. Make a list of all project numbers for projects that involve an employee whose last name is ‘Smith’, either as a worker or as a manager of the department that controls the project. 

SQL> SELECT DISTINCT p.PNUMBER FROM PROJECT p LEFT JOIN WORKS_ON w ON p.PNUMBER = w.PNO LEFT JOIN DEPARTMENT1 d ON p.DNUM = d.DNUMBER WHERE w.ESSN IN (SELECT SSN FROM EMPLOYEE1 WHERE LNAME = 'Smith') OR d.MGR_SSN IN (SELECT SSN FROM EMPLOYEE1 WHERE LNAME = 'Smith');

   PNUMBER
----------
         1
         2

--5. Show the resulting salaries if every employee working on the ‘ProductX’ project is given a 10 percent raise.

SQL> SELECT e.FNAME, e.LNAME, e.SALARY, e.SALARY * 1.10 AS RAISED_SALARY FROM EMPLOYEE1 e JOIN WORKS_ON w ON e.SSN = w.ESSN JOIN PROJECT p ON w.PNO = p.PNUMBER WHERE p.PNAME = 'ProductX';

FNAME      LNAME       SALARY RAISED_SALARY
---------- ---------- ------- -------------
John       Smith       $30000         33000
Joyce      English     $25000         27500

--6. Retrieve a list of employees and the projects they are working on, ordered by department and, within each department, ordered alphabetically by last name, then first name.

SQL> SELECT
  2      E.Dno,
  3      E.Lname,
  4      E.Fname,
  5      P.Pname
  6  FROM EMPLOYEE1 E
  7  JOIN WORKS_ON W
  8    ON E.Ssn = W.Essn
  9  JOIN PROJECT P
 10    ON W.Pno = P.Pnumber
 11  ORDER BY
 12      E.Dno,
 13      E.Lname,
 14      E.Fname;

DNO LNAME      FNAME      PNAME
--- ---------- ---------- ---------------
  4 Borg       James      Reorganization
  4 Jabbar     Ahmad      Newbenefits
  4 Jabbar     Ahmad      Computerization
  4 Wallace    Jennifer   Newbenefits
  4 Wallace    Jennifer   Reorganization
  4 Zelaya     Alicia     Newbenefits
  4 Zelaya     Alicia     Computerization
  5 English    Joyce      ProductX
  5 English    Joyce      ProductY
  5 Narayan    Ramesh     ProductZ
  5 Smith      John       ProductX
  5 Smith      John       ProductY
  5 Wong       Franklin   ProductY
  5 Wong       Franklin   Reorganization
  5 Wong       Franklin   ProductZ
  5 Wong       Franklin   Computerization

16 rows selected

--7. Retrieve the name of each employee who has a dependent with the same first name and is the same sex as the employee.

SQL> SELECT DISTINCT E.Fname, E.Lname
  2  FROM EMPLOYEE1 E
  3  JOIN DEPENDENT D
  4    ON E.Ssn = D.Essn
  5  WHERE E.Fname = D.Dependent_name
  6    AND E.Sex = D.Sex;

no rows selected

--8.Retrieve the names of employees who have no dependents. 

SQL> SELECT E.Fname, E.Lname
  2  FROM EMPLOYEE1 E
  3  WHERE NOT EXISTS (
  4      SELECT 1
  5      FROM DEPENDENT D
  6      WHERE D.Essn = E.Ssn
  7  );

FNAME      LNAME
---------- ----------
Richard    Marini
James      Borg
Alicia     Zelaya
Ahmad      Jabbar
Joyce      English
Ramesh     Narayan

6 rows selected.

--9. List the names of managers who have at least one dependent. 

SQL> SELECT DISTINCT E.Fname, E.Lname
  2  FROM EMPLOYEE1 E
  3  JOIN DEPARTMENT1 D
  4    ON E.Ssn = D.Mgr_ssn
  5  JOIN DEPENDENT DEP
  6    ON E.Ssn = DEP.Essn;

FNAME      LNAME
---------- ----------
Franklin   Wong
Jennifer   Wallace

--10. Find the sum of the salaries of all employees, the maximum salary, the minimum salary, and the average salary. 

SQL> SELECT
  2      SUM(Salary) AS Total_Salary,
  3      MAX(Salary) AS Max_Salary,
  4      MIN(Salary) AS Min_Salary,
  5      AVG(Salary) AS Avg_Salary
  6  FROM EMPLOYEE1;

TOTAL_SALARY MAX_SALARY MIN_SALARY AVG_SALARY
------------ ---------- ---------- ----------
      318000      55000      25000 35333.3333

--11. For each project, retrieve the project number, the project name, and the number of employees who work on that project. 

SQL> SELECT P.Pnumber, P.Pname, COUNT(W.Essn) AS Num_Employees
  2  FROM PROJECT P
  3  LEFT JOIN WORKS_ON W
  4    ON P.Pnumber = W.Pno
  5  GROUP BY P.Pnumber, P.Pname;

   PNUMBER PNAME           NUM_EMPLOYEES
---------- --------------- -------------
         2 ProductY                    3
        30 Newbenefits                 3
        20 Reorganization              3
         1 ProductX                    2
        10 Computerization             3
         3 ProductZ                    2

6 rows selected.

--12. For each project on which more than two employees work, retrieve the project number, the project name, and the number of employees who work on the project. 

SQL> SELECT P.Pnumber, P.Pname, COUNT(W.Essn) AS Num_Employees
  2  FROM PROJECT P
  3  JOIN WORKS_ON W
  4    ON P.Pnumber = W.Pno
  5  GROUP BY P.Pnumber, P.Pname
  6  HAVING COUNT(W.Essn) > 2;

   PNUMBER PNAME           NUM_EMPLOYEES
---------- --------------- -------------
         2 ProductY                    3
        30 Newbenefits                 3
        20 Reorganization              3
        10 Computerization             3

--13. For each department that has more than five employees, retrieve the department number and the number of its employees who are making more than 40,000.

SQL> SELECT E.Dno AS Department_Number,
  2         COUNT(*) AS Num_Employees_Over_40000
  3  FROM EMPLOYEE1 E
  4  WHERE E.Salary > 40000
  5    AND E.Dno IN (
  6        SELECT Dno
  7        FROM EMPLOYEE1
  8        GROUP BY Dno
  9        HAVING COUNT(*) > 5
 10    )
 11  GROUP BY E.Dno;

no rows selected