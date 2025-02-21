--1
SELECT first_name, last_name, salary
FROM employees
WHERE last_name LIKE '%a%'
AND commission_pct IS NULL
AND salary BETWEEN 10000 AND 20000
ORDER BY salary;
--2
SELECT MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary, SUM(salary) AS total_salary_mass, AVG(salary) AS average_salary
FROM employees;
--3
SELECT CONCAT(SUBSTR(first_name, 1, 1), last_name) AS full_name, salary, department_id
FROM employees
WHERE department_id = 20;
--4
SELECT last_name, ROUND(salary * 1.05333, 2) AS incremented_salary
FROM employees
WHERE department_id = 80;
--5
SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 6), 'Day, DD Month YYYY') AS Future
FROM dual;
--6
SELECT last_name, TO_CHAR(hire_date, 'DD/MM/YY') AS hire_date_formatted
FROM employees;
--7
SELECT last_name, TO_CHAR(hire_date, 'Day, DD "de" Month "de" YYYY') AS formatted_date
FROM employees;
--8
SELECT last_name, hire_date, TO_CHAR(hire_date, 'MM-DD') AS anniversary
FROM employees
ORDER BY TO_CHAR(hire_date, 'ddd');
--9
SELECT last_name, NVL(salary + commission_pct, salary) AS Retribució
FROM employees;
--10
SELECT last_name,
CASE
WHEN MONTHS_BETWEEN(SYSDATE, hire_date) / 12 BETWEEN 5 AND 9 THEN 'CINC ANYS DE SERVEI'
WHEN MONTHS_BETWEEN(SYSDATE, hire_date) / 12 BETWEEN 10 AND 14 THEN 'DEU ANYS DE SERVEI'
WHEN MONTHS_BETWEEN(SYSDATE, hire_date) / 12 BETWEEN 15 AND 19 THEN 'QUINZE ANYS DE SERVEI'
WHEN MONTHS_BETWEEN(SYSDATE, hire_date) / 12 BETWEEN 20 AND 24 THEN 'VINT ANYS DE SERVEI'
WHEN MONTHS_BETWEEN(SYSDATE, hire_date) / 12 >= 25 THEN 'VINT-I-CINC ANYS DE SERVEI'
ELSE 'EMPLEAT AMB MENYS DE CINC ANYS DE SERVEI'
END AS years_of_service
FROM employees;

-- 11 Using USING
SELECT city, department_name, location_id, department_id
FROM departments
JOIN locations USING(location_id)
WHERE department_id IN (10, 20, 30) AND UPPER(city) = 'SEATTLE';

-- 12 Using ON
SELECT city, department_name, location_id, department_id
FROM departments d
JOIN locations l ON d.location_id = l.location_id
WHERE department_id IN (10, 20, 30) AND city = 'Seattle';

-- 13 Classic join
SELECT city, department_name, location_id, department_id
FROM departments, locations
WHERE departments.location_id = locations.location_id
AND department_id IN (10, 20, 30) AND city = 'Seattle';

-- 14 Using JOIN
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- 15 Classic join
SELECT e.first_name, e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

SELECT e1.last_name AS employee, e2.last_name AS manager
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.employee_id;

SELECT COUNT(*) AS num_employees, COUNT(DISTINCT manager_id) AS num_managers
FROM employees;

