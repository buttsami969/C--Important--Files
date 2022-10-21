Rem
Rem $Header: oraolap/admin/xoqu19.sql /main/2 2020/07/19 10:28:06 dgoddard Exp $
Rem
Rem xoqu19.sql
Rem
Rem Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
Rem
Rem    NAME
Rem      xoqu19.sql - migration script for upgrading olap api component.
Rem
Rem    DESCRIPTION
Rem      upgrade OLAP API from 19
Rem
Rem    NOTES
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqu19.sql
Rem    SQL_SHIPPED_FILE: olap/admin/xoqu19.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      03/19/19 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

-- for next version.
-- @@xoqu20

@?/rdbms/admin/sqlsessend.sql
 
