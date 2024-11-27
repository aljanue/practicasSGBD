-- Ejercicio 1
-- Transacción 1.1
INSERT INTO DEPT (deptno, dname, loc)
VALUES (50, 'HHRR', 'LOS ANGELES');
ROLLBACK;
SELECT * FROM DEPT WHERE deptno='50';
-- No aparece nada
-- Transacción 1.2
INSERT INTO DEPT (deptno, dname, loc)
VALUES (50, 'HHRR', 'LOS ANGELES');
COMMIT;
SELECT * FROM DEPT WHERE deptno = 50;
-- 50	HHRR	LOS ANGELES
-- Transacción 1.3
INSERT INTO EMP (empno, ename, job)
VALUES (8001, 'JULIAN', 'CONSULTANT');
UPDATE EMP
SET mgr = 7839, hiredate = TO_DATE('20/10/83', 'DD/MM/YY'), sal = 3500, comm = 0, deptno = 50
WHERE empno = 8001;
SAVEPOINT SP1;
UPDATE EMP
SET mgr = 7369, hiredate = TO_DATE('20/10/83', 'DD/MM/YY'), sal = 3500, comm = NULL, deptno = 40
WHERE empno = 8001;
ROLLBACK TO SP1;
SELECT * FROM EMP WHERE empno = 8001;
COMMIT;
-- 8001	JULIAN	CONSULTANT	7839	20/10/83	3500	0	50
-- No se actualiza lo de después del savepoint, ya que se ha hecho el Rollback

-- Ejercicio 2
-- Transacción 2.1
INSERT INTO DEPT (deptno, dname, loc)
VALUES (60, 'DEPT_EJ2', 'LOC_DEPT_EJ2');
SAVEPOINT SP1;
INSERT INTO EMP (empno, ename, job, deptno)
VALUES (9061, 'NOMBRE_EMPLEADO_1', 'TRABAJO_EMPLEADO_1', 60);
INSERT INTO EMP (empno, ename, job, deptno)
VALUES (9062, 'NOMBRE_EMPLEADO_2', 'TRABAJO_EMPLEADO_2', 60);
INSERT INTO DEPT (deptno, dname, loc)
VALUES (70, 'NOMBRE_DEPARTAMENTO_70', 'LOCALIZACION_DEPARTAMENTO_70');
SAVEPOINT SP2;
INSERT INTO EMP (empno, ename, job, deptno)
VALUES (9071, 'NOMBRE_EMPLEADO_3', 'TRABAJO_EMPLEADO_3', 70);
INSERT INTO EMP (empno, ename, job, deptno)
VALUES (9072, 'NOMBRE_EMPLEADO_4', 'TRABAJO_EMPLEADO_4', 70);
ROLLBACK TO SP2;
INSERT INTO EMP (empno, ename, job, deptno)
VALUES (9071, 'NOMBRE_EMPLEADO_3', 'TRABAJO_EMPLEADO_3', 70);
ROLLBACK TO SP1;
INSERT INTO EMP (empno, ename, job, deptno)
VALUES (9071, 'NOMBRE_EMPLEADO_3', 'TRABAJO_EMPLEADO_3', 70);
COMMIT;
/*
Da error cuando intentamos:
INSERT INTO EMP (empno, ename, job, deptno)
VALUES (9071, 'NOMBRE_EMPLEADO_3', 'TRABAJO_EMPLEADO_3', 70);
Porque al hacer Rollback borramos el departamento 70, por lo que no lo encuentra
al intentar insertar el ultimo empleado.
*/
-- Ejercicio 3
-- Caso 3.1.1
ROLLBACK;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
                                                                ROLLBACK;
                                                                SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
INSERT INTO DEPT (deptno, dname) VALUES (151, 'ADVERTISING');
                                                                SELECT COUNT(*) FROM DEPT;
SELECT COUNT(*) FROM DEPT;
COMMIT;
                                                                SELECT COUNT(*) FROM DEPT;
                                                                COMMIT;
                                                                SELECT COUNT(*) FROM DEPT;
/*
En el primer select count(*) (Sesion B) muestra 5.
En el primer select count(*) (Sesion A) muestra 6.
Lo de la sesion A no se refleja en lo de la sesion B.
Al hacer el Commit en sesion A, se refleja el cambio en la sesion B, mostrando 6.
Al hacer Commit en la sesion B, sigue saliendo 6.
*/
-- Caso 3.1.2
DELETE FROM DEPT WHERE deptno=151;
COMMIT;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
                                                                ROLLBACK;
                                                                SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
INSERT INTO DEPT (deptno, dname) VALUES (151, 'ADVERTISING');
                                                                SELECT COUNT(*) FROM DEPT;
SELECT COUNT(*) FROM DEPT;
COMMIT;
                                                                SELECT COUNT(*) FROM DEPT;
                                                                COMMIT;
                                                                SELECT COUNT(*) FROM DEPT;
