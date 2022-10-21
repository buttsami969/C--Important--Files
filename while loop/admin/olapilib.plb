DECLARE
obj_dne exception;
pragma exception_init(obj_dne, -4043);
begin
  execute immediate 'DROP LIBRARY DBMS_OLAPI_LIB2';
EXCEPTION
  WHEN obj_dne THEN
       NULL;
END;
/
CREATE or REPLACE LIBRARY DBMS_OLAPI_LIB2 wrapped 
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
16
2a 61
QNNHdYSWO43DAqEDbT3FzFiHChgwg04I9Z7AdBjDuFKbskr+/lJ0pV/+CPVlCee9nrLLUjLM
uHQr58tSdAj1yaamtfqZqg==

/
