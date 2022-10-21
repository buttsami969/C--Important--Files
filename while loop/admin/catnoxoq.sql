Rem
Rem $Header: oraolap/admin/catnoxoq.sql /main/10 2020/08/17 12:07:43 jcarey Exp $
Rem
Rem catnoxoq.sql
Rem
Rem Copyright (c) 2001, 2020, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      catnoxoq.sql -
Rem
Rem    DESCRIPTION
Rem
Rem
Rem    
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/catnoxoq.sql
Rem    SQL_SHIPPED_FILE: olap/admin/catnoxoq.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      08/07/20 - Bug 31725025 - guard drops
Rem    dmiramon    08/11/15 - RTI 16153263 Remove XOQ component before drop
Rem                           user OLAPSYS
Rem    cchiappa    04/14/14 - Add sqlsess{start,end} calls
Rem    awesley     03/30/12 - add drop OLAPSYS, OLAP_DBA and OLAP_USER
Rem    akociube    03/06/09 - Remove component info
Rem    wechen      05/23/05 - fix bug 4348588
Rem    cdalessi    04/23/04 - Repair broken comment
Rem    cdalessi    10/18/02 - cdalessi_txn103996
Rem    cdalessi    10/11/02 - Creation

@@?/rdbms/admin/sqlsessstart.sql

@@xoqdrop.sql

execute sys.dbms_registry.removed('XOQ');

  declare
  user_dne exception;
  pragma exception_init(user_dne, -1918);
  begin
    execute immediate 'drop user OLAPSYS cascade';
    EXCEPTION
      WHEN user_dne THEN
    NULL;
  END;
/

  declare
  role_dne exception;
  pragma exception_init(role_dne, -1919);
  begin 
  execute immediate 'drop role OLAP_DBA';
    EXCEPTION
      WHEN role_dne THEN
    NULL;
  END;
/


  declare
  role_dne exception;
  pragma exception_init(role_dne, -1919);
  begin
    execute immediate 'drop role OLAP_USER';
    EXCEPTION
      WHEN role_dne THEN
    NULL;
  END;
/

-- No longer show up in dba_registry
delete from registry$ where cid='XOQ' and status='99';

@@?/rdbms/admin/sqlsessend.sql
