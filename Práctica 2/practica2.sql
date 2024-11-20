-- Ejercicio 1
-- Copiamos las tablas
INSERT INTO ACTORES
    SELECT
        *
    FROM
        GIISGBD.ACTORES_DATOS2;

INSERT INTO PELICULAS
    SELECT
        *
    FROM
        GIISGBD.PELICULAS_DATOS2;

INSERT INTO ACTUACION
    SELECT
        *
    FROM
        GIISGBD.ACTUACION_DATOS2;

-- Creamos los indices
CREATE INDEX IDX_SEXO ON ACTORES (SEXO);

CREATE INDEX IDX_ANYO ON PELICULAS (ANYO);

-- Creamos las estadísticas
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTORES',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;
/

BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'PELICULAS',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;

BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTUACION',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;

EXEC DBMS_STATS.GATHER_INDEX_STATS(
    OWNNAME=>'GIISGBD109',
    INDNAME=>'IDX_SEXO',
    FORCE =>TRUE
);
EXEC DBMS_STATS.GATHER_INDEX_STATS(
    OWNNAME=>'GIISGBD109',
    INDNAME=>'IDX_ANYO',
    FORCE =>TRUE
);
 
-- Comprobaciones
SELECT
    TABLE_NAME  AS "Nom",
    NUM_ROWS    AS "Nombre de files",
    BLOCKS      AS "Nombre de blocs",
    AVG_ROW_LEN AS "Longitud mitjana dels registres"
FROM
    USER_TABLES
WHERE
    TABLE_NAME IN ('ACTORES', 'PELICULAS', 'ACTUACION');
SELECT
    TABLE_NAME   AS "Nom de taula",
    COLUMN_NAME  AS "Nom de columna",
    NUM_DISTINCT AS "Quantitat de valors diferents",
    LOW_VALUE    AS "Valor mínim",
    HIGH_VALUE   AS "Valor màxim",
    NUM_NULLS    AS "Nombre de nuls",
    AVG_COL_LEN  AS "Longitud mitjana de la columna",
    HISTOGRAM    AS "Histograma"
FROM
    USER_TAB_COL_STATISTICS
WHERE
    TABLE_NAME IN ('ACTORES', 'PELICULAS', 'ACTUACION');
SELECT
    INDEX_NAME              AS "Nom",
    TABLE_NAME              AS "Taula",
    BLEVEL                  AS "Profunditat",
    LEAF_BLOCKS             AS "Blocs en les fulles",
    DISTINCT_KEYS           AS "Quantitat de claus diferents",
    AVG_LEAF_BLOCKS_PER_KEY AS "Mitjana de blocs fulla per clau",
    AVG_DATA_BLOCKS_PER_KEY AS "Mitjana de blocs de dades per clau",
    CLUSTERING_FACTOR       AS "Factor de clustering",
    NUM_ROWS                AS "Nombre de registres"
FROM
    USER_IND_STATISTICS
WHERE
    INDEX_NAME IN ('IDX_SEXO', 'IDX_ANYO');
 
-- Resultados:

 /*
TABLAS=[
  {
    "Nom": "'ACTORES'",
    "Nombre de files": "9146",
    "Nombre de blocs": "244",
    "Longitud mitjana dels registres": "108"
  },
  {
    "Nom": "'ACTUACION'",
    "Nombre de files": "12500",
    "Nombre de blocs": "244",
    "Longitud mitjana dels registres": "111"
  },
  {
    "Nom": "'PELICULAS'",
    "Nombre de files": "11182",
    "Nombre de blocs": "370",
    "Longitud mitjana dels registres": "210"
  }
]

COLUMNAS=[
  {
    "Nom de taula": "'ACTORES'",
    "Nom de columna": "'OID'",
    "Quantitat de valors diferents": "9146",
    "Valor mínim": "'C3173202'",
    "Valor màxim": "'C33B3C35'",
    "Nombre de nuls": "0",
    "Longitud mitjana de la columna": "5",
    "Histograma": "'NONE'"
  },
  {
    "Nom de taula": "'ACTORES'",
    "Nom de columna": "'NOM'",
    "Quantitat de valors diferents": "9146",
    "Valor mínim": "'41616C746F2C20416E75202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020'",
    "Valor màxim": "'6C6120507565626C612C204E69C3B161206465202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020'",
    "Nombre de nuls": "0",
    "Longitud mitjana de la columna": "101",
    "Histograma": "'NONE'"
  },
  {
    "Nom de taula": "'ACTORES'",
    "Nom de columna": "'SEXO'",
    "Quantitat de valors diferents": "1",
    "Valor mínim": "'4D'",
    "Valor màxim": "'4D'",
    "Nombre de nuls": "0",
    "Longitud mitjana de la columna": "2",
    "Histograma": "'NONE'"
  },
  {
    "Nom de taula": "'ACTUACION'",
    "Nom de columna": "'ACTOR'",
    "Quantitat de valors diferents": "9146",
    "Valor mínim": "'C3173202'",
    "Valor màxim": "'C33B3C35'",
    "Nombre de nuls": "0",
    "Longitud mitjana de la columna": "5",
    "Histograma": "'NONE'"
  },
  {
    "Nom de taula": "'ACTUACION'",
    "Nom de columna": "'PELI'",
    "Quantitat de valors diferents": "11182",
    "Valor mínim": "'C3173108'",
    "Valor màxim": "'C33B3B54'",
    "Nombre de nuls": "0",
    "Longitud mitjana de la columna": "5",
    "Histograma": "'NONE'"
  },
  {
    "Nom de taula": "'ACTUACION'",
    "Nom de columna": "'PAPEL'",
    "Quantitat de valors diferents": "6585",
    "Valor mínim": "'317374204174746F726E657920202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020'",
    "Valor màxim": "'C3897661202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020'",
    "Nombre de nuls": "0",
    "Longitud mitjana de la columna": "101",
    "Histograma": "'NONE'"
  },
  {
    "Nom de taula": "'PELICULAS'",
    "Nom de columna": "'OID'",
    "Quantitat de valors diferents": "11182",
    "Valor mínim": "'C3173108'",
    "Valor màxim": "'C33B3B54'",
    "Nombre de nuls": "0",
    "Longitud mitjana de la columna": "5",
    "Histograma": "'NONE'"
  },
  {
    "Nom de taula": "'PELICULAS'",
    "Nom de columna": "'TITULO'",
    "Quantitat de valors diferents": "11014",
    "Valor mínim": "'2431303030206120546F756368646F776E2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020'",
    "Valor màxim": "'C3BF72626F6C2064652045737061C3B1612C20456C20202020202020202020202020202020202020202020202020202020202020202020202020202020202020'",
    "Nombre de nuls": "0",
    "Longitud mitjana de la columna": "201",
    "Histograma": "'NONE'"
  },
  {
    "Nom de taula": "'PELICULAS'",
    "Nom de columna": "'ANYO'",
    "Quantitat de valors diferents": "95",
    "Valor mínim": "'80'",
    "Valor màxim": "'C21464'",
    "Nombre de nuls": "0",
    "Longitud mitjana de la columna": "4",
    "Histograma": "'NONE'"
  }
]

INDICES=[
  {
    "Nom": "'IDX_ANYO'",
    "Taula": "'PELICULAS'",
    "Profunditat": "1",
    "Blocs en les fulles": "24",
    "Quantitat de claus diferents": "95",
    "Mitjana de blocs fulla per clau": "1",
    "Mitjana de blocs de dades per clau": "88",
    "Factor de clustering": "8450",
    "Nombre de registres": "11182"
  },
  {
    "Nom": "'IDX_SEXO'",
    "Taula": "'ACTORES'",
    "Profunditat": "1",
    "Blocs en les fulles": "17",
    "Quantitat de claus diferents": "1",
    "Mitjana de blocs fulla per clau": "17",
    "Mitjana de blocs de dades per clau": "143",
    "Factor de clustering": "143",
    "Nombre de registres": "9146"
  }
]
*/
 
 -- Conclusiones:

 /*
- Se ha creado un índice para SEXO y sólo existe 1 valor
- Hay muchos actores (9146) para la cantidad de peliculas (11182) y actuaciones (12500)
haciendo que la proporcion salga aprox a 1.2 actores por pelicula y 1.1 actuaciones por pelicula
lo cual no es lógico, pues en una película actúan muchos actores y los actores actúan en muchas películas
*/
 
 -- Eliminar els índexs i les estadístiques generades.
