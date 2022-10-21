Rem
Rem $Header: oraolap/admin/apse18.sql /main/4 2020/08/17 12:07:42 jcarey Exp $
Rem
Rem apse18.sql
Rem
Rem Copyright (c) 2016, 2020, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      apse18.sql - Downgrade the APS component to 18.1
Rem
Rem    DESCRIPTION
Rem      Performs any actions necessary to downgrade the APS component
Rem      from ??? to 18.1
Rem
Rem    NOTES
Rem      None
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/apse18.sql
Rem    SQL_SHIPPED_FILE: olap/admin/apse18.sql
Rem    SQL_PHASE: DOWNGRADE
Rem    SQL_STARTUP_MODE: DOWNGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    SQL_CALLING_FILE: rdbms/admin/cmpdwgrd.sql
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      08/07/20  - Bug 31725025 - guard drops
Rem    jcarey      03/19/19  - Bug 29448716 - upgrade cleanup
Rem    jcarey      02/12/18  - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

EXECUTE sys.dbms_registry.downgrading('APS');

@@apse19

declare
  object_does_not_exist exception;
  pragma exception_init(object_does_not_exist, -4843);
begin
execute immediate 'drop procedure APS_VALIDATE';
  EXCEPTION
    WHEN object_does_not_exist THEN
  NULL;
END;

/
EXECUTE sys.dbms_registry.downgraded('APS','18');

@?/rdbms/admin/sqlsessend.sql
