Rem
Rem  apsviews.sql
Rem
Rem Copyright (c) 2002, 2017, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      apsviews.sql
Rem
Rem    DESCRIPTION
Rem      Create OLAP AW related views not in catxs.sql
Rem
Rem    NOTES
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/apsviews.sql
Rem    SQL_SHIPPED_FILE:olap/admin/apsviews.sql
Rem    SQL_PHASE: UPGRADE
Rem    SQL_STARTUP_MODE: UPGRADE
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    ghicks      03/14/17 - bug 25713495 - pass 'SYS' to create_cdbview
Rem    mstasiew    04/02/15 - 20345942 proj 58196 read priv, ora_check_sys_priv
Rem    zqiu        09/03/14 - bug 19556059, add cdb views
Rem    cchiappa    03/14/13 - Backport cchiappa_set_oracle_script_121010
Rem    dbardwel    10/27/08 - updates for all$olap2_aws to work correctly with 11.2
Rem    dbardwel    08/19/08 - Move definition of all$olap2_aws view to apsviews.sql
Rem                           Also just return 11.1, 10.2, and 10.1 AWs now
Rem    dbardwel    01/24/05 - Support for Version 10.2 for  ALL_AW_AC_10g
Rem    dbardwel    07/20/04 - Add new views ALL_AW_AC and ALL_AW_AC_10_1_0_3
Rem                           for all active catalog AWs
Rem    dbardwel    04/08/04 - Remove ALL_AW_NUMBERS no longer needed.
Rem    dbardwel    03/29/04 - Add ALL_AW_PROP_NAME view for all_olap2_aws
Rem    dbardwel    03/26/04 - Added missing join to ALL_AW_PROP
Rem    ghicks      03/05/04 - new columns in aw_prop$ views
Rem    ckearney    11/20/03 - add ALL_AW_NUMBERS
Rem    zqiu        10/08/03 - hide the deleted; show prop type, val
Rem    zqiu        10/01/03 - fix redundancy in all_ views
Rem    zqiu        09/26/03 - zqiu_txn108960
Rem    zqiu        09/25/03 - creation

@@?/rdbms/admin/sqlsessstart.sql

-- create views on aw_prop$

create or replace view DBA_AW_PROP
(OWNER, AW_NUMBER, AW_NAME, OBJ_ID, OBJ_NAME, 
 PROPERTY_NAME, PROPERTY_TYPE, PROPERTY_VALUE,
 FULL_PROPERTY_VALUE, PROPERTY_VALUE_LENGTH)
as
SELECT u.name, a.awseq#, a.awname, p.oid, p.objname, 
       p.propname, dbms_aw.olap_type(nvl(p.proptype, 0)),
       dbms_aw.prop_val(p.rowid), dbms_aw.prop_clob(p.rowid),
       dbms_aw.prop_len(p.rowid) 