/*
Hasta que la sesion B no hace Commit, no se ven los cambios de la sesion A.
*/
-- Caso 3.2.1
ROLLBACK;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
                                                                ROLLBACK;
                                                                SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
                                                                SELECT * FROM DEPT WHERE deptno = 151;
UPDATE DEPT SET dname = 'NEW_NAME' WHERE deptno = 151;
COMMIT;
                                                                SELECT * FROM DEPT WHERE deptno = 151;
                                                                COMMIT;
                                                                SELECT * FROM DEPT WHERE deptno = 151;
/*
No se ven los cambios en la sesion B hasta que no se hace commit (se confirman) en la sesion A.
*/
-- Caso 3.2.2
UPDATE DEPT SET dname = 'ADVERSITING' WHERE deptno = 151;
COMMIT;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
                                                                ROLLBACK;
                                                                SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
                                                                SELECT * FROM DEPT WHERE deptno = 151;
UPDATE DEPT SET dname = 'NEW_NAME' WHERE deptno = 151;
COMMIT;
                                                                SELECT * FROM DEPT WHERE deptno = 151;
                                                                COMMIT;
                                                                SELECT * FROM DEPT WHERE deptno = 151;                                                                
/*
No se ven los cambios en la sesion B hasta que no se hace commit (se confirman) en la sesion B.
Debido al tipo de aislamiento de la sesion B.
*/

-- Ejercicio 4
-- Caso 4.1
ROLLBACK;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
INSERT INTO DEPT (deptno, dname) VALUES (101, 'PRIVACY');
COMMIT;
                                                                ROLLBACK;
                                                                SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE DEPT SET deptno = 102 WHERE deptno = 101;
                                                                UPDATE DEPT SET deptno = deptno + 5 WHERE deptno = 101;
                                                                UPDATE DEPT SET deptno = deptno + 5 WHERE deptno = 102;
COMMIT;
                                                                COMMIT;
/*
Se puede modificar el departamento 101, ya que se ha hecho commit previamente en la sesion A
pero no se puede modificar el departamento 102, debido a que se ha creado en la sesión A pero no se ha confirmado todavía.
*/
-- Caso 4.2
ROLLBACK;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
                                                                ROLLBACK;
                                                                SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM DEPT WHERE deptno >= 100 FOR UPDATE; -- Muestra los dos departamentos por arriba de 100.
                                                                SELECT COUNT(*) FROM DEPT WHERE deptno < 100; -- Muestra que hay 5 departamentos.
UPDATE DEPT SET deptno = deptno - 10 WHERE deptno >= 100;
SELECT COUNT(*) FROM DEPT WHERE deptno < 100; -- Ahora hay 1 departamento mas (Total 6) al restarle 10.
                                                                SELECT COUNT(*) FROM DEPT WHERE deptno < 100; -- El Update no se ha reflejado todavia.
COMMIT;
                                                                COMMIT;
/*
Hasta que no se hace Commit no se ven los cambios.
*/
-- Caso 4.3
ROLLBACK;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
                                                                            ROLLBACK;
                                                                            SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
INSERT INTO DEPT (deptno, dname) VALUES (110, 'NOMBRE_DEPARTAMENTO_110');
COMMIT;
                                                                            INSERT INTO DEPT (deptno, dname) VALUES (120, 'NOMBRE_DEPARTAMENTO_120');
                                                                            COMMIT;
SELECT * FROM DEPT WHERE deptno = 110 FOR UPDATE;
                                                                            SELECT * FROM DEPT WHERE deptno = 120 FOR UPDATE;
UPDATE DEPT SET dname = 'NEW_NAME_110' WHERE deptno = 110;
                                                                            UPDATE DEPT SET dname = 'NEW_NAME_120' WHERE deptno = 120;
SELECT * FROM DEPT WHERE deptno = 120 FOR UPDATE;
                                                                            SELECT * FROM DEPT WHERE deptno = 110 FOR UPDATE;
UPDATE DEPT SET dname = 'NEW_NAME_2_120' WHERE deptno = 120;
                                                                            UPDATE DEPT SET dname = 'NEW_NAME_2_110' WHERE deptno = 110;
COMMIT;                                                                            
                                                                            COMMIT;
/*
La sesion A no puede reservar el departamento 120 para modificarlo ya que lo ha reservado previamente la sesion B.
Se produce un bloqueo de escritura.

A la sesion B le pasa lo mismo con el departamento 110.

No pueden seguir hasta que no se liberan (hacen commit).
Informe de error -
ORA-00060: detectado interbloqueo mientras se esperaba un recurso
*/
-- Ejercicio 5
-- Caso 5.1
ROLLBACK;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
LOCK TABLE DEPT IN SHARE MODE;
                                                                            ROLLBACK;
                                                                            SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
                                                                            SELECT * FROM DEPT WHERE deptno = 50;
                                                                            UPDATE DEPT SET dname = 'NEW_NAME' WHERE deptno = 50;