DROP INDEX IDX_SEXO;
DROP INDEX IDX_ANYO;
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTORES'
    );
END;
/

BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'PELICULAS'
    );
END;
/

BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTUACION'
    );
END;
/

-- Consultar información de las tablas
SELECT
    TABLE_NAME  AS "Nom",
    NUM_ROWS    AS "Nombre de files",
    BLOCKS      AS "Nombre de blocs",
    AVG_ROW_LEN AS "Longitud mitjana dels registres"
FROM
    USER_TABLES
WHERE
    TABLE_NAME IN ('ACTORES', 'PELICULAS', 'ACTUACION');

-- Consultar información de las columnas
SELECT
    TABLE_NAME   AS "Nom de taula",
    COLUMN_NAME  AS "Nom de columna",
    NUM_DISTINCT AS "Quantitat de valors diferents",
    LOW_VALUE    AS "Valor mínim",
    HIGH_VALUE   AS "Valor màxim",
    NUM_NULLS    AS "Nombre de nuls",
    AVG_COL_LEN  AS "Longitud mitjana de la columna",
    HISTOGRAM    AS "Histograma"
FROM
    USER_TAB_COL_STATISTICS
WHERE
    TABLE_NAME IN ('ACTORES', 'PELICULAS', 'ACTUACION');

-- Consultar información de los índices
SELECT
    INDEX_NAME              AS "Nom",
    TABLE_NAME              AS "Taula",
    BLEVEL                  AS "Profunditat",
    LEAF_BLOCKS             AS "Blocs en les fulles",
    DISTINCT_KEYS           AS "Quantitat de claus diferents",
    AVG_LEAF_BLOCKS_PER_KEY AS "Mitjana de blocs fulla per clau",
    AVG_DATA_BLOCKS_PER_KEY AS "Mitjana de blocs de dades per clau",
    CLUSTERING_FACTOR       AS "Factor de clustering",
    NUM_ROWS                AS "Nombre de registres"
FROM
    USER_IND_STATISTICS
WHERE
    INDEX_NAME IN ('IDX_SEXO', 'IDX_ANYO');

-- Ejercicio 2:
-- Consulta a utilizar 1
SELECT
    *
FROM
    PELICULAS
WHERE
    ANYO > 1992;

-- Consulta a utilizar 2
SELECT
    *
FROM
    PELICULAS P,
    ACTUACION ACT
WHERE
    P.OID = ACT.PELI
    AND ANYO > 1992;

-- Consulta a utilizar 3
SELECT
    P.*
FROM
    ACTORES A,
    ACTUACION X,
    PELICULAS P
WHERE
    A.NOM = ’LOY,
    MYRNA’
    AND A.OID = X.ACTOR
    AND P.OID = X.PELI;

-- PLANOS DE EJECUCIÓN:
-- Plano de ejecución de la consulta 1
EXPLAIN PLAN FOR
SELECT *
FROM PELICULAS
WHERE ANYO > 1992;

SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 2378278331'
' '
'-------------------------------------------------------------------------------'
'| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |'
'-------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |           |  1844 |   410K|   102   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| PELICULAS |  1844 |   410K|   102   (0)| 00:00:01 |'
'-------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("ANYO">1992)'
' '
'Note'
'-----'
'   - dynamic statistics used: dynamic sampling (level=2)'
'   - SQL plan baseline "SQL_PLAN_37ncmpadunta7d6672d41" used for this statement'
*/

-- Plano de ejecución de la consulta 2
EXPLAIN PLAN FOR
SELECT *
FROM PELICULAS P, ACTUACION ACT
WHERE P.OID = ACT.PELI
AND ANYO > 1992;

SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 3550993981'
' '
'---------------------------------------------------------------------------------------'
'| Id  | Operation             | Name          | Rows  | Bytes | Cost (%CPU)| Time     |'
'---------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT      |               |  2302 |   800K|   204   (0)| 00:00:01 |'
'|*  1 |  HASH JOIN            |               |  2302 |   800K|   204   (0)| 00:00:01 |'
'|*  2 |   TABLE ACCESS FULL   | PELICULAS     |  1844 |   410K|   102   (0)| 00:00:01 |'
'|   3 |   INDEX FAST FULL SCAN| SYS_C00313005 | 14408 |  1801K|   102   (0)| 00:00:01 |'
'---------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("P"."OID"="ACT"."PELI")'
'   2 - filter("ANYO">1992)'
' '
'Note'
'-----'
'   - dynamic statistics used: dynamic sampling (level=2)'
'   - SQL plan baseline "SQL_PLAN_5rbfp05f7uk3m7c4a039a" used for this statement'
*/

-- Plano de ejecución de la consulta 3
EXPLAIN PLAN FOR
SELECT P.*
FROM ACTORES A, ACTUACION X, PELICULAS P
WHERE A.NOM = 'Loy, Myrna'
AND A.OID = X.ACTOR
AND P.OID = X.PELI;

SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 1413788855'
' '
'----------------------------------------------------------------------------------------------'
'| Id  | Operation                    | Name          | Rows  | Bytes | Cost (%CPU)| Time     |'
'----------------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT             |               |     8 |  2952 |    80   (0)| 00:00:01 |'
'|   1 |  NESTED LOOPS                |               |     8 |  2952 |    80   (0)| 00:00:01 |'
'|   2 |   NESTED LOOPS               |               |     9 |  2952 |    80   (0)| 00:00:01 |'
'|   3 |    NESTED LOOPS              |               |     9 |  1269 |    71   (0)| 00:00:01 |'
'|*  4 |     TABLE ACCESS FULL        | ACTORES       |     3 |   345 |    68   (0)| 00:00:01 |'
'|*  5 |     INDEX RANGE SCAN         | SYS_C00313005 |     3 |    78 |     1   (0)| 00:00:01 |'
'|*  6 |    INDEX UNIQUE SCAN         | SYS_C00313001 |     1 |       |     0   (0)| 00:00:01 |'
'|   7 |   TABLE ACCESS BY INDEX ROWID| PELICULAS     |     1 |   228 |     1   (0)| 00:00:01 |'
'----------------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   4 - filter("A"."NOM"='Loy, Myrna')'
'   5 - access("A"."OID"="X"."ACTOR")'
'   6 - access("P"."OID"="X"."PELI")'
' '
'Note'
'-----'
'   - dynamic statistics used: dynamic sampling (level=2)'
'   - SQL plan baseline "SQL_PLAN_4z5x6suxn6hpc21f1959c" used for this statement'
*/


-- Significado de “Note - dynamic sampling used for this statement�?.
/*
Sirve para recopilar estadísticas en tiempo de ejecución, mejorando así la precisión de las 
estimaciones de cardinalidad y costos. Esto ayuda al optimizador a seleccionar un 
plan de ejecución más eficiente.
*/

-- Crear estadísticas
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'PELICULAS',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;
/

BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTUACION',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;
/

BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTORES',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;
/

-- Volver a obtener plano de ejecución

-- RESULTADOS:
-- Consulta 1:
/*
'Plan hash value: 2378278331'
' '
'-------------------------------------------------------------------------------'
'| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |'
'-------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |           |  1999 |   409K|   102   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| PELICULAS |  1999 |   409K|   102   (0)| 00:00:01 |'
'-------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("ANYO">1992)'
' '
'Note'
'-----'
'   - SQL plan baseline "SQL_PLAN_37ncmpadunta7d6672d41" used for this statement'
*/

