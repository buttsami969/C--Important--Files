Rem
Rem $Header: oraolap/admin/xoqe18.sql /main/5 2020/08/17 12:07:43 jcarey Exp $
Rem
Rem xoq18.sql
Rem
Rem Copyright (c) 2018, 2020, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoq18.sql - <one-line expansion of the name>
Rem
Rem    DESCRIPTION
Rem      <short description of component this file declares/defines>
Rem
Rem    NOTES
Rem      <other useful comments, qualifications, etc.>
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqe18.sql
Rem    SQL_SHIPPED_FILE:olap/admin/xoqe18.sql
Rem    SQL_PHASE: DOWNGRADE
Rem    SQL_STARTUP_MODE: DOWNGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      08/07/20 - Bug 31725025 - guard drops
Rem    jcarey      03/19/19 - Bug 29448716 - upgrade cleanup
Rem    bspeckha    05/07/18 - Bug 27964123 Reset version on downgrade to 18
Rem    jcarey      02/12/18 - Created
Rem

@?/rdbms/admin/sqlsessstart.sql

EXECUTE sys.dbms_registry.downgrading('XOQ');

DECLARE
obj_dne exception;
pragma exception_init(obj_dne, -4843);
BEGIN
execute immediate 'drop procedure XOQ_VALIDATE';
EXCEPTION
  WHEN obj_dne THEN
     NULL;
END;
/

@@xoqe19
EXECUTE sys.dbms_registry.downgraded('XOQ','18');

@?/rdbms/admin/sqlsessend.sql
 
