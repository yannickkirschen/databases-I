-- Nehmen Sie an, heute ist der 01.01.2009. Welche Departments (IDs)
-- beschäftigen Mitarbeiter, die in den letzten 2 Jahren dort
-- angefangen haben und aktuell weniger als 5000 verdienen?
SELECT DISTINCT D.DEPARTMENT_ID
FROM HR.EMPLOYEES E
         RIGHT JOIN HR.DEPARTMENTS D on D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE E.HIRE_DATE BETWEEN '2007-01-01' AND '2009-01-01'
  AND E.SALARY < 5000;

-- Zeigen Sie die JOB_ID und JOB_TITLE aller Manager-Jobs an und
-- erweitern Sie das Ergebnnis um einen "Holiday Manager" mit der ID "HY_MGR".
SELECT JOB_ID, JOB_TITLE
FROM HR.JOBS
WHERE JOB_TITLE LIKE '%Manager%'
UNION
VALUES ('HY_MGR', 'Holiday Manager');

-- Die Departments sollen über eine Schnittstelle an ein anderes System
-- übergeben werden, welches jedoch nur 12 Zeichen als DeptName unterstützt.
-- Zeigen SIe die DeptIDs sowie DeptNames an und in einer dritten Spalte
-- ja/nein, je nachdem ob es hier Schnittstellenprobleme gibt oder nicht.
SELECT DEPARTMENT_ID,
       DEPARTMENT_NAME,
       CASE
           WHEN LENGTH(DEPARTMENT_NAME) > 12 THEN 'ja'
           ELSE 'nein'
           END AS "Schnittstellenproblem"
FROM HR.DEPARTMENTS;

-- Zeigen Sie die Provision ("Commission") der Mitarbeiter an, die 2004
-- in das Unternehmen gekommen sind. Falls nicht angegeben, gilt 0%.
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       COALESCE(E.COMMISSION_PCT, 0) * 100 AS "Commission"
FROM HR.EMPLOYEES E
WHERE YEAR(HIRE_DATE) = 2004;