-- Consulta 2:
/*
'Plan hash value: 3550993981'
' '
'---------------------------------------------------------------------------------------'
'| Id  | Operation             | Name          | Rows  | Bytes | Cost (%CPU)| Time     |'
'---------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT      |               |  2235 |   700K|   186   (0)| 00:00:01 |'
'|*  1 |  HASH JOIN            |               |  2235 |   700K|   186   (0)| 00:00:01 |'
'|*  2 |   TABLE ACCESS FULL   | PELICULAS     |  1999 |   409K|   102   (0)| 00:00:01 |'
'|   3 |   INDEX FAST FULL SCAN| SYS_C00313005 | 12500 |  1354K|    84   (0)| 00:00:01 |'
'---------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("P"."OID"="ACT"."PELI")'
'   2 - filter("ANYO">1992)'
' '
'Note'
'-----'
'   - SQL plan baseline "SQL_PLAN_5rbfp05f7uk3m7c4a039a" used for this statement'
*/

-- Consulta 3:
/*
'Plan hash value: 1413788855'
' '
'----------------------------------------------------------------------------------------------'
'| Id  | Operation                    | Name          | Rows  | Bytes | Cost (%CPU)| Time     |'
'----------------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT             |               |     1 |   326 |    70   (0)| 00:00:01 |'
'|   1 |  NESTED LOOPS                |               |     1 |   326 |    70   (0)| 00:00:01 |'
'|   2 |   NESTED LOOPS               |               |     1 |   326 |    70   (0)| 00:00:01 |'
'|   3 |    NESTED LOOPS              |               |     1 |   116 |    69   (0)| 00:00:01 |'
'|*  4 |     TABLE ACCESS FULL        | ACTORES       |     1 |   106 |    68   (0)| 00:00:01 |'
'|*  5 |     INDEX RANGE SCAN         | SYS_C00313005 |     1 |    10 |     1   (0)| 00:00:01 |'
'|*  6 |    INDEX UNIQUE SCAN         | SYS_C00313001 |     1 |       |     0   (0)| 00:00:01 |'
'|   7 |   TABLE ACCESS BY INDEX ROWID| PELICULAS     |     1 |   210 |     1   (0)| 00:00:01 |'
'----------------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   4 - filter("A"."NOM"='Loy, Myrna')'
'   5 - access("A"."OID"="X"."ACTOR")'
'   6 - access("P"."OID"="X"."PELI")'
' '
'Note'
'-----'
'   - SQL plan baseline "SQL_PLAN_4z5x6suxn6hpc21f1959c" used for this statement'
*/

-- Conclusiones: Cambios respecto a los planes anteriores sin estadísticas
/*
- Ausencia de muestreo dinámico
- Reducción del coste de las consultas cuando 
se utilizan estadísticas precisas.
*/

-- Ejercicio 3
SELECT
    *
FROM
    PELICULAS
WHERE
    ANYO=1960;

SELECT
    *
FROM
    PELICULAS
WHERE
    ANYO<1960;

SELECT
    *
FROM
    PELICULAS
WHERE
    ANYO>1960;

SELECT
    *
FROM
    PELICULAS
WHERE
    ANYO<>1960;

-- Borramos las estadísticas
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'PELICULAS'
    );
END;
 

-- Obtenenemos planos de ejecución sin estadísticas:
-- Plano de ejecución de la consulta 1
EXPLAIN PLAN FOR
SELECT
    *
FROM
    PELICULAS
WHERE
    ANYO = 1960;
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);
 
-- Resultado:

 /*
'Plan hash value: 2378278331'
' '
'-------------------------------------------------------------------------------'
'| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |'
'-------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |           |    70 | 15960 |   102   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| PELICULAS |    70 | 15960 |   102   (0)| 00:00:01 |'
'-------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("ANYO"=1960)'
' '
'Note'
'-----'
'   - dynamic statistics used: dynamic sampling (level=2)'
'   - SQL plan baseline "SQL_PLAN_1jdpsryxmw9bbd6672d41" used for this statement'
*/
 
 -- Plano de ejecución de la consulta 2
EXPLAIN PLAN FOR
SELECT
    *
FROM
    PELICULAS
WHERE
    ANYO < 1960;
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);
 
-- Resultado:

 /*
'Plan hash value: 2378278331'
' '
'-------------------------------------------------------------------------------'
'| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |'
'-------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |           |  4129 |   919K|   102   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| PELICULAS |  4129 |   919K|   102   (0)| 00:00:01 |'
'-------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("ANYO"<1960)'
' '
'Note'
'-----'
'   - dynamic statistics used: dynamic sampling (level=2)'
'   - SQL plan baseline "SQL_PLAN_311qg5amb8st0d6672d41" used for this statement'
*/
 
 -- Plano de ejecución de la consulta 3
EXPLAIN PLAN FOR
SELECT
    *
FROM
    PELICULAS
WHERE
    ANYO > 1960;
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);
 
-- Resultado:

 /*
'Plan hash value: 2378278331'
' '
'-------------------------------------------------------------------------------'
'| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |'
'-------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |           |  7042 |  1567K|   102   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| PELICULAS |  7042 |  1567K|   102   (0)| 00:00:01 |'
'-------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("ANYO">1960)'
' '
'Note'
'-----'
'   - dynamic statistics used: dynamic sampling (level=2)'
*/
 
 -- Plano de ejecución de la consulta 4
EXPLAIN PLAN FOR
SELECT
    *
FROM
    PELICULAS
WHERE
    ANYO <> 1960;
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);
 
-- Resultado:

 /*
'Plan hash value: 2378278331'
' '
'-------------------------------------------------------------------------------'
'| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |'
'-------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |           | 11170 |  2487K|   102   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| PELICULAS | 11170 |  2487K|   102   (0)| 00:00:01 |'
'-------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("ANYO"<>1960)'
' '
'Note'
'-----'
'   - dynamic statistics used: dynamic sampling (level=2)'
*/
 
 -- Creamos estadísticas
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'PELICULAS',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;
 

-- Volver a obtener plano de ejecución
-- Resultado CONSULTA 1:

 /*
'Plan hash value: 2378278331'
' '
'-------------------------------------------------------------------------------'
'| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |'
'-------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |           |    89 | 18690 |   102   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| PELICULAS |    89 | 18690 |   102   (0)| 00:00:01 |'
'-------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("ANYO"=1960)'
' '
'Note'
'-----'
'   - SQL plan baseline "SQL_PLAN_1jdpsryxmw9bbd6672d41" used for this statement'
*/
 
 -- Resultado CONSULTA 2:

 /*
'Plan hash value: 2378278331'
' '
'-------------------------------------------------------------------------------'
'| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |'
'-------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |           |  3989 |   818K|   102   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| PELICULAS |  3989 |   818K|   102   (0)| 00:00:01 |'
'-------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("ANYO"<1960)'
' '
'Note'
'-----'
'   - SQL plan baseline "SQL_PLAN_311qg5amb8st0d6672d41" used for this statement'
*/
 
 -- Resultado CONSULTA 3:

 /*
'Plan hash value: 2378278331'
' '
'-------------------------------------------------------------------------------'
'| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |'
'-------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |           |  7105 |  1457K|   102   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| PELICULAS |  7105 |  1457K|   102   (0)| 00:00:01 |'
'-------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("ANYO">1960)'
' '
*/
 
 -- Resultado CONSULTA 4:

 /*
'Plan hash value: 2378278331'
' '
'-------------------------------------------------------------------------------'
'| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |'
'-------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |           | 11093 |  2274K|   102   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| PELICULAS | 11093 |  2274K|   102   (0)| 00:00:01 |'
'-------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("ANYO"<>1960)'
' '
*/
 
 -- Conclusiones: Cambios respecto a los planes anteriores sin estadísticas

 /*
La principal diferencia entre las consultas con y sin estadísticas es la 
precisión de las estimaciones de filas y bytes. Con estadísticas, el optimizador 
puede hacer estimaciones más precisas, lo que puede llevar a una mejor selección 
del plan de ejecución. Sin estadísticas, el optimizador debe recurrir al 
muestreo dinámico para recopilar datos en tiempo de ejecución, lo que puede 
resultar en estimaciones menos precisas.
*/
 
 -- Ejercicio 4
