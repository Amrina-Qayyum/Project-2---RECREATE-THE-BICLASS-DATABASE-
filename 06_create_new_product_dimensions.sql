USE G9_2;
GO

IF OBJECT_ID('[CH01-01-Dimension].[DimProductSubcategory]', 'U') IS NOT NULL
    DROP TABLE [CH01-01-Dimension].[DimProductSubcategory];
GO

IF OBJECT_ID('[CH01-01-Dimension].[DimProductCategory]', 'U') IS NOT NULL
    DROP TABLE [CH01-01-Dimension].[DimProductCategory];
GO

CREATE TABLE [CH01-01-Dimension].[DimProductCategory]
(
    ProductCategoryKey INT NOT NULL
        CONSTRAINT PK_DimProductCategory PRIMARY KEY
        CONSTRAINT DF_DimProductCategory_ProductCategoryKey
            DEFAULT (NEXT VALUE FOR PkSequence.DimProductCategorySequenceObject),

    ProductCategory VARCHAR(20) NOT NULL,

    UserAuthorizationKey INT NOT NULL,
    DateAdded DATETIME2(7) NULL
        CONSTRAINT DF_DimProductCategory_DateAdded DEFAULT (SYSDATETIME()),
    DateOfLastUpdate DATETIME2(7) NULL
        CONSTRAINT DF_DimProductCategory_DateOfLastUpdate DEFAULT (SYSDATETIME())
);
GO

CREATE TABLE [CH01-01-Dimension].[DimProductSubcategory]
(
    ProductSubcategoryKey INT NOT NULL
        CONSTRAINT PK_DimProductSubcategory PRIMARY KEY
        CONSTRAINT DF_DimProductSubcategory_ProductSubcategoryKey
            DEFAULT (NEXT VALUE FOR PkSequence.DimProductSubcategorySequenceObject),

    ProductCategoryKey INT NOT NULL,
    ProductSubcategory VARCHAR(20) NOT NULL,

    UserAuthorizationKey INT NOT NULL,
    DateAdded DATETIME2(7) NULL
        CONSTRAINT DF_DimProductSubcategory_DateAdded DEFAULT (SYSDATETIME()),
    DateOfLastUpdate DATETIME2(7) NULL
        CONSTRAINT DF_DimProductSubcategory_DateOfLastUpdate DEFAULT (SYSDATETIME()),

    CONSTRAINT FK_DimProductSubcategory_DimProductCategory
        FOREIGN KEY (ProductCategoryKey)
        REFERENCES [CH01-01-Dimension].[DimProductCategory](ProductCategoryKey)
);
GO


USE G9_2;
GO

SELECT s.name AS SchemaName, t.name AS TableName
FROM sys.tables t
JOIN sys.schemas s
  ON t.schema_id = s.schema_id
ORDER BY s.name, t.name;
GO

USE G9_2;
GO

SELECT
    c.TABLE_SCHEMA,
    c.TABLE_NAME,
    c.COLUMN_NAME,
    c.DATA_TYPE,
    c.CHARACTER_MAXIMUM_LENGTH,
    c.IS_NULLABLE,
    c.ORDINAL_POSITION
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA IN ('CH01-01-Dimension', 'CH01-01-Fact')
ORDER BY c.TABLE_SCHEMA, c.TABLE_NAME, c.ORDINAL_POSITION;
GO