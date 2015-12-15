USE [AFS Johannesburg]
GO

/****** Object:  Trigger [dbo].[updateAccountDot]    Script Date: 24/03/2015 04:33:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[updateAccountDot]
ON [dbo].[Accounts]
FOR INSERT, UPDATE AS

DECLARE 
	@Mstr varchar(30)

SELECT @Mstr = Master_Sub_Account from Inserted

IF UPDATE(Master_Sub_Account)
BEGIN
		update Accounts
		set Master_Sub_Account = REPLACE(Master_Sub_Account,'>','.') 
		where AccountLink = (select AccountLink from Inserted)
END

GO


