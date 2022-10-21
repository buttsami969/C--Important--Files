--
-- $Header: oraolap/src/sql/dbmsawx.sql /main/7 2019/09/11 16:12:52 jcarey Exp $
--
-- dbmsawx.sql
--
-- Copyright (c) 2004, 2019, Oracle and/or its affiliates. All rights reserved.
--
--    NAME
--      dbmsawx.sql - Public definitions for DBMS_AW_XML
--
--    DESCRIPTION
--      Provides the prototype for the DBMS_AW_XML package
--
--    NOTES
--      <other useful comments, qualifications, etc.>

Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/src/sql/dbmsawx.sql
Rem    SQL_SHIPPED_FILE: olap/admin/dbmsawx.sql
Rem    SQL_PHASE: DBMSAWX
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA

--
--    MODIFIED   (MM/DD/YY)
--    jcarey      08/26/19 - logstandby cleanup
--    mstasiew    03/15/13 - 16473621 set ORACLE_SCRIPT
--    glyon       04/01/08 - add compressed form of readAWMetadata
--    cchiappa    03/07/05 - Add executefile 
--    dmellor     12/29/04 - Add readAWMetadata
--    cchiappa    12/13/04 - Created
--

@@?/rdbms/admin/sqlsessstart.sql

CREATE OR REPLACE PACKAGE dbms_aw_xml AUTHID CURRENT_USER AS
  FUNCTION execute(input IN CLOB) RETURN VARCHAR2;
  PRAGMA SUPPLEMENTAL_LOG_DATA(execute, UNSUPPORTED);
  FUNCTION readAWMetadata(input varchar2, input2 varchar2)
             RETURN GENWSTRINGSEQUENCE;
  pragma supplemental_log_data(readAWMetadata, READ_ONLY);
  PROCEDURE readAWMetadata1(byteParams IN OUT GENRAWSEQUENCE, wstrParams IN OUT GENWSTRINGSEQUENCE);
  pragma supplemental_log_data(readAWMetadata1, READ_ONLY);
  FUNCTION executefile(dirname IN VARCHAR2, fname IN VARCHAR2) RETURN VARCHAR2;
  PRAGMA SUPPLEMENTAL_LOG_DATA(executefile, UNSUPPORTED);

END dbms_aw_xml;
/
SHOW ERRORS;

-- Give execute privileges
CREATE OR REPLACE PUBLIC SYNONYM dbms_aw_xml FOR sys.dbms_aw_xml
/
GRANT EXECUTE ON dbms_aw_xml TO PUBLIC
/

@@?/rdbms/admin/sqlsessend.sql
