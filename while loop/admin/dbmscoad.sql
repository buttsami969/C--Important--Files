Rem
Rem $Header: oraolap/src/sql/dbmscoad.sql /main/14 2019/11/20 11:32:34 ghicks Exp $
Rem
Rem dbmscoad.sql
Rem
Rem Copyright (c) 2007, 2019, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      dbmscoad.sql -  Cube Organized mv ADvise public interface
Rem
Rem    DESCRIPTION
Rem      Invoker rights package spec for dbms_cube_advise.
Rem      See prvtcoad.sql for package body. Table function mv_cube_advice
Rem      produces a table of advice records containing constraint DDL 
Rem      to enhance query rewrite opportunuties for a cube MV.
Rem      in-line not null, primary/forign key, relational dimensions
Rem      and mv logs can be generated.
Rem      It also defines public table and record types that the mv_cube_advice
Rem      function returns. 
Rem
Rem    NOTES
Rem      This advice does not directly validate that the generated constraints
Rem      are respected by the data values in the source tables, however it can
Rem      generate constrainst in an ENABLE VALIDATE initial state.  This allows
Rem      the execution of the advice to validate the data.  If validation shows
Rem      the constraint be violated by the data or related constraint context
Rem      the user can choose to correct the data, modify the constraint, or 
Rem      not create the constraint if it not valid in the context
Rem      of the data model. Doing so may limit available query rewrite
Rem      transforms and thus diminish use of the cube MV in fulling queries.  
Rem      MV logs are only generated with other advice if VALIDATE is 1.
Rem      MV logs are always generated if you explicitly ask for them, reqType 5.
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/src/sql/dbmscoad.sql
Rem    SQL_SHIPPED_FILE: olap/admin/dbmscoad.sql
Rem    SQL_PHASE: DBMSCOAD
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    csperry     07/18/16 - fix b24312080 rem
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    ghicks      10/01/19 - Bug 30491698: remove drops
Rem    ghicks      07/10/19 - Bug 29470735: logical standby support
Rem    csperry     07/18/16 - fix b24312080 remove non-constant pkg vars
Rem    csperry     05/24/16 - fix bug-23335364
Rem    csperry     03/17/15 - fix 12.1 compatible mode support
Rem    csperry     01/23/15 - support long (128 byte) identifiers
Rem    mstasiew    03/14/13 - 16473621 set ORACLE_SCRIPT
Rem    csperry     01/04/08 - add trace destination constants
Rem    csperry     06/27/07 - remove check_privs proc from public view
Rem    csperry     05/29/07 - Hide errors when creating sequence
Rem    csperry     05/08/07 - add compile mv stmt type
Rem    csperry     04/19/07 - add anti-object sql statement support
Rem    csperry     01/05/07 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

Rem public record and table type supporting pipelined function mv_cube_advice

create or replace type coad_advice_rec force as OBJECT (
     owner       dbms_id,
     apiObject   dbms_id,
     sqlObjOwn   dbms_id,
     sqlObject   varchar2(261),
     adviceType  number(38,0),
     disposition clob,
     sqlText     clob,
     dropText    clob ) 
/
show errors

create or replace type coad_advice_t force is table of coad_advice_rec
/
show errors

-- Only drop if you want to reset the sequence's start with  value
-- drop sequence  DBMS_CUBE_ADVICE_SEQ$;
-- Suppress pre-existing object error ORA-00955
begin
 execute immediate 'create sequence  DBMS_CUBE_ADVICE_SEQ$ 
                    minvalue 1 maxvalue 99999999999999999999999 
                    increment by 1 start with 1 
                    cache 100 noorder cycle';
 exception when others
  then if sqlcode <> -955 
         then raise;
       end if;
end;
/
	     

CREATE OR REPLACE package dbms_cube_advise AUTHID CURRENT_USER is
   PRAGMA supplemental_log_data(default, READ_ONLY);

