DECLARE
obj_dne exception;
pragma exception_init(obj_dne, -4843);
BEGIN
  BEGIN
  execute immediate '  DROP PACKAGE GenDatabaseInterface';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate '  DROP PACKAGE GenConnectionInterface'; 
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate ' DROP PACKAGE GenServerInterface';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate '  DROP PACKAGE GenMdmPropertyIdConstants'; 
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate  'DROP PACKAGE GenMdmClassConstants'; 
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate ' DROP PACKAGE GenMdmObjectIdConstants';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate '  DROP PACKAGE GenMetadataProviderInterface';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate  ' DROP PACKAGE GenCursorManagerInterface';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate '  DROP PACKAGE GenDataTypeIdConstants';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate '  DROP PACKAGE GenDefinitionManagerInterface';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;

  BEGIN
  execute immediate '  DROP PACKAGE GenDataProviderInterface';
  EXCEPTION
    WHEN obj_dne THEN
       NULL;
  END;
END;
/
