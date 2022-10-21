Rem
Rem $Header: oraolap/admin/apse19.sql /main/2 2020/07/19 10:16:12 dgoddard Exp $
Rem
Rem apse19.sql
Rem
Rem Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
Rem
Rem    NAME
Rem      apse19.sql - downgrade APS to 19
Rem
Rem    DESCRIPTION
Rem      downgrade APS to 19
Rem
Rem    NOTES
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/apse19.sql
Rem    SQL_SHIPPED_FILE: olap/admin/apse19.sql
Rem    SQL_PHASE:        DOWNGRADE      
Rem    SQL_STARTUP_MODE: DOWNGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    SQL_CALLING_FILE: rdbms/admin/cmpdwgrd.sql
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      03/19/19 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

EXECUTE sys.dbms_registry.downgrading('APS');

--For next version
--@@apseNN+1

EXECUTE sys.dbms_registry.downgraded('APS','19');

@?/rdbms/admin/sqlsessend.sql
 