DROP TABLE ACTORES;
INSERT INTO ACTORES
    SELECT
        *
    FROM
        GIISGBD.ACTORES_DATOS1;
SELECT
    *
FROM
    ACTORES
WHERE
    SEXO = 'H';
SELECT
    COUNT(*)
FROM
    ACTORES
WHERE
    SEXO = 'H';
 
-- Generar les estad�stiques adequades (per a les taules que intervenen en les consultes).
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTORES',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;
 

-- Obtenir el pla d'execuci� d'ambdues consultes.
-- Consulta 1. Plano de ejecuci�n.
EXPLAIN PLAN FOR
SELECT
    *
FROM
    ACTORES
WHERE
    SEXO='H';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);
 /*
Plan hash value: 2765877494
 
-----------------------------------------------------------------------------
| Id  | Operation         | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |         |  1172 |   123K|    13   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| ACTORES |  1172 |   123K|    13   (0)| 00:00:01 |
-----------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("SEXO"='H')
 
Note
-----
   - SQL plan baseline "SQL_PLAN_5sagc315vquw0c4135987" used for this statement
*/
 
 -- Consulta 2. Plano de ejecuci�n.
EXPLAIN PLAN FOR
SELECT
    COUNT(*)
FROM
    ACTORES
WHERE
    SEXO='H';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);
 /*
Plan hash value: 3398582430
 
------------------------------------------------------------------------------
| Id  | Operation          | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |         |     1 |     2 |    13   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE    |         |     1 |     2 |            |          |
|*  2 |   TABLE ACCESS FULL| ACTORES |  1172 |  2344 |    13   (0)| 00:00:01 |
------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - filter("SEXO"='H')
*/
 
 -- Crear l'índex de tipus B-Tree IDX_SEXO ON ACTORES (SEXO) i generar les estadístiques adequades.
CREATE INDEX IDX_SEXO ON ACTORES (SEXO);
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTORES',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;
 

-- Tornar a obtenir el pla d'execució de les consultes.
-- Consulta 1. Plano de ejecución.
EXPLAIN PLAN FOR
SELECT
    *
FROM
    ACTORES
WHERE
    SEXO='H';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);
 
-- Resultado:

 /*
'Plan hash value: 2765877494'
' '
'-----------------------------------------------------------------------------'
'| Id  | Operation         | Name    | Rows  | Bytes | Cost (%CPU)| Time     |'
'-----------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |         |  1382 |   145K|    13   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| ACTORES |  1382 |   145K|    13   (0)| 00:00:01 |'
'-----------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("SEXO"='H')'
' '
'Note'
'-----'
'   - SQL plan baseline "SQL_PLAN_5sagc315vquw0c4135987" used for this statement'
*/
 
 -- Consulta 2. Plano de ejecución.
EXPLAIN PLAN FOR
SELECT
    COUNT(*)
FROM
    ACTORES
WHERE
    SEXO='H';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);
 
-- Resultado:

 /*
'Plan hash value: 3805308972'
' '
'------------------------------------------------------------------------------'
'| Id  | Operation         | Name     | Rows  | Bytes | Cost (%CPU)| Time     |'
'------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |          |     1 |     2 |     3   (0)| 00:00:01 |'
'|   1 |  SORT AGGREGATE   |          |     1 |     2 |            |          |'
'|*  2 |   INDEX RANGE SCAN| IDX_SEXO |  1382 |  2764 |     3   (0)| 00:00:01 |'
'------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   2 - access("SEXO"='H')'
*/
 
 -- Eliminar l'índex creat en el pas 3, i crear un nou índex sobre el mateix camp de la mateixa
-- taula, però aquesta vegada de tipus BITMAP, generant de nou les estadístiques adequades.
DROP INDEX IDX_SEXO;
CREATE BITMAP INDEX IDX_SEXO ON ACTORES (SEXO);
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTORES',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;
 

-- Tornar a obtenir el pla d'execució de les consultes.
-- Consulta 1. Plano de ejecución.
EXPLAIN PLAN FOR
SELECT
    *
FROM
    ACTORES
WHERE
    SEXO='H';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);
 
-- Resultado:

 /*
'Plan hash value: 2765877494'
' '
'-----------------------------------------------------------------------------'
'| Id  | Operation         | Name    | Rows  | Bytes | Cost (%CPU)| Time     |'
'-----------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT  |         |  1382 |   145K|    13   (0)| 00:00:01 |'
'|*  1 |  TABLE ACCESS FULL| ACTORES |  1382 |   145K|    13   (0)| 00:00:01 |'
'-----------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - filter("SEXO"='H')'
' '
'Note'
'-----'
'   - SQL plan baseline "SQL_PLAN_5sagc315vquw0c4135987" used for this statement'
*/
 
 -- Consulta 2. Plano de ejecución.
EXPLAIN PLAN FOR
SELECT
    COUNT(*)
FROM
    ACTORES
WHERE
    SEXO='H';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);
 
-- Resultado:

 /*
'Plan hash value: 2453959698'
' '
'------------------------------------------------------------------------------------------'
'| Id  | Operation                     | Name     | Rows  | Bytes | Cost (%CPU)| Time     |'
'------------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT              |          |     1 |     2 |     1   (0)| 00:00:01 |'
'|   1 |  SORT AGGREGATE               |          |     1 |     2 |            |          |'
'|   2 |   BITMAP CONVERSION COUNT     |          |  1382 |  2764 |     1   (0)| 00:00:01 |'
'|*  3 |    BITMAP INDEX FAST FULL SCAN| IDX_SEXO |       |       |            |          |'
'------------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   3 - filter("SEXO"='H')'
*/
 
 -- Diferencias y conclusiones:

 /*
Índice B-Tree: Es más eficiente para consultas que requieren acceso a un rango de 
valores o para consultas que necesitan acceder a filas individuales rápidamente. 

Índice Bitmap: Es más eficiente para consultas que implican operaciones de 
agregación o que tienen condiciones de igualdad en columnas con baja cardinalidad. 
*/
 
 -- Eliminar l'índex creat.
DROP INDEX IDX_SEXO;
 
-- Ejercicio 5
-- Copiamos tablas de GIISGBD A NUESTRO LOCAL:
CREATE TABLE ACTORES_BASE AS
    SELECT
        *
    FROM
        GIISGBD.ACTORES_BASE;

CREATE TABLE PELICULAS_BASE AS
    SELECT
        *
    FROM
        GIISGBD.PELICULAS_BASE;

CREATE TABLE ACTUACION_BASE AS
    SELECT
        *
    FROM
        GIISGBD.ACTUACION_BASE;


--Consultas a analizar
SELECT
    A.NOM,
    A.SEXO
FROM
    GIISGBD.ACTORES_BASE   A
WHERE
    EXISTS (
        SELECT
            *
        FROM
            GIISGBD.PELICULAS_BASE P,
            GIISGBD.ACTUACION_BASE ACT
        WHERE
            P.OID = ACT.PELI
            AND P.ANYO = 1980
            AND A.OID = ACT.ACTOR
    );
SELECT
    A.NOM,
    A.SEXO
FROM
    GIISGBD.ACTORES_BASE   A
WHERE
    A.OID IN (
        SELECT
            ACT.ACTOR
        FROM
            GIISGBD.PELICULAS_BASE P,
            GIISGBD.ACTUACION_BASE ACT
        WHERE
            P.OID = ACT.PELI
            AND P.ANYO = 1980
    );
