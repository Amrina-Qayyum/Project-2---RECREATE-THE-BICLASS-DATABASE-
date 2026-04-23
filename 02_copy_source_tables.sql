USE G9_2;
GO

IF OBJECT_ID('FileUpload.OriginallyLoadedData', 'U') IS NOT NULL
    DROP TABLE FileUpload.OriginallyLoadedData;
GO

SELECT *
INTO FileUpload.OriginallyLoadedData
FROM BIClass.FileUpload.OriginallyLoadedData;
GO

IF OBJECT_ID('FileUpload.ProductCategories', 'U') IS NOT NULL
    DROP TABLE FileUpload.ProductCategories;
GO

SELECT *
INTO FileUpload.ProductCategories
FROM BIClass.FileUpload.ProductCategories;
GO

IF OBJECT_ID('FileUpload.ProductSubcategories', 'U') IS NOT NULL
    DROP TABLE FileUpload.ProductSubcategories;
GO

SELECT *
INTO FileUpload.ProductSubcategories
FROM BIClass.FileUpload.ProductSubcategories;
GO


USE G9_2;
GO

SELECT s.name AS SchemaName, t.name AS TableName
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
ORDER BY s.name, t.name;
GO
