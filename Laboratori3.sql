-- 1
SELECT *
FROM user_constraints
WHERE table_name='DEPARTAMENTS';

SELECT *
FROM user_cons_columns
WHERE table_name='DEPARTAMENTS';

ALTER TABLE DEPARTAMENTS
DROP PRIMARY KEY CASCADE;
ALTER TABLE DEPARTAMENTS ADD CONSTRAINT departaments_pk PRIMARY KEY (codi);
ALTER TABLE professors 
ADD CONSTRAINT FK_PROF_DEP 
FOREIGN KEY (departament_codi) REFERENCES departaments(codi);

ALTER TABLE DEPARTAMENTS RENAME CONSTRAINT DEP_ID_PK TO  departaments_pk;


-- 2
SELECT *
FROM user_constraints
WHERE table_name='PROFESSORS';
ALTER TABLE PROFESSORS
ADD CONSTRAINT CHK_TC CHECK (dedicacio = 'TC' OR dedicacio = '6h' OR dedicacio = '3h');

UPDATE PROFESSORS
SET dedicacio = '20m'
WHERE codi = 1;


-- 3
SELECT *
FROM user_constraints
WHERE table_name='CLASSES';


ALTER TABLE CLASSES
DROP CONSTRAINT NN_CLASSECODI;


INSERT INTO classes (nom, capacitat, situacio)
VALUES(3.1, 60, 'Planta3');


-- 4

SELECT *
FROM user_constraints
WHERE table_name='DEPARTAMENTS';

ALTER TABLE DEPARTAMENTS
DISABLE CONSTRAINT NN_DEP_name;

UPDATE DEPARTAMENTS SET nom=NULL WHERE codi=001;

ALTER TABLE DEPARTAMENTS
ENABLE NOVALIDATE CONSTRAINT NN_DEP_name;

ALTER TABLE DEPARTAMENTS
DROP CONSTRAINT NN_DEP_name;

-- mal no modificar
ALTER TABLE DEPARTAMENTS
MODIFY nom VARCHAR(40);

ALTER TABLE DEPARTAMENTS
MODIFY nom VARCHAR(40) NOT NULL;

UPDATE DEPARTAMENTS
SET nom = null
WHERE codi = 001;

-- 5
ALTER TABLE ASSIGNATURES
ADD CONSTRAINT CHK_hores CHECK ((NVL(HORES_TEORIA,0) + NVL(HORES_PRACTICA,0)) = TRUNC(CREDITS/1.5));

ALTER TABLE ASSIGNATURES
DROP CONSTRAINT CHK_hores;


--6
SELECT *
FROM user_constraints
WHERE table_name='ASSIGNATURES';

ALTER TABLE ASSIGNATURES
ADD CONSTRAINT CHK_MAX_CREDITS CHECK (CREDITS <= 9);



-- 7 no es pot fer neesitem triggers
ALTER TABLE DOCENCIES
ADD CONSTRAINT CHK_num_alumnes CHECK ((SELECT capacitat FROM Classes WHERE codi = docencies.classe) <= (SELECT num_alumnes FROM assignatures WHERE sigles = docencies.assignatura));


-- 8
SELECT a.constraint_name, a.delete_rule
FROM user_constraints a
WHERE a.table_name = 'PROFESSOR'
AND a.constraint_type = 'R';

-- 9
SELECT *
FROM user_constraints
WHERE table_name='PROFESSORS';

ALTER TABLE professors
DROP CONSTRAINT FK_DEP;

ALTER TABLE professors 
ADD CONSTRAINT FK_PROF_DEP 
FOREIGN KEY (departament_codi) REFERENCES departaments(codi) 
ON DELETE SET NULL;

DELETE FROM departaments WHERE codi = 001;
ROLLBACK;
-- 10
ALTER TABLE professors
DROP CONSTRAINT FK_PROF_DEP;

ALTER TABLE professors 
ADD CONSTRAINT FK_PROF_DEP 
FOREIGN KEY (departament_codi) REFERENCES departaments(codi) 
ON DELETE CASCADE;

DELETE FROM departaments WHERE codi = 002;
ROLLBACK;
-- 11
ALTER TABLE professors
DROP CONSTRAINT FK_PROF_DEP;

ALTER TABLE professors 
ADD CONSTRAINT FK_PROF_DEP 
FOREIGN KEY (departament_codi) REFERENCES departaments(codi);
-- 12
ALTER TABLE DEPARTAMENTS
DISABLE CONSTRAINT NN_DEP_name;

INSERT INTO DEPARTAMENTS (codi)
VALUES(004);
INSERT INTO DEPARTAMENTS (codi)
VALUES(005);
INSERT INTO DEPARTAMENTS (codi)
VALUES(006);

ALTER TABLE DEPARTAMENTS
ENABLE NOVALIDATE CONSTRAINT NN_DEP_name;

-- 13
ALTER TABLE PROFESSORS
DROP CONSTRAINT FK_DIR;

ALTER TABLE PROFESSORS 
ADD CONSTRAINT FK_DIR FOREIGN KEY(director) REFERENCES PROFESSORS(codi)
DEFERRABLE INITIALLY DEFERRED;

INSERT INTO professors (codi, cognom1, cognom2, nom, actiu, categoria, dedicacio, departament_codi, director)
VALUES (4, 'Marti', 'Gomez', 'Pere', 'S', 'Titular', 'TC', 001, 6);
INSERT INTO professors (codi, cognom1, cognom2, nom, actiu, categoria, dedicacio, departament_codi, director)
VALUES (5, 'Cotet', 'Jull', 'Albert', 'S', 'Titular', 'TC', 001, 6);
INSERT INTO professors (codi, cognom1, cognom2, nom, actiu, categoria, dedicacio, departament_codi)
VALUES (6, 'Adell', 'Carpi', 'Xavier', 'S', 'Director', 'TC', 002);
COMMIT;

DELETE FROM PROFESSORS
WHERE codi IN (4,5,6);


-- 14

DROP TABLE MGR_HISTORY;
CREATE table MGR_HISTORY
(EMPLOYEE_ID	NUMBER(6),
MANAGER_ID	NUMBER(6),
SALARY	NUMBER(8,2));

DROP TABLE SAL_HISTORY;
CREATE table SAL_HISTORY
(EMPLOYEE_ID	NUMBER(6),
HIRE_DATE	DATE,
SALARY	NUMBER(8,2));

drop TABLE SPECIAL_SAL;
CREATE table SPECIAL_SAL
(EMPLOYEE_ID	NUMBER(6),
SALARY	NUMBER(8,2));

SELECT employee_id, hire_date, salary, manager_id
FROM EMPLOYEES
WHERE employee_id >= 200 AND salary < 5000;

--guia restricciones
DESC user_constraints;