SELECT
    A.NOM,
    A.SEXO
FROM
    GIISGBD.ACTORES_BASE   A
WHERE
    A.OID = ANY (
        SELECT
            ACT.ACTOR
        FROM
            GIISGBD.PELICULAS_BASE P,
            GIISGBD.ACTUACION_BASE ACT
        WHERE
            P.OID = ACT.PELI
            AND P.ANYO = 1980
    );
SELECT
    DISTINCT A.NOM,
    A.SEXO
FROM
    GIISGBD.PELICULAS_BASE P,
    GIISGBD.ACTUACION_BASE ACT,
    GIISGBD.ACTORES_BASE   A
WHERE
    P.OID = ACT.PELI
    AND A.OID = ACT.ACTOR
    AND P.ANYO = 1980;

-- Generar les estadístiques adequades (per a les taules que intervenen en les consultes). 
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTORES_BASE',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;

-- Obtenir el pla d'execució de les 4 consultes. 
-- Consulta 1. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA1'
    FOR
    SELECT
        A.NOM,
        A.SEXO
    FROM
        ACTORES_BASE   A
    WHERE
        EXISTS (
            SELECT
                *
            FROM
                PELICULAS_BASE P,
                ACTUACION_BASE ACT
            WHERE
                P.OID = ACT.PELI
                AND P.ANYO = 1980
                AND A.OID = ACT.ACTOR
        );
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 2277454862'
' '
'---------------------------------------------------------------------------------------'
'| Id  | Operation            | Name           | Rows  | Bytes | Cost (%CPU)| Time     |'
'---------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT     |                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|*  1 |  HASH JOIN RIGHT SEMI|                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|   2 |   VIEW               | VW_SQ_1        | 14478 |   183K|  6531   (1)| 00:00:01 |'
'|*  3 |    HASH JOIN         |                | 14478 |   311K|  6531   (1)| 00:00:01 |'
'|*  4 |     TABLE ACCESS FULL| PELICULAS_BASE |  1409 | 14090 |  1193   (1)| 00:00:01 |'
'|   5 |     TABLE ACCESS FULL| ACTUACION_BASE |  1196K|    13M|  5335   (1)| 00:00:01 |'
'|   6 |   TABLE ACCESS FULL  | ACTORES_BASE   |   321K|    33M|  1399   (1)| 00:00:01 |'
'---------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ITEM_1")'
'   3 - access("P"."OID"="ACT"."PELI")'
'   4 - filter("P"."ANYO"=1980)'
' '
*/

-- Consulta 2. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA2'
    FOR
    SELECT
        A.NOM,
        A.SEXO
    FROM
        ACTORES_BASE   A
    WHERE
        A.OID IN (
            SELECT
                ACT.ACTOR
            FROM
                PELICULAS_BASE P,
                ACTUACION_BASE ACT
            WHERE
                P.OID = ACT.PELI
            AND P.ANYO = 1980
        );
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 1830521352'
' '
'---------------------------------------------------------------------------------------'
'| Id  | Operation            | Name           | Rows  | Bytes | Cost (%CPU)| Time     |'
'---------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT     |                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|*  1 |  HASH JOIN RIGHT SEMI|                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|   2 |   VIEW               | VW_NSO_1       | 14478 |   183K|  6531   (1)| 00:00:01 |'
'|*  3 |    HASH JOIN         |                | 14478 |   311K|  6531   (1)| 00:00:01 |'
'|*  4 |     TABLE ACCESS FULL| PELICULAS_BASE |  1409 | 14090 |  1193   (1)| 00:00:01 |'
'|   5 |     TABLE ACCESS FULL| ACTUACION_BASE |  1196K|    13M|  5335   (1)| 00:00:01 |'
'|   6 |   TABLE ACCESS FULL  | ACTORES_BASE   |   321K|    33M|  1399   (1)| 00:00:01 |'
'---------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ACTOR")'
'   3 - access("P"."OID"="ACT"."PELI")'
'   4 - filter("P"."ANYO"=1980)'
' '
*/

-- Consulta 3. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA3'
    FOR
    SELECT
        A.NOM,
        A.SEXO
    FROM
        ACTORES_BASE   A
    WHERE
        A.OID = ANY (
            SELECT
                ACT.ACTOR
            FROM
                PELICULAS_BASE P,
                ACTUACION_BASE ACT
            WHERE
                P.OID = ACT.PELI
            AND P.ANYO = 1980
        );
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 1830521352'
' '
'---------------------------------------------------------------------------------------'
'| Id  | Operation            | Name           | Rows  | Bytes | Cost (%CPU)| Time     |'
'---------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT     |                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|*  1 |  HASH JOIN RIGHT SEMI|                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|   2 |   VIEW               | VW_NSO_1       | 14478 |   183K|  6531   (1)| 00:00:01 |'
'|*  3 |    HASH JOIN         |                | 14478 |   311K|  6531   (1)| 00:00:01 |'
'|*  4 |     TABLE ACCESS FULL| PELICULAS_BASE |  1409 | 14090 |  1193   (1)| 00:00:01 |'
'|   5 |     TABLE ACCESS FULL| ACTUACION_BASE |  1196K|    13M|  5335   (1)| 00:00:01 |'
'|   6 |   TABLE ACCESS FULL  | ACTORES_BASE   |   321K|    33M|  1399   (1)| 00:00:01 |'
'---------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ACTOR")'
'   3 - access("P"."OID"="ACT"."PELI")'
'   4 - filter("P"."ANYO"=1980)'
' '
*/

-- Consulta 4. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA4'
    FOR
    SELECT
        DISTINCT
        A.NOM,
        A.SEXO
    FROM
        PELICULAS_BASE P,
        ACTUACION_BASE ACT,
        ACTORES_BASE   A
    WHERE
        P.OID = ACT.PELI
        AND A.OID = ACT.ACTOR
        AND P.ANYO = 1980;
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 1022368436'
' '
'-----------------------------------------------------------------------------------------------'
'| Id  | Operation            | Name           | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |'
'-----------------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT     |                | 14365 |  1837K|       |  8355   (1)| 00:00:01 |'
'|   1 |  HASH UNIQUE         |                | 14365 |  1837K|  2064K|  8355   (1)| 00:00:01 |'
'|*  2 |   HASH JOIN          |                | 14365 |  1837K|       |  7931   (1)| 00:00:01 |'
'|*  3 |    HASH JOIN         |                | 14478 |   311K|       |  6531   (1)| 00:00:01 |'
'|*  4 |     TABLE ACCESS FULL| PELICULAS_BASE |  1409 | 14090 |       |  1193   (1)| 00:00:01 |'
'|   5 |     TABLE ACCESS FULL| ACTUACION_BASE |  1196K|    13M|       |  5335   (1)| 00:00:01 |'
'|   6 |    TABLE ACCESS FULL | ACTORES_BASE   |   321K|    33M|       |  1399   (1)| 00:00:01 |'
'-----------------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   2 - access("A"."OID"="ACT"."ACTOR")'
'   3 - access("P"."OID"="ACT"."PELI")'
'   4 - filter("P"."ANYO"=1980)'
' '
*/

-- Diferencias y conclusiones:
/*
Similitudes:
- Todas las consultas utilizan operaciones de HASH JOIN para unir las tablas PELICULAS_BASE, ACTUACION_BASE y ACTORES_BASE.
- Las cuatro consultas realizan un TABLE ACCESS FULL en las tres tablas, indicando que no se utilizan índices para estas consultas.
- Los costos de las consultas son muy similares, con valores alrededor de 7931, reflejando la complejidad similar de las operaciones.

Diferencias:
- La consulta 4 utiliza una operación adicional de HASH UNIQUE para eliminar duplicados, ya que incluye la cláusula DISTINCT.
- Las consultas 2 y 3 tienen el mismo Plan hash value, indicando que Oracle ha generado el mismo plan de ejecución para estas dos consultas.

Causas:
- Las similitudes se deben a que las consultas son conceptualmente idénticas y Oracle optimiza las consultas de manera similar.
- Las diferencias en la consulta 4 se deben a la necesidad de eliminar duplicados con DISTINCT.
- El uso de HASH JOIN y TABLE ACCESS FULL indica que no hay índices adecuados para las columnas utilizadas en las condiciones de las
consultas, o que Oracle ha determinado que el acceso completo a las tablas es más eficiente en este caso.
*/

