Rem
Rem $Header: oraolap/admin/catnoamd.sql /main/9 2020/08/17 12:07:43 jcarey Exp $
Rem
Rem catnoamd.sql
Rem
Rem Copyright (c) 2000, 2020, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      catnoamd.sql 
Rem
Rem    DESCRIPTION
Rem      Remove cwmlite 
Rem
Rem    NOTES
Rem      Must be run as 'SYS'. Does not remove OLAP_DBA_TABLES tablespace.
Rem
Rem    
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: oraolap/admin/catnoamd.sql
Rem    SQL_SHIPPED_FILE: olap/admin/catnoamd.sql
Rem    SQL_PHASE: UTILITY 
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    jcarey      08/07/20 - Bug 31725025 - guard drops
Rem    ghicks      07/02/20 - Bug 31564317: error dropping admin role
Rem    ghicks      06/08/20 - Bug 31426867: remove 'FORCE' when inappropriate
Rem    ghicks      05/18/20 - bug 31353592: swallow errors to make rerunnable
Rem    ghicks      07/16/18 - bug 28354015: fix STARTUP_MODE metadata
Rem    ddedonat    11/19/14 - Bug 20103170 drop OLAPSYS owned base object:
Rem                           tables, views, packages, functions, sequences,
Rem                           and types except xml_load... objects
Rem    awesley     03/21/12 - deprecate cwm transaction 13068864
Rem                           move from cwmlite/admin, 
Rem                           replace @@cwm2drop.sql @@factvdrp.sql 
Rem                            @@dimvwdrp.sql @@olapodrp.sqlwith script content
Rem    awesley     03/10/09 - add missing drops
Rem                         - add second '@' to factvdrp.sql, dimvwdrp.sql,
Rem                           olapodrp.sql
Rem    cdalessi    10/21/02 - cdalessi_txn104879
Rem    mrangwal    02/15/02 - Add olapodrp call
Rem    cdalessi    01/18/02 - 
Rem    cdalessi    01/14/02 - 
Rem    awesley     11/06/01 - Add cwm2 api
Rem    dthompso    07/24/00 - add connection.
Rem    dthompso    06/01/00 - Add new public synonyms for osa.
Rem    dthompso    04/27/00 - Initial Version
Rem    dthompso    01/00/00 - Created
Rem
  
@@?/rdbms/admin/sqlsessstart.sql

