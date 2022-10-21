Rem
Rem *************************************************************************
Rem *** IF YOU CHANGE THIS FILE,                                          ***
Rem ***        edit oraolap/test/olapdev/src/txolapsq.tsc accordingly!    ***
Rem *************************************************************************
Rem
Rem  olap.sql
Rem
Rem Copyright (c) 2001, 2017, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      olap.sql
Rem
Rem    DESCRIPTION
Rem      Create OLAP user and OLAP Catalog entry for default OLAP instance.
Rem
Rem    NOTES
Rem      This script must be run as SYS, and is typically called by DBCA at
Rem      installation time.
Rem
Rem BEGIN SQL_FILE_METADATA
Rem SQL_SOURCE_FILE: oraolap/admin/olap.sql
Rem SQL_SHIPPED_FILE: olap/admin/olap.sql
Rem SQL_PHASE: OLAP
Rem SQL_STARTUP_MODE: NORMAL
Rem SQL_IGNORABLE_ERRORS: NONE
Rem SQL_CALLING_FILE: rdbms/admin/catpexec.sql
Rem END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      03/31/17 - Bug 25684134 - better olap_on handling
Rem    mstasiew    02/17/16 - Bug 22733638: component install need byte semntcs
Rem    czechar     09/17/15 - Add SQL file metadata
Rem    cchiappa    03/14/13 - Backport cchiappa_set_oracle_script_121010
Rem    awesley     06/13/12 - add in registry and exception test to Option_Off   
Rem    awesley     05/24/12 - set registry status to OPTION OFF
Rem    awesley     03/21/12 - deprecate cwm tx 13068864 
Rem                           remove amd processing, add &s to catxoq.sql  
Rem    cchiappa    02/03/11 - V12 compatible
Rem    jcarey      06/06/06 - add compat 11 support 
Rem    ilisansk    08/12/05 - remove OLE DB for OLAP code (olapimdx.plb)
Rem    cchiappa    12/15/04 - AWXML moved to cataps 
Rem    esoyleme    05/05/04 - run amdrelod if OLAPSYS exists
Rem    cdalessi    03/02/04 - Check for OLAP=TRUE in v$option.
Rem    cdalessi    11/17/03 - Add tablespace and temp params to catamd.sql 
Rem                           call.
Rem    cdalessi    10/24/03 - add olapimdx.plb
Rem    cdalessi    10/21/03 - change refs to cwmlite and add catamd to 
Rem                           the mix.
Rem    cdalessi    10/09/03 - Add catawxml.sql.
Rem    cdalessi    01/14/03 - Fix compatibility check to handle 10.x
Rem    cdalessi    10/11/02 - Renamed component load script calls
Rem    ckearney    10/08/02 - Removed olapmdm.sql
Rem    ckearney    03/29/02 - Added invocation of olapmdm.sql
Rem    cdalessi    02/25/02 - Add compat checks.
Rem    esoyleme    02/19/02 - xumuts.plb
Rem    cdalessi    02/01/02 - adding MV stuff
Rem    mrangwal    02/01/02 - Reference to mvtabgs.sql and creatind.sql
Rem    cdalessi    01/14/02 - Remove packages that depend on olap catalog
Rem    cdalessi    10/26/01 - cdalessi_txn100336
Rem    cdalessi    07/26/00 - Created
Rem    cdalessi    08/20/00 - Remove matvw
Rem    cdalessi    08/07/00 - Added oesdba user creation
Rem    akociube    08/09/00 - Added oesguest user creation
Rem    cdalessi    11/16/00 - Removed oesguest
Rem    cdalessi    11/28/00 - Add system call to set TNS_ALIAS
Rem                           in oes.key
Rem    cdalessi    01/17/01 - Renamed oesdba to olapdba
Rem    kingols     02/07/01 - Added connect and resource privs to olapdba
Rem    cdalessi    03/15/01 - Added sess_sh calls to register in Namespace
Rem    cdalessi    03/16/01 - Set full path to verifier script calls
Rem    cdalessi    03/23/01 - New packages
Rem    cdalessi    03/27/01 - Drop olapsvr and olapdba and recreate
Rem    cdalessi    04/25/01 - Break out host calls to olaphost.sql
Rem                           and delete truncate for olapsys schema tables
Rem    cdalessi    07/25/01 - Add dimview and factview


@@?/rdbms/admin/sqlsessstart.sql

ALTER SESSION SET NLS_LENGTH_SEMANTICS=BYTE;

@@cataps.sql
@@catxoq.sql

@@?/rdbms/admin/sqlsessend.sql

