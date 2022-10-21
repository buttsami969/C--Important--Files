Rem
Rem  catawxml.sql
Rem
Rem Copyright (c) 2003, 2017, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      catawxml.sql
Rem
Rem    DESCRIPTION
Rem      Install OLAP AW XML support
Rem
Rem    NOTES
Rem      DBMS_AW_XML should go in olappl.sql like the rest of our
Rem      catalog procedural objects, but since it depends on
Rem      OLAPI types that aren't instantiated until catxoq.sql
Rem      is run, it needs to be built here instead.
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/catawxml.sql
Rem    SQL_SHIPPED_FILE:olap/admin/catawxml.sql
Rem    SQL_PHASE:CATAWXML
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    awesley     02/14/14 - add calls to sqlsessstart.sql and sqlsessend.sql
Rem    cchiappa    01/11/05 - Move DBMS_AW_XML here 
Rem    cchiappa    12/13/04 - Move to package 
Rem    cdalessi    10/15/04 - fix; add missing grant
Rem    esoyleme    04/22/04 - sqlized
Rem    cdalessi    12/08/03 - fix resolutions 
Rem    cdalessi    10/20/03 - Rework loadjava options
Rem    cdalessi    10/06/03 - Creation
Rem

@@?/rdbms/admin/sqlsessstart.sql

call dbms_java.loadjava('-force -resolve -grant PUBLIC -synonym olap/api/lib/olap_api_spl.jar');
call dbms_java.loadjava('-force -resolve -grant PUBLIC -synonym olap/api/lib/awxml.jar');

@@dbmsawx.sql
@@prvtawx.plb

@@?/rdbms/admin/sqlsessend.sql
