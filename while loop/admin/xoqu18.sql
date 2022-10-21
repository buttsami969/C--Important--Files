Rem
Rem $Header: oraolap/admin/xoqu18.sql /main/5 2020/07/19 10:27:47 dgoddard Exp $
Rem
Rem xoqu18.sql
Rem
Rem Copyright (c) 2018, 2019, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqu18.sql - migration script for upgrading olap api component
Rem
Rem    DESCRIPTION
Rem      Upgrade OLAP API from 18
Rem
Rem    NOTES
Rem
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqu18.sql
Rem    SQL_SHIPPED_FILE: olap/admin/xoqu18.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      03/19/19 - Bug 29448716 - upgrade cleanup
Rem    ghicks      07/16/18 - bug 28354015: fix PHASE, STARTUP_MODE metadata
Rem    ghicks      07/11/18 - Bug 28327999, mv ALTER/NO AUTN to catupend.sql
Rem    ghicks      06/20/18 - Created, and added BUG 27965300 actions
Rem

Rem =========================================================================
Rem BEGIN Bug 27965300 changes: remove authentication from user OLAPSYS
Rem =========================================================================

BEGIN
  EXECUTE IMMEDIATE 'REVOKE olap_dba FROM olapsys';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

Rem =========================================================================
Rem END Bug 27965300 changes
Rem =========================================================================

@@xoqu19
