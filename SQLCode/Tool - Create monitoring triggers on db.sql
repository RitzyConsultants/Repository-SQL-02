 --THIS SCRIPT CREATES A TRIGGER FOR ALL TABLES IN DB AND MONITORS WHEN TABLE IS ADJUSTED AND WHAT IS ADJUSTED

--CHECK AND DROP EXISTSING WORKING
IF OBJECT_ID ('TableNames','U') IS NOT NULL
  DROP Table TableNames
GO

--CREATE TABLE FOR WORKNG
CREATE TABLE TableNames
(
TableID int identity primary key,
TableName varchar(max),
TableAction varchar(max)
)

--CREATE MONITORING TRIGGERS!!
GO
DECLARE @TableName varchar(max)
DECLARE @DSQL varchar(max)
DECLARE tableMonitor CURSOR FOR
SELECT name from sys.tables

OPEN tableMonitor
FETCH NEXT FROM tableMonitor INTO @TableName --FETCH FIRST VALUE...

WHILE @@FETCH_STATUS = 0 BEGIN --BEGIN THE LOOP

IF @TableName <> 'TableNames' BEGIN -- CHECK TABLE IS NOT THE TABLE USED FOR MONITORING
--CREATE Dynamic SQL TO CREATE THE TRIGGER
SET @DSQL= 'CREATE TRIGGER mTRIGINSERT'+ @TableName + ' ON  ' +@TableName + '
AFTER INSERT
AS 
insert into TableNames
(TableName,TableAction)
VALUES
('''+ @TableName +''', ''VALUE INSERTED'')'

--EXECUTE DYNAMIC SQL (CHECK IT DOESN"T EXIST ALREADY!!!)
IF OBJECT_ID ('mTRIGINSERT'+@TableName,'TR') IS NULL BEGIN
  EXECUTE(@DSQL)
  print 'TRIGGER CREATED FOR ' + @TABLENAME
END
ELSE
  DECLARE @FLUSHOLD varchar(max)
  SET @FLUSHOLD = 'DROP TRIGGER mTRIGINSERT' + @TableName
  EXECUTE(@FLUSHOLD)
  EXECUTE(@DSQL)
  print 'TRIGGER CREATED FOR ' + @TABLENAME
END
--FETCH NEXT
FETCH NEXT FROM tableMonitor INTO @TableName

END --END LOOP

GO

--DISPOSE OF CURSOR (CLOSE AND DEALLOCATE)
CLOSE tableMonitor
DEALLOCATE tableMonitor

--============================================================================================================================
--============================================================================================================================

--THIS SCRIPT CREATES A TRIGGER FOR ALL TABLES IN DB AND MONITORS WHEN TABLE IS ADJUSTED AND WHAT IS ADJUSTED

DECLARE @TableName varchar(max)
DECLARE @DSQL varchar(max)
DECLARE tableMonitor CURSOR FOR
SELECT name from sys.tables

OPEN tableMonitor
FETCH NEXT FROM tableMonitor INTO @TableName --FETCH FIRST VALUE...

WHILE @@FETCH_STATUS = 0 BEGIN --BEGIN THE LOOP

IF @TableName <> 'TableNames' BEGIN -- CHECK TABLE IS NOT THE TABLE USED FOR MONITORING
--CREATE Dynamic SQL TO CREATE THE TRIGGER
SET @DSQL= 'CREATE TRIGGER mTRIGUPDATE'+ @TableName + ' ON  ' +@TableName + '
AFTER UPDATE
AS 
insert into TableNames
(TableName,TableAction)
VALUES
('''+ @TableName +''', ''VALUE UPDATED'')'

--EXECUTE DYNAMIC SQL (CHECK IT DOESN"T EXIST ALREADY!!!)
IF OBJECT_ID ('mTRIGUPDATE'+@TableName,'TR') IS NULL BEGIN
  EXECUTE(@DSQL)
  print 'TRIGGER CREATED FOR ' + @TABLENAME
END
ELSE
  DECLARE @FLUSHOLD varchar(max)
  SET @FLUSHOLD = 'DROP TRIGGER mTRIGUPDATE' + @TableName
  EXECUTE(@FLUSHOLD)
  EXECUTE(@DSQL)
  print 'TRIGGER CREATED FOR ' + @TABLENAME
END
--FETCH NEXT
FETCH NEXT FROM tableMonitor INTO @TableName

END --END LOOP

GO

--DISPOSE OF CURSOR (CLOSE AND DEALLOCATE)
CLOSE tableMonitor
DEALLOCATE tableMonitor

--============================================================================================================================
--============================================================================================================================

--THIS SCRIPT CREATES A TRIGGER FOR ALL TABLES IN DB AND MONITORS WHEN TABLE IS ADJUSTED AND WHAT IS ADJUSTED

DECLARE @TableName varchar(max)
DECLARE @DSQL varchar(max)
DECLARE tableMonitor CURSOR FOR
SELECT name from sys.tables

OPEN tableMonitor
FETCH NEXT FROM tableMonitor INTO @TableName --FETCH FIRST VALUE...

WHILE @@FETCH_STATUS = 0 BEGIN --BEGIN THE LOOP

IF @TableName <> 'TableNames' BEGIN -- CHECK TABLE IS NOT THE TABLE USED FOR MONITORING
--CREATE Dynamic SQL TO CREATE THE TRIGGER
SET @DSQL= 'CREATE TRIGGER mTRIGDELETE'+ @TableName + ' ON  ' +@TableName + '
AFTER DELETE
AS 
insert into TableNames
(TableName,TableAction)
VALUES
('''+ @TableName +''', ''VALUE DELETE'')'

--EXECUTE DYNAMIC SQL (CHECK IT DOESN"T EXIST ALREADY!!!)
IF OBJECT_ID ('mTRIGDELETE'+@TableName,'TR') IS NULL BEGIN
  EXECUTE(@DSQL)
  print 'TRIGGER CREATED FOR ' + @TABLENAME
END
ELSE
  DECLARE @FLUSHOLD varchar(max)
  SET @FLUSHOLD = 'DROP TRIGGER mTRIGDELETE' + @TableName
  EXECUTE(@FLUSHOLD)
  EXECUTE(@DSQL)
  print 'TRIGGER CREATED FOR ' + @TABLENAME
END
--FETCH NEXT
FETCH NEXT FROM tableMonitor INTO @TableName

END --END LOOP

GO

--DISPOSE OF CURSOR (CLOSE AND DEALLOCATE)
CLOSE tableMonitor
DEALLOCATE tableMonitor


--SELECT * FROM TableNames