-- detach attach
-- gary 11/03/2015
-- some databases not affected as drive letter not changed (c: drive)
-- others were on d or another
-- had to attach Evolutioncommon, Metsoauto, Neles2003.2004.2005
-- these no data MelMetso,Metso YE2010,

USE master;
GO
EXEC sp_detach_db @dbname = N'MetsoAuto';
GO

USE master;
GO
EXEC sp_detach_db @dbname = N'EvolutionCommon';
GO

USE master;
GO
CREATE DATABASE MetsoAuto 
    ON (FILENAME = 'D:\EvoData\MetsoAuto.mdf'),
    (FILENAME = 'D:\EvoData\MetsoAuto_log.ldf')
    FOR ATTACH;
GO

USE master;
GO
CREATE DATABASE EvolutionCommon 
    ON (FILENAME = 'D:\EvoData\EvolutionCommon.mdf'),
    (FILENAME = 'D:\EvoData\EvolutionCommon_log.ldf')
    FOR ATTACH;
GO

USE master;
GO
CREATE DATABASE Neles2003 
    ON (FILENAME = 'D:\EvoData\Neles2003.mdf'),
    (FILENAME = 'D:\EvoData\Neles2003_log.ldf')
    FOR ATTACH;
GO

USE master;
GO
CREATE DATABASE Neles2004
    ON (FILENAME = 'D:\EvoData\Neles2004.mdf'),
    (FILENAME = 'D:\EvoData\Neles2004_log.ldf')
    FOR ATTACH;
GO

USE master;
GO
CREATE DATABASE Neles2005 
    ON (FILENAME = 'D:\EvoData\Neles2005.mdf'),
    (FILENAME = 'D:\EvoData\Neles2005_log.ldf')
    FOR ATTACH;
GO

use master
go
CREATE DATABASE MetsoAuto ON (FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.GARY2008R2\MSSQL\Data\MetsoAuto.mdf')
FOR ATTACH_REBUILD_LOG;

use master
go
CREATE DATABASE EvolutionCommon ON (FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.GARY2008R2\MSSQL\Data\Evolutioncommon.mdf')
FOR ATTACH_REBUILD_LOG;