-- Canviar el filtre del camp P.ANYO en totes les consultes al valor 2000. Obtenir de nou els 
-- plans d'execució de les 4 consultes.

-- Consulta 1. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA1'
    FOR
    SELECT
        A.NOM,
        A.SEXO
    FROM
        ACTORES_BASE   A
    WHERE
        EXISTS (
            SELECT
                *
            FROM
                PELICULAS_BASE P,
                ACTUACION_BASE ACT
            WHERE
                P.OID = ACT.PELI
                AND P.ANYO = 2000
                AND A.OID = ACT.ACTOR
        );
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 2277454862'
' '
'---------------------------------------------------------------------------------------'
'| Id  | Operation            | Name           | Rows  | Bytes | Cost (%CPU)| Time     |'
'---------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT     |                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|*  1 |  HASH JOIN RIGHT SEMI|                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|   2 |   VIEW               | VW_SQ_1        | 14478 |   183K|  6531   (1)| 00:00:01 |'
'|*  3 |    HASH JOIN         |                | 14478 |   311K|  6531   (1)| 00:00:01 |'
'|*  4 |     TABLE ACCESS FULL| PELICULAS_BASE |  1409 | 14090 |  1193   (1)| 00:00:01 |'
'|   5 |     TABLE ACCESS FULL| ACTUACION_BASE |  1196K|    13M|  5335   (1)| 00:00:01 |'
'|   6 |   TABLE ACCESS FULL  | ACTORES_BASE   |   321K|    33M|  1399   (1)| 00:00:01 |'
'---------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ITEM_1")'
'   3 - access("P"."OID"="ACT"."PELI")'
'   4 - filter("P"."ANYO"=2000)'
*/

-- Consulta 2. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA2'
    FOR
    SELECT
        A.NOM,
        A.SEXO
    FROM
        ACTORES_BASE   A
    WHERE
        A.OID IN (
            SELECT
                ACT.ACTOR
            FROM
                PELICULAS_BASE P,
                ACTUACION_BASE ACT
            WHERE
                P.OID = ACT.PELI
            AND P.ANYO = 2000
        );
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 1830521352'
' '
'---------------------------------------------------------------------------------------'
'| Id  | Operation            | Name           | Rows  | Bytes | Cost (%CPU)| Time     |'
'---------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT     |                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|*  1 |  HASH JOIN RIGHT SEMI|                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|   2 |   VIEW               | VW_NSO_1       | 14478 |   183K|  6531   (1)| 00:00:01 |'
'|*  3 |    HASH JOIN         |                | 14478 |   311K|  6531   (1)| 00:00:01 |'
'|*  4 |     TABLE ACCESS FULL| PELICULAS_BASE |  1409 | 14090 |  1193   (1)| 00:00:01 |'
'|   5 |     TABLE ACCESS FULL| ACTUACION_BASE |  1196K|    13M|  5335   (1)| 00:00:01 |'
'|   6 |   TABLE ACCESS FULL  | ACTORES_BASE   |   321K|    33M|  1399   (1)| 00:00:01 |'
'---------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ACTOR")'
'   3 - access("P"."OID"="ACT"."PELI")'
'   4 - filter("P"."ANYO"=2000)'
*/

-- Consulta 3. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA3'
    FOR
    SELECT
        A.NOM,
        A.SEXO
    FROM
        ACTORES_BASE   A
    WHERE
        A.OID = ANY (
            SELECT
                ACT.ACTOR
            FROM
                PELICULAS_BASE P,
                ACTUACION_BASE ACT
            WHERE
                P.OID = ACT.PELI
            AND P.ANYO = 2000
        );
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 1830521352'
' '
'---------------------------------------------------------------------------------------'
'| Id  | Operation            | Name           | Rows  | Bytes | Cost (%CPU)| Time     |'
'---------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT     |                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|*  1 |  HASH JOIN RIGHT SEMI|                | 14478 |  1724K|  7931   (1)| 00:00:01 |'
'|   2 |   VIEW               | VW_NSO_1       | 14478 |   183K|  6531   (1)| 00:00:01 |'
'|*  3 |    HASH JOIN         |                | 14478 |   311K|  6531   (1)| 00:00:01 |'
'|*  4 |     TABLE ACCESS FULL| PELICULAS_BASE |  1409 | 14090 |  1193   (1)| 00:00:01 |'
'|   5 |     TABLE ACCESS FULL| ACTUACION_BASE |  1196K|    13M|  5335   (1)| 00:00:01 |'
'|   6 |   TABLE ACCESS FULL  | ACTORES_BASE   |   321K|    33M|  1399   (1)| 00:00:01 |'
'---------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ACTOR")'
'   3 - access("P"."OID"="ACT"."PELI")'
'   4 - filter("P"."ANYO"=2000)'
*/

-- Consulta 4. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA4'
    FOR
    SELECT
        DISTINCT
        A.NOM,
        A.SEXO
    FROM
        PELICULAS_BASE P,
        ACTUACION_BASE ACT,
        ACTORES_BASE   A
    WHERE
        P.OID = ACT.PELI
        AND A.OID = ACT.ACTOR
        AND P.ANYO = 2000;
SELECT  
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 1022368436'
' '
'-----------------------------------------------------------------------------------------------'
'| Id  | Operation            | Name           | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |'
'-----------------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT     |                | 14365 |  1837K|       |  8355   (1)| 00:00:01 |'
'|   1 |  HASH UNIQUE         |                | 14365 |  1837K|  2064K|  8355   (1)| 00:00:01 |'
'|*  2 |   HASH JOIN          |                | 14365 |  1837K|       |  7931   (1)| 00:00:01 |'
'|*  3 |    HASH JOIN         |                | 14478 |   311K|       |  6531   (1)| 00:00:01 |'
'|*  4 |     TABLE ACCESS FULL| PELICULAS_BASE |  1409 | 14090 |       |  1193   (1)| 00:00:01 |'
'|   5 |     TABLE ACCESS FULL| ACTUACION_BASE |  1196K|    13M|       |  5335   (1)| 00:00:01 |'
'|   6 |    TABLE ACCESS FULL | ACTORES_BASE   |   321K|    33M|       |  1399   (1)| 00:00:01 |'
'-----------------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   2 - access("A"."OID"="ACT"."ACTOR")'
'   3 - access("P"."OID"="ACT"."PELI")'
'   4 - filter("P"."ANYO"=2000)'
*/

-- Diferencias y conclusiones:
/*
Similitudes:
- Los planes de ejecución siguen utilizando HASH JOIN y TABLE ACCESS FULL para unir y acceder a las tablas PELICULAS_BASE, ACTUACION_BASE y ACTORES_BASE.
- Los costos de las consultas son similares a los anteriores, con valores alrededor de 7931, reflejando una complejidad similar en las operaciones.

Diferencias:
- No se observan diferencias significativas en los planes de ejecución al cambiar el año a 2000. Los planes de ejecución y los costos permanecen prácticamente iguales.

Motivo:
- La razón principal es que el cambio en el valor del año no afecta significativamente la estructura de los datos ni la forma en que Oracle optimiza las consultas. 
*/

-- Ejercicio 6
-- Vaciamos las tablas principales
TRUNCATE TABLE ACTORES;
TRUNCATE TABLE PELICULAS;
TRUNCATE TABLE ACTUACION;
-- Copiamos los datos de las tablas de GIISGBD_DATOS1 a nuestras tablas locales
INSERT INTO ACTORES
    SELECT
        *
    FROM
        GIISGBD.ACTORES_DATOS1;

