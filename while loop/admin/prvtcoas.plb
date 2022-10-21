@@?/rdbms/admin/sqlsessstart.sql
CREATE OR REPLACE package dbms_cube_advise_sec wrapped 
a000000
1
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
9
b1 c6
h3bPDHMcpkaLWlQRFTHwB6tzsg0wgzLXf8sVfHQCOMnc7oJLn8CknGDnH4oa4AMREzc3PqxO
t/BEQfkItxlEKUaAQHlCKw8PDAj4Mz93Bg3Yqa3wf2ePqJ7VogWqW1CrwmkYt6YuBF9k0c8M
Dm7CnkdNIVEcRap1wsXZlnIlh/gDKiUDC3WMLf1eW5gofi/RSQ==

/
show errors
CREATE OR REPLACE package body dbms_cube_advise_sec wrapped 
a000000
1
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
b
24e 160
0+DTv2lZONfdmCY1NHxkul9kIWowg5VpLvYVZy/NMQ9/Wq/nNdvmKLIcyb/GUyFI9STmAGJc
x6VQXhGqnQPspzkj4h0d2RNCIBkFYpfqVr2iOzO4e8/1CM5CEYb4KR5oDS320A5VFpTdfbDO
skueYCNM/cgqxYCYEX3X1mws2Dc5O3GMTBTfuAg0r55ZtOfCMQY+T65tuzcX7NP9Hw3ydQ4J
E5oanGxT7RPwZNpl5xhNq2I+m+RSegwXQnnKxoknbcWYPl1po+au/xeUWCVkEs/saoL+kSIp
19KLIGa9Zow5CJ7/+er1iNhsx9DSKZuqGru2m1sU9RHUbILCpjBTpmsH98k=

