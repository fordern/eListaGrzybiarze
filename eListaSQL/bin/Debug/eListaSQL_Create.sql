﻿/*
Deployment script for eListaSQL

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "eListaSQL"
:setvar DefaultFilePrefix "eListaSQL"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)] COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[uzytkownik_grupa]...';


GO
CREATE TABLE [dbo].[uzytkownik_grupa] (
    [id]            BIGINT        NOT NULL,
    [id_uzytkownik] BIGINT        NOT NULL,
    [grupa]         VARCHAR (255) NOT NULL,
    [cdfsfsdfsd]    NCHAR (10)    NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Creating [dbo].[czas_pracy]...';


GO
CREATE TABLE [dbo].[czas_pracy] (
    [id]            BIGINT        NOT NULL,
    [id_uzytkownik] BIGINT        NOT NULL,
    [zakres_prac]   VARCHAR (255) NOT NULL,
    [dzien]         DATE          NOT NULL,
    [rozpoczecie]   DATE          NOT NULL,
    [zakonczenie]   DATE          NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Creating [dbo].[nieobecnosci]...';


GO
CREATE TABLE [dbo].[nieobecnosci] (
    [id]            BIGINT        NOT NULL,
    [id_uzytkownik] BIGINT        NOT NULL,
    [typ]           VARCHAR (255) NOT NULL,
    [data ]         DATE          NOT NULL,
    [ilosc_godzin]  INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Creating [dbo].[dziennik_planow]...';


GO
CREATE TABLE [dbo].[dziennik_planow] (
    [id]             BIGINT       NOT NULL,
    [id_uzytkownik]  BIGINT       NOT NULL,
    [dzien_tygodnia] VARCHAR (15) NOT NULL,
    [plan_od]        DATE         NOT NULL,
    [plan_do]        DATE         NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Creating [dbo].[uzytkownik]...';


GO
CREATE TABLE [dbo].[uzytkownik] (
    [id]       BIGINT        NOT NULL,
    [imie]     VARCHAR (255) NOT NULL,
    [nazwisko] VARCHAR (255) NOT NULL,
    [email]    VARCHAR (255) NOT NULL,
    [haslo]    VARCHAR (255) NOT NULL,
    [telefon]  VARCHAR (15)  NOT NULL,
    [aktywny]  BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Creating FK_uzytkownik_grupa_uzytkownik...';


GO
ALTER TABLE [dbo].[uzytkownik_grupa]
    ADD CONSTRAINT [FK_uzytkownik_grupa_uzytkownik] FOREIGN KEY ([id_uzytkownik]) REFERENCES [dbo].[uzytkownik] ([id]);


GO
PRINT N'Creating FK_czas_pracy_uzytkownik...';


GO
ALTER TABLE [dbo].[czas_pracy]
    ADD CONSTRAINT [FK_czas_pracy_uzytkownik] FOREIGN KEY ([id_uzytkownik]) REFERENCES [dbo].[uzytkownik] ([id]);


GO
PRINT N'Creating FK_nieobecnosci_uzytkownik...';


GO
ALTER TABLE [dbo].[nieobecnosci]
    ADD CONSTRAINT [FK_nieobecnosci_uzytkownik] FOREIGN KEY ([id_uzytkownik]) REFERENCES [dbo].[uzytkownik] ([id]);


GO
PRINT N'Creating FK_dziennik_planow_uzytkownik...';


GO
ALTER TABLE [dbo].[dziennik_planow]
    ADD CONSTRAINT [FK_dziennik_planow_uzytkownik] FOREIGN KEY ([id_uzytkownik]) REFERENCES [dbo].[uzytkownik] ([id]);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a5256e6a-0a5e-4aea-b86d-2b0a0d3b20cd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a5256e6a-0a5e-4aea-b86d-2b0a0d3b20cd')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a7648d1d-c6aa-4ce2-b52e-075b8e65679a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a7648d1d-c6aa-4ce2-b52e-075b8e65679a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5fd0e839-6b69-469b-99ac-469b8d622af1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5fd0e839-6b69-469b-99ac-469b8d622af1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd79d6c84-0814-42ef-9bf8-a591d3065d80')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d79d6c84-0814-42ef-9bf8-a591d3065d80')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c6282e71-983c-41ba-8927-fb8622f3d70d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c6282e71-983c-41ba-8927-fb8622f3d70d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3dfe723f-8631-4d3e-998e-5f28be08bef9')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3dfe723f-8631-4d3e-998e-5f28be08bef9')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET MULTI_USER 
    WITH ROLLBACK IMMEDIATE;


GO
PRINT N'Update complete.';


GO
