Rem
Rem $Header: oraolap/admin/xoqeawmd.sql /st_rdbms_21/1 2021/03/10 19:56:04 apfwkr Exp $
Rem
Rem xoqeawmd.sql
Rem
Rem Copyright (c) 2015, 2021, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqeawmd.sql - downgrade script to revert to old object lengths
Rem
Rem    DESCRIPTION
Rem      Install the pre-12.2 object types for the 10.2 active catalog views
Rem      as a downgrade from a 12.2 installation.
Rem
Rem    NOTES
Rem      There is no way to alter an object type and shrink a column length
Rem      so it is necessary to re-install the object type and dependent active
Rem      catalog views.
Rem
Rem    BEGIN SQL_FILE_METADATA 
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqeawmd.sql 
Rem    SQL_SHIPPED_FILE: olap/admin/xoqeawmd.sql
Rem    SQL_PHASE: DOWNGRADE
Rem    SQL_STARTUP_MODE: NORMAL 
Rem    SQL_IGNORABLE_ERRORS: NONE 
Rem    SQL_CALLING_FILE: olap/admin/xoqe121.sql
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    apfwkr      03/09/21 - Backport cjohnson_bug-32531209 from main
Rem    cjohnson    02/25/21 - bug 32531209
Rem    jcarey      08/07/20 - Bug 31725025 - guard drops
Rem    jcarey      09/22/17 - Bug 25687751- AW lockdown
Rem    jcarey      03/27/17 - Bug 25684134 - better olap_on processing
Rem    dbardwel    01/12/15 - Bug 20315390 revert long identifier for downgrade
Rem

@@?/rdbms/admin/sqlsessstart.sql

exec sys.dbms_aw_internal.olap_script_start;

REM ADTs used by all views

DECLARE
obj_dne exception;
pragma exception_init(obj_dne, -4843);
BEGIN
execute immediate 'DROP TYPE olapsys.ALL_OLAP2_AW_METADATA_T';
EXCEPTION
  WHEN obj_dne THEN
     NULL;
END;
/
DECLARE
obj_dne exception;
pragma exception_init(obj_dne, -4843);
BEGIN
execute immediate 'DROP TYPE olapsys.ALL_OLAP2_AW_METADATA_O';
EXCEPTION
  WHEN obj_dne THEN
     NULL;
END;
/

REM The object definition for the table functions to use

CREATE OR REPLACE TYPE olapsys.ALL_OLAP2_AW_METADATA_O AS OBJECT (
 AWOWNER VARCHAR2(30),
 AWNAME VARCHAR2(30),
 AWOBJECT VARCHAR2(90),
 COL1 VARCHAR2(4000),
 COL2 VARCHAR2(4000),
 COL3 VARCHAR2(4000),
 COL4 VARCHAR2(4000),
 COL5 number,
 COL6 VARCHAR2(4000),
 COL7 VARCHAR2(4000),
 COL8 VARCHAR2(4000),
 COL9 VARCHAR2(4000),
 AWMDKEY NUMBER)
/

CREATE OR REPLACE TYPE olapsys.ALL_OLAP2_AW_METADATA_T AS TABLE OF ALL_OLAP2_AW_METADATA_O
/

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN

  BEGIN
  execute immediate 'drop view olapsys.all$olap2_aw_phys_obj_ext';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'drop view olapsys.all$olap2_aw_phys_obj_rel_obj';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'drop view olapsys.all$olap2_aw_map_hier_use';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate 'drop view olapsys.all$olap2_aw_map_lvl_use';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
END;
/

REM Need to drop views and synonyms due to Editioning object change in 12.1.0.1.0

REM ALL_OLAP2_AW_CATALOGS

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CATALOGS';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CATALOGS';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_CATALOGS AS
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.COL5 as CATALOG_ID,
       AW.COL1 as CATALOG_NAME,
       AW.COL4 as PARENT_CATALOG_NAME,
       AW.COL2 as DESCRIPTION
