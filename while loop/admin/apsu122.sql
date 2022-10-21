Rem
Rem $Header: oraolap/admin/apsu122.sql /main/3 2020/07/19 10:17:13 dgoddard Exp $
Rem
Rem apsu122.sql
Rem
Rem Copyright (c) 2016, 2018, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      apsu122.sql - Upgrade the APS component from 12.2
Rem
Rem    DESCRIPTION
Rem      Performs any actions necessary to upgrade the APS component
Rem      from 12.2 to ???
Rem
Rem    NOTES
Rem      None
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/apsu122.sql
Rem    SQL_SHIPPED_FILE: olap/admin/apsu122.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    SQL_CALLING_FILE: rdbms/admin/cmpdwgrd.sql
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    ghicks      07/16/18 - bug 28354015: fix PHASE, STARTUP_MODE metadata
Rem    cchiappa    09/20/16 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

--uncomment for next release
--@@apsuNNN.sql

@?/rdbms/admin/sqlsessend.sql
