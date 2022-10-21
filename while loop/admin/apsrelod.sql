Rem
Rem $Header: oraolap/admin/apsrelod.sql /main/13 2020/07/19 10:16:32 dgoddard Exp $
Rem
Rem apsrelod.sql
Rem
Rem Copyright (c) 2001, 2019, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      apsrelod.sql - reload APS-related packages
Rem
Rem    DESCRIPTION
Rem
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/apsrelod.sql
Rem    SQL_SHIPPED_FILE: olap/admin/apsrelod.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      03/22/19 - Fix metadata
Rem    akociube    04/18/08 - fix patch downgrade
Rem    cchiappa    01/11/05 - catawxml now part of xoq
Rem    cchiappa    12/15/04 - Include catawxml 
Rem    zqiu        09/26/03 - add apsviews.sql
Rem    cdalessi    01/21/03 - fix value to compat
Rem    cdalessi    01/14/03 - Fix compatibility check to handle 10.x
Rem    cdalessi    12/09/02 - 10i migration changes
Rem    cdalessi    12/02/02 - Creation

@@cataps.sql
