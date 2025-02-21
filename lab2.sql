--1
SELECT last_name, 
       TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS anys,
       TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) % 12 AS mesos
FROM employees
ORDER BY anys DESC, mesos DESC;

--2
SELECT * FROM employees WHERE last_name LIKE 'J%' 
   OR cognom LIKE 'K%' 
   OR cognom LIKE 'L%' 
   OR cognom LIKE 'M%';

SELECT * FROM employees WHERE LEFT(last_name, 1) IN ('J', 'K', 'L', 'M');

--3
SELECT last_name, 
       NVL2(comission_pct, 'Yes', 'No') AS rep_comissio
FROM employees;

--4
SELECT * FROM employees WHERE UPPER(last_name) LIKE '%N';

SELECT * FROM employees WHERE UPPER(RIGHT(last_name, 1)) = 'N';

--5
SELECT * FROM employees WHERE DAY(hire_date) <= 15;

--6
SELECT last_name, salary, ROUND(salary / 1000) AS 'Millions d'euros' FROM employees;

--7
SELECT last_name, 
       TO_CHAR(hire_date, 'DD "de" month') AS aniversari
FROM employees
ORDER BY TO_CHAR(hire_date, 'MM-DD');

--8

SELECT DAYNAME(hire_date) AS dia_setmana, COUNT(*) AS num_contractacions
FROM employees 
GROUP BY dia_setmana
HAVING num_contractacions >= 3;

--9

select job_id, TO_CHAR(end_date, 'YYYY') as Year, COUNT(*)
from job_history
group by job_id, TO_CHAR(end_date, 'YYYY')
order by Year;

--10 

SELECT departament_id, job_id, SUM(comission_pct) AS total_comissio
FROM employees
WHERE comission_pct IS NOT NULL
GROUP BY department, job_id;

--11

CREATE TABLE departments (
    codi CHAR(3) PRIMARY KEY, 
    nom VARCHAR(40) NOT NULL
);

CREATE TABLE professors (
    codi INT PRIMARY KEY,
    cognom1 VARCHAR(25) NOT NULL,
    cognom2 VARCHAR(25) NOT NULL,
    nom VARCHAR(20) NOT NULL,
    actiu CHAR(1) NOT NULL,
    categoria VARCHAR(40) NOT NULL,
    dedicacio CHAR(3) NOT NULL,
    departament CHAR(3) NOT NULL,
    director INT,
    FOREIGN KEY (departament) REFERENCES departaments(codi),
    FOREIGN KEY (director) REFERENCES professors(codi)
);

--13

DROP TABLE IF EXISTS docencies;
DROP TABLE IF EXISTS assignatures;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS professors;
DROP TABLE IF EXISTS departaments;
--15
INSERT INTO departaments VALUES 
('001', 'Informàtica'), 
('002', 'Telemàtica'), 
('003', 'Electrònica');

INSERT INTO professors VALUES 
(1, 'Jiménez', 'Clos', 'Josep', 'S', 'Titular', 'TC', '001', 3), 
(2, 'Martí', 'Margall', 'Maria', 'S', 'Titular', 'TC', '001', 3), 
(3, 'Montserrat', 'Adell', 'Marta', 'S', 'Director', 'TC', '002', NULL);

INSERT INTO assignatures VALUES 
('ES', 'Estadística', 6, '1B', 3, 1, 30), 
('BD', 'Bases de dades', 6, '2A', 4, 0, 28), 
('SO', 'Sistemes Operatius', 9, '3A', 5, 1, 46);

INSERT INTO classes VALUES 
('1', '3.1', 60, 'Planta3'), 
('2', '2.3', 30, 'Planta2'), 
('3', '2.6', 30, 'Planta2');

INSERT INTO docencies VALUES 
(1, 2, '2', 'ES', '23_24'), 
(2, 2, '2', 'BD', '23_24'), 
(3, 1, '1', 'SO', '23_24');
--16
UPDATE assignatures 
SET hores_teoria = 3, hores_practica = 1 
WHERE sigles = 'BD';

--17
DELETE FROM classes WHERE codi = '3';

--18
COMMIT;