declare
  type command_t is table of varchar2(80);
  commands constant command_t := command_t(
            'drop public synonym cwm2_olap_exceptions',
            'drop public synonym cwm2_olap_manager',
            'drop public synonym cwm2_olap_utility',
            'drop public synonym cwm2_olap_catalog',
            'drop public synonym cwm2_olap_cube',
            'drop public synonym cwm2_olap_dimension',
            'drop public synonym cwm2_olap_dimension_attribute',
            'drop public synonym cwm2_olap_hierarchy',
            'drop public synonym cwm2_olap_level',
            'drop public synonym cwm2_olap_level_attribute',
            'drop public synonym cwm2_olap_measure',
            'drop public synonym cwm2_olap_validate',
            'drop public synonym cwm2_olap_verify_access',
            'drop public synonym cwm2_olap_export',
            'drop public synonym cwm2_olap_delete',
            'drop public synonym cwm2_olap_table_map',
            'drop public synonym cwm2_olap_pc_transform',
            'drop public synonym cwm2_security',
            'drop public synonym dbms_aw_utilities',
            'drop public synonym all_olapmr_dimensions',
            'drop public synonym all_olapmr_dim_attributes',
            'drop public synonym all_olapmr_attributes',
            'drop public synonym all_olapmr_dim_levels',
            'drop public synonym cwm2_olap_classify',
            'drop public synonym dba_olap2_cubes',
            'drop public synonym dba_olap2_cube_measures',
            'drop public synonym dba_olap2_cube_dim_uses',
            'drop public synonym dba_olap2_cube_meas_dim_uses',
            'drop public synonym dba_olap2_dimensions',
            'drop public synonym dba_olap2_dim_hierarchies',
            'drop public synonym dba_olap2_dim_levels',
            'drop public synonym dba_olap2_dim_hier_level_uses',
            'drop public synonym dba_olap2_dim_attributes',
            'drop public synonym dba_olap2_dim_attr_uses',
            'drop public synonym dba_olap2_dim_level_attributes',
            'drop public synonym dba_olap2_cube_measure_maps',
            'drop public synonym dba_olap2_fact_level_uses',
            'drop public synonym dba_olap2_level_key_col_uses',
            'drop public synonym dba_olap2_join_key_column_uses',
            'drop public synonym dba_olap2_dim_level_attr_maps',
            'drop public synonym dba_olap2_catalogs',
            'drop public synonym dba_olap2_entity_desc_uses',
            'drop public synonym dba_olap2_catalog_entity_uses',
            'drop public synonym dba_olap2_fact_table_gid',
            'drop public synonym dba_olap2_hier_custom_sort',
            'drop public synonym dba_olapmr_facttblkeymaps',
            'drop public synonym dba_olapmr_facttblfctmaps',
            'drop public synonym dba_olap2_listdims',
            'drop public synonym dba_olap2_dim_hiers',
            'drop public synonym dba_olap2_hierdims',
            'drop public synonym dba_olap2_FactTblKeyMaps',
            'drop public synonym dba_olap2_rufcttblkyMaps',
            'drop public synonym dba_olap2_FactTblFctMaps',
            'drop public synonym dba_olap2_hierdim_keycol_map',
            'drop public synonym dba_olapmr_dim_levels_keymaps',
            'drop public synonym dba_olap2_dim_levels_keymaps',
            'drop public synonym dba_olap2_mr_measdimview',
            'drop public synonym dba_olap9i1_hier_dimensions',
            'drop public synonym dba_olap9i2_hier_dimensions',
            'drop public synonym dba_olap1_cubes',
            'drop public synonym dba_olap2_entity_parameters',
            'drop public synonym dba_olap2_entity_ext_parms',
            'drop public synonym all_olap2_cubes',
            'drop public synonym all_olap2_cube_measures',
            'drop public synonym all_olap2_cube_dim_uses',
            'drop public synonym all_olap2_cube_meas_dim_uses',
            'drop public synonym all_olap2_dimensions',
            'drop public synonym all_olap2_dim_hierarchies',
            'drop public synonym all_olap2_dim_levels',
            'drop public synonym all_olap2_dim_hier_level_uses',
            'drop public synonym all_olap2_dim_attributes',
            'drop public synonym all_olap2_dim_attr_uses',
            'drop public synonym all_olap2_dim_level_attributes',
            'drop public synonym all_olap2_cube_measure_maps',
            'drop public synonym all_olap2_fact_level_uses',
            'drop public synonym all_olap2_level_key_col_uses',
            'drop public synonym all_olap2_join_key_column_uses',
            'drop public synonym all_olap2_dim_level_attr_maps',
            'drop public synonym all_olap2_catalogs',
            'drop public synonym all_olap2_entity_desc_uses',
            'drop public synonym all_olap2_catalog_entity_uses',
            'drop public synonym all_olap2_fact_table_gid',
            'drop public synonym all_olap2_hier_custom_sort',
            'drop public synonym all_olapmr_facttblkeymaps',
            'drop public synonym all_olapmr_facttblfctmaps',
            'drop public synonym all_olap2_listdims',
            'drop public synonym all_olap2_dim_hiers',
            'drop public synonym all_olap2_hierdims',
            'drop public synonym all_olap2_FactTblKeyMaps',
            'drop public synonym all_olap2_rufcttblkyMaps',
            'drop public synonym all_olap2_FactTblFctMaps',
            'drop public synonym all_olap2_hierdim_keycol_map',
            'drop public synonym all_olapmr_dim_levels_keymaps',
            'drop public synonym all_olap2_dim_levels_keymaps',
            'drop public synonym all_olap2_mr_measdimview',
            'drop public synonym all_olap9i1_hier_dimensions',
            'drop public synonym all_olap9i2_hier_dimensions',
            'drop public synonym all_olap1_cubes',
            'drop public synonym all_olap2_entity_parameters',
            'drop public synonym all_olap2_entity_ext_parms',
            'drop public synonym cwm_classify',
            'drop public synonym cwm_exceptions',
            'drop public synonym cwm_olap_cube',
            'drop public synonym cwm_olap_measure',
            'drop public synonym cwm_olap_dim_attribute',
            'drop public synonym cwm_olap_dimension',
            'drop public synonym cwm_olap_hierarchy',
            'drop public synonym cwm_olap_level',
            'drop public synonym cwm_olap_level_attribute',
            'drop public synonym cwm_utility',
            'drop public synonym dba_olap_catalog_entity_uses',
            'drop public synonym dba_olap_catalogs',
            'drop public synonym dba_olap_columns',
            'drop public synonym dba_olap_cube_dim_uses',
            'drop public synonym dba_olap_cube_measure_dim_uses',
            'drop public synonym dba_olap_cube_measure_maps',
            'drop public synonym dba_olap_cube_measures',
            'drop public synonym dba_olap_cubes',
            'drop public synonym dba_olap_descriptor_types',
            'drop public synonym dba_olap_descriptors',
            'drop public synonym dba_olap_dim_attr_uses',
            'drop public synonym dba_olap_dim_attributes',
            'drop public synonym dba_olap_dim_hier_level_uses',
            'drop public synonym dba_olap_dim_hierarchies',
            'drop public synonym dba_olap_dim_level_attr_maps',
            'drop public synonym dba_olap_dim_level_attributes',
            'drop public synonym dba_olap_dim_levels',
            'drop public synonym dba_olap_dimensions',
            'drop public synonym dba_olap_entity_desc_uses',
            'drop public synonym dba_olap_fact_level_uses',
            'drop public synonym dba_olap_foreign_keys',
            'drop public synonym dba_olap_function_arguments',
            'drop public synonym dba_olap_function_parameters',
            'drop public synonym dba_olap_function_usages',
            'drop public synonym dba_olap_functions',
            'drop public synonym dba_olap_join_key_column_uses',
            'drop public synonym dba_olap_key_column_uses',
            'drop public synonym dba_olap_keys',
            'drop public synonym dba_olap_level_key_column_uses',
            'drop public synonym dba_olap_tables',
            'drop public synonym all_olap_catalog_entity_uses',
            'drop public synonym all_olap_catalogs',
            'drop public synonym all_olap_columns',
            'drop public synonym all_olap_cube_dim_uses',
            'drop public synonym all_olap_cube_measure_dim_uses',
            'drop public synonym all_olap_cube_measure_maps',
            'drop public synonym all_olap_cube_measures',
            'drop public synonym all_olap_cubes',
            'drop public synonym all_olap_descriptor_types',
            'drop public synonym all_olap_descriptors',
            'drop public synonym all_olap_dim_attr_uses',
            'drop public synonym all_olap_dim_attributes',
            'drop public synonym all_olap_dim_hier_level_uses',
            'drop public synonym all_olap_dim_hierarchies',
            'drop public synonym all_olap_dim_level_attr_maps',
            'drop public synonym all_olap_dim_level_attributes',
            'drop public synonym all_olap_dim_levels',
            'drop public synonym all_olap_dimensions',
            'drop public synonym all_olap_entity_desc_uses',
            'drop public synonym all_olap_fact_level_uses',
            'drop public synonym all_olap_foreign_keys',
            'drop public synonym all_olap_function_arguments',
            'drop public synonym all_olap_function_parameters',
            'drop public synonym all_olap_function_usages',
            'drop public synonym all_olap_functions',
            'drop public synonym all_olap_join_key_column_uses',
            'drop public synonym all_olap_key_column_uses',
            'drop public synonym all_olap_keys',
            'drop public synonym all_olap_level_key_column_uses',
            'drop public synonym all_olap_tables',
            'drop package SYS.CWM2_OLAP_INSTALLER',
            'drop public synonym ALL_AW_CUBE_AGG_LEVELS',
            'drop public synonym ALL_AW_CUBE_AGG_MEASURES',
            'drop public synonym ALL_AW_CUBE_AGG_PLANS',
            'drop public synonym ALL_AW_CUBE_ENABLED_HIERCOMBO',
            'drop public synonym ALL_AW_CUBE_ENABLED_VIEWS',
            'drop public synonym ALL_AW_DIM_ENABLED_VIEWS',
            'drop public synonym ALL_AW_LOAD_CUBES',
            'drop public synonym ALL_AW_LOAD_CUBE_DIMS',
            'drop public synonym ALL_AW_LOAD_CUBE_FILTERS',
            'drop public synonym ALL_AW_LOAD_CUBE_MEASURES',
            'drop public synonym ALL_AW_LOAD_CUBE_PARMS',
            'drop public synonym ALL_AW_LOAD_DIMENSIONS',
            'drop public synonym ALL_AW_LOAD_DIM_FILTERS',
            'drop public synonym ALL_AW_LOAD_DIM_PARMS',
            'drop public synonym ALL_LOAD_CUBE_SEGWIDTH',
            'drop public synonym ALL_OLAP2_AGGREGATION_USES',
            'drop public synonym ALL_OLAP2_AWVIEWCOLS',
            'drop public synonym ALL_OLAP2_AWVIEWS',
            'drop public synonym ALL_OLAP2_AW_ATTRIBUTES',
            'drop public synonym ALL_OLAP2_AW_CATALOGS',
            'drop public synonym ALL_OLAP2_AW_CATALOG_MEASURES',
            'drop public synonym ALL_OLAP2_AW_CUBES',
            'drop public synonym ALL_OLAP2_AW_CUBE_AGG_LVL',
            'drop public synonym ALL_OLAP2_AW_CUBE_AGG_MEAS',
            'drop public synonym ALL_OLAP2_AW_CUBE_AGG_OP',
            'drop public synonym ALL_OLAP2_AW_CUBE_AGG_SPECS',
            'drop public synonym ALL_OLAP2_AW_CUBE_DIM_USES',
            'drop public synonym ALL_OLAP2_AW_CUBE_MEASURES',
            'drop public synonym ALL_OLAP2_AW_DIMENSIONS',
            'drop public synonym ALL_OLAP2_AW_DIM_HIER_LVL_ORD',
            'drop public synonym ALL_OLAP2_AW_DIM_LEVELS',
            'drop public synonym ALL_OLAP2_AW_PHYS_OBJ',
            'drop public synonym ALL_OLAP2_AW_PHYS_OBJ_PROP',
            'drop public synonym ALL_OLAP2_MV_CUBE_AGG_LEVELS',
            'drop public synonym ALL_OLAP2_MV_CUBE_AGG_MEASURES',
            'drop public synonym CWM2_OLAP_AW_AWUTIL',
            'drop public synonym CWM2_OLAP_METADATA_REFRESH',
            'drop public synonym CWM2_OLAP_MR_CHECK_PRIVS',
            'drop public synonym CWM2_OLAP_MR_SECURITY_INIT',
            'drop public synonym CWM2_OLAP_MR_SESSION_POP',
            'drop public synonym CWM2_OLAP_OLAPAPI_ENABLE',
            'drop public synonym DBA_OLAP2_AGGREGATION_USES',
            'drop public synonym DBA_OLAP2_AWVIEWCOLS',
            'drop public synonym DBA_OLAP2_AWVIEWS',
            'drop public synonym DBMS_AWM',
            'drop public synonym MRV_OLAP1_FACTTBLFCTMAPS',
            'drop public synonym MRV_OLAP1_FACTTBLKEYMAPS',
            'drop public synonym MRV_OLAP1_POP_CUBES',
            'drop public synonym MRV_OLAP1_POP_DIMENSIONS',
            'drop public synonym MRV_OLAP2_AGGREGATION_USES',
            'drop public synonym MRV_OLAP2_AWS',
            'drop public synonym MRV_OLAP2_AWVIEWCOLS',
            'drop public synonym MRV_OLAP2_AWVIEWS',
            'drop public synonym MRV_OLAP2_AW_ATTRIBUTES',
            'drop public synonym MRV_OLAP2_AW_CUBES',
            'drop public synonym MRV_OLAP2_AW_CUBE_AGG_LVL',
            'drop public synonym MRV_OLAP2_AW_CUBE_AGG_MEAS',
            'drop public synonym MRV_OLAP2_AW_CUBE_AGG_OP',
            'drop public synonym MRV_OLAP2_AW_CUBE_AGG_SPECS',
            'drop public synonym MRV_OLAP2_AW_CUBE_DIM_USES',
            'drop public synonym MRV_OLAP2_AW_CUBE_MEASURES',
            'drop public synonym MRV_OLAP2_AW_DIMENSIONS',
            'drop public synonym MRV_OLAP2_AW_DIM_HIER_LVL_ORD',
            'drop public synonym MRV_OLAP2_AW_DIM_LEVELS',
            'drop public synonym MRV_OLAP2_AW_MAP_ATTR_USE',
            'drop public synonym MRV_OLAP2_AW_MAP_DIM_USE',
            'drop public synonym MRV_OLAP2_AW_MAP_MEAS_USE',
            'drop public synonym MRV_OLAP2_AW_PHYS_OBJ',
            'drop public synonym MRV_OLAP2_AW_PHYS_OBJ_PROP',
            'drop public synonym MRV_OLAP2_CATALOGS',
            'drop public synonym MRV_OLAP2_CATALOG_ENTITY_USES',
            'drop public synonym MRV_OLAP2_CUBE_MEASURES',
            'drop public synonym MRV_OLAP2_DESCRIPTORS',
            'drop public synonym MRV_OLAP2_DIM_ATTRIBUTES',
            'drop public synonym MRV_OLAP2_DIM_HIERS',
            'drop public synonym MRV_OLAP2_DIM_HIER_LEVEL_USES',
            'drop public synonym MRV_OLAP2_DIM_LEVEL_ATTR_MAPS',
            'drop public synonym MRV_OLAP2_ENTITY_DESC_USES',
            'drop public synonym MRV_OLAP2_ENTITY_EXT_PARMS',
            'drop public synonym MRV_OLAP2_ENTITY_PARAMETERS',
            'drop public synonym MRV_OLAP2_FACTTBLFCTMAPS',
            'drop public synonym MRV_OLAP2_FACTTBLKEYMAPS',
            'drop public synonym MRV_OLAP2_HIERDIMS',
            'drop public synonym MRV_OLAP2_HIERDIMS_CC',
            'drop public synonym MRV_OLAP2_HIERDIM_KEYCOL_MAP',
            'drop public synonym MRV_OLAP2_HIER_CUSTOM_SORT',
            'drop public synonym MRV_OLAP2_JOIN_KEY_COL_USES',
            'drop public synonym MRV_OLAP2_LISTDIMS',
            'drop public synonym MRV_OLAP2_LISTDIMS_CC',
            'drop public synonym MRV_OLAP2_POP_CUBES',
            'drop public synonym MRV_OLAP2_POP_DIMENSIONS',
            'drop public synonym MRV_OLAP_CWM1_AGGOP',
            'drop public synonym MRV_OLAP_CWM1_AGGORD',
            'drop public synonym OLAP_SYS_AW_ACCESS_CUBE_VIEW',
            'drop public synonym OLAP_SYS_AW_ACCESS_DIM_VIEW',
            'drop public synonym OLAP_SYS_AW_ENABLE_ACCESS_VIEW',
            'drop public synonym OlapFactView',
            'drop public synonym OlapDimView',
            'drop public synonym DBMS_ODM',
            'drop view olapsys.olap_sys_aw_access_dim_view',
            'drop view olapsys.olap_sys_aw_access_cube_view',
            'drop type olapsys.olap_sys_aw_access_tbl',
            'drop type olapsys.olap_sys_aw_access_obj',
            'drop view olapsys.olap_sys_aw_enable_access_view',
            'drop type olapsys.olap_sys_aw_enable_access_tbl',
            'drop type olapsys.olap_sys_aw_enable_access_obj',
            'drop type olapsys.all_olap2_aw_metadata_t',
            'drop type olapsys.all_olap2_aw_metadata_o');
  object_does_not_exist exception;
    pragma exception_init(object_does_not_exist, -4043);
  synonym_does_not_exist exception;
    pragma exception_init(synonym_does_not_exist, -1432);
  view_does_not_exist exception;
    pragma exception_init(view_does_not_exist, -942);