FROM aw$ a, aw_prop$ p, user$ u, 
     (select max(rowid) keep (dense_rank last order by gen#) rid
           from aw_prop$ group by awseq#, oid, propname)  
WHERE   a.owner#=u.user# and a.awseq#=p.awseq# 
        and p.rowid = rid and p.propval IS NOT NULL
/

comment on table DBA_AW_PROP is
'Object properties in Analytic Workspaces in the database'
/
comment on column DBA_AW_PROP.OWNER is
'Owner of the Analytic Workspace'
/
comment on column DBA_AW_PROP.AW_NUMBER is
'Number of the Analytic Workspace'
/
comment on column DBA_AW_PROP.AW_NAME is
'Name of the Analytic Workspace'
/
comment on column DBA_AW_PROP.OBJ_ID is
'Object ID in the Analytic Workspace'
/
comment on column DBA_AW_PROP.OBJ_NAME is
'Object name in the Analytic Workspace'
/
comment on column DBA_AW_PROP.PROPERTY_NAME is
'Property name of the object in the Analytic Workspace'
/
comment on column DBA_AW_PROP.PROPERTY_TYPE is
'Type of the property in the Analytic Workspace'
/
comment on column DBA_AW_PROP.PROPERTY_VALUE is
'Value of the property in the Analytic Workspace'
/
comment on column DBA_AW_PROP.FULL_PROPERTY_VALUE is
'Complete value of the property in the Analytic Workspace'
/
comment on column DBA_AW_PROP.PROPERTY_VALUE_LENGTH is
'Length in bytes of the property in the Analytic Workspace'
/

execute SYS.CDBView.create_cdbview(false,'SYS','DBA_AW_PROP','CDB_AW_PROP');
create or replace public synonym CDB_AW_PROP for sys.CDB_AW_PROP;
grant select on CDB_AW_PROP to select_catalog_role;

create or replace view USER_AW_PROP
(AW_NUMBER, AW_NAME, OBJ_ID, OBJ_NAME, 
 PROPERTY_NAME, PROPERTY_TYPE, PROPERTY_VALUE,
 FULL_PROPERTY_VALUE, PROPERTY_VALUE_LENGTH)
as
SELECT a.awseq#, a.awname, p.oid, p.objname, 
       p.propname, dbms_aw.olap_type( nvl(p.proptype, 0)),
       dbms_aw.prop_val(p.rowid), dbms_aw.prop_clob(p.rowid),
       dbms_aw.prop_len(p.rowid) 
FROM aw$ a, aw_prop$ p,
     (select max(rowid) keep (dense_rank last order by gen#) rid
           from aw_prop$ group by awseq#, oid, propname) 
WHERE   a.owner#=USERENV('SCHEMAID') and a.awseq#=p.awseq#
        and p.rowid = rid and p.propval IS NOT NULL
/

comment on table USER_AW_PROP is
'Object properties in Analytic Workspaces owned by the user'
/
comment on column USER_AW_PROP.AW_NUMBER is
'Number of the Analytic Workspace'
/
comment on column USER_AW_PROP.AW_NAME is
'Name of the Analytic Workspace'
/
comment on column USER_AW_PROP.OBJ_ID is
'Object ID in the Analytic Workspace'
/
comment on column USER_AW_PROP.OBJ_NAME is
'Object name in the Analytic Workspace'
/
comment on column USER_AW_PROP.PROPERTY_NAME is
'Property name of the object in the Analytic Workspace'
/
comment on column USER_AW_PROP.PROPERTY_TYPE is
'Type of the property in the Analytic Workspace'
/
comment on column USER_AW_PROP.PROPERTY_VALUE is
'Value of the property in the Analytic Workspace'
/
comment on column USER_AW_PROP.FULL_PROPERTY_VALUE is
'Complete value of the property in the Analytic Workspace'
/
comment on column USER_AW_PROP.PROPERTY_VALUE_LENGTH is
'Length in bytes of the property in the Analytic Workspace'
/

create or replace view ALL_AW_PROP
(OWNER, AW_NUMBER, AW_NAME, OBJ_ID, OBJ_NAME, 
 PROPERTY_NAME, PROPERTY_TYPE, PROPERTY_VALUE,
 FULL_PROPERTY_VALUE, PROPERTY_VALUE_LENGTH)
as
SELECT u.name, a.awseq#, a.awname, p.oid, p.objname, 
       p.propname, dbms_aw.olap_type( nvl(p.proptype, 0)),
       dbms_aw.prop_val(p.rowid), dbms_aw.prop_clob(p.rowid),
       dbms_aw.prop_len(p.rowid) 
FROM aw$ a, aw_prop$ p, sys.obj$ o, sys.user$ u,
     (select max(rowid) keep (dense_rank last order by gen#) rid
           from aw_prop$ group by awseq#, oid, propname) 
WHERE  a.owner#=u.user# 
       and o.owner# = a.owner#
       and o.name = 'AW$' || a.awname and o.type#= 2 /* type for table */
       and a.awseq#=p.awseq#
       and (a.owner# in (userenv('SCHEMAID'), 1)   /* public objects */
            or
            o.obj# in ( select obj#  /* directly granted privileges */
                        from sys.objauth$
                        where grantee# in ( select kzsrorol from x$kzsro )
                      ) 
            or   /* user has system privilages */
              ora_check_SYS_privilege (o.owner#, o.type#) = 1
            )
        and p.rowid = rid and p.propval IS NOT NULL
/

comment on table ALL_AW_PROP is
'Object properties in Analytic Workspaces accessible to the user'
/
comment on column ALL_AW_PROP.OWNER is
'Owner of the Analytic Workspace'
/
comment on column ALL_AW_PROP.AW_NUMBER is
'Number of the Analytic Workspace'
/
comment on column ALL_AW_PROP.AW_NAME is
'Name of the Analytic Workspace'
/
comment on column ALL_AW_PROP.OBJ_ID is
'Object ID in the Analytic Workspace'
/
comment on column ALL_AW_PROP.OBJ_NAME is
'Object name in the Analytic Workspace'
/
comment on column ALL_AW_PROP.PROPERTY_NAME is
'Property name of the object in the Analytic Workspace'
/
comment on column ALL_AW_PROP.PROPERTY_TYPE is
'Type of the property in the Analytic Workspace'
/
comment on column ALL_AW_PROP.PROPERTY_VALUE is
'Value of the property in the Analytic Workspace'
/
comment on column ALL_AW_PROP.FULL_PROPERTY_VALUE is
'Complete value of the property in the Analytic Workspace'
/
comment on column ALL_AW_PROP.PROPERTY_VALUE_LENGTH is
'Length in bytes of the property in the Analytic Workspace'
/

-- create views on aw_obj$

create or replace view DBA_AW_OBJ
(OWNER, AW_NUMBER, AW_NAME, OBJ_ID, OBJ_NAME, OBJ_TYPE, PART_NAME)
as
SELECT u.name, a.awseq#, a.awname, o.oid, o.objname, o.objtype, o.partname
FROM aw$ a, aw_obj$ o, user$ u, 
     (select max(rowid) keep (dense_rank last order by gen#) rid
      from aw_obj$ group by awseq#, oid)  
WHERE   a.owner#=u.user# and a.awseq#=o.awseq# 
        and o.rowid = rid and o.objtype IS NOT NULL
/

comment on table DBA_AW_OBJ is
'Objects in Analytic Workspaces in the database'
/
comment on column DBA_AW_OBJ.OWNER is
'Owner of the Analytic Workspace'
/
comment on column DBA_AW_OBJ.AW_NUMBER is
'Number of the Analytic Workspace'
/
comment on column DBA_AW_OBJ.AW_NAME is
'Name of the Analytic Workspace'
/
comment on column DBA_AW_OBJ.OBJ_ID is
'Object ID in the Analytic Workspace'
/
comment on column DBA_AW_OBJ.OBJ_NAME is
'Object name in the Analytic Workspace'
/
comment on column DBA_AW_OBJ.OBJ_TYPE is
'Type of the object in the Analytic Workspace'
/
comment on column DBA_AW_OBJ.PART_NAME is
'Partition of the object in the Analytic Workspace'
/

execute SYS.CDBView.create_cdbview(false,'SYS','DBA_AW_OBJ','CDB_AW_OBJ');
create or replace public synonym CDB_AW_OBJ for sys.CDB_AW_OBJ;
grant select on CDB_AW_OBJ to select_catalog_role;

create or replace view USER_AW_OBJ
(AW_NUMBER, AW_NAME, OBJ_ID, OBJ_NAME, OBJ_TYPE, PART_NAME)
as
SELECT a.awseq#, a.awname, o.oid, o.objname, o.objtype, o.partname
FROM aw$ a, aw_obj$ o, 
     (select max(rowid) keep (dense_rank last order by gen#) rid
      from aw_obj$ group by awseq#, oid)  
WHERE   a.owner#=USERENV('SCHEMAID') and a.awseq#=o.awseq#
        and o.rowid = rid and o.objtype IS NOT NULL
/

comment on table USER_AW_OBJ is
'Objects in Analytic Workspaces owned by the user'
/
comment on column USER_AW_OBJ.AW_NUMBER is
'Number of the Analytic Workspace'
/
comment on column USER_AW_OBJ.AW_NAME is
'Name of the Analytic Workspace'
/
comment on column USER_AW_OBJ.OBJ_ID is
'Object ID in the Analytic Workspace'
/
comment on column USER_AW_OBJ.OBJ_NAME is
'Object name in the Analytic Workspace'
/
comment on column USER_AW_OBJ.OBJ_TYPE is
'Type of the object in the Analytic Workspace'
/
comment on column USER_AW_OBJ.PART_NAME is
'Partition of the object in the Analytic Workspace'
/

create or replace view ALL_AW_OBJ
(OWNER, AW_NUMBER, AW_NAME, OBJ_ID, OBJ_NAME, OBJ_TYPE, PART_NAME)
as
SELECT u.name, a.awseq#, a.awname, p.oid, p.objname, p.objtype, p.partname
FROM aw$ a, aw_obj$ p, sys.obj$ o, sys.user$ u, 
     (select max(rowid) keep (dense_rank last order by gen#) rid
      from aw_obj$ group by awseq#, oid)
WHERE  a.owner#=u.user# 
       and o.name = 'AW$' || a.awname and o.type#= 2 /* type for table */
       and a.awseq#=p.awseq#
       and (a.owner# in (userenv('SCHEMAID'), 1)   /* public objects */
            or
            o.obj# in ( select obj#  /* directly granted privileges */
                        from sys.objauth$
                        where grantee# in ( select kzsrorol from x$kzsro )
                      ) 
            or   /* user has system privilages */
              ora_check_SYS_privilege (o.owner#, o.type#) = 1
            )
       and p.rowid = rid and p.objtype IS NOT NULL
/

comment on table ALL_AW_OBJ is
'Objects in Analytic Workspaces accessible to the user'
/
comment on column ALL_AW_OBJ.OWNER is
'Owner of the Analytic Workspace'
/
comment on column ALL_AW_OBJ.AW_NUMBER is
'Number of the Analytic Workspace'
/
comment on column ALL_AW_OBJ.AW_NAME is
'Name of the Analytic Workspace'
/
comment on column ALL_AW_OBJ.OBJ_ID is
'Object ID in the Analytic Workspace'
/
comment on column ALL_AW_OBJ.OBJ_NAME is
'Object name in the Analytic Workspace'
/
comment on column ALL_AW_OBJ.OBJ_TYPE is
'Type of the object in the Analytic Workspace'
/
comment on column ALL_AW_OBJ.PART_NAME is
'Partition of the object in the Analytic Workspace'
/

Rem This is used by all_olap2_aws to get the property name information 
Rem for versioning. It has been created for performance reasons only.
create or replace view ALL_AW_PROP_NAME
(OWNER, AW_NUMBER, AW_NAME, OBJ_ID, OBJ_NAME,
 PROPERTY_NAME)
as
SELECT u.name, a.awseq#, a.awname, p.oid, p.objname,
       p.propname
FROM aw$ a, aw_prop$ p, sys.obj$ o, sys.user$ u,
     (select max(rowid) keep (dense_rank last order by gen#) rid
           from aw_prop$ group by awseq#, oid, propname)
WHERE  a.owner#=u.user#
       and o.owner# = a.owner#
       and o.name = 'AW$' || a.awname and o.type#= 2 /* type for table */
       and a.awseq#=p.awseq#
       and (a.owner# in (userenv('SCHEMAID'), 1)   /* public objects */
            or
            o.obj# in ( select obj#  /* directly granted privileges */
                        from sys.objauth$
                        where grantee# in ( select kzsrorol from x$kzsro )
                      )
            or   /* user has system privilages */
              ora_check_SYS_privilege (o.owner#, o.type#) = 1
            )
        and p.rowid = rid and p.propval IS NOT NULL
/

COMMENT ON TABLE all_aw_prop_name IS
'Analytic Workspace property names accessible to the user'
/


REM This view provides all active catalog AWs that user can see
REM This view is used in AWMD SPL implementation 
create or replace view ALL_AW_AC
(OWNER, AW_NUMBER, AW_NAME)
as
SELECT distinct u.name, a.awseq#, a.awname
FROM aw$ a, aw_prop$ p, sys.obj$ o, sys.user$ u
WHERE  a.owner#=u.user#
       and o.owner# = a.owner#
       and o.name = 'AW$' || a.awname and o.type#= 2 /* type for table */
       and a.awseq#=p.awseq#
       and (a.owner# in (userenv('SCHEMAID'), 1)   /* public objects */
            or
            o.obj# in ( select obj#  /* directly granted privileges */
                        from sys.objauth$
                        where grantee# in ( select kzsrorol from x$kzsro )
                      )
            or   /* user has system privilages */
              ora_check_SYS_privilege (o.owner#, o.type#) = 1
            )
        and p.propname = 'AW$ROLE'
/

COMMENT ON TABLE all_aw_ac IS
'Active Catalog Analytic Workspaces accessible to the user'
/

GRANT READ ON ALL_AW_AC to public;
CREATE OR REPLACE PUBLIC SYNONYM ALL_AW_AC FOR SYS.ALL_AW_AC;


REM This view provides all 10.1.0.3 and later Standard Form AWs user can see
REM This view is used in AWMD SPL Implementation
create or replace view ALL_AW_AC_10g
(OWNER, AW_NUMBER, AW_NAME)
as
SELECT distinct u.name, a.awseq#, a.awname
FROM aw$ a, aw_prop$ p, sys.obj$ o, sys.user$ u
WHERE  a.owner#=u.user#
       and o.owner# = a.owner#
       and o.name = 'AW$' || a.awname and o.type#= 2 /* type for table */
       and a.awseq#=p.awseq#
       and (a.owner# in (userenv('SCHEMAID'), 1)   /* public objects */
            or
            o.obj# in ( select obj#  /* directly granted privileges */
                        from sys.objauth$
                        where grantee# in ( select kzsrorol from x$kzsro )
                      )
            or   /* user has system privilages */
              ora_check_SYS_privilege (o.owner#, o.type#) = 1
            )
        and (p.propname = 'AW$VERSION10.1.0.3' or p.propname = 'AW$VERSION10.2')
/

Rem This view is used to get the AWs and their metadata version
create or replace view all$olap2_aws
(owner, aw, aw_number, aw_version, sf_version)
as
  select aws11g.owner, aws11g.aw_name, aws11g.aw_number, aws11g.aw_version, '11.1' sf_version
  from all_aws aws11g,
            (select /*+ ordered */ a.awseq#, r.rid, p.rowid, p.propname
              from sys.aw$ a, sys.aw_prop$ p, sys.obj$ o, dba_users u,
                   (select max(rowid) keep (dense_rank last order by gen#) rid
                    from sys.aw_prop$ group by awseq#, oid, propname) r
              where a.owner# = u.user_id
                and o.owner# = a.owner#
                and o.name = 'AW$' || a.awname and o.type# = 2
                and a.awseq# = p.awseq#
                and p.objname = '___AW_VERSION'
                and p.propname  = 'AW$VERSION11.1'
                and p.rowid = r.rid
                and p.propval is not null) props11g
 where props11g.awseq# = aws11g.aw_number
union all
  select max(aws.owner) owner, max(aws.aw_name) aw, props1.awseq#,
         max(aws.aw_version) aw_version,
               (case when count(props1.awseq#) = 2 then '10.2'
                     when count(props1.awseq#) = 1 then '10.1.0.3'
                     else null end) sf_version
         from all_aws aws,
              (select /*+ ordered */ a.awseq#, r.rid, p.rowid, p.propname
               from sys.aw$ a, sys.aw_prop$ p, sys.obj$ o, dba_users u,
                    (select max(rowid) keep (dense_rank last order by gen#) rid
                     from sys.aw_prop$ group by awseq#, oid, propname) r
               where a.owner# = u.user_id
                 and o.owner# = a.owner#
                 and o.name = 'AW$' || a.awname and o.type# = 2
                 and a.awseq# = p.awseq#
                 and p.propname in ('AW$VERSION10.2', 'AW$VERSION10.1.0.3')
                 and p.objname = '___XML_USER_AW_VERSION'
                 and p.rowid = r.rid
                 and p.propval is not null) props1
  where props1.awseq# = aws.aw_number
        and (props1.awseq# not in 
              (select /*+ ordered */ a.awseq#
               from sys.aw$ a, sys.aw_prop$ p, sys.obj$ o, dba_users u,
                    (select max(rowid) keep (dense_rank last order by gen#) rid
                     from sys.aw_prop$ group by awseq#, oid, propname) r
               where a.owner# = u.user_id
                 and o.owner# = a.owner#
                 and o.name = 'AW$' || a.awname and o.type# = 2
                 and a.awseq# = p.awseq#
                 and p.propname = 'AW$VERSION11.1'
                 and p.objname = '___AW_VERSION'
                 and p.rowid = r.rid
                 and p.propval is not null))
  group by awseq#
/

grant read on all$olap2_aws to public
/

create or replace public synonym ALL_OLAP2_AWS for all$olap2_aws
/

GRANT READ ON ALL_AW_AC_10g to public;
CREATE OR REPLACE PUBLIC SYNONYM ALL_AW_AC_10g FOR SYS.ALL_AW_AC_10g;


CREATE OR REPLACE PUBLIC SYNONYM DBA_AW_PROP FOR SYS.DBA_AW_PROP
/
GRANT SELECT ON DBA_AW_PROP to select_catalog_role
/
CREATE OR REPLACE PUBLIC SYNONYM DBA_AW_OBJ FOR SYS.DBA_AW_OBJ
/
GRANT SELECT ON DBA_AW_OBJ to select_catalog_role
/

CREATE OR REPLACE PUBLIC SYNONYM USER_AW_PROP FOR SYS.USER_AW_PROP
/
GRANT READ ON USER_AW_PROP to public
/
CREATE OR REPLACE PUBLIC SYNONYM USER_AW_OBJ FOR SYS.USER_AW_OBJ
/
GRANT READ ON USER_AW_OBJ to public
/

CREATE OR REPLACE PUBLIC SYNONYM ALL_AW_PROP FOR SYS.ALL_AW_PROP
/
GRANT READ ON ALL_AW_PROP to public
/
CREATE OR REPLACE PUBLIC SYNONYM ALL_AW_OBJ FOR SYS.ALL_AW_OBJ
/
GRANT READ ON ALL_AW_OBJ to public
/

CREATE OR REPLACE PUBLIC SYNONYM ALL_AW_PROP_NAME FOR SYS.ALL_AW_PROP_NAME
/
GRANT READ ON ALL_AW_PROP_NAME to public
/

@@?/rdbms/admin/sqlsessend.sql