FROM
TABLE(CAST(SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T',
                       'ACTIVE_CATALOG ''ALL_CATALOGS'' ''ALL''',
                       'MEASURE AWOWNER FROM sys.awmd!CAT_AWOWNER
                        MEASURE AWNAME FROM sys.awmd!CAT_AWNAME
                        MEASURE COL5 FROM sys.awmd!CAT_CATALOG_ID 
                        MEASURE COL1 FROM sys.awmd!CAT_MEASFOLDERNAME
                        MEASURE COL2 FROM sys.awmd!CAT_MEASFOLDERDESC
                        MEASURE COL4 FROM sys.awmd!CAT_PARENTFOLDERNAME 
                        DIMENSION AWMDKEY FROM sys.awmd!AWMDKEY_CAT')
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/
GRANT SELECT ON olapsys.ALL$OLAP2_AW_CATALOGS to PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CATALOGS for olapsys.ALL$OLAP2_AW_CATALOGS
/


REM ALL_OLAP2_AW_CATALOG_MEASURES

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CATALOG_MEASURES';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CATALOG_MEASURES';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_CATALOG_MEASURES AS
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.COL5 as CATALOG_ID,
       AW.COL4 as CATALOG_NAME,
       AW.COL1 as ENTITY_OWNER,
       AW.COL2 as ENTITY_NAME,
       AW.COL3 as CHILD_ENTITY_NAME 
FROM
TABLE(CAST(SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T',
                       'ACTIVE_CATALOG ''ALL_CATALOG_MEASURES'' ''ALL''',
                       'MEASURE AWOWNER FROM sys.awmd!CATM_AWOWNER 
                        MEASURE AWNAME FROM sys.awmd!CATM_AWNAME
                        MEASURE COL5 FROM sys.awmd!CATM_CATALOG_ID
                        MEASURE COL1 FROM sys.awmd!CATM_AWOWNER
                        MEASURE COL2 FROM sys.awmd!CATM_CUBE_NAME
                        MEASURE COL3 FROM sys.awmd!CATM_MEASURE_NAME
                        MEASURE COL4 FROM sys.awmd!CATM_MEASFOLDERNAME
                        DIMENSION AWMDKEY FROM sys.awmd!AWMDKEY_CATM')
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/
GRANT SELECT ON olapsys.ALL$OLAP2_AW_CATALOG_MEASURES to PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CATALOG_MEASURES for olapsys.ALL$OLAP2_AW_CATALOG_MEASURES
/


REM ALL_OLAP2_AW_PHYS_OBJ

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_PHYS_OBJ';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_PHYS_OBJ';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_PHYS_OBJ AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_OBJECT_NAME,
       AW.COL1 as AW_OBJECT_TYPE,
       AW.COL2 as AW_OBJECT_DATATYPE 
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_OLAP2_AW_PHYS_OBJ'' ''ALL''',
                       'MEASURE AWOWNER FROM sys.awmd!AWOWNER
                        MEASURE AWNAME FROM sys.awmd!AWNAME
                        MEASURE AWOBJECT FROM sys.awmd!AWOBJECT
                        MEASURE COL1 FROM sys.awmd!AWOBJECTTYPE
                        MEASURE COL2 FROM sys.awmd!AWOBJECTDATATYPE
                        DIMENSION AWMDKEY FROM sys.awmd!AWMDKEY')
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_PHYS_OBJ TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_PHYS_OBJ for olapsys.ALL$OLAP2_AW_PHYS_OBJ
/


REM ALL_OLAP2_AW_PHYS_OBJ_PROP

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_PHYS_OBJ_PROP';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_PHYS_OBJ_PROP';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/


CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_PHYS_OBJ_PROP AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_OBJECT_NAME,
       AW.COL1 as AW_PROP_NAME,
       AW.COL2 as AW_PROP_VALUE 
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_OLAP2_AW_PHYS_OBJ_PROP'' ''ALL''',
                         'MEASURE AWOWNER FROM sys.awmd!PROPS_AWOWNER
                          MEASURE AWNAME FROM sys.awmd!PROPS_AWNAME
                          MEASURE AWOBJECT FROM sys.awmd!PROPS_AWOBJECT
                          MEASURE COL1 FROM sys.awmd!PROPS_AWOBJECTPROPNAME
                          MEASURE COL2 FROM sys.awmd!PROPS_AWOBJECTPROPVALUE
                          DIMENSION AWMDKEY FROM sys.awmd!AWMDKEY_PROPS')
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_PHYS_OBJ_PROP TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_PHYS_OBJ_PROP for olapsys.ALL$OLAP2_AW_PHYS_OBJ_PROP
/


REM ALL_OLAP2_AW_DIMENSIONS

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_DIMENSIONS ';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_DIMENSIONS';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_DIMENSIONS AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_LOGICAL_NAME,
       AW.COL3 as AW_PHYSICAL_OBJECT,
       AW.COL1 as SOURCE_OWNER,
       AW.COL2 as SOURCE_NAME
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_DIMENSIONS'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!DIM_OWNER
                        MEASURE AWNAME FROM SYS.AWMD!DIM_AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!DIM_DIMENSION_NAME
                        MEASURE COL1 FROM SYS.AWMD!DIM_SOURCE_OWNER
                        MEASURE COL2 FROM SYS.AWMD!DIM_SOURCE_NAME
                        MEASURE COL3 from SYS.AWMD!DIM_AW_PHYSICAL_OBJECT
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY_DIM'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_DIMENSIONS TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_DIMENSIONS for olapsys.ALL$OLAP2_AW_DIMENSIONS
/

REM ALL_OLAP2_AW_ATTRIBUTES

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_ATTRIBUTES';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_ATTRIBUTES';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_ATTRIBUTES AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.COL4 as AW_DIMENSION_NAME,
       AW.AWOBJECT as AW_LOGICAL_NAME,
       AW.COL3 as AW_PHYSICAL_OBJECT,
       AW.COL7 as DISPLAY_NAME,
       AW.COL8 as DESCRIPTION,
       AW.COL9 as ATTRIBUTE_TYPE,
       AW.COL1 as SOURCE_OWNER,
       AW.COL6 as SOURCE_DIMENSION_NAME,
       AW.COL2 as SOURCE_NAME
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_ATTRIBUTES'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!ATTR_OWNER
                        MEASURE AWNAME FROM SYS.AWMD!ATTR_AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!ATTR_ATTRIBUTE_NAME
                        MEASURE COL1 FROM SYS.AWMD!ATTR_SOURCE_OWNER
                        MEASURE COL2 FROM SYS.AWMD!ATTR_SOURCE_NAME
                        MEASURE COL3 from SYS.AWMD!ATTR_AW_PHYSICAL_OBJECT
                        MEASURE COL6 FROM SYS.AWMD!ATTR_DIMENSION_SOURCE_NAME
                        MEASURE COL4 FROM SYS.AWMD!ATTR_DIMENSION_NAME
                        MEASURE COL7 FROM SYS.AWMD!ATTR_DISPLAY_NAME
                        MEASURE COL8 FROM SYS.AWMD!ATTR_DESCRIPTION
                        MEASURE COL9 FROM SYS.AWMD!ATTR_CF_TYPE
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY_ATTR'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_ATTRIBUTES TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_ATTRIBUTES for olapsys.ALL$OLAP2_AW_ATTRIBUTES
/


REM ALL_OLAP2_AW_CUBES

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBES';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -942);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CUBES';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_CUBES AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_LOGICAL_NAME,
       AW.COL3 as AW_PHYSICAL_OBJECT,
       AW.COL1 as SOURCE_OWNER,
       AW.COL2 as SOURCE_NAME
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_CUBES'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!CUBE_OWNER
                        MEASURE AWNAME FROM SYS.AWMD!CUBE_AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!CUBE_CUBE_NAME
                        MEASURE COL1 FROM SYS.AWMD!CUBE_SOURCE_OWNER
                        MEASURE COL2 FROM SYS.AWMD!CUBE_SOURCE_NAME
                        MEASURE COL3 FROM SYS.AWMD!CUBE_AW_PHYSICAL_OBJECT
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY_CUBE'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_CUBES TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBES for olapsys.ALL$OLAP2_AW_CUBES
/


REM ALL_OLAP2_AW_CUBE_DIM_USES

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_DIM_USES ';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -942);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CUBE_DIM_USES';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_CUBE_DIM_USES AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_LOGICAL_NAME,
       AW.COL1 as DIMENSION_AW_OWNER,
       AW.COL2 as DIMENSION_AW_NAME,
       AW.COL3 as DIMENSION_SOURCE_OWNER,
       AW.COL4 as DIMENSION_SOURCE_NAME
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_CUBE_DIM_USES'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!CDU_OWNER
                        MEASURE AWNAME FROM SYS.AWMD!CDU_AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!CDU_CUBE_NAME
                        MEASURE COL1 FROM SYS.AWMD!CDU_DIMENSION_OWNER
                        MEASURE COL2 FROM SYS.AWMD!CDU_DIMENSION_NAME
                        MEASURE COL3 FROM SYS.AWMD!CDU_DIMENSION_SOURCE_OWNER
                        MEASURE COL4 FROM SYS.AWMD!CDU_DIMENSION_SOURCE_NAME
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY_CDU'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_CUBE_DIM_USES TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_DIM_USES for olapsys.ALL$OLAP2_AW_CUBE_DIM_USES
/


DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW ALL$AW_DIM_ENABLED_VIEWS';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym__dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_AW_DIM_ENABLED_VIEWS';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW ALL$AW_DIM_ENABLED_VIEWS AS
  SELECT AW.AWOWNER as AW_OWNER,
         AW.AWNAME as AW_NAME,
         AW.COL1 as DIMENSION_NAME,
         AW.COL2 as HIERARCHY_NAME,
         AW.COL3 as SYSTEM_VIEWNAME,
         AW.COL4 as USER_VIEWNAME
  FROM
    TABLE(CAST(SYS.OLAP_TABLE('SYS.AWMD duration query',
                          'olapsys.ALL_OLAP2_AW_METADATA_T',
                          'ACTIVE_CATALOG ''ALL_AW_DIM_ENABLED_VIEWS'' ''ALL''',
                          'MEASURE AWOWNER FROM SYS.AWMD!AWOWNER
                           MEASURE AWNAME FROM SYS.AWMD!AWNAME
                           MEASURE COL1 FROM SYS.AWMD!DIMENSION_NAME
                           MEASURE COL2 FROM SYS.AWMD!HIERARCHY_NAME
                           MEASURE COL3 FROM SYS.AWMD!VIEWNAME
                           MEASURE COL4 FROM SYS.AWMD!USERVIEWNAME
                           DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY')
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$AW_DIM_ENABLED_VIEWS TO PUBLIC
/

create or replace public synonym ALL_AW_DIM_ENABLED_VIEWS for olapsys.ALL$AW_DIM_ENABLED_VIEWS
/


DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW ALL$AW_CUBE_ENABLED_VIEWS';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_AW_CUBE_ENABLED_VIEWS';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW ALL$AW_CUBE_ENABLED_VIEWS AS
  SELECT AW.AWOWNER as AW_OWNER,
         AW.AWNAME as AW_NAME,
         AW.COL1 as CUBE_NAME,
         AW.COL5 as HIERCOMBO_NUM,
         AW.COL6 as HIERCOMBO_STR,
         AW.COL3 as SYSTEM_VIEWNAME,
         AW.COL4 as USER_VIEWNAME
  FROM
    TABLE(CAST(SYS.OLAP_TABLE('SYS.AWMD duration query',
                          'olapsys.ALL_OLAP2_AW_METADATA_T',
                          'ACTIVE_CATALOG ''ALL_AW_CUBE_ENABLED_VIEWS'' ''ALL''',
                          'MEASURE AWOWNER FROM SYS.AWMD!AWOWNER
                           MEASURE AWNAME FROM SYS.AWMD!AWNAME
                           MEASURE COL1 FROM SYS.AWMD!CUBE_NAME
                           MEASURE COL5 FROM SYS.AWMD!HIERCOMBO_NUM
                           MEASURE COL6 FROM SYS.AWMD!HIERCOMBO_STR
                           MEASURE COL3 FROM SYS.AWMD!VIEWNAME
                           MEASURE COL4 FROM SYS.AWMD!USERVIEWNAME
                           DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY')
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$AW_CUBE_ENABLED_VIEWS TO PUBLIC
/

create or replace public synonym ALL_AW_CUBE_ENABLED_VIEWS for olapsys.ALL$AW_CUBE_ENABLED_VIEWS
/

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW ALL$AW_CUBE_ENABLED_HIERCOMBO';
EXCEPTION
  WHEN tab_view_nde THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -942);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_AW_CUBE_ENABLED_HIERCOMBO ';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW ALL$AW_CUBE_ENABLED_HIERCOMBO AS
  SELECT AW.AWOWNER as AW_OWNER,
         AW.AWNAME as AW_NAME,
         AW.COL1 as CUBE_NAME,
         AW.COL5 as HIERCOMBO_NUM,
         AW.COL3 as HIERCOMBO_STR
  FROM
    TABLE(CAST(SYS.OLAP_TABLE('SYS.AWMD duration query',
                          'olapsys.ALL_OLAP2_AW_METADATA_T',
                          'ACTIVE_CATALOG ''ALL_AW_CUBE_ENABLED_HIERCOMBO'' ''ALL''',
                          'MEASURE AWOWNER FROM SYS.AWMD!AWOWNER
                           MEASURE AWNAME FROM SYS.AWMD!AWNAME
                           MEASURE COL1 FROM SYS.AWMD!CUBE_NAME
                           MEASURE COL5 FROM SYS.AWMD!HIERCOMBO_NUM
                           MEASURE COL3 FROM SYS.AWMD!HIERCOMBO_STR
                           DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY')
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$AW_CUBE_ENABLED_HIERCOMBO TO PUBLIC
/

create or replace public synonym ALL_AW_CUBE_ENABLED_HIERCOMBO for olapsys.ALL$AW_CUBE_ENABLED_HIERCOMBO
/


REM ALL_OLAP2_AW_DIM_LEVELS

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_DIM_LEVELS';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -942);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_DIM_LEVELS ';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_DIM_LEVELS AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_LOGICAL_NAME,
       AW.COL1 as LEVEL_NAME,
       AW.COL2 as DISPLAY_NAME,
       AW.COL3 as DESCRIPTION
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_DIM_LEVELS'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!DL_OWNER
                        MEASURE AWNAME FROM SYS.AWMD!DL_AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!DL_DIMENSION_NAME
                        MEASURE COL1 FROM SYS.AWMD!DL_LEVEL_NAME
                        MEASURE COL2 FROM SYS.AWMD!DL_DISPLAY_NAME
                        MEASURE COL3 FROM SYS.AWMD!DL_DESCRIPTION
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY_DL'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_DIM_LEVELS TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_DIM_LEVELS for olapsys.ALL$OLAP2_AW_DIM_LEVELS
/

REM ALL_OLAP2_AW_DIM_HIER_LVL_ORD

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_DIM_HIER_LVL_ORD';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -942);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_DIM_HIER_LVL_ORD';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_DIM_HIER_LVL_ORD AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_DIMENSION_NAME,
       AW.COL1 as AW_HIERARCHY_NAME,
       AW.COL2 as IS_DEFAULT_HIER,
       AW.COL3 as AW_LEVEL_NAME,
       AW.COL5 as POSITION
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_DIM_HIER_LVL_ORD'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!DHLO_OWNER
                        MEASURE AWNAME FROM SYS.AWMD!DHLO_AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!DHLO_DIMENSION_NAME
                        MEASURE COL1 FROM SYS.AWMD!DHLO_HIERARCHY_NAME
                        MEASURE COL2 FROM SYS.AWMD!DHLO_IS_DFLT_HIER
                        MEASURE COL3 FROM SYS.AWMD!DHLO_LEVEL_NAME
                        MEASURE COL5 FROM SYS.AWMD!DHLO_HIER_LVL_POS
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY_DHLO'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_DIM_HIER_LVL_ORD TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_DIM_HIER_LVL_ORD for olapsys.ALL$OLAP2_AW_DIM_HIER_LVL_ORD
/


REM ALL_OLAP2_AW_CUBE_MEASURES

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_MEASURES';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym__dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CUBE_MEASURES';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_CUBE_MEASURES AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_CUBE_NAME,
       AW.COL1 as AW_MEASURE_NAME,
       AW.COL6 as AW_PHYSICAL_OBJECT,
       AW.COL2 as MEASURE_SOURCE_NAME,
       AW.COL3 as DISPLAY_NAME,
       AW.COL4 as DESCRIPTION,
       AW.COL7 as IS_AGGREGATEABLE
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_CUBE_MEASURES'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!CM_OWNER
                        MEASURE AWNAME FROM SYS.AWMD!CM_AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!CM_CUBE_NAME
                        MEASURE COL1 FROM SYS.AWMD!CM_MEASURE_NAME
                        MEASURE COL2 FROM SYS.AWMD!CM_SOURCE_NAME
                        MEASURE COL3 FROM SYS.AWMD!CM_DISPLAY_NAME
                        MEASURE COL4 FROM SYS.AWMD!CM_DESCRIPTION
                        MEASURE COL6 FROM SYS.AWMD!CM_AW_PHYSICAL_OBJECT
                        MEASURE COL7 FROM SYS.AWMD!CM_ISAGGREGATEABLE
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY_CM'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_CUBE_MEASURES TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_MEASURES for olapsys.ALL$OLAP2_AW_CUBE_MEASURES
/

REM ALL_OLAP2_AW_CUBE_AGG_SPECS

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_SPECS';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CUBE_AGG_SPECS';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_SPECS AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_CUBE_NAME,
       AW.COL1 as AW_AGGSPEC_NAME
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_CUBE_AGGSPECS'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!OWNER
                        MEASURE AWNAME FROM SYS.AWMD!AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!CUBE_NAME
                        MEASURE COL1 FROM SYS.AWMD!AGGSPEC_NAME
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_CUBE_AGG_SPECS TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_AGG_SPECS for olapsys.ALL$OLAP2_AW_CUBE_AGG_SPECS
/


REM ALL_OLAP2_AW_CUBE_AGG_MEAS

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_MEAS';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CUBE_AGG_MEAS';
EXCEPTION
  WHEN synonym THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_MEAS AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_CUBE_NAME,
       AW.COL1 as AW_AGGSPEC_NAME,
       AW.COL2 as AW_MEASURE_NAME
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_CUBE_AGGSPECS_MEASURES'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!OWNER
                        MEASURE AWNAME FROM SYS.AWMD!AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!CUBE_NAME
                        MEASURE COL1 FROM SYS.AWMD!AGGSPEC_NAME
                        MEASURE COL2 FROM SYS.AWMD!MEASURE_NAME
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_CUBE_AGG_MEAS TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_AGG_MEAS for olapsys.ALL$OLAP2_AW_CUBE_AGG_MEAS
/

REM ALL_OLAP2_AW_CUBE_AGG_LVL

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_LVL';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CUBE_AGG_LVL';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_LVL AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_CUBE_NAME,
       AW.COL1 as AW_AGGSPEC_NAME,
       AW.COL2 as AW_DIMENSION_NAME,
       AW.COL3 as AW_LEVEL_NAME
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_CUBE_AGGSPECS_LEVELS'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!OWNER
                        MEASURE AWNAME FROM SYS.AWMD!AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!CUBE_NAME
                        MEASURE COL1 FROM SYS.AWMD!AGGSPEC_NAME
                        MEASURE COL2 FROM SYS.AWMD!DIMENSION_NAME
                        MEASURE COL3 FROM SYS.AWMD!LEVEL_NAME
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_CUBE_AGG_LVL TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_AGG_LVL for olapsys.ALL$OLAP2_AW_CUBE_AGG_LVL
/

REM ALL_OLAP2_AW_CUBE_AGG_OP

DECLARE
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_OP';
EXCEPTION
  WHEN tab_view_dne THEN
     NULL;
END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CUBE_AGG_OP';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/

CREATE OR REPLACE VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_OP AS 
SELECT AW.AWOWNER as AW_OWNER,
       AW.AWNAME as AW_NAME,
       AW.AWOBJECT as AW_CUBE_NAME,
       NULL as AW_MEASURE_NAME,
       AW.COL1 as AW_AGGSPEC_NAME,
       AW.COL2 as AW_DIMENSION_NAME,
       AW.COL3 as OPERATOR
FROM 
TABLE(CAST (SYS.OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_CUBE_AGGSPECS_OPERATORS'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!OWNER
                        MEASURE AWNAME FROM SYS.AWMD!AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!CUBE_NAME
                        MEASURE COL1 FROM SYS.AWMD!AGGSPEC_NAME
                        MEASURE COL2 FROM SYS.AWMD!DIMENSION_NAME
                        MEASURE COL3 FROM SYS.AWMD!OPERATOR
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT SELECT ON olapsys.ALL$OLAP2_AW_CUBE_AGG_OP TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_AGG_OP for olapsys.ALL$OLAP2_AW_CUBE_AGG_OP
/

commit
/
exec sys.dbms_aw.shutdown
exec sys.dbms_aw_internal.olap_script_end;
@?/rdbms/admin/sqlsessend.sql
