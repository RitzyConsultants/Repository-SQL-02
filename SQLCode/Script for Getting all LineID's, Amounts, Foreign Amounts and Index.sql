USE [RITZY IT]
GO
/****** Object:  StoredProcedure [dbo].[cAllocs_Seperator]    Script Date: 2015-03-04 9:10:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----DROP PROC cAllocs_Seperator

--EXEC cAllocs_Seperator @FROM_DATE = '2013-09-30', @TO_DATE = '2014-09-30'

--DELETE FROM Temp_Allocation

--DROP TABLE Temp_Allocation

--SELECT * FROM Temp_Allocation

ALTER PROC [dbo].[cAllocs_Seperator]	@FROM_DATE VARCHAR(MAX),
								@TO_DATE VARCHAR(MAX)

AS

--DROP THE TABLE IF EXISTS

DROP TABLE Temp_Allocation

--CREATE THE TEMP TABLE

CREATE TABLE Temp_Allocation
(LineID INT,
LineDate DATE,
AccountLink VARCHAR(MAX),
Debit FLOAT,
Credit FLOAT,
AllocAmountA VARCHAR(MAX),
AllocAmountF VARCHAR(MAX),
AllocAmountI VARCHAR(MAX),
AllocAmountD DATE)

--IF YOU ARE USING A CLIENT, UNCOMMENT THE AND AccountLink = @Client

declare CurAlloc cursor
for 
SELECT
cAllocs,
AutoIdx,
TxDate,
AccountLink,
Debit,
Credit
FROM
PostAR
WHERE 
CONVERT(VARCHAR, cAllocs) <> ''
and 
(
Id = 'Inv' 
OR
Id = 'OInv'
)
and 
Outstanding = 0
and
Reference -- 
in 
(
SELECT
InvNumber 
FROM
InvNum
WHERE
(
DocType = 0 -- zero equals invoice ie. only retrieving invoices, can add code for sales order and jobcard
OR
DocType = 4
)
AND
DocState = 4 -- documents are fully processed ie. not quote or partial delivery
AND
CONVERT(Date, InvDate) > @FROM_DATE 
and
CONVERT(Date,InvDate)  <= @TO_DATE 
)

open CurAlloc

DECLARE @ValueReturned varchar(max)
DECLARE @ID VARCHAR(MAX)
DECLARE @LineDate Date
DECLARE @AccountLink VARCHAR(MAX)
DECLARE @Debit FLOAT
DECLARE @Credit FLOAT

FETCH NEXT FROM CurAlloc
into @ValueReturned, @ID,@LineDate, @AccountLink,@Debit,@Credit

while @@FETCH_STATUS = 0
BEGIN

DECLARE @MyKeyIds VARCHAR(MAX)
DECLARE @IDset VARCHAR(MAX)
DECLARE @Pos INT
DECLARE @NextPos INT
DECLARE @Delimiter VARCHAR(MAX)
DECLARE @Index VARCHAR(MAX)

SET @Delimiter = ';'
Set @MyKeyIds= REPLACE(@ValueReturned, '|', ';') + @Delimiter
SET @Pos = charindex(@Delimiter, @MyKeyIds)

WHILE (@pos <> 0)
BEGIN
    SET @IDset = substring(@MyKeyIds,1,@Pos - 1)
    IF (@IDset LIKE '%A%')
    BEGIN
        PRINT SUBSTRING(@IDset, 3, LEN(@IDset)) -- Show Results
        UPDATE Temp_Allocation
        SET AllocAmountA = (SUBSTRING(@IDset, 3, LEN(@IDset)))
        WHERE LineID = @ID
        AND
        AllocAmountI = @Index
        AND
        (SUBSTRING(@IDset, 3, LEN(@IDset))) is not null
		SET @MyKeyIds = substring(@MyKeyIds,@Pos+1,len(@MyKeyIds))
		SET @Pos = charindex(@Delimiter,@MyKeyIds)
   	END
	ELSE IF (@IDset LIKE '%F%')
	BEGIN
		PRINT SUBSTRING(@IDset, 3, LEN(@IDset)) -- Show Results
        UPDATE Temp_Allocation
        SET AllocAmountF = (SUBSTRING(@IDset, 3, LEN(@IDset)))
        WHERE LineID = @ID
        AND
        (SUBSTRING(@IDset, 3, LEN(@IDset))) is not null
		SET @MyKeyIds = substring(@MyKeyIds,@Pos+1,len(@MyKeyIds))
		SET @Pos = charindex(@Delimiter,@MyKeyIds)
	END
	ELSE IF (@IDset LIKE '%D%')
	BEGIN
		PRINT SUBSTRING(@IDset, 3, LEN(@IDset)) -- Show Results
        UPDATE Temp_Allocation
        SET AllocAmountD = (SUBSTRING(@IDset, 3, LEN(@IDset)))
        WHERE LineID = @ID
        AND
        AllocAmountI = @Index
        AND
        (SUBSTRING(@IDset, 3, LEN(@IDset))) is not null
		SET @MyKeyIds = substring(@MyKeyIds,@Pos+1,len(@MyKeyIds))
		SET @Pos = charindex(@Delimiter,@MyKeyIds)
	END
	ELSE IF (@IDset LIKE '%I%')
	BEGIN
		PRINT SUBSTRING(@IDset, 3, LEN(@IDset)) -- Show Results
        INSERT INTO Temp_Allocation
        (AllocAmountI, LineID,LineDate, AccountLink,Debit,Credit)
        VALUES
        (SUBSTRING(@IDset, 3, LEN(@IDset)), @ID,@LineDate, @AccountLink,@Debit,@Credit)
        SET @MyKeyIds = substring(@MyKeyIds,@Pos+1,len(@MyKeyIds))
		SET @Pos = charindex(@Delimiter,@MyKeyIds)
		
		SET @Index = (SUBSTRING(@IDset, 3, LEN(@IDset)))
		
	END
	ELSE
	BEGIN
		SET @MyKeyIds = substring(@MyKeyIds,@Pos+1,len(@MyKeyIds))
		SET @Pos = charindex(@Delimiter,@MyKeyIds)
	END
	END

FETCH NEXT FROM CurAlloc
into @ValueReturned, @ID,@LineDate, @AccountLink,@Debit,@Credit

END

CLOSE CurAlloc
Deallocate CurAlloc

