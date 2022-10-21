Rem Copyright (c) 2000, 2018, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqsys_user.sql
Rem
Rem    DESCRIPTION
Rem      Create metadata owner schema 'OLAPSYS' with no password
Rem
Rem    NOTES
Rem      Invoked from xoqsys.sql.  Requires paramaters for default and
Rem      temporary tablespace.  
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqsys_user.sql
Rem    SQL_SHIPPED_FILE:olap/admin/xoqsys_user.sql
Rem    SQL_PHASE: XOQSYS_USER
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    ghicks      07/16/18 - bug 28354015: fix PHASE, STARTUP_MODE metadata
Rem    ghicks      07/11/18 - Bug 28327999, ACCOUNT LOCK/NO AUTHORIZATION
Rem    ghicks      06/19/18 - Bug 27965300, Created from xoqsys.sql
Rem

Rem  if user olapsys does not exist create it

@@?/rdbms/admin/sqlsessstart.sql

DECLARE
  isthere     NUMBER;
BEGIN
  
  select count(*) into isthere from all_users where username ='OLAPSYS';
  if isthere = 0 then

    execute immediate 'create user olapsys'
                  || ' no authentication account lock'
                  || ' default tablespace ' || '&1'
                  || ' temporary tablespace ' || '&2'
                  || ' quota unlimited on ' || '&1';

  end if;
END;
/


@@?/rdbms/admin/sqlsessend.sql
