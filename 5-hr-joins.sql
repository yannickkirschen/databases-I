-- Erstellen Sie eine Übersicht aller Departments mit Department_name,
-- Manager_name (in einem Feld, falls NULL soll "N/A" angezeigt werden)
-- und Postleitzahl. Departments mit fehlender PLZ sollen nicht angezeigt werden.
SELECT D.DEPARTMENT_NAME,
       COALESCE(E.FIRST_NAME || ' ' || E.LAST_NAME, 'N/A') AS MANAGER_NAME,
       L.POSTAL_CODE
FROM HR.DEPARTMENTS D
         LEFT OUTER JOIN HR.EMPLOYEES E
                         ON (D.MANAGER_ID = E.EMPLOYEE_ID)
         LEFT OUTER JOIN HR.LOCATIONS L
                         ON (D.LOCATION_ID = L.LOCATION_ID)
WHERE L.POSTAL_CODE IS NOT NULL;

-- Ermittelen Sie die Employee-Ids der "Programmer", die mindestens 200
-- mehr verdienen als "Kevin Mourgos" und geben Sie die Differenz an.
SELECT E.EMPLOYEE_ID
FROM HR.EMPLOYEES E
WHERE E.JOB_ID = 'IT_PROG'
  AND E.SALARY - (SELECT E2.SALARY
                  FROM HR.EMPLOYEES E2
                  WHERE E2.FIRST_NAME = 'Kevin'
                    AND E2.LAST_NAME = 'Mourgos') > 200;

-- Erweitern Sie die erste Aufgabe um die Summe der Kosten der im
-- jeweiligen Department angestellten Mitarbeiter. Vernachlässigen
-- Sie dabei bitte das Gehalt vom Manager selbst. Falls keine Kosten
-- anfallen. soll 0 angezeigt werden.
SELECT D.DEPARTMENT_NAME,
       COALESCE(E.FIRST_NAME || ' ' || E.LAST_NAME, 'N/A') AS MANAGER_NAME,
       L.POSTAL_CODE,
       COALESCE(SUM(E.SALARY), 0)                          AS COSTS
FROM HR.DEPARTMENTS D
         LEFT OUTER JOIN HR.EMPLOYEES E
                         ON (D.MANAGER_ID = E.EMPLOYEE_ID)
         LEFT OUTER JOIN HR.LOCATIONS L
                         ON (D.LOCATION_ID = L.LOCATION_ID)
WHERE L.POSTAL_CODE IS NOT NULL
GROUP BY D.DEPARTMENT_NAME, E.FIRST_NAME, E.LAST_NAME, L.POSTAL_CODE;

-- Zeigen Sie die Jobs an, die von mindestens zwei Personen ausgeübt werden
-- und bei denen das Durchschnittseinkommen höher als der Durchschnitt von
-- MIN_SALARY und MAX_SALARY ist.
SELECT J.JOB_TITLE, AVG(E.SALARY)
FROM HR.JOBS J
         INNER JOIN HR.EMPLOYEES E ON (J.JOB_ID = E.JOB_ID)
GROUP BY J.JOB_TITLE
HAVING COUNT(J.JOB_TITLE) > 1;