begin
  for i in 1 .. commands.count
  loop
    begin
      -- dbms_output.put_line(commands(i));
      execute immediate commands(i);
    exception
      when object_does_not_exist then null;
      when synonym_does_not_exist then null;
      when view_does_not_exist then null;
      when others then raise;
    end;
  end loop;
end;
/
 
declare
  immcmd VARCHAR2(400);
begin
  -- drop tables and indexes user for referential integrity constraints 
  for c_object in (select owner, object_name, object_type
                   from dba_objects
                   where owner = 'OLAPSYS'
                   and object_name not in ('XML_LOAD_RECORDS','XML_LOAD_LOG')
                   and object_type = 'TABLE'
                   order by object_type, owner, object_name
                   )
  loop
    -- dbms_output.put_line('DROP TABLE OLAPSYS.' || c_object.object_name);
    declare
      table_does_not_exist exception;
      pragma exception_init(table_does_not_exist, -942);
    begin
      execute immediate 
        'drop TABLE OLAPSYS.' || c_object.object_name || ' cascade constraints';
    EXCEPTION
     WHEN table_does_not_exist THEN
       NULL;
    END;

  end loop;

  -- drop remaining objects, TABLE and INDEX are dropped @dba_objects
  for c_object in (select owner, object_name, object_type
                   from dba_objects
                   where owner = 'OLAPSYS'
                   and object_name != 'XML_LOADID_SEQUENCE'
                   and object_Type not in ('TABLE', 'INDEX', 'PACKAGE BODY')
                   order by object_type, owner, object_name
                   )
  loop
    immcmd := 'drop ' || c_object.object_type || ' OLAPSYS."' || c_object.object_name||'"';
    if c_object.object_type in ('SYNONYM','TYPE') then
      immcmd := immcmd || ' force';
    end if;
    -- dbms_output.put_line(immcmd);
    execute immediate immcmd;
  end loop;
end;
/

rem
rem drop OLAP_DBA role
rem
declare
  role_does_not_exist exception;
    pragma exception_init(role_does_not_exist, -1919);
begin
  execute immediate 'drop role OLAP_DBA';
exception
  when role_does_not_exist then null;
  when others then raise;
end;
/

declare
  not_in_registry exception;
    pragma exception_init(not_in_registry, -39705);
begin
  sys.dbms_registry.removed('AMD');
exception
  when not_in_registry then null;
  when others then raise;
end;
/

-- No longer show up in dba_registry
begin
  execute immediate 'delete from registry$ where cid=''AMD'' and status=''99''';
end;
/

@@?/rdbms/admin/sqlsessend.sql

