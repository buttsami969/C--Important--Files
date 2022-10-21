Rem Copyright (c) 2000, 2018, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqsys.sql
Rem
Rem    DESCRIPTION
Rem      Create metadata owner schema 'OLAPSYS' with no password
Rem
Rem    NOTES
Rem      Must be run as 'SYS' and requires paramaters for default and
Rem      temporary tablespace.  
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqsys.sql
Rem    SQL_SHIPPED_FILE:olap/admin/xoqsys.sql
Rem    SQL_PHASE: XOQSYS
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    ghicks      07/16/18 - bug 28354015: fix STARTUP_MODE metadata
Rem    ghicks      05/10/18 - Bug 27965300, create OLAPSYS without password
Rem    ghicks      12/08/15 - Bug 22303952: revoke INHERT PRIVILEGES
Rem    awesley     01/24/14 - Bug 17639176 move tablespaces defaulting to catxoq.sql, always create XMl_LOAD... objects,
Rem    awesley    `06/11/13 - LRG 9185136 remove all grants from olapsys 
Rem    mstasiew    03/14/13 - 16473621 set ORACLE_SCRIPT
Rem    awesley     01/30/13 - bug 16230256 create OLAPSYS if it does not exist 
Rem    awesley     03/21/12 - deprecate cwm tx 13068864 
Rem                           copy from cwmlite/admin, 
Rem                           consolidate olapsys creaate scripts
Rem    jheng       06/13/11 - Project 32973 grant to olapsys
Rem    glyon       06/24/08 - bug 7204558 XXXeliminate references to sys.user$
Rem    clei        02/13/08 - remove update statement on user$
Rem    glyon       06/04/07 - Make it impossible to connect as olapsys
Rem    jcarey      10/07/04 - Remove unnecessary rights
Rem    cdalessi    04/23/04 - Remove references to all_aw_numbers 
Rem    awesley     04/12/04 - add grant to sys.view$, create/drop any synonym
Rem    dbardwel    03/29/04 - 
Rem    ckearney    11/20/03 - add grant to all_aw_numbers and aw_prop$
Rem    ckearney    11/20/03 - add grant to all_aw_numbers and aw_prop$
Rem    awesley     11/12/03 - add grant select on dba_tables, dba_constraints, dba_objects, create/drop dimension
Rem    cdalessi    07/29/03 - 
Rem    cdalessi    10/21/02 - cdalessi_txn104879
Rem    cdalessi    10/10/02 - Renamed this file from oneuser.sql to amdsys.sql
Rem    dthompso    04/11/01 - B1716330 Add parameter for default temporary tab
Rem    dallan      06/23/00 - Add parameter for tablespace, created in DBCA.
Rem    dthompso    04/27/00 - Initial Version
Rem    dthompso    01/00/00 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

@@xoqsys_user.sql &1 &2   

@@xoqsys_schema.sql

@@?/rdbms/admin/sqlsessend.sql
