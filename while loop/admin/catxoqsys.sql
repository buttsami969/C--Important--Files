Rem Copyright (c) 2013, Oracle and/or its affiliates. All rights reserved.
Rem
Rem    NAME
Rem      catxoqsys.sql
Rem
Rem    DESCRIPTION
Rem      Create OLAP API Packages and Libraries.  Call xoqsys.sql to create OLAPSYS user.
Rem
Rem    NOTES
Rem      Must be run as 'SYS' and requires paramaters for default (&1) and
Rem      temporary (&2) tablespace.  
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    awesley     08/23/13 - Add second @ to comp_file execute 

@@?/rdbms/admin/sqlsessstart.sql

COLUMN :file_name NEW_VALUE comp_file NOPRINT
VARIABLE file_name VARCHAR2(256)
BEGIN
  :file_name := 'xoqsys.sql';  -- create OLAPSYS
END;
/

SELECT :file_name FROM DUAL;
@@&comp_file &1 &2

@@?/rdbms/admin/sqlsessend.sql

