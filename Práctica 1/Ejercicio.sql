ALTER USER GIISGBD109 IDENTIFIED BY practicas2025;

-- Ejercicio 1: Creación de tablas e inserción de datos
CREATE TABLE PAISES (
    ID_PAIS NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(64) NOT NULL,
    CONTINENTE VARCHAR2(24) NOT NULL,
    CAPITAL VARCHAR2(64) NOT NULL,
    SITUACION VARCHAR2(128),
    NOTAS VARCHAR2(128)
);

CREATE TABLE RIOS (
    ID_RIO NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL,
    LONGITUD NUMBER,
    CUENCA NUMBER,
    CAUDAL_MEDIO NUMBER,
    NACIMIENTO VARCHAR2(64) NOT NULL,
    PAIS_NACIMIENTO NUMBER NOT NULL,
    DESEMBOCADURA VARCHAR2(64) NOT NULL,
    PAIS_DESEMBOC NUMBER NOT NULL,
    constraint fk_NACIMIENTO FOREIGN KEY (PAIS_NACIMIENTO) REFERENCES PAISES(ID_PAIS),
    constraint fk_DESEMBOCADURA FOREIGN KEY (PAIS_DESEMBOC) REFERENCES PAISES(ID_PAIS)
);

INSERT INTO PAISES (ID_PAIS, NOMBRE, CONTINENTE, CAPITAL, SITUACION, NOTAS)
VALUES (1, 'España', 'Europa', 'Madrid', 'Suroeste de Europa', 'Mi país de origen');

INSERT INTO PAISES (ID_PAIS, NOMBRE, CONTINENTE, CAPITAL, SITUACION, NOTAS)
VALUES (2, 'Brasil', 'América del Sur', 'Brasilia', 'Este de América del Sur', 'País más grande de América del Sur');

INSERT INTO PAISES (ID_PAIS, NOMBRE, CONTINENTE, CAPITAL, SITUACION, NOTAS)
VALUES (3, 'China', 'Asia', 'Pekín', 'Este de Asia', 'País más poblado del mundo');

INSERT INTO RIOS (ID_RIO, NOMBRE, LONGITUD, CUENCA, CAUDAL_MEDIO, NACIMIENTO, PAIS_NACIMIENTO, DESEMBOCADURA, PAIS_DESEMBOC)
VALUES (2, 'Río Ebro', 910, 85300, 426, 'Fontibre', 1, 'Mar Mediterráneo', 1);

INSERT INTO RIOS (ID_RIO, NOMBRE, LONGITUD, CUENCA, CAUDAL_MEDIO, NACIMIENTO, PAIS_NACIMIENTO, DESEMBOCADURA, PAIS_DESEMBOC)
VALUES (3, 'Río Amazonas', 6400, 7050000, 209000, 'Nevado Mismi', 2, 'Océano Atlántico', 2);

INSERT INTO RIOS (ID_RIO, NOMBRE, LONGITUD, CUENCA, CAUDAL_MEDIO, NACIMIENTO, PAIS_NACIMIENTO, DESEMBOCADURA, PAIS_DESEMBOC)
VALUES (4, 'Río Yangtsé', 6300, 1808500, 31900, 'Glaciar de Jianggendiru', 3, 'Mar de China Oriental', 3);

-- Ejercicio 2. Implementación de triggers
CREATE OR REPLACE TRIGGER TRG_INSERT_RIOS_LONGITUD
BEFORE INSERT OR UPDATE ON RIOS
FOR EACH ROW
BEGIN
    IF :NEW.LONGITUD > 7000000 
    OR :NEW.LONGITUD < 0
    THEN
        RAISE_APPLICATION_ERROR(-20000, 'La longitud del río debe ser positiva y menor de 7000000');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TRG_INSERT_RIOS_CAUDAL
BEFORE INSERT OR UPDATE ON RIOS
FOR EACH ROW
BEGIN
    IF :NEW.CAUDAL_MEDIO < 0
    OR :NEW.CAUDAL_MEDIO > 200000 
    THEN
        RAISE_APPLICATION_ERROR(-20000, 'La longitud del caudal debe ser positiva y menor de 200000');
    END IF;
END;
/


-- a) Contar els rius que hi ha a la taula RIOS al començament del procés.
SELECT * FROM RIOS;

