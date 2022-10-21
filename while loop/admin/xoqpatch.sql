Rem
Rem $Header: oraolap/admin/xoqpatch.sql /main/4 2020/07/19 10:25:25 dgoddard Exp $
Rem
Rem xoqpatch.sql
Rem
Rem Copyright (c) 2001, 2017, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqpatch.sql -
Rem
Rem    DESCRIPTION
Rem
Rem
Rem    
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqpatch.sql
Rem    SQL_SHIPPED_FILE: olap/admin/xoqpatch.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    cdalessi    04/23/04 - Catpatch bug fix - removed redundant loaded call
Rem    cdalessi    04/09/04 - 10.1.0.2 -> 10.1.0.3 - essentially a reload
Rem    cdalessi    10/18/02 - cdalessi_txn103996
Rem    cdalessi    10/11/02 - Creation

execute sys.dbms_registry.upgrading('XOQ');
@@xoqrelod.sql

