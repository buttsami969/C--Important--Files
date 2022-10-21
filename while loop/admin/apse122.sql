Rem
Rem $Header: oraolap/admin/apse122.sql /main/6 2020/08/17 12:07:43 jcarey Exp $
Rem
Rem apse122.sql
Rem
Rem Copyright (c) 2016, 2020, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      apse122.sql - Downgrade the APS component to 12.2
Rem
Rem    DESCRIPTION
Rem      Performs any actions necessary to downgrade the APS component
Rem      from ??? to 12.2
Rem
Rem    NOTES
Rem      None
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/apse122.sql
Rem    SQL_SHIPPED_FILE: olap/admin/apse122.sql
Rem    SQL_PHASE: DOWNGRADE
Rem    SQL_STARTUP_MODE: DOWNGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    SQL_CALLING_FILE: rdbms/admin/cmpdwgrd.sql
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      08/07/20 - Bug 31725025 - guard drops
Rem    ghicks      07/16/18 - bug 28354015: fix PHASE, STARTUP_MODE metadata
Rem    jcarey      02/12/18 - call apse18
Rem    jcarey      11/09/17 - add contents
Rem    cchiappa    09/20/16 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

EXECUTE sys.dbms_registry.downgrading('APS');

Rem comment out for current release script
@@apse18.sql

DECLARE
  synonym_does_not_exist exception;
  pragma exception_init(synonym_does_not_exist, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM cdb_aw_obj';
EXCEPTION
  WHEN synonym_does_not_exist THEN
     NULL;
END;
/
DECLARE
  view_does_not_exist exception;
  pragma exception_init(view_does_not_exist, -942);
BEGIN
execute immediate 'DROP VIEW cdb_aw_obj';
EXCEPTION
  WHEN view_does_not_exist THEN
     NULL;
END;
/
DECLARE
  synonym_does_not_exist exception;
  pragma exception_init(synonym_does_not_exist, -1432);
BEGIN
execute immediate 'DROP PUBLIC SYNONYM cdb_aw_prop';
EXCEPTION
  WHEN synonym_does_not_exist THEN
     NULL;
END;
/
DECLARE
  view_does_not_exist exception;
  pragma exception_init(view_does_not_exist, -942);
BEGIN
execute immediate 'DROP VIEW cdb_aw_prop';
EXCEPTION
  WHEN view_does_not_exist THEN
     NULL;
END;
/

EXECUTE sys.dbms_registry.downgraded('APS','12.2.0');

@?/rdbms/admin/sqlsessend.sql
