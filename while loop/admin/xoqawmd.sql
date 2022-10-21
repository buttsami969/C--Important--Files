REM
REM Copyright (c) 2001, 2020, Oracle and/or its affiliates. 
REM All rights reserved.
REM
REM    NAME
REM      xoqawmd.sql
REM
REM    DESCRIPTION
REM
REM    NOTES
REM
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqawmd.sql
Rem    SQL_SHIPPED_FILE:olap/admin/xoqawmd.sql
Rem    SQL_PHASE:  XOQAWMD 
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
REM    MODIFIED   (MM/DD/YY)
Rem       jcarey   08/20/20 - more guard drops
Rem       jcarey   08/12/20 - Bug 31725025 - guard drops
REM       jcarey   09/22/17 - Bug 25687751- AW lockdown
REM       jcarey   03/27/17 - Bug 25684134 - better olap_on processing
REM       ddedonat 06/23/15 - Bug 21294751 - Add OLAPSYS schema name to views ALL$AW_DIM_ENABLED_VIEWS, ALL$AW_CUBE_ENABLED_VIEWS
REM                           and ALL$AW_CUBE_ENABLED_HIERCOMBO
REM       mstasiew 04/02/15 - 20345952 proj 58196 select to read privilege
REM       dbardwel 01/07/15 - Bug 20315390 to support long object identifiers
Rem       awesley  01/24/14 - Bug 17639176 Drop views and synonyms before create to fix EDITIONABLE property problems in 12.1.0.1
REM       mstasiew 03/14/13 - 16473621 set ORACLE_SCRIPT
REM       awesley  03/21/12 - deprecate cwm tx 13068864 
REM                           copy from cwmlite/admin/cwm2awmd.sql, rename
REM       dbardwel 08/19/08 - Move all$olap2_aws to apsviews.sql so SYS will own the view
REM       glyon    06/24/08 - bug 7204558: eliminate references to sys.user$
REM       dbardwel 09/18/06 - Suport all_olap2_aws for 11R1
REM       dbardwel 11/09/05 - Re-Work for 10.2 to fix bug 4722589. Basic change is to
REM                           update SYS.AWMD!<objects> referenced in limit map 
REM       dbardwel 06/29/05 - Re-write all_olap2_aws for maximum query performance
REM                           This is now written direcly against sys tables instead
REM                           of being written against all_aw_prop_name view.
REM       dbardwel 03/30/05 - Performance fix to all_olap2_aws view
REM       dbardwel 01/26/05 - Refinement to all_olap2_aws to support having both
REM                           10.1.0.3 and 10.2 AW$VERSION properties for simpler upgrade
REM                           and no maintenance of paging manager xsdmd.c code.
REM       dbardwel 01/24/05 - Updates to all_olap2_aws for version 10.2 support
REM       ckearney 06/11/04 - fix 1000 byte limit
REM       dbardwel 05/21/04 - Performance work on ALL$OLAP2_AWS view
REM       dbardwel 04/12/04 - Change the SF version to 10.1.0.3 instead of 2.0
REM       dbardwel 04/06/04 - Further work on active catalogs
REM       dbardwel 04/05/04 - Further work on active catalogs
REM       dbardwel 03/30/04 - Added AW Catalogs and Catalog Measures views for 10.1.0.3
REM       dbardwel 03/29/04 - 
REM       dbardwel 03/26/04 - 
REM       dbardwel 03/26/04 - Added 2nd parameter to ACTIVE_CATALOG
REM                           SPL invocation for ViewType. 
REM       ckearney 03/15/04 - changes to ALL_OLAP_AWS & PHYS queries
REM       mstasiew 08/13/03 - 
REM       cdalessi 06/10/03 - 
REM       cdalessi 05/14/03 - Change some create to create or replace type
REM       mstasiew 05/21/03 - 
REM       dbardwel 05/22/03 - 
REM       mstasiew 04/11/03 - 
REM       mstasiew 04/07/03 - 
REM       mstasiew 01/20/03 - 
REM       mstasiew 01/17/03 - 
REM       dbardwel 01/23/03 - 
REM       dbardwel 01/03/03 - 
REM       mstasiew 01/13/03 - 
REM       mstasiew 11/08/02 - 
REM       mstasiew 10/29/02 - 
REM       mstasiew 08/19/02 - mstasiew_txn103605
REM       mstasiew 08/16/02 - 
REM       mstasiew 08/16/02 - 
REM    mstasiew    8/16/02