/*
El Update se queda esperando a que la sesion A termine
*/
-- Caso 5.2
ROLLBACK;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
LOCK TABLE DEPT IN EXCLUSIVE MODE;
                                                                            ROLLBACK;
                                                                            SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
                                                                            SELECT * FROM DEPT WHERE deptno = 50;
                                                                            UPDATE DEPT SET dname = 'NEW_NAME' WHERE deptno = 50;
/*
El Update se queda esperando a que la sesion A termine
*/
-- Caso 5.3
ROLLBACK;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
LOCK TABLE DEPT IN SHARE MODE;
                                                                            ROLLBACK;
                                                                            SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
                                                                            SELECT * FROM DEPT WHERE deptno = 50 FOR UPDATE;
/*
El SELECT [...] FOR UPDATE se queda esperando a que la sesion A termine
*/
-- Caso 5.4
ROLLBACK;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
LOCK TABLE DEPT IN ROW SHARE MODE;
                                                                            ROLLBACK;
                                                                            SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
                                                                            LOCK TABLE DEPT IN ROW EXCLUSIVE MODE;
SELECT * FROM V$LOCKED_OBJECT;                                                   
COMMIT;
SELECT * FROM V$LOCKED_OBJECT;
                                                                            COMMIT;
SELECT * FROM V$LOCKED_OBJECT;
/*
1er SELECT:
0	0	0	675611	1579	GIISGBD108	mario	12576	2	0
0	0	0	675611	5333	GIISGBD108	mario	12576	3	0

2o SELECT:
0	0	0	675611	5333	GIISGBD108	mario	12576	3	0

3er SELECT:
Vacio

Conclusion
Se van liberando bloqueos al hacer COMMIT (o ROLLBACK).
*/
-- Ejercicio 6
CREATE TABLE EMPGRADE (
    EMPNO NUMBER PRIMARY KEY,
    GRADE NUMBER
);

BEGIN
    FOR emp IN (SELECT empno, sal FROM EMP) LOOP
        DECLARE
            v_grade NUMBER := 0;
        BEGIN
            SELECT GRADE INTO v_grade
            FROM SALGRADE
            WHERE emp.sal BETWEEN LOSAL AND HISAL
            AND ROWNUM = 1; -- Asegura que solo un resultado sea seleccionado
            
            INSERT INTO EMPGRADE (EMPNO, GRADE)
            VALUES (emp.empno, v_grade);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                INSERT INTO EMPGRADE (EMPNO, GRADE)
                VALUES (emp.empno, 0);
        END;
    END LOOP;
END;
/
SELECT * FROM EMPGRADE;
CREATE OR REPLACE PROCEDURE ManageEmployee IS
BEGIN
    -- 1. Crear un empleado nuevo
    INSERT INTO EMP (empno, ename, job)
    VALUES (8010, 'CAGE', 'ASSISTANT');
    
    -- 2. Actualizar el empleado creado
    UPDATE EMP
    SET mgr = 8001,
        hiredate = TO_DATE('13/01/83', 'DD/MM/YY'),
        sal = 3800,
        comm = 100,
        deptno = 50
    WHERE empno = 8010;
    
    -- 3. Asignar el nuevo empleado creado al grado salarial 4
    INSERT INTO EMPGRADE (EMPNO, GRADE)
    VALUES (8010, 4);

    -- 4. Comprobar las condiciones
    DECLARE
        v_sal NUMBER;
        v_mgr_sal NUMBER;
        v_grade NUMBER;
        v_count NUMBER;
    BEGIN
        -- Obtener el salario del empleado
        SELECT sal INTO v_sal FROM EMP WHERE empno = 8010;
        
        -- Obtener el salario del manager
        SELECT sal INTO v_mgr_sal FROM EMP WHERE empno = 8001;
        
        -- Obtener el grado salarial del empleado
        SELECT grade INTO v_grade FROM EMPGRADE WHERE empno = 8010;
        
        -- Condición #1: el grado salarial asignado coincide con el salario del empleado
        SELECT COUNT(*) INTO v_count
        FROM SALGRADE
        WHERE GRADE = v_grade AND v_sal BETWEEN LOSAL AND HISAL;
        
        IF v_count = 0 THEN
            -- Deshacer la inserción y asignar el valor correcto
            DELETE FROM EMPGRADE WHERE EMPNO = 8010;
            SELECT grade INTO v_grade
            FROM SALGRADE
            WHERE v_sal BETWEEN LOSAL AND HISAL
            AND ROWNUM = 1;
            INSERT INTO EMPGRADE (EMPNO, GRADE) VALUES (8010, v_grade);
        END IF;
        
        -- Condición #2: el salario del empleado es inferior al salario del manager
        IF v_sal >= v_mgr_sal THEN
            -- Deshacer la actualización y volverla a hacer con un salario 800 unidades inferior al del manager
            UPDATE EMP SET sal = v_mgr_sal - 800 WHERE empno = 8010;
        END IF;
    END;

    -- 7. Validar la transacción
    COMMIT;
END;
/
EXEC ManageEmployee;

SELECT * FROM EMP WHERE empno = 8010;




                                                                         
                                                                            


