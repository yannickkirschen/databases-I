-- Selektieren Sie alle Mitarbeiter, die keine Führungskräfte sind (deren
-- EMPLOYEE_ID also nicht die MANAGER_ID eines anderen Mitarbeiters ist).
SELECT E.EMPLOYEE_ID
FROM HR.EMPLOYEES E
WHERE E.EMPLOYEE_ID NOT IN (SELECT DISTINCT MANAGER_ID FROM HR.EMPLOYEES WHERE MANAGER_ID IS NOT NULL);

-- Welche Angestellten (Vorname+Nachname) sind Vorgesetzte? Vermeiden Sie Joins.
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME
FROM HR.EMPLOYEES E
WHERE E.EMPLOYEE_ID IN (SELECT DISTINCT MANAGER_ID FROM HR.EMPLOYEES WHERE MANAGER_ID IS NOT NULL);

-- Jedes Department (Name) hat ein maximales Einkommen. Ermitteln Sie eine
-- solche Liste und erweitern Sie diese Abfrage, um nur noch den Durchschnitt der
-- Maximaleinkommen aller Departments anzuzeigen.
SELECT AVG(MAX_SALARY)
FROM (SELECT MAX(SALARY) MAX_SALARY
      FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID
 ) as MAX_SALARY;

-- Welche "Shipping Clerk"s haben ein Einkommen, das höher ist als jedes der
-- Einkommen von "Purching Clerk"s? Lösen Sie die Aufgabe auf zwei Weisen, je
-- mit einer single-row subquery und einer multi-row subquery.
-- 1. Single row
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME
FROM HR.EMPLOYEES E
WHERE E.JOB_ID = 'SH_CLERK'
  AND E.SALARY > (SELECT MAX(SALARY) FROM HR.EMPLOYEES WHERE JOB_ID = 'PU_CLERK');

-- 2. Multirow
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME
FROM HR.EMPLOYEES E
WHERE E.JOB_ID = 'SH_CLERK'
  AND E.SALARY > ALL (SELECT SALARY FROM HR.EMPLOYEES WHERE JOB_ID = 'PU_CLERK');

-- Welche "Sales Representative"s haben ein Einkommen, das höher ist als jedes
-- der Einkommen von allen erst später angestellten "Accountant"s? Lösen Sie
-- dies mit einer korrelierten Unterabfrage beliebiger Art.
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME
FROM HR.EMPLOYEES E
WHERE E.JOB_ID = 'SA_REP'
  AND E.SALARY > ALL (SELECT SALARY FROM HR.EMPLOYEES WHERE JOB_ID = 'AC_ACCOUNT' AND HIRE_DATE > E.HIRE_DATE);

-- Welche Mitarbeiter (ID) nahmen sowohl an der Schulung "How to Find Happiness in Life" als
-- als auch an der Schulung "MS Excel Basics" teil?
SELECT E.EMPLOYEE_ID
FROM HR.EMPLOYEES E
WHERE E.EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM HR.COURSES WHERE COURSE_NAME = 'How to Find Happiness in Life')
  AND E.EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM HR.COURSES WHERE COURSE_NAME = 'MS Excel Basics');
