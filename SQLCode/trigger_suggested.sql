/*
CREATE [OR REPLACE ] TRIGGER trigger_name 
{BEFORE | AFTER | INSTEAD OF } 
{INSERT [OR] | UPDATE [OR] | DELETE} 
[OF col_name] 
ON table_name 
[REFERENCING OLD AS o NEW AS n] 
[FOR EACH ROW] 
WHEN (condition)  
DECLARE
   Declaration-statements
BEGIN 
   Executable-statements
EXCEPTION
   Exception-handling-statements
END;
*/

-----gary proposed trigger
CREATE OR REPLACE TRIGGER gr_update_comments
AFTER INSERT ON InvNum
FOR EACH ROW
--WHEN 
DECLARE
   comment1 varchar(30)
   comment2 varchar(30)
   comment3 varchar(30)
BEGIN
   if select * from inserted -- variables @type, calendar etc
   update based on type and timeframe e.g. if month = 02 then "FEBRUARY" etc.
   --select * from RecurRC
   --select * from RecurRDef
   --select * from RecurRF
   --select * from RecurRL
END 
