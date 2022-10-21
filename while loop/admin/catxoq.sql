Rem
Rem *************************************************************************
Rem *** IF YOU CHANGE THIS FILE,                                          ***
Rem ***        edit oraolap/test/olapdev/src/txolapsq.tsc accordingly!    ***
Rem *************************************************************************
Rem
Rem  catxoq.sql
Rem
Rem Copyright (c) 2002, 2020, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      catxoq.sql
Rem
Rem    DESCRIPTION
Rem      Create OLAP API Packages and Libraries
Rem
Rem    NOTES
Rem      This script must be run as user SYS, and is typically called by
Rem      olap.sql installation time.
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/catxoq.sql
Rem    SQL_SHIPPED_FILE:olap/admin/catxoq.sql
Rem    SQL_PHASE: CATXOQ 
Rem    SQL_STARTUP_MODE: NORMAL 
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    ghicks      10/17/19 - refactor olapiboo.plb for absence of XDB
Rem    cjohnson    05/22/19 - lrg-22212196
Rem    cjohnson    05/15/19 - move xdb support to olapibooxdb.sql
Rem    jcarey      07/18/17 - RTI 20451734 - better validate cleanup
Rem    raeburns    06/02/17 - Bug 26170491: Remove release_version dependency
Rem                         - Remove registry$error check (in xoqdbmig.sql only)
Rem                         - Remove initial option check (check after validation)
Rem    jcarey      03/09/17 - Bug 24589165: xoq valid when olap option off
Rem    ddedonat    09/16/15 - bug 21856522 xoq_validate procedure modified to resolve invalid XOQ component
Rem                           on upgrade of database from 12.1.0.2.0 to 12.2.0.1
Rem    ddedonat    07/15/15 - bug 21184939 Performs Revoke of Select Privilege and Grant of Read Privilege
Rem                           for any CwM views that may still exist for databases created in 11.2 and prior
Rem    ddedonat    12/04/14 - bug 20089214 OLAPSYS is not defined in DBA_REGISTRY as XOQ's schema
Rem    dbardwel    02/18/14 - bug 17997122 consider non-pdb and pdb databases
Rem                           for OLAP_XS_ADMIN role install validation
Rem    awesley     01/24/14 - Bug 17639176 always call xoqsys.sql, default tablespace parameters if not acceptable
Rem    awesley     07/23/13 - LRG 9276702 reopened - handle undefined & variables by calling catnothing or catxoqsys
Rem    awesley     06/19/13 - LRG 9276702 - make file_name 256 chars, use 'dbms_registry.nothing_script'
Rem    glyon       05/06/13 - bug 16763501 - component is not valid if errors
Rem    mstasiew    03/14/13 - 16473621 set ORACLE_SCRIPT
Rem    mstasiew    11/29/12 - 15844540 set to INVALID if xoq_validate crashes
Rem    awesley     04/27/12 - set registry status to OPTION OFF
Rem    awesley     03/21/12 - deprecate cwm tx 13068864 
Rem                           add xoqsys.sql, xoqroles.sql    
Rem    glyon       04/29/10 - triton conversion -- eliminate olapixds
Rem    glyon       10/28/09 - confine fixed table statistics to development
Rem    byu         06/22/09 - remove olapimod.plb and olapiomd.plb
Rem    akociube    04/08/09 - Add dbmscbu.sql
Rem    csperry     05/12/08 - Correct order due to new function dependency
Rem    glyon       06/04/07 - eliminate alter session table
Rem    csperry     05/16/07 - add install of dbms_cube_advise
Rem    dbardwel    12/21/06 - add awmxsrol.sql and awmcrxdb.plb
Rem    wechen      11/15/06 - add olapixds.plb
Rem    wechen      07/21/05 - remove olapi*92010.sql
Rem    cchiappa    01/11/05 - Move AW_XML into XOQ 
Rem    cdalessi    11/01/04 - move xoq_validate definition down 
Rem    wechen      01/05/04 - remove snapi
Rem    cdalessi    11/03/03 - fix banner 
Rem    cdalessi    10/21/03 - change refs to cwmlite and move olapimdx.plb
Rem                           down to catamd.sql
Rem    wechen      10/06/03 - re-enable xoq_validate to call OlapiBootstrap
Rem    cdalessi    08/20/03 - 
Rem    wechen      07/28/03 - xoq_validate
Rem    wechen      06/24/03 - invoke olapimov.plb
Rem    glyon       06/13/03 - add olapimdx for OLE DB for OLAP support
Rem    cdalessi    10/18/02 - cdalessi_txn103996
Rem    cdalessi    10/14/02 - Change to catxoq
Rem    wechen      08/21/02 -
Rem    cdalessi    08/15/02 -
Rem    wechen      06/26/02 -
Rem    wechen      06/05/02 -
Rem    kingols     05/31/02 -
Rem    cdalessi    02/27/02 - cdalessi_txn102058
Rem    cdalessi    02/25/02 - Creation

