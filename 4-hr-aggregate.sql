-- Welche Nachnamen kommen bei den Angestellten mehr als einmal vor?
SELECT LAST_NAME, COUNT(LAST_NAME) AS LAST_NAME_COUNT
FROM HR.EMPLOYEES
GROUP BY LAST_NAME
HAVING COUNT(LAST_NAME) > 1;

-- Ermitteln Sie die Anzahl der Angestellten, deren Nachname weniger als
-- fünf Zeichen lang ist. Tun Sie dies auf zwei Wegen:
-- 1. Mit einer WHERE-Klausel
SELECT COUNT(LAST_NAME) AS LAST_NAME_COUNT
FROM HR.EMPLOYEES
WHERE LENGTH(LAST_NAME) < 5;

-- 2. Ohne WHERE-Klausel
SELECT SUM(LAST_NAME_COUNT)
FROM (SELECT COUNT(LAST_NAME) AS LAST_NAME_COUNT
      FROM HR.EMPLOYEES
      GROUP BY LAST_NAME
      HAVING LENGTH(LAST_NAME) < 5) as ELNC;

-- Was ist die größte erlaubte Gehaltsspanne unter den Jobs, die mit "_REP"
-- in der ID enden? Zeigen Sie diese Spanne an!
SELECT MAX(MAX_SALARY - MIN_SALARY) AS MAX_SALARY_RANGE
FROM HR.JOBS
WHERE JOB_ID LIKE '%_REP';

-- Fertigen Sie eine Auswertung Ihrer Standort an:
-- 1. Ermitteln Sie je Land und Bundesstaat/Bundesland die Anzahl der Standorte.
SELECT COUNTRY_ID, STATE_PROVINCE, COUNT(LOCATION_ID) AS LOCATION_COUNT
FROM HR.LOCATIONS
GROUP BY COUNTRY_ID, STATE_PROVINCE;

-- 2. NULL-Felder ersetzen Sie bitte mit "N/A".
SELECT COUNTRY_ID, COALESCE(STATE_PROVINCE, 'N/A') AS STATE, COUNT(LOCATION_ID) AS LOCATION_COUNT
FROM HR.LOCATIONS
GROUP BY COUNTRY_ID, STATE_PROVINCE;

-- 3. Sortieren Sie das Ergebnis absteigend nach Anzahl der Standorte
-- und dann aufsteigend nach Land und Bundesstaat/Bundesland.
SELECT COUNTRY_ID, COALESCE(STATE_PROVINCE, 'N/A') AS STATE, COUNT(LOCATION_ID) AS LOCATION_COUNT
FROM HR.LOCATIONS
GROUP BY COUNTRY_ID, STATE_PROVINCE
ORDER BY LOCATION_COUNT DESC, COUNTRY_ID, STATE;