-- b) Inserir un riu amb una longitud permesa (INSERT) y consultar la taula per acomprovar que ha funcionat la inserció (SELECT)
INSERT INTO RIOS (ID_RIO, NOMBRE, LONGITUD, CUENCA, CAUDAL_MEDIO, NACIMIENTO, PAIS_NACIMIENTO, DESEMBOCADURA, PAIS_DESEMBOC)
VALUES (1, 'Río Misisipi', 17800, 250, 10089, 'Lago Itasca', 2, 'Golfo de México', 2);
SELECT * FROM RIOS;

-- c) Modificar un riu amb una longitud no permesa (UPDATE) y mostrar l’error que genera el SGBD
UPDATE RIOS SET LONGITUD = -120 WHERE ID_RIO = 1;
-- ORA-20000: La longitud del río o del caudal debe ser positiva y menor de 1000000

-- d) Deshabilitar el trigger (sentència SQL) creat
ALTER TRIGGER TRG_INSERT_RIOS DISABLE;
UPDATE RIOS SET LONGITUD = -120 WHERE ID_RIO = 1;
SELECT * FROM RIOS;

-- f) Habilitar el trigger (sentència SQL)
ALTER TRIGGER TRG_INSERT_RIOS ENABLE;

-- g) Executar un ROLLBACK per a desfer la transacció.
ROLLBACK;

-- h) Contar els rius que hi ha a la taula RIOS després del ROLLBACK, comparar el numero amb l’obtingut al principi, i comentar el resultat obtingut
SELECT * FROM RIOS;

-- EJERCICIO 3. 
-- Implementar un trigger PL/SQL que impedisca que s’inserisquen o modifiquen registres en la taula RIOS assignant-los un país de desembocadura que no estiga a Europa
CREATE OR REPLACE TRIGGER TRG_INSERT_RIOS_PAIS
BEFORE INSERT OR UPDATE ON RIOS
FOR EACH ROW
DECLARE
    continente VARCHAR2(24);
BEGIN
    -- Obtener el continente del país de desembocadura
    SELECT CONTINENTE INTO continente
    FROM PAISES
    WHERE ID_PAIS = :NEW.PAIS_DESEMBOC;

    -- Verificar si el continente no es Europa
    IF continente != 'Europa' THEN
        RAISE_APPLICATION_ERROR(-20000, 'El país de desembocadura debe estar en Europa');
    END IF;
END;
/
-- A) INSERTAR UN RIO QUE LA DESEMBOCADURA SOBRE UN PAIS QUE NO ESTÁ EN EUROPA
INSERT INTO RIOS (ID_RIO, NOMBRE, LONGITUD, CUENCA, CAUDAL_MEDIO, NACIMIENTO, PAIS_NACIMIENTO, DESEMBOCADURA, PAIS_DESEMBOC)
VALUES (5, 'Río Misisipi', 17800, 250, 10089, 'Lago Itasca', 2, 'Golfo de México', 1);
-- NO hay error porque el pais con ID 1 es España y está en Europa
INSERT INTO RIOS (ID_RIO, NOMBRE, LONGITUD, CUENCA, CAUDAL_MEDIO, NACIMIENTO, PAIS_NACIMIENTO, DESEMBOCADURA, PAIS_DESEMBOC)
VALUES (5, 'Río Misisipi', 17800, 250, 10089, 'Lago Itasca', 2, 'Golfo de México', 2);
-- ORA-20000: El país de desembocadura debe estar en Europa (Brazil (id 2) no está en Europa)

-- EJERCICIO 4: 
-- Incloure un nou camp en la taula PAISES anomenat NUM_RIOS per a guardar el nombre
-- de rius que desemboquen en aqueix país, i implementar un trigger perquè mantinga
-- actualitzat aquest camp NUM_RIOS en la taula PAISES quan la taula RIOS patisca
-- qualsevol canvi que afecte a aquest valor.

-- Crear campo nuevo NUM_RIOS en la tabla PAISES
ALTER TABLE PAISES ADD (NUM_RIOS NUMBER DEFAULT 0);

-- Actualizar el campo NUM_RIOS con los ríos existentes
UPDATE PAISES p
SET NUM_RIOS = (
    SELECT COUNT(*)
    FROM RIOS r
    WHERE r.PAIS_DESEMBOC = p.ID_PAIS
);
COMMIT;

-- Verificar la actualización
SELECT * FROM PAISES;
SELECT * FROM RIOS;

