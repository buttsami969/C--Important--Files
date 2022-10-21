Rem
Rem $Header: oraolap/admin/catnoaps.sql /main/14 2020/08/24 10:32:20 jcarey Exp $
Rem
Rem catnoaps.sql
Rem
Rem Copyright (c) 2001, 2020, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      catnoaps.sql - Deinstall APS (OLAP) RDBMS component
Rem
Rem    DESCRIPTION
Rem
Rem
Rem    
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/catnoaps.sql
Rem    SQL_SHIPPED_FILE: olap/admin/catnoaps.sql
Rem    SQL_PHASE: UTILITY 
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      08/20/20 - more guard code.
Rem    jcarey      08/07/20 - Bug 31725025 - guard drops
Rem    zqiu        07/29/19 - bug 30088497, protect aps_clean
Rem    ghicks      07/16/18 - bug 28354015: fix STARTUP_MODE metadata
Rem    cchiappa    02/19/15 - Fix long identifiers
Rem    zqiu        11/13/14 - lrg 13331942, rm cdb views
Rem    cchiappa    04/14/14 - Add sqlsess{start,end} calls
Rem    zqiu        08/13/10 - more printouts at error
Rem    akociube    03/06/09 - Remove component info
Rem    cchiappa    04/02/04 - Fix misspelling
Rem    zqiu        01/13/04 - do something
Rem    cdalessi    10/11/02 - Creation

@@?/rdbms/admin/sqlsessstart.sql

create or replace procedure aps_clean as
  -- Note - aps_clean is only invoked if we've
  -- already verified that there are no 
  -- user AWs, so blindly assuming SYS schema
  -- should be OK.
  CURSOR c1 IS SELECT a.awname FROM aw$ a;
  awname   varchar2(132); -- M_IDEN + SYS.
  dropstmt varchar2(300);
  table_does_not_exist exception;
  pragma exception_init(table_does_not_exist, -942);
  sequence_does_not_exist exception;
  pragma exception_init(sequence_does_not_exist, -2289);
begin
  /* Drop AW tables, the trigger will do the rest */
  for awname_rec in c1 loop 
    awname := SYS.DBMS_ASSERT.QUALIFIED_SQL_NAME('SYS.' ||
              SYS.DBMS_ASSERT.ENQUOTE_NAME('AW$' || awname_rec.awname));
    dropstmt := 'drop table ' || awname ;
    dbms_output.put_line(dropstmt);
    begin 
      execute immediate dropstmt;
    EXCEPTION
      WHEN table_does_not_exist THEN
        NULL;
     END;

    -- not all AWs will have a sequence on the AW table
    BEGIN
      awname := SYS.DBMS_ASSERT.QUALIFIED_SQL_NAME('SYS.' ||
                SYS.DBMS_ASSERT.ENQUOTE_NAME(awname_rec.awname || '_S$'));
      dropstmt := 'drop sequence ' || awname ;
      execute immediate dropstmt;
    EXCEPTION
      WHEN sequence_does_not_exist THEN
        NULL;
    END;
  end loop;

  commit;
end;
/

-- anonymous block
DECLARE
  tb_exist  number;
  olap_user number;
  aw_left   VARCHAR2(257); -- 2 * M_IDEN + .
  msg_left  VARCHAR2(500);
  view_does_not_exist exception;
    pragma exception_init(view_does_not_exist, -942);
  sequence_does_not_exist exception;
    pragma exception_init(sequence_does_not_exist, -2289);
  private_synonym_dne exception;
    pragma exception_init(private_synonym_dne, -1434);
BEGIN 
  SELECT count(*) INTO tb_exist FROM aw$ WHERE awseq# >= 1000;
  SELECT count(*) INTO olap_user FROM gv$aw_olap;	
  IF tb_exist > 0 OR olap_user > 0 THEN
    IF tb_exist > 0 THEN
      SELECT  owner || '.' || aw_name
        INTO aw_left FROM dba_aws
       WHERE aw_number >= 1000 AND rownum = 1; 
      tb_exist := tb_exist - 1;
      msg_left := aw_left || ' and ' || tb_exist ||
                  ' other user created AWs exist';
    ELSE
      msg_left := 'Olap objects in use';
    END IF;

    RAISE_APPLICATION_ERROR(-20003,  
                  msg_left || ', unable to deinstall OLAP');
  END IF;  
  sys.dbms_registry.removing('APS');
  
  BEGIN
    execute immediate 'DROP VIEW CDB_AW_PROP';
    EXCEPTION
      WHEN view_does_not_exist THEN
      NULL;
  END;
  BEGIN
    execute immediate 'DROP VIEW DBA_AW_PROP';
  EXCEPTION
    WHEN view_does_not_exist THEN
	NULL;
  END;
  BEGIN
    execute immediate 'DROP VIEW USER_AW_PROP';
  EXCEPTION
    WHEN view_does_not_exist THEN
	NULL;
  END;
  BEGIN
    execute immediate 'DROP VIEW ALL_AW_PROP';
  EXCEPTION
    WHEN view_does_not_exist THEN
	NULL;
  END;

  BEGIN
    execute immediate 'DROP SYNONYM CDB_AW_PROP';
    EXCEPTION
      WHEN private_synonym_dne THEN
    NULL;
  END;
  BEGIN
    execute immediate 'DROP SYNONYM DBA_AW_PROP';
    EXCEPTION
      WHEN private_synonym_dne THEN
    NULL;
  END;
  BEGIN
    execute immediate 'DROP SYNONYM USER_AW_PROP';
    EXCEPTION
      WHEN private_synonym_dne THEN
    NULL;
  END;
  BEGIN
    execute immediate 'DROP SYNONYM ALL_AW_PROP';
    EXCEPTION
      WHEN private_synonym_dne THEN
    NULL;
  END;

  BEGIN
    execute immediate 'DROP VIEW CDB_AW_OBJ';
    EXCEPTION
      WHEN view_does_not_exist THEN
    NULL;
  END;
  BEGIN
    execute immediate 'DROP VIEW DBA_AW_OBJ';
    EXCEPTION
      WHEN view_does_not_exist THEN
    NULL;
  END;
  BEGIN
    execute immediate 'DROP VIEW USER_AW_OBJ';
    EXCEPTION
      WHEN view_does_not_exist THEN
    NULL;
  END;
  BEGIN
    execute immediate 'DROP VIEW ALL_AW_OBJ';
    EXCEPTION
      WHEN view_does_not_exist THEN
    NULL;
  END;

  BEGIN
    execute immediate 'DROP SYNONYM CDB_AW_OBJ';
    EXCEPTION
      WHEN private_synonym_dne THEN
    NULL;
  END;
  BEGIN
    execute immediate 'DROP SYNONYM DBA_AW_OBJ';
    EXCEPTION
      WHEN private_synonym_dne THEN
    NULL;
  END;
  BEGIN
    execute immediate 'DROP SYNONYM USER_AW_OBJ';
    EXCEPTION
      WHEN private_synonym_dne THEN
    NULL;
  END;
  BEGIN
    execute immediate 'DROP SYNONYM ALL_AW_OBJ';
    EXCEPTION
      WHEN private_synonym_dne THEN
    NULL;
  END;

  BEGIN
  execute immediate 'DROP VIEW all_aw_numbers';
  EXCEPTION
    WHEN view_does_not_exist THEN
	NULL;
  END;

  aps_clean;
  sys.dbms_registry.removed('APS');
END;
/
drop procedure aps_clean;

-- No longer show up in dba_registry
delete from registry$ where cid='APS' and status='99';

@?/rdbms/admin/sqlsessend.sql