@@?/rdbms/admin/sqlsessstart.sql

execute sys.dbms_aw_internal.olap_script_start;

REM ADTs used by all views

DECLARE
type_dne exception;
pragma exception_init(type_dne, -4043);
BEGIN
  execute immediate 'DROP TYPE olapsys.ALL_OLAP2_AW_METADATA_T';
    EXCEPTION
      WHEN type_dne THEN
    NULL;
  END;
/

DECLARE
type_dne exception;
pragma exception_init(type_dne, -4043);
BEGIN
execute immediate 'DROP TYPE olapsys.ALL_OLAP2_AW_METADATA_O';
    EXCEPTION
      WHEN type_dne THEN
    NULL;
  END;
/

CREATE OR REPLACE TYPE olapsys.ALL_OLAP2_AW_METADATA_O AS OBJECT (
 AWOWNER VARCHAR2(128),
 AWNAME VARCHAR2(128),
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
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'drop view olapsys.all$olap2_aw_phys_obj_ext';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'drop view olapsys.all$olap2_aw_phys_obj_rel_obj';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'drop view olapsys.all$olap2_aw_map_hier_use';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/ 
DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'drop view olapsys.all$olap2_aw_map_lvl_use';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/

REM Need to drop views and synonyms due to Editioning object change in 12.1.0.1.0

REM ALL_OLAP2_AW_CATALOGS

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CATALOGS';
    EXCEPTION
      WHEN view_dne THEN
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
TABLE(CAST(OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T',
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
GRANT READ ON olapsys.ALL$OLAP2_AW_CATALOGS to PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CATALOGS for olapsys.ALL$OLAP2_AW_CATALOGS
/


REM ALL_OLAP2_AW_CATALOG_MEASURES

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CATALOG_MEASURES';
    EXCEPTION
      WHEN view_dne THEN
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
TABLE(CAST(OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T',
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
GRANT READ ON olapsys.ALL$OLAP2_AW_CATALOG_MEASURES to PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CATALOG_MEASURES for olapsys.ALL$OLAP2_AW_CATALOG_MEASURES
/


REM ALL_OLAP2_AW_PHYS_OBJ

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_PHYS_OBJ';
    EXCEPTION
      WHEN view_dne THEN
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_OLAP2_AW_PHYS_OBJ'' ''ALL''',
                       'MEASURE AWOWNER FROM sys.awmd!AWOWNER
                        MEASURE AWNAME FROM sys.awmd!AWNAME
                        MEASURE AWOBJECT FROM sys.awmd!AWOBJECT
                        MEASURE COL1 FROM sys.awmd!AWOBJECTTYPE
                        MEASURE COL2 FROM sys.awmd!AWOBJECTDATATYPE
                        DIMENSION AWMDKEY FROM sys.awmd!AWMDKEY')
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT READ ON olapsys.ALL$OLAP2_AW_PHYS_OBJ TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_PHYS_OBJ for olapsys.ALL$OLAP2_AW_PHYS_OBJ
/


REM ALL_OLAP2_AW_PHYS_OBJ_PROP

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_PHYS_OBJ_PROP';
    EXCEPTION
      WHEN view_dne THEN
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_OLAP2_AW_PHYS_OBJ_PROP'' ''ALL''',
                         'MEASURE AWOWNER FROM sys.awmd!PROPS_AWOWNER
                          MEASURE AWNAME FROM sys.awmd!PROPS_AWNAME
                          MEASURE AWOBJECT FROM sys.awmd!PROPS_AWOBJECT
                          MEASURE COL1 FROM sys.awmd!PROPS_AWOBJECTPROPNAME
                          MEASURE COL2 FROM sys.awmd!PROPS_AWOBJECTPROPVALUE
                          DIMENSION AWMDKEY FROM sys.awmd!AWMDKEY_PROPS')
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT READ ON olapsys.ALL$OLAP2_AW_PHYS_OBJ_PROP TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_PHYS_OBJ_PROP for olapsys.ALL$OLAP2_AW_PHYS_OBJ_PROP
/


REM ALL_OLAP2_AW_DIMENSIONS

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_DIMENSIONS ';
    EXCEPTION
      WHEN view_dne THEN
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
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

GRANT READ ON olapsys.ALL$OLAP2_AW_DIMENSIONS TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_DIMENSIONS for olapsys.ALL$OLAP2_AW_DIMENSIONS
/

REM ALL_OLAP2_AW_ATTRIBUTES

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_ATTRIBUTES';
    EXCEPTION
      WHEN view_dne THEN
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
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

GRANT READ ON olapsys.ALL$OLAP2_AW_ATTRIBUTES TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_ATTRIBUTES for olapsys.ALL$OLAP2_AW_ATTRIBUTES
/




REM ALL_OLAP2_AW_CUBES

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBES';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
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

GRANT READ ON olapsys.ALL$OLAP2_AW_CUBES TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBES for olapsys.ALL$OLAP2_AW_CUBES
/


REM ALL_OLAP2_AW_CUBE_DIM_USES

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_DIM_USES ';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
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

GRANT READ ON olapsys.ALL$OLAP2_AW_CUBE_DIM_USES TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_DIM_USES for olapsys.ALL$OLAP2_AW_CUBE_DIM_USES
/


DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$AW_DIM_ENABLED_VIEWS';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_AW_DIM_ENABLED_VIEWS';
    EXCEPTION
      WHEN synonym_dne THEN
    NULL;
  END;
/

CREATE OR REPLACE VIEW olapsys.ALL$AW_DIM_ENABLED_VIEWS AS
  SELECT AW.AWOWNER as AW_OWNER,
         AW.AWNAME as AW_NAME,
         AW.COL1 as DIMENSION_NAME,
         AW.COL2 as HIERARCHY_NAME,
         AW.COL3 as SYSTEM_VIEWNAME,
         AW.COL4 as USER_VIEWNAME
  FROM
    TABLE(CAST(OLAP_TABLE('SYS.AWMD duration query',
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

GRANT READ ON olapsys.ALL$AW_DIM_ENABLED_VIEWS TO PUBLIC
/

create or replace public synonym ALL_AW_DIM_ENABLED_VIEWS for olapsys.ALL$AW_DIM_ENABLED_VIEWS
/


DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$AW_CUBE_ENABLED_VIEWS';
    EXCEPTION
      WHEN view_dne THEN
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

CREATE OR REPLACE VIEW olapsys.ALL$AW_CUBE_ENABLED_VIEWS AS
  SELECT AW.AWOWNER as AW_OWNER,
         AW.AWNAME as AW_NAME,
         AW.COL1 as CUBE_NAME,
         AW.COL5 as HIERCOMBO_NUM,
         AW.COL6 as HIERCOMBO_STR,
         AW.COL3 as SYSTEM_VIEWNAME,
         AW.COL4 as USER_VIEWNAME
  FROM
    TABLE(CAST(OLAP_TABLE('SYS.AWMD duration query',
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

GRANT READ ON olapsys.ALL$AW_CUBE_ENABLED_VIEWS TO PUBLIC
/

create or replace public synonym ALL_AW_CUBE_ENABLED_VIEWS for olapsys.ALL$AW_CUBE_ENABLED_VIEWS
/

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$AW_CUBE_ENABLED_HIERCOMBO';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_AW_CUBE_ENABLED_HIERCOMBO ';
    EXCEPTION
      WHEN synonym_dne THEN
    NULL;
  END;
/

CREATE OR REPLACE VIEW olapsys.ALL$AW_CUBE_ENABLED_HIERCOMBO AS
  SELECT AW.AWOWNER as AW_OWNER,
         AW.AWNAME as AW_NAME,
         AW.COL1 as CUBE_NAME,
         AW.COL5 as HIERCOMBO_NUM,
         AW.COL3 as HIERCOMBO_STR
  FROM
    TABLE(CAST(OLAP_TABLE('SYS.AWMD duration query',
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

GRANT READ ON olapsys.ALL$AW_CUBE_ENABLED_HIERCOMBO TO PUBLIC
/

create or replace public synonym ALL_AW_CUBE_ENABLED_HIERCOMBO for olapsys.ALL$AW_CUBE_ENABLED_HIERCOMBO
/


REM ALL_OLAP2_AW_DIM_LEVELS

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_DIM_LEVELS';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
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

GRANT READ ON olapsys.ALL$OLAP2_AW_DIM_LEVELS TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_DIM_LEVELS for olapsys.ALL$OLAP2_AW_DIM_LEVELS
/

REM ALL_OLAP2_AW_DIM_HIER_LVL_ORD

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_DIM_HIER_LVL_ORD';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
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

GRANT READ ON olapsys.ALL$OLAP2_AW_DIM_HIER_LVL_ORD TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_DIM_HIER_LVL_ORD for olapsys.ALL$OLAP2_AW_DIM_HIER_LVL_ORD
/


REM ALL_OLAP2_AW_CUBE_MEASURES

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_MEASURES';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
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

GRANT READ ON olapsys.ALL$OLAP2_AW_CUBE_MEASURES TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_MEASURES for olapsys.ALL$OLAP2_AW_CUBE_MEASURES
/

REM ALL_OLAP2_AW_CUBE_AGG_SPECS

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_SPECS';
    EXCEPTION
      WHEN view_dne THEN
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
                       'ACTIVE_CATALOG ''ALL_CUBE_AGGSPECS'' ''ALL''',
                       'MEASURE AWOWNER FROM SYS.AWMD!OWNER
                        MEASURE AWNAME FROM SYS.AWMD!AWNAME
                        MEASURE AWOBJECT FROM SYS.AWMD!CUBE_NAME
                        MEASURE COL1 FROM SYS.AWMD!AGGSPEC_NAME
                        DIMENSION AWMDKEY FROM SYS.AWMD!AWMDKEY'
                        )
                        AS olapsys.ALL_OLAP2_AW_METADATA_T)) AW
/

GRANT READ ON olapsys.ALL$OLAP2_AW_CUBE_AGG_SPECS TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_AGG_SPECS for olapsys.ALL$OLAP2_AW_CUBE_AGG_SPECS
/


REM ALL_OLAP2_AW_CUBE_AGG_MEAS

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_MEAS';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CUBE_AGG_MEAS';
    EXCEPTION
      WHEN synonym_dne THEN
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
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

GRANT READ ON olapsys.ALL$OLAP2_AW_CUBE_AGG_MEAS TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_AGG_MEAS for olapsys.ALL$OLAP2_AW_CUBE_AGG_MEAS
/

REM ALL_OLAP2_AW_CUBE_AGG_LVL

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_LVL';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
execute immediate'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CUBE_AGG_LVL';
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
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

GRANT READ ON olapsys.ALL$OLAP2_AW_CUBE_AGG_LVL TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_AGG_LVL for olapsys.ALL$OLAP2_AW_CUBE_AGG_LVL
/

REM ALL_OLAP2_AW_CUBE_AGG_OP

DECLARE
view_dne exception;
pragma exception_init(view_dne, -942);
BEGIN
execute immediate 'DROP VIEW olapsys.ALL$OLAP2_AW_CUBE_AGG_OP';
    EXCEPTION
      WHEN view_dne THEN
    NULL;
  END;
/
BEGIN
execute immediate 'DROP PUBLIC SYNONYM ALL_OLAP2_AW_CUBE_AGG_OP';
    EXCEPTION
      WHEN OTHERS THEN
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
TABLE(CAST (OLAP_TABLE('SYS.AWMD duration query', 'olapsys.ALL_OLAP2_AW_METADATA_T', 
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

GRANT READ ON olapsys.ALL$OLAP2_AW_CUBE_AGG_OP TO PUBLIC
/

create or replace public synonym ALL_OLAP2_AW_CUBE_AGG_OP for olapsys.ALL$OLAP2_AW_CUBE_AGG_OP
/

commit
/
exec sys.dbms_aw.shutdown

exec sys.dbms_aw_internal.olap_script_end;

@@?/rdbms/admin/sqlsessend.sql