CREATE OR REPLACE FUNCTION pex_script
RETURN VARCHAR2 IS
BEGIN
  if sys.dbms_registry.is_loaded('XDB') = 1 THEN
     RETURN 'olapipexxdb.plb';
  else
     RETURN 'olapipex.plb';
  end if;
END pex_script;
/
 
CREATE OR REPLACE FUNCTION awmcrxdb_script
RETURN VARCHAR2 IS
BEGIN
  if sys.dbms_registry.is_loaded('XDB') = 1 THEN
     RETURN 'awmcrxdb.plb';
  else
     RETURN '?/rdbms/admin/nothing.sql';
  end if;
END awmcrxdb_script;
/
 
  
@@?/rdbms/admin/sqlsessstart.sql

execute sys.dbms_registry.loading('XOQ' ,'Oracle OLAP API' ,'xoq_validate');
@@dbmscoad.sql
@@prvtcoas.plb
@@prvtcoad.plb

COLUMN pex_name NEW_VALUE pex_file NOPRINT;

SELECT pex_script AS pex_name FROM DUAL;

@@&pex_file

declare 
obj_dne exception;
pragma exception_init(obj_dne, -4043);  
begin
execute immediate 'DROP FUNCTION pex_script';
EXCEPTION
  WHEN obj_dne THEN
     NULL;
END;
/
@@olapiboo.plb  
@@olapiecm.plb
@@olapimdm.plb
@@olapidcm.plb
@@olapidsm.plb

@@awmxsrol.sql

COLUMN awmcrxdb_name NEW_VALUE awmcrxdbfile NOPRINT;

SELECT awmcrxdb_script AS awmcrxdb_name FROM DUAL;
 
@@&awmcrxdbfile
  
declare
obj_dne exception;
pragma exception_init(obj_dne, -4043);
begin
execute immediate 'DROP FUNCTION awmcrxdb_script';
EXCEPTION
  WHEN obj_dne THEN
     NULL;
END;
/
@@catawxml.sql

@@dbmscbu.sql
@@prvtcbu.plb

REM
REM OLAP Catalog requires compatible setting of at least 9.2
REM 
REM LRG app1 tests upgrading from 9.2 to current.  The OLAPSYS user is created when the 9.2 environment
REM is installed.  The 9.2 OLAPSYS database does not contain a number items such as XML_LOADID_SEQUENCE, 
REM active catalog views, etc. that were add at 10.2.  Previously, upgrades only checked that OLAPSYS exists.
REM The changes made to xoqsys.sql insure that the OLAPSYS database exists and that it contains the 10.2 items.
REM xoqsys.sql is call directly from this script because catxoqsys.sql did nothing useful except call xoqsys.
REM  


REM If catxoq is not called with two parameters, sqlplus is supposed to prompt for missing parameters.
REM For example, if catxoq is called from the sqlplus command line with only one parameter as in '@catxoq SYSAUX'   
REM sqlplus is supposed to prompt for the missing parameter with 'Enter value for 2:'.  We have seen that this
REM prompting does not always happen when catxoq is called in a nested upgrade script.  Somehow sqlplus resolves 
REM the missing parameter on its own and any number of bad things can happen.  Mostly something like
REM 'SP2-0310: unable to open file "xoqsys.sql"' as reported in bug 17639176.       
REM The following 3 lines of code fix this problem by using a technique for setting default values in SQLPLUS 
REM scripts that have optional parameters.  If one or more parameters are not passed to the script, the code initialize the
REM parameter to '' (null) and SQLPLUS does not prompt for values.   
column 1 new_value 1
column 2 new_value 2
select '' "1", '' "2" from dual where 1=2;

COLUMN  :default_ts  NEW_VALUE dts NOPRINT
VARIABLE default_ts  VARCHAR2(30)
COLUMN  :temp_ts     NEW_VALUE tts NOPRINT
VARIABLE temp_ts     VARCHAR2(30)

BEGIN
  BEGIN
   execute immediate 'select tablespace_name from dba_tablespaces where tablespace_name = upper(''&1'') and contents = ''PERMANENT''' into :default_ts;
  EXCEPTION 
    WHEN no_data_found THEN
      :default_ts := 'SYSAUX';
  END;
   
  BEGIN
    execute immediate 'select tablespace_name from dba_tablespaces where tablespace_name = upper(''&2'') and contents = ''TEMPORARY''' into :temp_ts;
  EXCEPTION 
    WHEN no_data_found THEN
      execute immediate 'select property_value from database_properties where property_name = ''DEFAULT_TEMP_TABLESPACE''' into :temp_ts;
  END;
