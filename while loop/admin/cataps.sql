Rem
Rem *************************************************************************
Rem *** IF YOU CHANGE THIS FILE,                                          ***
Rem ***        edit oraolap/test/olapdev/src/txolapsq.tsc accordingly!    ***
Rem *************************************************************************
Rem
Rem  cataps.sql
Rem
Rem Copyright (c) 2002, 2017, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      cataps.sql
Rem
Rem    DESCRIPTION
Rem      Create OLAP AW
Rem
Rem    NOTES
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/cataps.sql
Rem    SQL_SHIPPED_FILE:olap/admin/cataps.sql
Rem    SQL_PHASE: CATAPS 
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      09/22/17 - Bug 25687751- AW lockdown
Rem    jcarey      07/07/17 - better error level calc
Rem    jcarey      03/31/17 - Bug 25684134 - better olap_on handling
Rem    jcarey      08/02/13 - shut down olap after validate
Rem    cchiappa    03/14/13 - Backport cchiappa_set_oracle_script_121010
Rem    awesley     04/27/12 - set registry status to OPTION OFF
Rem    awesley     03/21/12 - deprecate cwm tx 13068864 
Rem                           remove mvtabgs.sql, creatind.sql    
Rem    cchiappa    01/11/05 - Move AW_XML into XOQ 
Rem    cchiappa    12/15/04 - Include AWXML 
Rem    zqiu        09/25/03 - include apsviews.sql
Rem    esoyleme    06/20/03 - validation procedure
Rem    cdalessi    10/14/02 - Change to cataps
Rem    cdalessi    02/25/02 - Creation

@@?/rdbms/admin/sqlsessstart.sql

CREATE OR REPLACE PROCEDURE aps_validate IS
   AWok BOOLEAN;
   OBJok BOOLEAN;
   x NUMBER; -- dummy output spot
   junklob CLOB;
   v_Value varchar2(64);
   running BOOLEAN;
   stmt VARCHAR2(100);
BEGIN

   sys.dbms_aw_internal.olap_script_start;
   if sys.dbms_aw.olap_running() then
     running := TRUE;
   else
     running := FALSE;
   end if;
   -- AWs are valid if we can read an option
   BEGIN
     junklob := sys.dbms_aw.INTERP('show SESSCACHE');
     AWok := TRUE;
   EXCEPTION
     WHEN OTHERS THEN 
       AWok := FALSE;
   END;

   -- supporting object things
   BEGIN
     SELECT 0 INTO x FROM DBA_OBJECTS
       WHERE STATUS = 'INVALID' AND rownum <=1 AND
         OWNER='SYS' AND OBJECT_NAME IN
        ('OLAP_TABLE', 'OLAPIMPL_T', 'OLAP_SRF_T', 'OLAP_NUMBER_SRF',
         'OLAP_EXPRESSION', 'OLAP_TEXT_SRF', 'OLAP_EXPRESSION_TEXT', 
         'OLAP_BOOL_SRF', 'OLAP_EXPRESSION_BOOL');
     -- at least one object is invalid so component is invalid
     OBJok := FALSE;
   EXCEPTION
   WHEN NO_DATA_FOUND THEN
     -- no invalid objects were found so component is valid
     OBJok := TRUE;
   END;

   IF NOT running THEN
      sys.dbms_aw.shutdown(TRUE);
   END IF;

   sys.dbms_aw_internal.olap_script_end;

   IF AWok AND OBJok THEN 
     SELECT value INTO v_Value FROM v$option WHERE parameter = 'OLAP';
     if v_Value = 'FALSE' then
       sys.dbms_registry.Option_Off('APS');
     else
       sys.dbms_registry.valid('APS');
     end if;
   ELSE
     sys.dbms_registry.invalid('APS');
   END IF;
   EXCEPTION
   WHEN OTHERS THEN
     sys.dbms_aw_internal.olap_script_end;
     raise;     
  END;
/
show errors;

execute sys.dbms_registry.loading('APS' ,'OLAP Analytic Workspace' ,'aps_validate');

@@xumuts.plb

@@apsviews.sql

BEGIN
 sys.dbms_registry.loaded('APS');
 aps_validate;
END;
/

@@?/rdbms/admin/sqlsessend.sql