---------------------------------------------------------------------------
--                   PUBLIC GLOBAL VARIABLES, TYPES AND CONSTANTS
---------------------------------------------------------------------------
   subtype qref2_vc2 is varchar2(261);  /* '"128"."128"' */
   subtype qref3_vc2 is varchar2(392);  /* '"128"."128"."128"' */

   -- Advice statement types
   DBMS_COAD_ADVTYP_NN     CONSTANT BINARY_INTEGER := 1; -- NOT NULL
   DBMS_COAD_ADVTYP_PKT    CONSTANT BINARY_INTEGER := 2; -- Primary Key on Tab
   DBMS_COAD_ADVTYP_PKV    CONSTANT BINARY_INTEGER := 3; -- Primary Key on View
   DBMS_COAD_ADVTYP_FKT    CONSTANT BINARY_INTEGER := 4; -- Foriegn Key on Tab
   DBMS_COAD_ADVTYP_FKV    CONSTANT BINARY_INTEGER := 5; -- Foriegn Key on View
   DBMS_COAD_ADVTYP_RELDIM CONSTANT BINARY_INTEGER := 6; -- Relational Dimension
   DBMS_COAD_ADVTYP_MVLOG  CONSTANT BINARY_INTEGER := 7; -- MView Log
   DBMS_COAD_ADVTYP_MVCMP  CONSTANT BINARY_INTEGER := 8; -- MView compile

   -- Trace diagnostics destinations
   DBMS_COAD_DIAG_NOTRACE CONSTANT BINARY_INTEGER := 0; -- no trace messages
   DBMS_COAD_DIAG_SRVROUT CONSTANT BINARY_INTEGER := 1; -- trace to serveroutput
   DBMS_COAD_DIAG_TRCFILE CONSTANT BINARY_INTEGER := 2; -- trace to tracefile

   -- Trace diagnostics log entry types
   DBMS_COAD_DIAG_NOTE      CONSTANT BINARY_INTEGER := 0; -- Note
   DBMS_COAD_DIAG_BACKTRACE CONSTANT BINARY_INTEGER := 1; -- BACKTRACE
   DBMS_COAD_DIAG_CKMVPRIV  CONSTANT BINARY_INTEGER := 2; -- SQLERRM 
   DBMS_COAD_DIAG_HANDLED   CONSTANT BINARY_INTEGER := 3; -- ERROR_STACK

   -- Record and ref cursor type for input to table function get_atr_expr_rc()
   TYPE lvlList_r IS RECORD (
     dimOwner   DBMS_ID,
     dimName    DBMS_ID,
     lvlName    DBMS_ID);

   TYPE lvlList_t IS REF CURSOR RETURN lvlList_r;

   -- Record and table type for output from table function get_atr_expr_rc()
   type atrExprList_r is RECORD ( 
     dimOwner   DBMS_ID,
     dimName    DBMS_ID,
     lvlName    DBMS_ID,
     atrExpr    qref3_vc2);

   type atrExprList_t is TABLE of atrExprList_r;

