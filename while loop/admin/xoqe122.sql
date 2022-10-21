Rem
Rem $Header: oraolap/admin/xoqe122.sql /main/5 2020/07/19 10:24:10 dgoddard Exp $
Rem
Rem xoqe122.sql
Rem
Rem Copyright (c) 2016, 2018, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqe122.sql - Downgrade the XOQ component to 12.2
Rem
Rem    DESCRIPTION
Rem      Performs any actions necessary to downgrade the XOQ component
Rem      from ??? to 12.2
Rem
Rem    NOTES
Rem      None
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqe122sql
Rem    SQL_SHIPPED_FILE: olap/admin/xoqe122.sql
Rem    SQL_PHASE: DOWNGRADE
Rem    SQL_STARTUP_MODE: DOWNGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    SQL_CALLING_FILE: rdbms/admin/cmpdwgrd.sql
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    ghicks      07/16/18 - bug 28354015: fix PHASE, STARTUP_MODE metadata
Rem    jcarey      03/08/18 - cleanup
Rem    jcarey      02/12/18 - call xoqe18
Rem    mstasiew    11/04/16 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

EXECUTE sys.dbms_registry.downgrading('XOQ');

Rem comment out for current release script
@@xoqe18.sql

EXECUTE sys.dbms_registry.downgraded('XOQ','12.2.0');

@?/rdbms/admin/sqlsessend.sql
