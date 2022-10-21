Rem
Rem $Header: oraolap/admin/xoqdrop.sql /main/19 2020/08/24 10:32:20 jcarey Exp $
Rem
Rem xoqdrop.sql
Rem
Rem Copyright (c) 2005, 2020, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      xoqdrop.sql -
Rem
Rem    DESCRIPTION
Rem
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/xoqdrop.sql
Rem    SQL_SHIPPED_FILE:olap/admin/xoqdrop.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      08/20/20 - More guard drops
Rem    jcarey      08/07/20 - Bug 31725025 - guard drops
Rem    glyon       01/04/12 - LRG 6666992: more triton changes
Rem    glyon       10/10/11 - triton parameter and package renames
Rem    glyon       08/09/10 - LRG 4815217 - Triton conversion
Rem    glyon       11/03/09 - more drops from olapimov.sql
Rem    akociube    04/08/09 - Add drop of dbms_cube_util
Rem    glyon       03/09/09 - Add drops of xoq_validate and interactionexecute
Rem    csperry     05/17/07 - Add drop of dbms_cube_advise
Rem    glyon       05/03/07 - drop dbms_cube and dbms_cune_exp
Rem    dbardwel    12/21/06 - remove AWMs /olap_data_security from xml db
Rem    wechen      12/06/06 - more drops from olapiboo.sql
Rem    wechen      11/14/06 - delete /OLAP_XDS
Rem    ilisansk    08/12/05 - removed drops from olapimdx.sql
REM    wechen      08/05/05 - remove SQLOLAPIException, OlapiBootstra &
REM                           OlapiHandshake, drop GenWstringSequence
Rem    wechen      07/21/05 - remove olapi*92010.sql
Rem    wechen      05/24/05 - wechen_txn115245
Rem    wechen      05/23/05 - Creation

DECLARE
obj_dne exception;
pragma exception_init(obj_dne, -4043);
sequence_dne exception;
pragma exception_init(sequence_dne, -2289);
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
tab_view_dne exception;
pragma exception_init(tab_view_dne, -942);
trigger_dne exception;
pragma exception_init(trigger_dne, -4080);
  --Execute Immediate Drop dbms_cube_advise
BEGIN
  BEGIN
  execute immediate 'drop package dbms_cube_advise';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate 'drop package dbms_cube_advise_sec';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate 'drop type coad_advice_t';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate 'drop type coad_advice_rec';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate 'drop sequence  DBMS_CUBE_ADVICE_SEQ$';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;

  -- all DROPs from olapiboo.sql

  BEGIN
  EXECUTE IMMEDIATE 'DROP TYPE GenOLAPIException FORCE';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM OlapiHandshake2';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE OlapiHandshake2';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM OlapiBootstrap2';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP FUNCTION OlapiBootstrap2';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP LIBRARY DBMS_OLAPI_LIB';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TYPE GenInterfaceStub FORCE';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TYPE GenInterfaceStubSequence FORCE';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TYPE GenRawSequence FORCE';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TYPE GenWstringSequence FORCE';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PACKAGE dbms_cube';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PACKAGE dbms_cube_exp';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE OLAP_ATTRIBUTES_SEQ';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE OLAP_DIMENSIONALITY_SEQ';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE OLAP_DIM_LEVELS_SEQ';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE OLAP_HIERARCHIES_SEQ';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE OLAP_HIER_LEVELS_SEQ';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE OLAP_MAPPINGS_SEQ';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE OLAP_MEASURES_SEQ';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE OLAP_MODELS_SEQ';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE OLAP_ASSIGNMENTS_SEQ';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE OLAP_CALCULATED_MEMBERS_SEQ';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;
  -- all DROPs from olapilib.sql

  BEGIN
  EXECUTE IMMEDIATE 'DROP LIBRARY DBMS_OLAPI_LIB2';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;
  -- all DROPs from olapimov.sql

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM GV_Olapi_Session_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM V_Olapi_Session_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM GV_Olapi_Iface_Object_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM V_Olapi_Iface_Object_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM GV_Olapi_Iface_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM V_Olapi_Iface_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM GV_Olapi_Memory_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM V_Olapi_Memory_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM GV_Ksmhp FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM Olapi_History_Seq FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM Olapi_History FORCE';
  EXCEPTION
    WHEN synonynm_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM Olapi_Session_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM Olapi_Iface_Object_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM Olapi_Iface_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM Olapi_Memory_Op_History FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM Olapi_Memory_Heap_History FORCE';
  EXCEPTION
    WHEN synonynm_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM DBMS_XSOQ FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM DBMS_XSOQ_UTIL FORCE';
  EXCEPTION
    WHEN synonym_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW GV_Olapi_Session_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW V_Olapi_Session_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW GV_Olapi_Iface_Object_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW V_Olapi_Iface_Object_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW GV_Olapi_Iface_Op_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW V_Olapi_Iface_Op_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW GV_Olapi_Memory_Op_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW V_Olapi_Memory_Op_History';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW GV_Ksmhp';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE Olapi_History_Seq';
  EXCEPTION
    WHEN sequence_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Olapi_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Olapi_Session_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Olapi_Iface_Object_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Olapi_Iface_Op_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Olapi_Memory_Op_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Olapi_Memory_Heap_History CASCADE CONSTRAINTS';
  EXCEPTION
    WHEN tab_view_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE OlapiHistoryRetention';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TRIGGER OlapiStartupTrigger';
  EXCEPTION
    WHEN trigger_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP TRIGGER OlapiShutdownTrigger';
  EXCEPTION
    WHEN trigger_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PACKAGE DBMS_XSOQ';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  EXECUTE IMMEDIATE 'DROP PACKAGE DBMS_XSOQ_UTIL';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;
