REM
REM Copyright (c) 2002, 2017, Oracle and/or its affiliates. 
REM All rights reserved.
REM
REM Name
REM   awmxsrol.sql
REM
REM Description
REM   OLAP_XS_ADMIN Role grants
REM
REM Notes
REM
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/awmxsrol.sql
Rem    SQL_SHIPPED_FILE:olap/admin/awmxsrol.sql
Rem    SQL_PHASE:AWMXSROL
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
REM MODIFIED (MM/DD/YY)
REM   yanlili  04/23/15 - Bug 20131705: Allow grant schema privileges to db role
REM   yanlili  01/12/15 - Bug 20131705: Remove xs_resource role
REM   awesley  02/14/14 - add calls to sqlsessstart.sql and sqlsessend.sql
REM   awesley  09/24/12 - create OlapPrivileges security class if it does not exist
REM   smierau  09/14/12 - Remove grants on xdb security view for R12
REM   awesley  08/29/12 - remove grants on XDB.XS$DATA_SECURITY
REM                       add grants on dbms_xds, xs$olap_policy, dba_roles
REM   wechen   05/28/12 - fix lrg 7006176
REM   glyon    02/24/12 - more triton changes
REM   glyon    05/05/10 - triton conversion
REM   -- 12.1 above this line
REM   dbardwel 04/25/08 - Add additional privileges for olap_xs_admin role for 11.2
REM   -- 11.2 -- above this line --
REM   dbardwel 08/07/07 - Add select on dba_xds_instance_sets to olap_xs_admin
REM   --- 11.1.0.7 -- Patch changes above this line ---
REM   dbardwel 06/15/07 - Add select on dba_roles to olap_xs_admin
REM   dbardwel 05/17.07 - Add olap_xs_admin role to DBA role
REM   dbardwel 01/17/07 - Rename awm_xs_admin -> olap_xs_admin
REM   dbardwel 12/01/06 - For AWM Release 11G R1
REM

@@?/rdbms/admin/sqlsessstart.sql

Rem add olap_xs_admin role if needed
declare
  cursor apsrole is select role from dba_roles where role = 'OLAP_XS_ADMIN';
  apsrolename varchar2(30);
begin
  if not apsrole%isopen then
    open apsrole;
    fetch apsrole into apsrolename;
    if apsrole%notfound then
      execute immediate 'create role olap_xs_admin not identified';
    end if;
    close apsrole;
  end if;
end;
/

Rem grants for olap_xs_admin role
exec xs_admin_util.grant_system_privilege('admin_sec_policy', 'olap_xs_admin', xs_admin_util.ptype_db);

--Rem in R12 XDB.XS$DATA_SECURITY no longer exists
grant execute on dbms_xds to olap_xs_admin;
grant select on xs$olap_policy to olap_xs_admin;
grant select on dba_roles to olap_xs_admin;

grant olap_xs_admin to DBA;

Rem create OlapPrivileges security class
declare
  sc_count number;
begin
  select count(*) into sc_count from sys.user_xs_security_classes where name = 'OlapPrivileges';
  if sc_count = 0 then
     xs_security_class.create_security_class(name=>'"OlapPrivileges"', priv_list=>NULL, parent_list=>XS$NAME_LIST('SYS.DML'), description => 'OLAP Data Security Class');
  end if;
end;
/

@@?/rdbms/admin/sqlsessend.sql