INSERT INTO PELICULAS
    SELECT
        *
    FROM
        GIISGBD.PELICULAS_DATOS1;

INSERT INTO ACTUACION
    SELECT
        *
    FROM
        GIISGBD.ACTUACION_DATOS1;

-- Borramos estadísticas
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTORES'
    );
    DBMS_STATS.DELETE_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'PELICULAS'
    );
    DBMS_STATS.DELETE_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTUACION'
    );
END;

-- Consultas a analizar:
SELECT
    A.NOM,
    P.TITULO,
    ACT.PAPEL,
    P.ANYO
FROM
    ACTORES   A,
    PELICULAS P,
    ACTUACION ACT
WHERE
    A.OID = ACT.ACTOR
    AND P.OID = ACT.PELI
    AND SEXO = 'H'
    AND P.TITULO LIKE 'Lost%';

SELECT
    A.NOM,
    P.TITULO,
    ACT.PAPEL,
    P.ANYO
FROM
    ACTORES_BASE   A,
    PELICULAS_BASE P,
    ACTUACION_BASE ACT
WHERE
    A.OID = ACT.ACTOR
    AND P.OID = ACT.PELI
    AND SEXO = 'H'
    AND P.TITULO LIKE 'Lost%';

SELECT
    A.NOM,
    P.TITULO,
    ACT.PAPEL,
    P.ANYO
FROM
    ACTORES_BASE   A,
    PELICULAS_BASE P,
    ACTUACION_BASE ACT
WHERE
    A.OID = ACT.ACTOR
    AND P.OID = ACT.PELI
    AND SEXO = 'H'
    AND P.TITULO LIKE '%Empire%';
-- Generamos estadísticas para las tablas
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTORES',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'PELICULAS',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTUACION',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;

-- Obtenemos los planes de ejecución de las consultas
-- Consulta 1. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA1'
    FOR
    SELECT
        A.NOM,
        P.TITULO,
        ACT.PAPEL,
        P.ANYO
    FROM
        ACTORES   A,
        PELICULAS P,
        ACTUACION ACT
    WHERE
        A.OID = ACT.ACTOR
        AND P.OID = ACT.PELI
        AND SEXO = 'H'
        AND P.TITULO LIKE 'Lost%';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 3398256115'
' '
'-----------------------------------------------------------------------------------'
'| Id  | Operation             | Name      | Rows  | Bytes | Cost (%CPU)| Time     |'
'-----------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT      |           |    14 |  6006 |    29   (0)| 00:00:01 |'
'|*  1 |  HASH JOIN            |           |    14 |  6006 |    29   (0)| 00:00:01 |'
'|   2 |   TABLE ACCESS FULL   | ACTUACION |  2500 |   270K|    13   (0)| 00:00:01 |'
'|   3 |   MERGE JOIN CARTESIAN|           |  1382 |   429K|    16   (0)| 00:00:01 |'
'|*  4 |    TABLE ACCESS FULL  | PELICULAS |     1 |   210 |     3   (0)| 00:00:01 |'
'|   5 |    BUFFER SORT        |           |  1382 |   145K|    13   (0)| 00:00:01 |'
'|*  6 |     TABLE ACCESS FULL | ACTORES   |  1382 |   145K|    13   (0)| 00:00:01 |'
'-----------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ACT"."ACTOR" AND "P"."OID"="ACT"."PELI")'
'   4 - filter("P"."TITULO" LIKE 'Lost%')'
'   6 - filter("SEXO"='H')'
*/

-- Consulta 2. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA2'
    FOR
    SELECT
        A.NOM,
        P.TITULO,
        ACT.PAPEL,
        P.ANYO
    FROM
        ACTORES_BASE   A,
        PELICULAS_BASE P,
        ACTUACION_BASE ACT
    WHERE
        A.OID = ACT.ACTOR
        AND P.OID = ACT.PELI
        AND SEXO = 'H'
        AND P.TITULO LIKE 'Lost%';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Resultado:
/*
'Plan hash value: 3843852525'
' '
'--------------------------------------------------------------------------------------'
'| Id  | Operation           | Name           | Rows  | Bytes | Cost (%CPU)| Time     |'
'--------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT    |                |     6 |  2586 |  7933   (1)| 00:00:01 |'
'|*  1 |  HASH JOIN          |                |     6 |  2586 |  7933   (1)| 00:00:01 |'
'|*  2 |   HASH JOIN         |                |    11 |  3542 |  6532   (1)| 00:00:01 |'
'|*  3 |    TABLE ACCESS FULL| PELICULAS_BASE |     1 |   210 |  1193   (1)| 00:00:01 |'
'|   4 |    TABLE ACCESS FULL| ACTUACION_BASE |  1196K|   127M|  5336   (1)| 00:00:01 |'
'|*  5 |   TABLE ACCESS FULL | ACTORES_BASE   |   160K|    16M|  1401   (1)| 00:00:01 |'
'--------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ACT"."ACTOR")'
'   2 - access("P"."OID"="ACT"."PELI")'
'   3 - filter("P"."TITULO" LIKE 'Lost%')'
'   5 - filter("SEXO"='H')'
' '
'Note'
'-----'
'   - SQL plan baseline "SQL_PLAN_7mvm5unxcdxwk55478034" used for this statement'
*/

-- Consulta 3. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA3'
    FOR
    SELECT
        A.NOM,
        P.TITULO,
        ACT.PAPEL,
        P.ANYO
    FROM
        ACTORES_BASE   A,
        PELICULAS_BASE P,
        ACTUACION_BASE ACT
    WHERE
        A.OID = ACT.ACTOR
        AND P.OID = ACT.PELI
        AND SEXO = 'H'
        AND P.TITULO LIKE '%Empire%';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);
    
-- Resultado:
/*
'Plan hash value: 2991472254'
' '
'----------------------------------------------------------------------------------------------'
'| Id  | Operation           | Name           | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |'
'----------------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT    |                | 36272 |    14M|       | 10007   (1)| 00:00:01 |'
'|*  1 |  HASH JOIN          |                | 36272 |    14M|    18M| 10007   (1)| 00:00:01 |'
'|*  2 |   TABLE ACCESS FULL | ACTORES_BASE   |   160K|    16M|       |  1401   (1)| 00:00:01 |'
'|*  3 |   HASH JOIN         |                | 73115 |    22M|       |  6532   (1)| 00:00:01 |'
'|*  4 |    TABLE ACCESS FULL| PELICULAS_BASE |  7116 |  1459K|       |  1193   (1)| 00:00:01 |'
'|   5 |    TABLE ACCESS FULL| ACTUACION_BASE |  1196K|   127M|       |  5336   (1)| 00:00:01 |'
'----------------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ACT"."ACTOR")'
'   2 - filter("SEXO"='H')'
'   3 - access("P"."OID"="ACT"."PELI")'
'   4 - filter("P"."TITULO" LIKE '%Empire%')'
*/

-- Proposar les millores necessàries perquè les consultes s'executen de manera més eficient. 
/*
Crear índices sobre las columnas relevantes:
- Crear índices sobre las columnas OID de las tablas ACTORES_BASE, PELICULAS_BASE y ACTUACION_BASE.
- Crear índices sobre las columnas SEXO de la taula ACTORES_BASE.
- Crear índices sobre las columnas TITULO de la taula PELICULAS_BASE.
*/

-- Crear índexs sobre les columnes rellevants
CREATE INDEX IDX_ACTORES_OID ON ACTORES_BASE (OID);
CREATE INDEX IDX_PELICULAS_OID ON PELICULAS_BASE (OID);
CREATE INDEX IDX_ACTUACION_OID_ACTOR ON ACTUACION_BASE (ACTOR);
CREATE INDEX IDX_ACTUACION_OID_PELI ON ACTUACION_BASE (PELI);
CREATE INDEX IDX_ACTORES_SEXO ON ACTORES_BASE (SEXO);
CREATE INDEX IDX_PELICULAS_TITULO ON PELICULAS_BASE (TITULO);

