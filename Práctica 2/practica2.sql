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

BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'PELICULAS'
    );
END;

BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        OWNNAME=>'GIISGBD109',
        TABNAME=>'ACTUACION'
    );
END;

