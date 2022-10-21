Rem
Rem Copyright (c) 2002, 2019, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqdbmig.sql - migration script for upgrading olap api component
Rem
Rem    DESCRIPTION
Rem      Migration script for upgrading the olap api component
Rem
Rem    NOTES
Rem
Rem    
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqdbmig.sql
Rem    SQL_SHIPPED_FILE: olap/admin/xoqdbmig.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      03/19/19 - Bug 29448716 - more upgrade files
Rem    jcarey      07/31/18 - bug 28411636 - run correct code
Rem    ghicks      06/20/18 - Upgrade from 18
Rem    jcarey      09/22/17 - Bug 25687751- AW lockdown
Rem    jcarey      08/02/17 - RTI 20476960 more olap hacking
Rem    mstasiew    07/12/17 - Bug 26431763: typo in comp upgr from 12.2
Rem    mstasiew    11/04/16 - Bug 25035156: upgrade from 12.2
Rem    mstasiew    11/06/15 - rti 18208835 chk errors, defer validate
Rem    cchiappa    08/05/14 - 12.2 support
Rem    awesley     01/24/14 - Bug 17639176 Change 12/03/13 cause 9.2 update regressions, restore old code
Rem    awesley     12/03/13 - If old version of OLAP API < 10.2.0.5 (10gR2) return nothing.sql
Rem    smierau     09/11/12 - upgrade to Triton moved to xsu112.sql
Rem    wechen      04/02/12 - upgrade to Triton security
Rem    cchiappa    02/03/11 - V12 support
Rem    jhartsin    02/21/08 - 11gR1 support
Rem    awesley     04/21/06 - 10gR2 support 
Rem    cdalessi    08/24/04 - 10gR1 support 
Rem    cdalessi    11/03/03 - fix banner 
Rem    cdalessi    08/06/03 - Fix placement of xoq_validate argument
Rem    wechen      07/30/03 - xoq_validate
Rem    cdalessi    01/22/03 - Set registry to upgraded
Rem    cdalessi    01/21/03 - Fix typos, compatibility checks and
Rem                           reload logic
Rem    cdalessi    12/09/02 - 10i migration changes
Rem    cdalessi    10/14/02 - change to catxoq
Rem    cdalessi    08/15/02 - Creation

execute sys.dbms_registry.upgrading('XOQ' ,'Oracle OLAP API' ,'xoq_validate','');

COLUMN :xoq_relod NEW_VALUE xoq_relod NOPRINT
VARIABLE xoq_relod VARCHAR2(128)
COLUMN :xoq_fname NEW_VALUE xoq_file NOPRINT
VARIABLE xoq_fname VARCHAR2(128)


exec sys.dbms_aw_internal.olap_script_start;
  

DECLARE
  compat          VARCHAR2(30);
BEGIN

  -- if the current version of XOQ is 19
  IF substr(dbms_registry.version('APS'),1,2)='19' THEN
    :xoq_fname := 'xoqu19.sql';
    :xoq_relod := 'xoqrelod.sql';
  -- if the current version of XOQ is 18
  ELSIF substr(dbms_registry.version('APS'),1,2)='18' THEN
    :xoq_fname := 'xoqu18.sql';
    :xoq_relod := 'xoqrelod.sql';
  -- if the current version of XOQ is 12.2
  ELSIF substr(dbms_registry.version('XOQ'),1,4)='12.2' THEN
    :xoq_fname := 'xoqu122.sql';
    :xoq_relod := 'xoqrelod.sql';
  -- if the current version of XOQ is 12.1
  ELSIF substr(dbms_registry.version('XOQ'),1,4)='12.1' THEN
    -- upgrade it
    :xoq_fname := 'xoqu121.sql';
    -- finish it off with a reload
    :xoq_relod := 'xoqrelod.sql';
  ELSE
    :xoq_relod := '?/rdbms/admin/nothing.sql';
    :xoq_fname := 'catxoq.sql';
  END IF;
END;
/

SELECT :xoq_fname FROM DUAL;
@@&xoq_file

SELECT :xoq_relod from DUAL;
@@&xoq_relod

exec sys.dbms_aw_internal.olap_script_end;

execute sys.dbms_registry.upgraded('XOQ');

Rem Check for errors during upgrade, set status to INVALID if errors found
BEGIN
  IF sys.dbms_registry.count_errors_in_registry('XOQ') > 0 THEN
    sys.dbms_registry.invalid('XOQ');
  END IF;
END;
/

