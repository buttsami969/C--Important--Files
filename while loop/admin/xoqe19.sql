Rem
Rem $Header: oraolap/admin/xoqe19.sql /main/2 2020/07/19 10:24:40 dgoddard Exp $
Rem
Rem xoqe19.sql
Rem
Rem Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
Rem
Rem    NAME
Rem      xoqe19.sql - <one-line expansion of the name>
Rem
Rem    DESCRIPTION
Rem      <short description of component this file declares/defines>
Rem
Rem    NOTES
Rem      <other useful comments, qualifications, etc.>
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqe19.sql
Rem    SQL_SHIPPED_FILE: olap/admin/xoqe19.sql
Rem    SQL_PHASE: DOWNGRADE
Rem    SQL_STARTUP_MODE: DOWNGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      03/19/19 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

exec sys.dbms_registry.downgrading('XOQ')

-- for next verison
--@@xoqe20

EXEC sys.dbms_registry.downgraded('XOQ','19') 

@?/rdbms/admin/sqlsessend.sql
 
