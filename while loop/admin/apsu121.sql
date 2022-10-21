Rem
Rem $Header: oraolap/admin/apsu121.sql /main/7 2020/07/19 10:16:55 dgoddard Exp $
Rem
Rem apsu121.sql
Rem
Rem Copyright (c) 2014, 2018, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      apsu121.sql - Upgrade the APS component to 12.2
Rem
Rem    DESCRIPTION
Rem      Performs any actions necessary to upgrade the APS component
Rem      from 12.1 to 12.2
Rem
Rem    NOTES
Rem      None
Rem
Rem    BEGIN SQL_FILE_METADATA 
Rem    SQL_SOURCE_FILE: oraolap/admin/apsu121.sql 
Rem    SQL_SHIPPED_FILE: 
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE 
Rem    SQL_CALLING_FILE: oraolap/admin/apsdbmig.sql
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    ghicks      07/16/18 - bug 28354015: fix PHASE, STARTUP_MODE metadata
Rem    mstasiew    01/12/17 - Bug 25384687: proj 58196 select to read aw views
Rem    cchiappa    09/20/16 - Upgrade to 12.2
Rem    cchiappa    02/03/16 - Don't call dbms_registry here
Rem    mstasiew    04/15/15 - 20345942 proj 58196 revoke select priv for olap
Rem    cchiappa    08/05/14 - 12.1 update to 12.1 script
Rem    cchiappa    08/05/14 - Created
Rem

@@?/rdbms/admin/sqlsessstart.sql

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON ALL_AW_AC FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON all$olap2_aws FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON ALL_AW_AC_10g FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON USER_AW_PROP FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON USER_AW_OBJ FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON ALL_AW_PROP FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON ALL_AW_OBJ FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON ALL_AW_PROP_NAME FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON AW$AWCREATE FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON AW$AWCREATE10G FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON AW$AWMD FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON AW$AWREPORT FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON AW$AWXML FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'REVOKE SELECT ON AW$EXPRESS FROM PUBLIC';
EXCEPTION
 WHEN OTHERS THEN
   IF SQLCODE IN ( -04042, -1927, -942, -4045 ) THEN NULL;
   ELSE RAISE;
   END IF;
END;
/

@@apsu122

@?/rdbms/admin/sqlsessend.sql