-- Generar estadístiques per a les taules i els índexs
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'GIISGBD109', TABNAME => 'ACTORES_BASE', CASCADE => TRUE, FORCE => TRUE);
    DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'GIISGBD109', TABNAME => 'PELICULAS_BASE', CASCADE => TRUE, FORCE => TRUE);
    DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'GIISGBD109', TABNAME => 'ACTUACION_BASE', CASCADE => TRUE, FORCE => TRUE);
    DBMS_STATS.GATHER_INDEX_STATS(OWNNAME => 'GIISGBD109', INDNAME => 'IDX_ACTORES_OID', FORCE => TRUE);
    DBMS_STATS.GATHER_INDEX_STATS(OWNNAME => 'GIISGBD109', INDNAME => 'IDX_PELICULAS_OID', FORCE => TRUE);
    DBMS_STATS.GATHER_INDEX_STATS(OWNNAME => 'GIISGBD109', INDNAME => 'IDX_ACTUACION_OID_ACTOR', FORCE => TRUE);
    DBMS_STATS.GATHER_INDEX_STATS(OWNNAME => 'GIISGBD109', INDNAME => 'IDX_ACTUACION_OID_PELI', FORCE => TRUE);
    DBMS_STATS.GATHER_INDEX_STATS(OWNNAME => 'GIISGBD109', INDNAME => 'IDX_ACTORES_SEXO', FORCE => TRUE);
    DBMS_STATS.GATHER_INDEX_STATS(OWNNAME => 'GIISGBD109', INDNAME => 'IDX_PELICULAS_TITULO', FORCE => TRUE);
END;
/

-- Obtenir els plans d'execució de les consultes
-- Consulta 1. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA1'
    FOR
    SELECT
        A.NOM,
        P.TITULO,
        ACT.PAPEL,
        P.ANYO
    FROM
        ACTORES_BASE   A,
        PELICULAS_BASE P,
        ACTUACION_BASE ACT
    WHERE
        A.OID = ACT.ACTOR
        AND P.OID = ACT.PELI
        AND SEXO = 'H'
        AND P.TITULO LIKE 'Lost%';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Consulta 2. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA2'
    FOR
    SELECT
        A.NOM,
        P.TITULO,
        ACT.PAPEL,
        P.ANYO
    FROM
        ACTORES_BASE   A,
        PELICULAS_BASE P,
        ACTUACION_BASE ACT
    WHERE
        A.OID = ACT.ACTOR
        AND P.OID = ACT.PELI
        AND SEXO = 'H'
        AND P.TITULO LIKE 'Lost%';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- Consulta 3. Plano de ejecución.
EXPLAIN PLAN
    SET STATEMENT_ID = 'CONSULTA3'
    FOR
    SELECT
        A.NOM,
        P.TITULO,
        ACT.PAPEL,
        P.ANYO
    FROM
        ACTORES_BASE   A,
        PELICULAS_BASE P,
        ACTUACION_BASE ACT
    WHERE
        A.OID = ACT.ACTOR
        AND P.OID = ACT.PELI
        AND SEXO = 'H'
        AND P.TITULO LIKE '%Empire%';
SELECT
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY);

-- RESULTADOS:
--Consulta 1:
/*
'Plan hash value: 3843852525'
' '
'--------------------------------------------------------------------------------------'
'| Id  | Operation           | Name           | Rows  | Bytes | Cost (%CPU)| Time     |'
'--------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT    |                |     7 |  3017 |  7933   (1)| 00:00:01 |'
'|*  1 |  HASH JOIN          |                |     7 |  3017 |  7933   (1)| 00:00:01 |'
'|*  2 |   HASH JOIN         |                |    11 |  3542 |  6532   (1)| 00:00:01 |'
'|*  3 |    TABLE ACCESS FULL| PELICULAS_BASE |     1 |   210 |  1193   (1)| 00:00:01 |'
'|   4 |    TABLE ACCESS FULL| ACTUACION_BASE |  1196K|   127M|  5336   (1)| 00:00:01 |'
'|*  5 |   TABLE ACCESS FULL | ACTORES_BASE   |   202K|    21M|  1401   (1)| 00:00:01 |'
'--------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ACT"."ACTOR")'
'   2 - access("P"."OID"="ACT"."PELI")'
'   3 - filter("P"."TITULO" LIKE 'Lost%')'
'   5 - filter("SEXO"='H')'
' '
'Note'
'-----'
'   - SQL plan baseline "SQL_PLAN_7mvm5unxcdxwk55478034" used for this statement'
*/

--Consulta 2:
/*
'Plan hash value: 3843852525'
' '
'--------------------------------------------------------------------------------------'
'| Id  | Operation           | Name           | Rows  | Bytes | Cost (%CPU)| Time     |'
'--------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT    |                |     7 |  3017 |  7933   (1)| 00:00:01 |'
'|*  1 |  HASH JOIN          |                |     7 |  3017 |  7933   (1)| 00:00:01 |'
'|*  2 |   HASH JOIN         |                |    11 |  3542 |  6532   (1)| 00:00:01 |'
'|*  3 |    TABLE ACCESS FULL| PELICULAS_BASE |     1 |   210 |  1193   (1)| 00:00:01 |'
'|   4 |    TABLE ACCESS FULL| ACTUACION_BASE |  1196K|   127M|  5336   (1)| 00:00:01 |'
'|*  5 |   TABLE ACCESS FULL | ACTORES_BASE   |   202K|    21M|  1401   (1)| 00:00:01 |'
'--------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ACT"."ACTOR")'
'   2 - access("P"."OID"="ACT"."PELI")'
'   3 - filter("P"."TITULO" LIKE 'Lost%')'
'   5 - filter("SEXO"='H')'
' '
'Note'
'-----'
'   - SQL plan baseline "SQL_PLAN_7mvm5unxcdxwk55478034" used for this statement'
*/

--Consulta 3:
/*
'Plan hash value: 3843852525'
' '
'----------------------------------------------------------------------------------------------'
'| Id  | Operation           | Name           | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |'
'----------------------------------------------------------------------------------------------'
'|   0 | SELECT STATEMENT    |                | 45673 |    18M|       | 10246   (1)| 00:00:01 |'
'|*  1 |  HASH JOIN          |                | 45673 |    18M|    23M| 10246   (1)| 00:00:01 |'
'|*  2 |   HASH JOIN         |                | 73115 |    22M|       |  6532   (1)| 00:00:01 |'
'|*  3 |    TABLE ACCESS FULL| PELICULAS_BASE |  7116 |  1459K|       |  1193   (1)| 00:00:01 |'
'|   4 |    TABLE ACCESS FULL| ACTUACION_BASE |  1196K|   127M|       |  5336   (1)| 00:00:01 |'
'|*  5 |   TABLE ACCESS FULL | ACTORES_BASE   |   202K|    21M|       |  1401   (1)| 00:00:01 |'
'----------------------------------------------------------------------------------------------'
' '
'Predicate Information (identified by operation id):'
'---------------------------------------------------'
' '
'   1 - access("A"."OID"="ACT"."ACTOR")'
'   2 - access("P"."OID"="ACT"."PELI")'
'   3 - filter("P"."TITULO" LIKE '%Empire%')'
'   5 - filter("SEXO"='H')'
' '
'Note'
'-----'
'   - this is an adaptive plan'
*/

-- Eliminar las tablas:
DROP TABLE ACTORES;
DROP TABLE PELICULAS;
DROP TABLE ACTUACION;
DROP TABLE ACTORES_BASE;
DROP TABLE PELICULAS_BASE;
DROP TABLE ACTUACION_BASE;



