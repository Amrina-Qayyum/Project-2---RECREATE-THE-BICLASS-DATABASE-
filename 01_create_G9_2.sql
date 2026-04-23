IF DB_ID('G9_2') IS NULL
    CREATE DATABASE G9_2;
GO

USE G9_2;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'DbSecurity')
    EXEC('CREATE SCHEMA DbSecurity');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Process')
    EXEC('CREATE SCHEMA Process');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Project2')
    EXEC('CREATE SCHEMA Project2');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'PkSequence')
    EXEC('CREATE SCHEMA PkSequence');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'CH01-01-Dimension')
    EXEC('CREATE SCHEMA [CH01-01-Dimension]');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'CH01-01-Fact')
    EXEC('CREATE SCHEMA [CH01-01-Fact]');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'FileUpload')
    EXEC('CREATE SCHEMA FileUpload');
GO



USE G9_2;
GO

SELECT name
FROM sys.schemas
ORDER BY name;
GO