---------------------------------------------------------------------------
--                   PUBLIC PROCEDURES AND FUNCTIONS DECLARATIONS
---------------------------------------------------------------------------


 -------------------------------- mv_cube_advice ---------------------------
 -- NAME: 
 --     mv_cube_advice
 -- 
 -- DESCRIPTION:
 --     This table function generates records that include a clob containing 
 --     sql ddl/dml that helps allow the broadest range of query rewrite 
 --     transforms possible and mv log based fast refresh for the cube based 
 --     MVs
 --
 -- PARAMETERS:
 --     owner         (IN)       - Owner of the cube MV
 --     mvName        (IN)       - Name of cube organized materialized view
 --     reqType       (IN)       - List of advice elements to generate 0-5
 --     validate      (IN)       - 1-validate constraint, 0[DEFAULT]-novalidate
 --     coad_advice_t returning  - Record that includes advice sql statments
 --
 -- REQTYPEs:
 --     0 [DEFAULT] - Generate all advice types that apply
 --     1           - column in-line not null constraints
 --     2           - primary key constraints
 --     3           - foriegn key constraints
 --     4           - relational dimension objects
 --     5           - mv logs, having 'with primary key'
 --
 -- TABLE FUNCTION RECORD FORMAT:
 --     owner       dbms_id   - Owner of apiObject
 --     apiObject   dbms_id   - Name of top apiObject
 --     sqlObjOwn   dbms_id   - Owner of primary subject object of sqlText
 --     sqlObject   dbms_id   - Name of  primary subject object of sqlText
 --     adviceType  number(38,0)   - Type of advice statement
 --     disposition varchar2(2000) - Notes of pre-existing conditions
 --     sqlText     clob           - Advice sql statment
 --     dropText    clob           - Anti-sqlText statement
 --     
 --     adviceTypes are declared in package dbms_cube_advise_int as follows
 --       1 -- NOT NULL,             DBMS_COAD_ADVTYP_NN     
 --       2 -- Primary Key on Tab,   DBMS_COAD_ADVTYP_PKT    
 --       3 -- Primary Key on View,  DBMS_COAD_ADVTYP_PKV    
 --       4 -- Foriegn Key on Tab,   DBMS_COAD_ADVTYP_FKT    
 --       5 -- Foriegn Key on View,  DBMS_COAD_ADVTYP_FKV    
 --       6 -- Relational Dimension, DBMS_COAD_ADVTYP_RELDIM 
 --       7 -- MView Log,            DBMS_COAD_ADVTYP_MVLOG
 --       8 -- MView compile,        DBMS_COAD_ADVTYP_MVCMP  
 --
 -- NOTES:
 --     This function used metadata collected from the MV itself and additional
 --     related metadata defined via the OLAP API.

   function mv_cube_advice
          (
            owner         in     varchar2 DEFAULT sys_context('USERENV', 'CURRENT_USER'),
            objName       in     varchar2,
            reqType       in     varchar2 DEFAULT '0',
            validate      in     number   DEFAULT 0
          ) return coad_advice_t pipelined;

   /* Sets dbms_coad_diag level flag. Allows diagnostics messages to go to
    * serveroutput via dbsm_output. 
    * 0 - No trace, 
    * 1 - Trace     */
   procedure trace 
             (
               diagLevel BINARY_INTEGER
             );

   /* Produced dbms_output messages based on msgids shown here  */
   procedure log
             (
               msgid BINARY_INTEGER DEFAULT 0,
               msgtxt varchar2 DEFAULT '' 
             );

   /* Set the name of an EXCEPTIONS table. See utlxexcpt.sql */
   procedure set_cns_exception_log 
             (
               exceptLogTab varchar2 DEFAULT '"'||
               sys_context('USERENV', 'CURRENT_USER') ||'"."EXCEPTIONS"'
             );

   /* Table function that returns list of attribute expressions for each
    * level when given a cursor of type lvlList_t i.e.dimension levels */
   function get_atr_expr_rc 
            (
              lvlList in lvlList_t 
            ) return atrExprList_t pipelined;

   /* Returns true if API objName has a colName that matches and is then
    * mdClass. MEASURE, UNIQUEKEYATTRIBTE, or ANY. */
   function is_md_class (
     mdClass  in      BINARY_INTEGER,
     owner    in      varchar2,
     objName  in      varchar2, 
     colName  in      varchar2) return BINARY_INTEGER ;              

   /* Gets name of table column in-line not null constraint, if any */
   function get_nn_name (
     tabOwner in      varchar2,
     tabName  in      varchar2,
     colName  in      varchar2) return varchar2;

   /* Gets name of table column primary key constraint, if any */
   function get_pk_name (
     tabOwner in      varchar2,
     tabName  in      varchar2,
     colName  in      varchar2) return varchar2; 

   /* Gets name of table column foriegn  key constraint, if any */
   function get_fk_name (
     tabOwner in      varchar2,
     tabName  in      varchar2,
     colName  in      varchar2) return varchar2; 

   /* Gets conflicting object info for dimension level mappings, if any */
   function get_dimlvl_disposition (
     tabOwner in      varchar2,
     tabName  in      varchar2,
     colName  in      varchar2) return varchar2;

   /* Gets conflicting object info for dimension name, if any */
   function get_dim_disposition (
     dimOwner in      varchar2,
     dimName  in      varchar2) return varchar2;

   /* Gets conflicting object info for hierarchy snowflake  joins, if any */
   function get_dimHierJoin_disposition (
     tabOwner in varchar2,
     tabName  in varchar2,
     colName  in varchar2) return varchar2;

   /* Gets a level name for a given dimension and column alias */
   function get_lvl_name (
     owner    in      varchar2,
     dimName  in      varchar2,
     colName  in      varchar2) return varchar2;

  /* Get count of distinct values in colName */
  function get_colDistinctCount 
    (owner   varchar2,
     tabName varchar2,
     colName varchar2) return number;

  /* Get first measure column for given MV column alias. */
  function get_meas_col
    (mvOwner  in varchar2,
     mvName   in varchar2,
     colAlias in varchar2 ) return varchar2;

  /* Function to get mv name for a given cube or cube dimension object */
  function get_mvname (
    owner    varchar2,
    objName  varchar2,
    objHier  varchar2 default NULL,    
    mvType   varchar2 default 'REFRESH' ) return varchar2;

  /* Function tests if mview has non-merged nested views */
  function check_for_nesting
   (mvOwner in varchar2,
    mvName  in varchar2 ) return boolean;

END dbms_cube_advise; /* package spec */
/
show errors



-- Give execute privileges
CREATE OR REPLACE PUBLIC SYNONYM dbms_cube_advise FOR sys.dbms_cube_advise
/
GRANT EXECUTE ON dbms_cube_advise TO PUBLIC
/

@@?/rdbms/admin/sqlsessend.sql
