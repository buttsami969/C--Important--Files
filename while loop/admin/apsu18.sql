Rem
Rem $Header: oraolap/admin/apsu18.sql /main/2 2020/07/19 10:17:32 dgoddard Exp $
Rem
Rem apsu18.sql
Rem
Rem Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
Rem
Rem    NAME
Rem      apsu18.sql - upgrade script from 18
Rem
Rem    DESCRIPTION
Rem      upgrade script for aps from 18
Rem
Rem    NOTES
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/apsu18.sql
Rem    SQL_SHIPPED_FILE: olap/admin/apsu18.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      03/19/19 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

@@apsu19

@?/rdbms/admin/sqlsessend.sql
 
