-- Ermitteln Sie Namen und Telefonnummer der Angestellten,
-- die mehr als 1500 verdienen oder mehr als 35% Provision
-- erhalten. Sortieren Sie diese absteigend nach der
-- Betriebszugehörigkeit.
SELECT FIRST_NAME || ' ' || EMPLOYEES.LAST_NAME, PHONE_NUMBER
FROM HR.EMPLOYEES
WHERE SALARY > 1500
   OR EMPLOYEES.COMMISSION_PCT > 0.35
ORDER BY HIRE_DATE DESC;

-- Welche Department-IDs sind unter den Angestellten
-- mit Gehältern kleiner 5000 vertreten?
SELECT DISTINCT DEPARTMENT_ID
FROM HR.EMPLOYEES
WHERE SALARY < 5000;

-- Welche JOB_IDs gehören zu Manager-Jobs? Sortieren Sie
-- aufsteigend nach Maximalgehalt.
SELECT JOB_ID
FROM HR.JOBS
WHERE JOB_TITLE LIKE '%Man%'
ORDER BY MAX_SALARY;

-- Zeige die Angestellten 'Gietz', 'Hartstein', 'Atkinson' und 'Sewall'
-- aufsteigend nach Gehalt inkl. Bonus. Vorsicht Falle :)
SELECT FIRST_NAME || ' ' || LAST_NAME, SALARY * COALESCE(EMPLOYEES.COMMISSION_PCT + 1, 1) AS "Gehalt inkl. Bonus"
FROM HR.EMPLOYEES
WHERE LAST_NAME IN ('Gietz', 'Hartstein', 'Atkinson', 'Sewall')
ORDER BY "Gehalt inkl. Bonus";

-- Welche Angestellten haben den Vorgesetzten mit der ID 101 oder 103?
-- Selektieren Sie EMPLOYEE_ID und den Namen. Sortieren Sie nach
-- EMPLOYEE_ID und lassen Sie sich nur die ersten 10 Datensätze anzeigen.
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME
FROM HR.EMPLOYEES
WHERE MANAGER_ID IN (101, 103)
ORDER BY EMPLOYEE_ID
    FETCH FIRST 10 ROWS ONLY;
