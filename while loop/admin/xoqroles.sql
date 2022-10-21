Rem Copyright (c) 2000, 2018, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqroles.sql
Rem
Rem    DESCRIPTION
Rem      Creates the role 'OLAP_DBA' and 'OLAP_USER' with grants
Rem
Rem    NOTES
Rem      Must be run as 'SYS'. Role is granted by default to 'DBA' role and
Rem      the metadata owner 'OLAPSYS'.
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqroles.sql
Rem    SQL_SHIPPED_FILE:olap/admin/xoqroles.sql
Rem    SQL_PHASE: XOQROLES
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    ghicks      07/16/18 - bug 28354015: fix PHASE, STARTUP_MODE metadata
Rem    ghicks      05/10/18 - bug 27965300, remove grant of OLAP_DBA to OLAPSYS
Rem    jhartsin    07/17/15 - expand onerolename to dbms_id 
Rem                           (varchar2(128)) (bug 20818215) 
Rem    awesley     03/21/12 - deprecate cwm tx 13068864 
Rem                           copy from cwmlite/admin/oneroles.sql, rename, 
Rem                           remove cwm_user, add XML grants 
Rem    glyon       06/04/07 - Add CWM_USER, OLAP_USER roles
Rem    dthompso    01/16/01 - Add 'select any dictionary' privilege
Rem    pramarao    09/09/00 - .added privilages to olap_dba to create and drop views
Rem    dallan      08/15/00 - Add ANALYZE ANY role to OLAP_DBA.
Rem    dthompso    04/27/00 - Initial Version
Rem    dthompso    01/00/00 - Created
Rem

Rem add olap_dba role if needed
declare
  cursor onerole is select role from dba_roles where role = 'OLAP_DBA';
  onerolename dbms_id;
begin
  if not  onerole%isopen then 
    open onerole;
    fetch onerole into onerolename;
    if onerole%notfound then
      execute immediate 'create role olap_dba';
    end if;
    close onerole;
  end if;
end;
/

Rem grant privileges needed in RDBMS 11.  Note that we do not revoke privileges
Rem that may no longer be needed.
grant CREATE ANY TABLE to OLAP_DBA
/
grant INSERT ANY TABLE to OLAP_DBA
/
grant UPDATE ANY TABLE to OLAP_DBA
/
grant DELETE ANY TABLE to OLAP_DBA
/
grant SELECT ANY TABLE to OLAP_DBA
/
grant DROP ANY TABLE to OLAP_DBA
/
grant CREATE ANY CUBE DIMENSION to OLAP_DBA
/
grant INSERT ANY CUBE DIMENSION to OLAP_DBA
/
grant UPDATE ANY CUBE DIMENSION to OLAP_DBA
/
grant DELETE ANY CUBE DIMENSION to OLAP_DBA
/
grant SELECT ANY CUBE DIMENSION to OLAP_DBA
/
grant DROP ANY CUBE DIMENSION to OLAP_DBA
/
grant CREATE ANY CUBE to OLAP_DBA
/
grant UPDATE ANY CUBE to OLAP_DBA
/
grant SELECT ANY CUBE to OLAP_DBA
/
grant DROP ANY CUBE to OLAP_DBA
/
grant CREATE ANY MEASURE FOLDER to OLAP_DBA
/
grant INSERT ANY MEASURE FOLDER to OLAP_DBA
/
grant DELETE ANY MEASURE FOLDER to OLAP_DBA
/
grant DROP ANY MEASURE FOLDER to OLAP_DBA
/
grant CREATE ANY CUBE BUILD PROCESS to OLAP_DBA
/
grant UPDATE ANY CUBE BUILD PROCESS to OLAP_DBA
/
grant DROP ANY CUBE BUILD PROCESS to OLAP_DBA
/
grant CREATE ANY VIEW to OLAP_DBA
/
grant DROP ANY VIEW to OLAP_DBA
/
grant CREATE JOB to OLAP_DBA
/
grant CREATE SEQUENCE to OLAP_DBA
/
grant OLAP_DBA to DBA
/


Rem add olap_user role if needed
declare
  cursor onerole is select role from dba_roles where role = 'OLAP_USER';
  onerolename dbms_id;
begin
  if not  onerole%isopen then 
    open onerole;
    fetch onerole into onerolename;
    if onerole%notfound then
      execute immediate 'create role olap_user';
    end if;
    close onerole;
  end if;
end;
/

grant create table to olap_user;
/

grant create cube dimension to olap_user;
/

grant create cube to olap_user;
/

grant create measure folder to olap_user;
/

grant create cube build process to olap_user;
/

grant create view to olap_user;
/

grant create sequence to olap_user;
/

grant create job to olap_user;
/

grant select on olapsys.XML_LOADID_SEQUENCE to OLAP_USER, OLAP_DBA
/

GRANT SELECT, INSERT, UPDATE, DELETE ON OLAPSYS.XML_LOAD_RECORDS TO OLAP_USER, OLAP_DBA;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON OLAPSYS.XML_LOAD_LOG TO OLAP_USER, OLAP_DBA;
/
