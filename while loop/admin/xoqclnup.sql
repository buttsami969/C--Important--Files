Rem
Rem $Header: oraolap/admin/xoqclnup.sql /main/7 2020/08/24 10:32:20 jcarey Exp $
Rem
Rem xoqclnup.sql
Rem
Rem Copyright (c) 2015, 2020, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqclnup.sql - Bug 20424899 - script to remove old OLAP Objects that
Rem                     may have been left behind in the database that may cause
Rem                     Privilege Escalation problems
Rem
Rem    DESCRIPTION
Rem      Revoke Public Privileges and remove old OLAP Objects from database.
Rem
Rem    NOTES
Rem      NONE
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqclnup.sql
Rem    SQL_SHIPPED_FILE: olap/admin/xoqclnup.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: ORA-01432,ORA-00942,ORA-02289
Rem    SQL_CALLING_FILE: oraolap/admin/xoqu112.sql
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      08/20/20 - RTI 23210352 - more drops.
Rem    jcarey      08/07/20 - Bug 31725025 - guard drops
Rem    stanaya     03/13/17 - Fixed Bug : 25635534    
Rem    mstasiew    09/28/15 - Bug 21841987: Add dbms_xsoq, dbms_xsoq_util
Rem    czechar     09/15/15 - fix missing SQL file metadata
Rem    ddedonat    03/06/15 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

Rem old releases granted unnecessary privileges
begin
  execute immediate('revoke all on olapsys.olap_session_dims from public');
  execute immediate('revoke all on olapsys.olap_session_cubes from public');
exception
  when others then
    null;
end;
/

begin
  execute immediate('revoke all on olapsys.cwm2$awcubecreateaccess from public');
  execute immediate('revoke all on olapsys.cwm2$awdimcreateaccess from public');
exception
  when others then
    null;
end;
/

begin
  execute immediate('revoke all on sys.olaptablevels from public');
  execute immediate('revoke all on sys.olaptableveltuples from public');
exception
  when others then
    null;
end;
/


Rem old OLAP objects no longer needed
DECLARE
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
obj_dne exception;
pragma exception_init(obj_dne, -4843);
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
sequence_dne exception;
pragma exception_init(sequence_dne, -2289);

BEGIN

  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM GV_Olapi_Session_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM V_Olapi_Session_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM GV_Olapi_Iface_Object_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM V_Olapi_Iface_Object_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM GV_Olapi_Iface_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM V_Olapi_Iface_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM GV_Olapi_Memory_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM V_Olapi_Memory_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM Olapi_History_Seq FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM Olapi_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM Olapi_Session_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM Olapi_Iface_Object_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM Olapi_Iface_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM Olapi_Memory_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM Olapi_Memory_Heap_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM DBMS_XSOQ FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PUBLIC SYNONYM DBMS_XSOQ_UTIL FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP VIEW GV_Olapi_Session_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP VIEW V_Olapi_Session_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP VIEW GV_Olapi_Iface_Object_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP VIEW V_Olapi_Iface_Object_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP VIEW GV_Olapi_Iface_Op_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP VIEW V_Olapi_Iface_Op_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP VIEW GV_Olapi_Memory_Op_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP VIEW V_Olapi_Memory_Op_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP SEQUENCE Olapi_History_Seq';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP TABLE Olapi_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP TABLE Olapi_Session_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP TABLE Olapi_Iface_Object_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP TABLE Olapi_Iface_Op_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP TABLE Olapi_Memory_Op_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP TABLE Olapi_Memory_Heap_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PACKAGE DBMS_XSOQ';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;
  
  BEGIN
  execute immediate 'DROP PACKAGE DBMS_XSOQ_UTIL';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;
END;
/
@?/rdbms/admin/sqlsessend.sql
