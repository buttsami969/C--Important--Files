Rem Copyright (c) 2000, 2018, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqsys_schema.sql
Rem
Rem    DESCRIPTION
Rem      Create metadata objects for schema 'OLAPSYS'
Rem
Rem    NOTES
Rem      Must be run as 'SYS'
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqsys_schema.sql
Rem    SQL_SHIPPED_FILE:olap/admin/xoqsys_schema.sql
Rem    SQL_PHASE: XOQSYS_SCHEMA
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    ghicks      07/16/18 - bug 28354015: fix PHASE, STARTUP_MODE metadata
Rem    ghicks      05/15/18 - Bug 27965300, Created from xoqsys.sql
Rem

@@?/rdbms/admin/sqlsessstart.sql

Rem revoke INHERIT PRIVILEGES from public
DECLARE
  already_revoked EXCEPTION;
  pragma exception_init(already_revoked,-01927);
BEGIN
   execute immediate 'REVOKE INHERIT PRIVILEGES ON USER OLAPSYS FROM public';
EXCEPTION
  when already_revoked then
    null;
END;
/

Rem copied with changes from cwmlite/admin/ cwm2inst.sql and cwm2mtbl.sql
alter session set current_schema = olapsys
/

BEGIN
  execute immediate 
  'create sequence olapsys.XML_LOADID_SEQUENCE';
EXCEPTION
  when others then
    null;
 END;
/

BEGIN
  execute immediate 
  'create table olapsys.XML_LOAD_RECORDS (
  xml_loadid number not null,
  xml_recordid number not null,
  xml_recordtext varchar2(2000),
  primary key (xml_loadid, xml_recordid))';
EXCEPTION
  when others then
    null;
 END;
/

BEGIN
  execute immediate 
  'create table olapsys.XML_LOAD_LOG (
  xml_loadid number not null,
  xml_recordid number not null,
  xml_date date not null,
  xml_aw varchar2(80),
  xml_message varchar2(2000),
  primary key (xml_loadid, xml_recordid))';
 EXCEPTION
  when others then
    null;
 END;
/

Rem copy from cwmlite/admin/cwm2inst.sql and rename 
@@xoqawmd.sql  -- create active catalog

alter session set current_schema = sys;

@@?/rdbms/admin/sqlsessend.sql