/
show errors
grant execute on dbms_cube_advise_sec to public;
create or replace force view "SYS"."COAD$INLINE_NOTNULL_CONS"
  (owner    ,
   table_name     ,
   constraint_name,
   column_name     
  ) as
  select distinct  
    u.name owner,          
    o.name table_name, 
    c.name constraint_name, 
    decode(ac.name, null, col.name, ac.name) column_name
  from 
    sys.user$ u,
    sys.cdef$ cd, 
    sys.con$ c, 
    sys.ccol$ cc, 
    sys.col$ col,
    sys."_CURRENT_EDITION_OBJ" o, 
    sys.attrcol$ ac  
  where 
    c.owner# =  u.user# and 
    c.con# = cd.con# and 
    cd.con# = cc.con# and 
    cd.con# = cc.con# and 
    cc.obj# = col.obj# and 
    cc.intcol# = col.intcol# and 
    cc.obj# = o.obj# and 
    cc.obj# = o.obj# and 
    col.obj# = ac.obj#(+) and 
    col.intcol# = ac.intcol#(+) and
    cd.type# = 7 and  /* in-line not null constraint */
    o.type# = 2 and /*  check contraint */
    (o.owner# in ( SYS_CONTEXT('USERENV', 'CURRENT_USERID'), 1 /*PUBLIC*/) or
     OBJ_ID(u.name, o.name, o.type#, o.obj#) in
       (select obj# from sys.objauth$
        where grantee# in (select kzsrorol
                           from x$kzsro)) or 
     ora_check_sys_privilege ( o.owner#, o.type# ) = 1);
show error
grant read on SYS.COAD$INLINE_NOTNULL_CONS to public;
create or replace force view "SYS"."COAD$CUBE_MVIEWS"
  (owner          ,
   olapobj_name   ,
   hierarchy_name ,
   is_default_hier,
   mview_name     ,
   mview_type     
  ) as
       select
         u.name owner, 
         o.name object_name,
         h.hierarchy_name hierarchy_name,
         (select 
            (case when dh. hierarchy_name = h.hierarchy_name 
                    then 'Y' else 'N' end) as is_default
          from sys.olap_hierarchies$ dh, sys.olap_cube_dimensions$ dd
          where dh.dim_obj# = dd.OBJ# and 
                dh.HIERARCHY_Id = dd.DEFAULT_HIERARCHY_ID and 
                dd.obj# = o.obj#) is_default_hier,
         impl_options.option_value mv_name,
         decode(impl_options.option_type, 30, 'REFRESH', 31, 'REWRITE', 
                'UNKNOWN')  mv_type
       from
         sys.olap_impl_options$ impl_options,
         sys.olap_hierarchies$ h,
         sys.obj$ o,
         sys.user$ u,
         sys.obj$ o2,
         sys.user$ u2
       where 
             h.hierarchy_id = impl_options.owning_objectid
         and h.dim_obj# = o.obj#
         and u.user# = o.owner#
         and impl_options.option_type in (30, 31) -- REFRESH,REWRITE
         and o2.name = impl_options.option_value
         and u2.user# = o2.owner#
         and (o2.owner# in 
               (SYS_CONTEXT('USERENV', 'CURRENT_USERID'), 1 /*PUBLIC*/)
          or  OBJ_ID(u2.name, o2.name, o2.type#, o2.obj#) in
                (select obj# from sys.objauth$
                 where grantee# in (select kzsrorol
                                    from x$kzsro))
          or  ora_check_sys_privilege (o2.owner#, o2.type# ) = 1)
       union all
       select
         u.name owner,
         o.name object_name,
         cast('' as varchar2(128)) as hierarchy_name,
         cast('' as varchar2(1)) as is_default_hier,
         impl_options.option_value mv_name,
         decode(impl_options.option_type, 30, 'REFRESH', 31, 'REWRITE', 
                'UNKNOWN')  mv_type
       from
         sys.olap_impl_options$ impl_options,
         sys.olap_cubes$ c,
         sys.obj$ o,
         sys.user$ u,
         sys.obj$ o2,
         sys.user$ u2
       where 
             c.obj# = impl_options.owning_objectid
         and o.obj# = c.obj#
         and u.user# = o.owner# 
         and impl_options.option_type in (30, 31) -- REFRESH,REWRITE
         and o2.name = impl_options.option_value
         and u2.user# = o2.owner#
         and (o2.owner# in 
               (SYS_CONTEXT('USERENV', 'CURRENT_USERID'), 1 /*PUBLIC*/)
          or  OBJ_ID(u2.name, o2.name, o2.type#, o2.obj#) in
                (select obj# from sys.objauth$
                 where grantee# in (select kzsrorol
                                    from x$kzsro))
          or  ora_check_sys_privilege (o2.owner#, o2.type# ) = 1);
show errors
grant read on SYS.COAD$CUBE_MVIEWS to public;
create or replace force view "SYS"."COAD$MVIEWS_WITH_VIEWS"
  (owner     ,
   mview_name 
  ) as
    select
      u.name owner,
      o.name mview_name
    from
      sys.sumkey$ s,
      sys.obj$ o,
      sys.user$ u,
      sys.obj$ o2
   where
      o.obj# = s.sumobj# and
      o.owner# = u.user# and
      o.type# = 42 and /* mview */
      s.detailobjtype = 2 and /* is a view type */
      o2.owner# = u.user# and
      o2.name = o.name and
      o2.type# = 2 and /* mviews backing table */
      (o2.owner# in 
         (SYS_CONTEXT('USERENV', 'CURRENT_USERID'), 1 /*PUBLIC*/) or
       OBJ_ID(u.name, o2.name, o2.type#, o2.obj#) in
         (select obj# from sys.objauth$
          where grantee# in (select kzsrorol
                              from x$kzsro)) or  
       ora_check_sys_privilege (o2.owner#, o2.type# ) = 1) 
    group by
      u.name, o.name;
show errors
grant read on SYS.COAD$MVIEWS_WITH_VIEWS to public;
@@?/rdbms/admin/sqlsessend.sql
