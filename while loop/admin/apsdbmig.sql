Rem
Rem Copyright (c) 2002, 2019, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      apsdbmig.sql - migration script for upgrading olap aw component
Rem
Rem    DESCRIPTION
Rem      Migration script for providing upgrading to the olap aw component
Rem
Rem    NOTES
Rem
Rem    
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/apsdbmig.sql
Rem    SQL_SHIPPED_FILE: olap/admin/apsdbmig.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      03/19/19 - Bug 29448716 - more upgrade files
Rem    jcarey      07/31/18 - bug 28411636 - run correct code
Rem    cchiappa    09/20/16 - Upgrade from 12.2
Rem    cchiappa    02/03/16 - Check for errors
Rem    cchiappa    08/05/14 - 12.2 support
Rem    cchiappa    02/03/11 - V12 support
Rem    zqiu        02/21/08 - 11gR1 support 
Rem    awesley     04/21/06 - 10gR2 support 
Rem    cdalessi    08/24/04 - 10gR1 support 
Rem    cdalessi    11/03/03 - fix banner 
Rem    cdalessi    08/20/03 - Add aps_validate call
Rem    cdalessi    02/06/03 - 
Rem    cdalessi    01/22/03 - Set registry to upgraded
Rem    cdalessi    01/21/03 - Fix typos, compatibility checks and
Rem                           reload logic
Rem    cdalessi    12/09/02 - 10i migration changes
Rem    cdalessi    10/14/02 - change to cataps
Rem    cdalessi    08/15/02 - Creation

execute sys.dbms_registry.upgrading('APS' ,'OLAP Analytic Workspace' ,'aps_validate','');

COLUMN :aps_relod NEW_VALUE aps_relod NOPRINT
VARIABLE aps_relod VARCHAR2(128)
COLUMN :aps_fname NEW_VALUE aps_file NOPRINT
VARIABLE aps_fname VARCHAR2(128)
DECLARE
  compat VARCHAR2(30);
BEGIN
  :aps_relod := '?/rdbms/admin/nothing.sql';

  -- if the current version of APS is 19
  IF substr(dbms_registry.version('APS'),1,2)='19' THEN
    :aps_fname := 'apsu19.sql';
    :aps_relod := 'apsrelod.sql';
  -- if the current version of APS is 18
  ELSIF substr(dbms_registry.version('APS'),1,2)='18' THEN
    :aps_fname := 'apsu18.sql';
    :aps_relod := 'apsrelod.sql';
  -- if the current version of APS is 12cR2
  ELSIF substr(dbms_registry.version('APS'),1,4)='12.2' THEN
    :aps_fname := 'apsu122.sql';
    :aps_relod := 'apsrelod.sql';
  -- if the current version of APS is 12cR1
  ELSIF substr(dbms_registry.version('APS'),1,4)='12.1' THEN
    :aps_fname := 'apsu121.sql';
    :aps_relod := 'apsrelod.sql';
  ELSE
      :aps_fname := 'cataps.sql';
  END IF;
END;
/

SELECT :aps_fname FROM DUAL;
@@&aps_file

SELECT :aps_relod from DUAL;
@@&aps_relod

execute sys.dbms_registry.upgraded('APS');

Rem Check for errors during upgrade, set status to INVALID if errors found
BEGIN
  IF sys.dbms_registry.count_errors_in_registry('APS') > 0 THEN
      sys.dbms_registry.invalid('APS');
  END IF;
END;
/
