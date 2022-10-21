Rem
Rem $Header: oraolap/src/sql/dbmscbu.sql /main/11 2019/11/20 11:32:34 ghicks Exp $
Rem
Rem dbmscbu.sql
Rem
Rem Copyright (c) 2009, 2019, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      dbmscbu.sql - DBMS_CUBE_UTIL declarations
Rem
Rem    DESCRIPTION
Rem      Provides interfaces for dbms_cube_util functions
Rem
Rem    NOTES
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/src/sql/dbmscbu.sql
Rem    SQL_SHIPPED_FILE: olap/admin/dbmscbu.sql
Rem    SQL_PHASE: DBMSCBU
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    ghicks      10/01/19 - Bug 30491698: remove drops
Rem    jcarey      01/15/19 - Bug 28136423 - rolling upgrade
Rem    csperry     09/08/15 - fix bug-21563035 remove unrelease feature
Rem    mstasiew    03/14/13 - 16473621 set ORACLE_SCRIPT
Rem    smierau     11/21/11 - change rpt filter member-list to clob
Rem    csperry     07/20/11 - Add new md report
Rem    ckearney    04/21/11 - add get_ext_metadata
Rem    csperry     06/29/09 - add get hierarchy special member method
Rem    smierau     03/23/09 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

create or replace type dbms_cube_util_ext_md_r force
  as object (owner             dbms_id,
             dimension_name    dbms_id,
             hierarchy_name    dbms_id,
             default_member    varchar2(4000),
             depth_count       number,
             depth             number,
             depth_cardinality number)
/

create or replace type dbms_cube_util_ext_md_t force
  as table of dbms_cube_util_ext_md_r
/

grant execute on dbms_cube_util_ext_md_r to public;
grant execute on dbms_cube_util_ext_md_t to public;

create or replace type dbms_cube_util_dflt_msr_r force
  as object (owner             dbms_id,
             cube_name         dbms_id, 
             default_measure   dbms_id )
/

create or replace type dbms_cube_util_dflt_msr_t force
  as table of dbms_cube_util_dflt_msr_r
/

grant execute on dbms_cube_util_dflt_msr_r to public;
grant execute on dbms_cube_util_dflt_msr_t to public;

CREATE OR REPLACE PACKAGE dbms_cube_util AUTHID CURRENT_USER AS

  ---------------------
  --  OVERVIEW
  --
  --  This package is the interface to cube utility functions
  --
  ---------------------
  --  Visibility        
  --   All users
  --

  ---------------------
  --  CONSTANTS

  ---------------------
  --  EXCEPTIONS

  ---------------------
  --  PROCEDURES

  -- Create a report filter
  PROCEDURE create_rpt_filter(p_owner       IN VARCHAR2,
                              p_dimension   IN VARCHAR2,
                              p_rfname      IN VARCHAR2,
                              p_member_list IN VARCHAR2);
  pragma supplemental_log_data(create_rpt_filter, auto_with_commit);

  PROCEDURE create_rpt_filter(p_owner       IN VARCHAR2,
                              p_dimension   IN VARCHAR2,
                              p_rfname      IN VARCHAR2,
                              p_member_list IN CLOB);
  pragma supplemental_log_data(create_rpt_filter, auto_with_commit);

  -- Drop a report filter
  PROCEDURE drop_rpt_filter(p_owner       IN VARCHAR2,
                            p_dimension   IN VARCHAR2,
                            p_rfname      IN VARCHAR2);
  pragma supplemental_log_data(drop_rpt_filter, auto_with_commit);

  -- Drop a branch
  PROCEDURE drop_branch(p_owner       IN VARCHAR2,
                        p_dimension   IN VARCHAR2);
  pragma supplemental_log_data(drop_branch, auto_with_commit);


  -- return extended metadata
  FUNCTION get_ext_metadata(owner          IN VARCHAR2 DEFAULT NULL,
                            dimension_name IN VARCHAR2 DEFAULT NULL)
  return sys.dbms_cube_util_ext_md_t
  pipelined;

  -- return default measure
  FUNCTION get_default_measure(owner     IN VARCHAR2 DEFAULT NULL,
                               cube_name IN VARCHAR2 DEFAULT NULL)
  return sys.dbms_cube_util_dflt_msr_t 
  pipelined;

END dbms_cube_UTIL; 
/
show errors;

-- Give execute privileges
CREATE OR REPLACE PUBLIC SYNONYM dbms_cube_util FOR sys.dbms_cube_util
/
GRANT EXECUTE ON dbms_cube_util TO PUBLIC
/

@@?/rdbms/admin/sqlsessend.sql