END;
/

select :default_ts from dual;
select :temp_ts from dual;

@@xoqsys.sql &dts &tts  -- create and populate OLAPSYS as needed

--  If CwM still exists in database call procedure to change objects 
--  privileges from Select to Read 
COLUMN :cwm_fname NEW_VALUE cwm_file NOPRINT
VARIABLE cwm_fname VARCHAR2(128)

BEGIN
  IF sys.dbms_registry.is_in_registry('AMD') = TRUE THEN
     :cwm_fname := 'xoqcwmpr.sql';
  ELSE
     :cwm_fname := '?/rdbms/admin/nothing.sql';
  END IF;
END;
/

SELECT :cwm_fname FROM DUAL;
@@&cwm_file

-- Add OLAPSYS to SCHEMA column of  DBA_REGISTRY
execute sys.dbms_registry.loading('XOQ' ,'Oracle OLAP API' ,'xoq_validate', 'OLAPSYS');

@@xoqroles.sql  -- create OLAP roles


-- XOQ is valid if compatible is set to 9.2 or higher, no errors occurred
-- duting the installation, and OlapiBootstrap() can be executed successfully.
-- Also, since the AW_XML package is dependent on it, make sure it seems to be
-- OK as well.
CREATE OR REPLACE PROCEDURE xoq_validate IS
  compat          VARCHAR2(30);
  dummy_num       NUMBER;
  dummy_out_1_str VARCHAR2(100);
  dummy_out_2_str VARCHAR2(100);
  ok              BOOLEAN := TRUE;
  v_Value         varchar2(64);
