Rem
Rem Copyright (c) 2016, 2019, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqdwgrd.sql - migration script for downgrading olap xoq component
Rem
Rem    DESCRIPTION
Rem      Migration script for downgrading the olap xoq component
Rem
Rem    NOTES
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqdwgrd.sql
Rem    SQL_SHIPPED_FILE: olap/admin/xoqdwgrd.sql
Rem    SQL_PHASE: DOWNGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      03/19/19 - Bug 29448716 - upgrade cleanup
Rem    bspeckha    04/12/18 - remove errorlogging from downgrade scripts
Rem    bspeckha    04/02/18 - Support downgrades to 18
Rem    mstasiew    01/31/17 - RTI 20078408 syntax error in substr lines
Rem    mstasiew    11/04/16 - Creation


WHENEVER SQLERROR EXIT
EXECUTE sys.dbms_registry.check_server_instance;
WHENEVER SQLERROR CONTINUE;

SELECT sys.dbms_registry_sys.time_stamp_display('XOQ') 
       AS timestamp FROM SYS.DUAL;

EXECUTE sys.dbms_registry.downgrading('XOQ');

Rem Setup component script filename variable
COLUMN :script_name NEW_VALUE comp_file NOPRINT
VARIABLE script_name VARCHAR2(100)

Rem Select downgrade script to run based on previous component version
DECLARE
  p_prv_version sys.registry$.prv_version%type;
BEGIN
  -- Get the previous version of the XOQ component
  SELECT prv_version INTO p_prv_version
  FROM registry$ WHERE cid='XOQ';

  IF substr(p_prv_version,1,6)='12.2.0' THEN
    :script_name := 'xoqe122.sql';
  ELSIF substr(p_prv_version,1,2)='18' THEN
    :script_name := 'xoqe18.sql';
  ELSIF substr(p_prv_version,1,2)='19' THEN
    :script_name := 'xoqe19.sql';
  ELSE
    :script_name := sys.dbms_registry.nothing_script;
  END IF;
END;
/

SELECT :script_name FROM SYS.DUAL;
@@&comp_file
