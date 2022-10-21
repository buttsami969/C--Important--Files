Rem
Rem $Header: oraolap/admin/xoqrelod.sql /main/10 2020/07/19 10:25:42 dgoddard Exp $
Rem
Rem xoqrelod.sql
Rem
Rem Copyright (c) 2001, 2017, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqrelod.sql -
Rem
Rem    DESCRIPTION
Rem
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqrelod.sql
Rem    SQL_SHIPPED_FILE:olap/admin/xoqrelod.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    cchiappa    12/15/04 - Move catawxml to apsrelod 
Rem    cdalessi    06/02/04 - catawxml.sql call
Rem    cdalessi    06/20/03 - fix olapapi call
Rem    cdalessi    01/21/03 - Fix value to compat
Rem    cdalessi    01/14/03 - Fix compatibility check to handle 10.x
Rem    cdalessi    12/02/02 - Creation

@@catxoq.sql
