Rem Copyright (c) 2013, 2017, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      catnothing.sql
Rem
Rem    DESCRIPTION
Rem      Create OLAP API Packages and Libraries.  Call dbms_registry.nothing_script function to
Rem        get name of do nothing script 'nothing.sql'. 
Rem
Rem    NOTES
Rem      Must be run as 'SYS'.
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/catnothing.sql
Rem    SQL_SHIPPED_FILE: olap/admin/catnothing.sql
Rem    SQL_PHASE: CATNOTHING 
Rem    SQL_STARTUP_MODE: NORMAL 
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    awesley     08/23/13 - Add second @ to comp_file execute 

@@?/rdbms/admin/sqlsessstart.sql

COLUMN :file_name NEW_VALUE comp_file NOPRINT
VARIABLE file_name VARCHAR2(256)
BEGIN
  :file_name := dbms_registry.nothing_script;
END;
/

SELECT :file_name FROM DUAL;
@@&comp_file

@@?/rdbms/admin/sqlsessend.sql