END;
/

-- drop OLAPI_TRACE_USER role, it it exists
declare
  cursor xoqrole is select role from dba_roles where role = 'OLAPI_TRACE_USER';
  xoqrolename varchar2(30);
begin
  if not xoqrole%isopen then
    open xoqrole;
    fetch xoqrole into xoqrolename;
    if xoqrole%found then
      execute immediate 'DROP ROLE OLAPI_TRACE_USER';
    end if;
    close xoqrole;
  end if;
end;
/

-- all DROPs from dbmscbu.sql

declare
synonym_dne exception;
pragma exception_init(synonym_dne, -1432);
BEGIN
EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM DBMS_CUBE_UTIL';
EXCEPTION
  WHEN synonym_dne THEN
     NULL;
END;
/
DECLARE
obj_dne exception;
pragma exception_init(obj_dne, -4043);
BEGIN
EXECUTE IMMEDIATE 'DROP PACKAGE DBMS_CUBE_UTIL';
EXCEPTION
  WHEN obj_dne THEN
     NULL;
END;
/
-- all DROPs from generated olapidrp.sql
@@olapidrp.plb

-- execute immediate drop data security
declare
  cursor cop is
    select schema_name, logical_name, policy_name
      from xs$olap_policy;
  rop cop%rowtype;
  cursor cis (p_name dba_xs_realm_constraints.policy%type) is
    select policy, acl
      from dba_xs_realm_constraints
     where policy=p_name;
  ris cis%rowtype;
  cursor cacl (a_name dba_xs_acls.name%type) is
    select name
      from dba_xs_acls
     where name=a_name;
  racl cacl%rowtype;
begin
  -- loop over OLAP policies
  open cop;
  loop
    fetch cop into rop;
    exit when cop%notfound;

    -- execute immediate drop OLAP policy
    dbms_xds.drop_olap_policy(rop.schema_name, rop.logical_name);

    -- loop over instance sets for OLAP policy
    open cis (rop.policy_name);
    loop
      fetch cis into ris;
      exit when cis%notfound;

      -- delete data security
      begin
        xs_data_security.delete_policy(ris.policy, xs_admin_util.default_option);
      exception
        when others then null;
      end;

      -- loop over ACLs for instance set
      open cacl (ris.acl);
      loop
        fetch cacl into racl;
        exit when cacl%notfound;

        -- delete access control list
        xs_acl.delete_acl(racl.name);
      end loop;
      close cacl;

    end loop;
    close cis;

  end loop;
  close cop;
end;
/

-- drop validation procedure

DECLARE
obj_dne exception;
pragma exception_init(obj_dne, -4043);
BEGIN
execute immediate 'drop procedure xoq_validate';
EXCEPTION
  WHEN obj_dne THEN
     NULL;
END;
/
-- execute immediate drop AWXML stuff

DECLARE
obj_dne exception;
pragma exception_init(obj_dne, -4043);
BEGIN
execute immediate 'drop function interactionexecute';
EXCEPTION
  WHEN obj_dne THEN
     NULL;
END;
/

DECLARE
obj_dne exception;
pragma exception_init(obj_dne, -4043);
BEGIN
execute immediate 'drop package dbms_aw_xml';
EXCEPTION
  WHEN obj_dne THEN
     NULL;
END;
/
