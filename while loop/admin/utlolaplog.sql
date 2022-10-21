Rem Copyright (c) 2007, 2020, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem NAME
REM    UTLOLAPLOG.SQL
Rem  FUNCTION
Rem  NOTES
Rem    This version of utlolaplog.sql matches the 11.2 release
Rem    of Oracle
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/utlolaplog.sql
Rem    SQL_SHIPPED_FILE: olap/admin/utlolaplog.sql
Rem    SQL_PHASE: UTILITY 
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem  MODIFIED
Rem     jcarey     08/07/20  - Bug 31725025 - guard drops
Rem     ghicks     07/16/18  - bug 28354015: fix STARTUP_MODE metadata
Rem     cchiappa   10/07/08  - Move sequence creation to prvtcbl.sql
Rem     smesropi   08/27/08  - Added COMMAND_STATUS_NUMBER for sorting
Rem     cchiappa   08/26/08  - Call DBMS_CUBE_LOG.TABLE_CREATE
Rem     lmarguli   08/05/08  - Added SEQUENCE CUBE_LOG_EVENT_ID
Rem     dgreenfi   05/07/08  - Fixed views to account for RAC sequence oddity
Rem     dgreenfi   04/25/08  - Added standard view definitions
Rem     lmarguli   02/19/08  - Changed width of PARTITION column from 10 to 50
Rem     sfeinste   11/29/07  - Added IN_BRANCH column
Rem     dgreenfi   07/27/07  - Added BUILD_SCRIPT, BUILD_TYPE, COMMAND_DEPTH, 
Rem                            BUILD_SUB_OBJECT, REFRESH_METHOD, SEQ_NUMBER,
Rem                            COMMAND_NUMBER
Rem     dgreenfi   05/16/07  - Changed OUTPUT to be a CLOB and added
Rem                            SLAVE_NUMBER
Rem     dgreenfi   05/01/07  - Added BUILD_OBJECT_TYPE and OWNER
Rem     jhartsin   04/13/07  - Renamed OLAP_API_BUILD_LOG to CUBE_BUILD_LOG
Rem     cvenezia   03/29/07  - Add SCHEDULER_JOB column for bug 5931530
Rem     cvenezia   03/21/07  - Start SEQUENCE for build_id at 1 for bug 5929600
Rem     cvenezia   02/07/07  - Add SEQUENCE for build_id
Rem     dgreenfi   01/09/07  - Creation
Rem
Rem This is the format for the table that is used by the 
Rem OLAP API build processor.   If this table is defined in the
Rem user's schema, then the build process will use it to log events.
Rem The actual table format is defined in the prvtcbl.sql, this script
Rem calls DBMS_CUBE_LOG to actually create the table

DECLARE
table_dne exception;
pragma exception_init(table_dne, -942);
BEGIN
  execute immediate 'DROP TABLE CUBE_BUILD_LOG';
EXCEPTION
  WHEN table_dne THEN
     NULL;
END;
/
EXECUTE DBMS_CUBE_LOG.TABLE_CREATE(DBMS_CUBE_LOG.TYPE_BUILD, 'CUBE_BUILD_LOG');

-- View containing only the rows for the last build
CREATE OR REPLACE VIEW CUBE_BUILD_LATEST AS
SELECT C.* 
FROM 
  CUBE_BUILD_LOG C,
  (SELECT MAX(BUILD_ID) KEEP (DENSE_RANK FIRST ORDER BY TIME DESC) MM FROM CUBE_BUILD_LOG)
  WHERE C.BUILD_ID = MM
;

-- Report that collapses all rows for a single 
-- command into one summary row
CREATE OR REPLACE VIEW CUBE_BUILD_REPORT AS
SELECT
 BUILD_ID,
 start_log.SLAVE_NUMBER,
 CASE WHEN
   start_log.SLAVE_NUMBER IS NULL OR start_log.SLAVE_NUMBER = 0
   THEN 'MASTER'
   ELSE ('SLAVE #' || TO_CHAR(start_log.SLAVE_NUMBER))
   END PROCESS,
 end_log.STATUS STATUS,
 start_log.COMMAND,
 COMMAND_NUMBER,
 start_log.COMMAND_DEPTH,
 RPAD(' ', start_log.COMMAND_DEPTH) || start_log.COMMAND NESTED_COMMAND,
 start_log.BUILD_OBJECT,
 start_log.BUILD_SUB_OBJECT,
 start_log.BUILD_OBJECT_TYPE,
 end_log.OUTPUT,
 start_log.AW,
 start_log.OWNER,
 start_log.PARTITION,
 start_log.SCHEDULER_JOB,
 start_log.TIME START_TIME,
 end_time END_TIME,
 NVL(end_time, CAST(SYSTIMESTAMP AS TIMESTAMP)) - start_log.TIME ELAPSED_TIME,
 substr(NVL(end_time, CAST(SYSTIMESTAMP AS TIMESTAMP)) - start_log.TIME, 11) ELAPSED,
 start_log.BUILD_SCRIPT,
 start_log.BUILD_TYPE,
 start_log.REFRESH_METHOD,
 SEQ_NUMBER,
 CASE
   WHEN start_log.IN_BRANCH = 1 THEN 'YES'
   ELSE 'NO'
 END IN_BRANCH
FROM
 (SELECT
    L1.*,
    NVL(SLAVE_NUMBER, 0) SN
  FROM CUBE_BUILD_LOG L1
  WHERE COMMAND_STATUS_NUMBER = 1) start_log
 JOIN
 (SELECT
    L2.*,
    CASE WHEN COMMAND_STATUS_NUMBER = 1 THEN NULL ELSE TIME END end_time
  FROM
    (SELECT
       L2.*,
       MAX(COMMAND_STATUS_NUMBER) OVER (
          PARTITION BY build_id, seq_number,
          command_number, NVL(SLAVE_NUMBER, 0)) CSN,
       NVL(SLAVE_NUMBER, 0) SN
     FROM CUBE_BUILD_LOG L2) L2
  WHERE COMMAND_STATUS_NUMBER = CSN) end_log
 USING (BUILD_ID, SEQ_NUMBER, COMMAND_NUMBER, SN)
/

-- A summary report of the lastest build
CREATE OR REPLACE VIEW CUBE_BUILD_REPORT_LATEST AS
SELECT C.* 
FROM 
  CUBE_BUILD_REPORT C,
  (SELECT MAX(BUILD_ID) KEEP (DENSE_RANK FIRST ORDER BY TIME DESC) MM FROM CUBE_BUILD_LOG)
  WHERE C.BUILD_ID = MM
;