BEGIN

  -- check compatible
  SELECT ltrim(value) INTO compat FROM v$parameter WHERE name='compatible';
  IF NOT (substr(compat,1,3) >= '9.2' OR substr(compat,1,2) >= '10') THEN
    ok := FALSE;
  END IF;

  IF ok THEN
    -- check that installed library is valid
    BEGIN
      SELECT 0 INTO dummy_num FROM DBA_LIBRARIES
        WHERE STATUS = 'INVALID' AND rownum <=1 AND
          OWNER='SYS' AND LIBRARY_NAME = 'DBMS_OLAPI_LIB';
      -- at least one object is invalid so component is invalid
      ok := FALSE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      -- no invalid objects were found so component remains valid
        NULL;
    END;
  END IF;

  IF ok THEN
    -- check very basic OLAP API function (including load of shared library)
    BEGIN
      sys.dbms_aw_internal.olap_script_start;
      dummy_num := OlapiBootstrap2(compat, dummy_out_1_str, dummy_out_2_str);
    EXCEPTION
      WHEN OTHERS THEN
        ok := FALSE;
    END;
    sys.dbms_aw_internal.olap_script_end;
  END IF;

  IF ok THEN
    -- check that Java classes are loaded successfully
    BEGIN
      SELECT 0 INTO dummy_num FROM dba_objects
        WHERE owner = 'SYS' AND
             status = 'INVALID' AND
             object_type = 'JAVA CLASS' AND
             object_name LIKE 'oracle/AWXML/%';
      -- at least one class is invalid so component is invalid
      ok := FALSE;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- no invalid components were found so component remains valid
      NULL;
    END;
  END IF;

  IF ok THEN
    -- check that installed types, packages, and procedures are valid
    BEGIN
      SELECT 0 INTO dummy_num FROM DBA_OBJECTS
        WHERE STATUS = 'INVALID' AND rownum <=1 AND
          OWNER='SYS' AND OBJECT_NAME IN
             ('DBMS_CUBE_ADVISE','DBMS_CUBE_ADVISE_SEC','DBMS_CUBE',
              'DBMS_CUBE_EXP','GENDATABASEINTERFACE','GENCONNECTIONINTERFACE',
              'GENSERVERINTERACE','GENMDMPROPERTYIDCONSTANTS',
              'GENMDMCLASSCONSTANTS','GENMDMOBJECTIDCONSTANTS',
              'GENMETADATAPROVIDERINTERFACE','GENCURSORMANAGERINTERFACE',
              'GENDATATYPEIDCONSTANTS','GENDEFINITIONMANAGERINTERFACE',
              'GENDATAPROVIDERINTERFACE','DBMS_AW_XML','DBMS_CUBE_UTIL',
              'COAD_ADVICE_T','COAD_ADVICE_REC','GENOLAPIEXCEPTION',
              'GENINTERFACESTUB', 'GENINTERFACESTUBSEQUENCE',
              'GENRAWSEQUENCE','GENWSTRINGSEQUENCE',
              'DBMS_CUBE_UTIL_EXT_MD_T','DBMS_CUBE_UTIL_EXT_MD_R',
              'OLAPIHANDSHAKE2','OLAPIBOOTSTRAP2');
      -- at least one object is invalid so component is invalid
      ok := FALSE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      -- no invalid objects were found so component remains valid
        NULL;
    END;
  END IF;

  IF ok and sys.dbms_registry.is_loaded('XDB') = 1 THEN
    -- check for expected role
    BEGIN
      SELECT 0 INTO dummy_num FROM DBA_ROLES
        WHERE ROLE = 'OLAP_XS_ADMIN';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ok := FALSE;
    END;
  END IF;

  IF ok THEN
    -- Address bug 17997122 by carefully checking OLAP_XS_ADMIN role
    -- privileges against the DBA_TAB_PRIVS view. 
    -- check for privileges granted as local granted privileges, COMMON='NO'
 
    -- Bug 21856522 As of 12.2 Privs on sys owned pl/sql packages can be common = no or
    -- common = yes
    SELECT COUNT(*) INTO dummy_num
    FROM DBA_TAB_PRIVS
    WHERE GRANTEE='OLAP_XS_ADMIN' AND
          PRIVILEGE='EXECUTE' AND 
          OWNER='SYS' AND
          TABLE_NAME='DBMS_XDS';

    IF dummy_num = 0 THEN
       -- Missing grant to pl/sql package, so invalid
       ok := FALSE;
    END IF;
  END IF;

  IF ok THEN
    SELECT COUNT(*) INTO dummy_num
    FROM DBA_TAB_PRIVS
    WHERE GRANTEE='OLAP_XS_ADMIN' AND
          ((PRIVILEGE='SELECT' AND OWNER='SYS' AND
             TABLE_NAME='XS$OLAP_POLICY' AND COMMON='NO') OR
           (PRIVILEGE='SELECT' AND OWNER='SYS' AND
             TABLE_NAME='DBA_ROLES' AND COMMON='NO'));

    IF dummy_num = 0 THEN
      -- No local granted privileges
      -- check to see if grants are common granted privileges, COMMON = 'YES'
      SELECT COUNT(*) INTO dummy_num
      FROM DBA_TAB_PRIVS
      WHERE GRANTEE='OLAP_XS_ADMIN' AND
            ((PRIVILEGE='SELECT' AND OWNER='SYS' AND
               TABLE_NAME='XS$OLAP_POLICY' AND COMMON='YES') OR
             (PRIVILEGE='SELECT' AND OWNER='SYS' AND
               TABLE_NAME='DBA_ROLES' AND COMMON='YES'));
      IF dummy_num != 2 THEN
        -- Incomplete set of common granted privileges granted, so invalid
        ok := FALSE;
      END IF;

    ELSIF dummy_num = 2 THEN
      --  Grants are valid for local granted privileges.
      --  Now grants may also be a common granted privilege, COMMON = 'YES'
      SELECT COUNT(*) INTO dummy_num
      FROM DBA_TAB_PRIVS
      WHERE GRANTEE='OLAP_XS_ADMIN' AND
            ((PRIVILEGE='SELECT' AND OWNER='SYS' AND
               TABLE_NAME='XS$OLAP_POLICY' AND COMMON='YES') OR
             (PRIVILEGE='SELECT' AND OWNER='SYS' AND
               TABLE_NAME='DBA_ROLES' AND COMMON='YES'));
      IF dummy_num = 0 THEN
        -- No Common granted privileges granted,
        -- but still valid because of valid local granted privileges
        ok := TRUE;
      ELSIF dummy_num != 2 THEN
        -- Incomplete set of common granted privileges granted, so invalid
        ok := FALSE;
      END IF;
    ELSE
      -- Incomplete set of local granted privileges granted, so invalid
      ok := FALSE;
    END IF;
  END IF;

  IF ok THEN
    SELECT value INTO v_Value FROM v$option WHERE parameter = 'OLAP';
    if v_Value = 'FALSE' then
      -- set status OPTION OFF
      sys.dbms_registry.Option_Off('XOQ');
    else
      sys.dbms_registry.valid('XOQ');
    end if;
  ELSE
    sys.dbms_registry.invalid('XOQ');
  END IF;
END;
/
show errors;

execute sys.dbms_registry.loaded('XOQ');
begin
 xoq_validate;
exception
when others then
 sys.dbms_registry.invalid('XOQ');
end;
/

@@?/rdbms/admin/sqlsessend.sql

