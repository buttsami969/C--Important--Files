Rem
Rem $Header: oraolap/admin/xoqu122.sql /main/4 2020/07/19 10:27:27 dgoddard Exp $
Rem
Rem xoqu122.sql
Rem
Rem Copyright (c) 2016, 2019, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqu122.sql - Upgrade the XOQ component from 12.2
Rem
Rem    DESCRIPTION
Rem      Performs any actions necessary to upgrade the XOQ component
Rem      from 12.2 to ???
Rem
Rem    NOTES
Rem      None
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqu122.sql
Rem    SQL_SHIPPED_FILE: olap/admin/xoqu122.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    SQL_CALLING_FILE: rdbms/admin/cmpdwgrd.sql
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      03/19/19 - Bug 29448716 - upgrade cleanup
Rem    ghicks      07/16/18 - bug 28354015: fix PHASE, STARTUP_MODE metadata
Rem    mstasiew    11/04/16 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

@@xoqu18

@?/rdbms/admin/sqlsessend.sql