-- Crear trigger para mantener actualizado el campo NUM_RIOS
CREATE OR REPLACE TRIGGER TRG_UPDATE_NUM_RIOS
AFTER INSERT OR UPDATE OR DELETE ON RIOS
FOR EACH ROW
BEGIN
    -- Si se inserta un nuevo río
    IF INSERTING THEN
        UPDATE PAISES
        SET NUM_RIOS = NUM_RIOS + 1
        WHERE ID_PAIS = :NEW.PAIS_DESEMBOC;
    END IF;

    -- Si se actualiza un río
    IF UPDATING THEN
        -- Si el país de desembocadura ha cambiado
        IF :OLD.PAIS_DESEMBOC != :NEW.PAIS_DESEMBOC THEN
            -- Disminuir el contador en el país antiguo
            UPDATE PAISES
            SET NUM_RIOS = NUM_RIOS - 1
            WHERE ID_PAIS = :OLD.PAIS_DESEMBOC;

            -- Aumentar el contador en el nuevo país
            UPDATE PAISES
            SET NUM_RIOS = NUM_RIOS + 1
            WHERE ID_PAIS = :NEW.PAIS_DESEMBOC;
        END IF;
    END IF;

    -- Si se elimina un río
    IF DELETING THEN
        UPDATE PAISES
        SET NUM_RIOS = NUM_RIOS - 1
        WHERE ID_PAIS = :OLD.PAIS_DESEMBOC;
    END IF;
END;
/

-- Creamos rio y vemos como suma 1 el pais con la desembocadura
INSERT INTO RIOS (ID_RIO, NOMBRE, LONGITUD, CUENCA, CAUDAL_MEDIO, NACIMIENTO, PAIS_NACIMIENTO, DESEMBOCADURA, PAIS_DESEMBOC)
VALUES (6, 'Río Misisipi', 17800, 250, 10089, 'Lago Itasca', 2, 'Golfo de México', 1);
SELECT * FROM PAISES;

-- Actualizamos rio y vemos si resta 1 el pais con la antigua desembocadura y suma 1 el pais con la nueva desembocadura
UPDATE RIOS SET PAIS_DESEMBOC = 1 WHERE ID_RIO = 3;
SELECT * FROM PAISES;

-- Eliminamos rio y vemos si resta 1 el pais con la desembocadura
DELETE FROM RIOS WHERE ID_RIO = 6;
SELECT * FROM PAISES;

-- EJERCICIO 5
-- Implementar un o més triggers PL/SQL que mantinguen la taula CAMBIOLOG
-- actualitzada amb les dates dels 10 últims canvis que s'hagen realitzat sobre les taules PAISES
-- i RIOS. S'ha d'emmagatzemar al menys el nom de la taula modificada i la data de la
-- modificació (usar SYSDATE). Nota: S'haurà de definir i crear la taula CAMBIOLOG

-- Creamos la tabla
CREATE TABLE CAMBIOLOG (
    ID_LOG NUMBER GENERATED BY DEFAULT AS IDENTITY,
    NOMBRE_TABLA VARCHAR2(50),
    FECHA_MODIFICACION DATE,
    CONSTRAINT PK_CAMBIOLOG PRIMARY KEY (ID_LOG)
);

-- Creamos trigger para la tabla PAISES
CREATE OR REPLACE TRIGGER TRG_CAMBIOLOG_PAISES
AFTER INSERT OR UPDATE OR DELETE ON PAISES
FOR EACH ROW
BEGIN
    INSERT INTO CAMBIOLOG (NOMBRE_TABLA, FECHA_MODIFICACION)
    VALUES ('PAISES', SYSDATE);

    -- Eliminar registros antiguos si hay más de 10
    DELETE FROM CAMBIOLOG
    WHERE ID_LOG IN (
        SELECT ID_LOG
        FROM CAMBIOLOG
        ORDER BY FECHA_MODIFICACION DESC
        OFFSET 10 ROWS
    );
END;
/

-- Creamos trigger para la tabla RIOS
CREATE OR REPLACE TRIGGER TRG_CAMBIOLOG_RIOS
AFTER INSERT OR UPDATE OR DELETE ON RIOS
FOR EACH ROW
BEGIN
    INSERT INTO CAMBIOLOG (NOMBRE_TABLA, FECHA_MODIFICACION)
    VALUES ('RIOS', SYSDATE);

    -- Eliminar registros antiguos si hay más de 10
    DELETE FROM CAMBIOLOG
    WHERE ID_LOG IN (
        SELECT ID_LOG
        FROM CAMBIOLOG
        ORDER BY FECHA_MODIFICACION DESC
        OFFSET 10 ROWS
    );
END;
/