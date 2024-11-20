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


exec dbms_stats.gather_index_stats(ownname=>'GIISGBD109',indname=>'IDX_SEXO',FORCE =>TRUE);
exec dbms_stats.gather_index_stats(ownname=>'GIISGBD109',indname=>'IDX_ANYO',FORCE =>TRUE);

-- Comprobaciones
SELECT 
    table_name AS "Nom",
    num_rows AS "Nombre de files",
    blocks AS "Nombre de blocs",
    avg_row_len AS "Longitud mitjana dels registres"
FROM 
    user_tables
WHERE 
    table_name IN ('ACTORES', 'PELICULAS', 'ACTUACION');

SELECT 
    table_name AS "Nom de taula",
    column_name AS "Nom de columna",
    num_distinct AS "Quantitat de valors diferents",
    low_value AS "Valor mínim",
    high_value AS "Valor màxim",
    num_nulls AS "Nombre de nuls",
    avg_col_len AS "Longitud mitjana de la columna",
    histogram AS "Histograma"
FROM 
    user_tab_col_statistics
WHERE 
    table_name IN ('ACTORES', 'PELICULAS', 'ACTUACION');

SELECT 
    index_name AS "Nom",
    table_name AS "Taula",
    blevel AS "Profunditat",
    leaf_blocks AS "Blocs en les fulles",
    distinct_keys AS "Quantitat de claus diferents",
    avg_leaf_blocks_per_key AS "Mitjana de blocs fulla per clau",
    avg_data_blocks_per_key AS "Mitjana de blocs de dades per clau",
    clustering_factor AS "Factor de clustering",
    num_rows AS "Nombre de registres"
FROM 
    user_ind_statistics
WHERE 
    index_name IN ('IDX_SEXO', 'IDX_ANYO');

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
    table_name AS "Nom",
    num_rows AS "Nombre de files",
    blocks AS "Nombre de blocs",
    avg_row_len AS "Longitud mitjana dels registres"
FROM 
    user_tables
WHERE 
    table_name IN ('ACTORES', 'PELICULAS', 'ACTUACION');

-- Consultar información de las columnas
SELECT 
    table_name AS "Nom de taula",
    column_name AS "Nom de columna",
    num_distinct AS "Quantitat de valors diferents",
    low_value AS "Valor mínim",
    high_value AS "Valor màxim",
    num_nulls AS "Nombre de nuls",
    avg_col_len AS "Longitud mitjana de la columna",
    histogram AS "Histograma"
FROM 
    user_tab_col_statistics
WHERE 
    table_name IN ('ACTORES', 'PELICULAS', 'ACTUACION');

-- Consultar información de los índices
SELECT 
    index_name AS "Nom",
    table_name AS "Taula",
    blevel AS "Profunditat",
    leaf_blocks AS "Blocs en les fulles",
    distinct_keys AS "Quantitat de claus diferents",
    avg_leaf_blocks_per_key AS "Mitjana de blocs fulla per clau",
    avg_data_blocks_per_key AS "Mitjana de blocs de dades per clau",
    clustering_factor AS "Factor de clustering",
    num_rows AS "Nombre de registres"
FROM 
    user_ind_statistics
WHERE 
    index_name IN ('IDX_SEXO', 'IDX_ANYO');

-- Ejercicio 2:
-- Consulta a utilizar 1
SELECT *  
FROM PELICULAS  
WHERE ANYO > 1992; 
-- Consulta a utilizar 2
SELECT *  
FROM PELICULAS P, ACTUACION ACT  
WHERE P.OID = ACT.PELI  
AND ANYO > 1992; 
-- Consulta a utilizar 3
SELECT P.*  
FROM ACTORES A, ACTUACION X, PELICULAS P  
WHERE A.NOM = ’Loy, Myrna’  
AND A.OID = X.ACTOR  
AND P.OID = X.PELI;

-- PLANOS DE EJECUCIÓN:
-- Plano de ejecución de la consulta 1
EXPLAIN PLAN FOR
SELECT *
FROM PELICULAS
WHERE ANYO > 1992;

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

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

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

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

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

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
SELECT * FROM PELICULAS WHERE ANYO=1960; 
SELECT * FROM PELICULAS WHERE ANYO<1960; 
SELECT * FROM PELICULAS WHERE ANYO>1960; 
SELECT * FROM PELICULAS WHERE ANYO<>1960;

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
SELECT *
FROM PELICULAS
WHERE ANYO = 1960;

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

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
SELECT *
FROM PELICULAS
WHERE ANYO < 1960;

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

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
SELECT *
FROM PELICULAS
WHERE ANYO > 1960;

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

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
SELECT *
FROM PELICULAS
WHERE ANYO <> 1960;

SELECT * FROM table(DBMS_XPLAN.DISPLAY);

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
drop table actores;
insert into actores select * from giisgbd.actores_datos1;

SELECT * FROM ACTORES WHERE SEXO = 'H';
SELECT COUNT(*) FROM ACTORES WHERE SEXO = 'H';
-- Generar les estad�stiques adequades (per a les taules que intervenen en les consultes). 
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME=>'GIISGBD108',
        TABNAME=>'ACTORES',
        CASCADE=>TRUE,
        FORCE=>TRUE
    );
END;
-- Obtenir el pla d'execuci� d'ambdues consultes.
-- Consulta 1. Plano de ejecuci�n.
EXPLAIN PLAN FOR
SELECT *
FROM ACTORES
WHERE SEXO='H';

SELECT * FROM table(DBMS_XPLAN.DISPLAY);
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
SELECT COUNT(*)
FROM ACTORES
WHERE SEXO='H';

SELECT * FROM table(DBMS_XPLAN.DISPLAY);
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
