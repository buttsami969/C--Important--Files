declare
  b        boolean;
  r        PLS_INTEGER;
  ace      XMLType;
  ace_data VARCHAR2(2000); 
begin
  begin
    if (not dbms_xdb.existsResource('/olap_data_security')) then
      b := dbms_xdb.createfolder('/olap_data_security');
    end if;
    if (not dbms_xdb.existsResource('/olap_data_security/public')) then
      b := dbms_xdb.createfolder('/olap_data_security/public');
    end if;
    if (not dbms_xdb.existsResource('/olap_data_security/public/acls')) then
      b := dbms_xdb.createfolder('/olap_data_security/public/acls');
    end if;
  exception
    when others then
      if sqlcode <> -31003 then
        raise;
      end if;
  end;

  begin
    if (not dbms_xdb.existsResource('/xds')) then
      b := dbms_xdb.createfolder('/xds');
    end if;
    if (not dbms_xdb.existsResource('/xds/dsd')) then
      b := dbms_xdb.createfolder('/xds/dsd');
    end if;
  exception
    when others then
      if sqlcode <> -31003 then
        raise;
      end if;
  end;

  ace_data := '<ace xmlns="http://xmlns.oracle.com/xdb/acl.xsd"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://xmlns.oracle.com/xdb/acl.xsd
                                        http://xmlns.oracle.com/xdb/acl.xsd
                                        DAV:http://xmlns.oracle.com/xdb/dav.xsd">
                 <principal>OLAP_XS_ADMIN</principal>
                 <grant>true</grant>
                 <privilege><all/></privilege>
               </ace>';
  ace := XMLType.createXML(ace_data);

  r := DBMS_XDB.changePrivileges('/olap_data_security', ace);
  r := DBMS_XDB.changePrivileges('/olap_data_security/public', ace);
  r := DBMS_XDB.changePrivileges('/olap_data_security/public/acls', ace);

  r := DBMS_XDB.changePrivileges('/xds', ace);
  r := DBMS_XDB.changePrivileges('/xds/dsd', ace);
end;
/
commit;
