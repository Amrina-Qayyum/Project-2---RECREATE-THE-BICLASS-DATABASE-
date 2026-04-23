USE G9_2;
GO

/* Drop target tables first if they already exist */
IF OBJECT_ID('[CH01-01-Fact].[Data]', 'U') IS NOT NULL
    DROP TABLE [CH01-01-Fact].[Data];
GO
IF OBJECT_ID('[CH01-01-Dimension].[SalesManagers]', 'U') IS NOT NULL
    DROP TABLE [CH01-01-Dimension].[SalesManagers];
GO
IF OBJECT_ID('[CH01-01-Dimension].[DimTerritory]', 'U') IS NOT NULL
    DROP TABLE [CH01-01-Dimension].[DimTerritory];
GO
IF OBJECT_ID('[CH01-01-Dimension].[DimProduct]', 'U') IS NOT NULL
    DROP TABLE [CH01-01-Dimension].[DimProduct];
GO
IF OBJECT_ID('[CH01-01-Dimension].[DimOrderDate]', 'U') IS NOT NULL
    DROP TABLE [CH01-01-Dimension].[DimOrderDate];
GO
IF OBJECT_ID('[CH01-01-Dimension].[DimOccupation]', 'U') IS NOT NULL
    DROP TABLE [CH01-01-Dimension].[DimOccupation];
GO
IF OBJECT_ID('[CH01-01-Dimension].[DimMaritalStatus]', 'U') IS NOT NULL
    DROP TABLE [CH01-01-Dimension].[DimMaritalStatus];
GO
IF OBJECT_ID('[CH01-01-Dimension].[DimGender]', 'U') IS NOT NULL
    DROP TABLE [CH01-01-Dimension].[DimGender];
GO
IF OBJECT_ID('[CH01-01-Dimension].[DimCustomer]', 'U') IS NOT NULL
    DROP TABLE [CH01-01-Dimension].[DimCustomer];
GO

DECLARE @Tables TABLE
(
    RowNum INT IDENTITY(1,1),
    SchemaName SYSNAME,
    TableName SYSNAME
);

INSERT INTO @Tables (SchemaName, TableName)
VALUES
('CH01-01-Dimension', 'DimCustomer'),
('CH01-01-Dimension', 'DimGender'),
('CH01-01-Dimension', 'DimMaritalStatus'),
('CH01-01-Dimension', 'DimOccupation'),
('CH01-01-Dimension', 'DimOrderDate'),
('CH01-01-Dimension', 'DimProduct'),
('CH01-01-Dimension', 'DimTerritory'),
('CH01-01-Dimension', 'SalesManagers'),
('CH01-01-Fact', 'Data');

DECLARE
    @i INT = 1,
    @max INT,
    @SchemaName SYSNAME,
    @TableName SYSNAME,
    @SourceObject NVARCHAR(300),
    @TargetObject NVARCHAR(300),
    @CreateSQL NVARCHAR(MAX),
    @ColumnSQL NVARCHAR(MAX),
    @PKSQL NVARCHAR(MAX);

SELECT @max = COUNT(*) FROM @Tables;

WHILE @i <= @max
BEGIN
    SELECT
        @SchemaName = SchemaName,
        @TableName  = TableName
    FROM @Tables
    WHERE RowNum = @i;

    SET @SourceObject = N'BIClass.' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName);
    SET @TargetObject = QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName);

    /* Build column list */
    SELECT @ColumnSQL =
        STUFF((
            SELECT
                CHAR(10) + N'    ,' + QUOTENAME(c.name) + N' ' +
                CASE
                    WHEN ty.name IN ('varchar', 'char', 'binary', 'varbinary')
                        THEN ty.name + N'(' + CASE WHEN c.max_length = -1 THEN 'MAX' ELSE CAST(c.max_length AS VARCHAR(10)) END + N')'
                    WHEN ty.name IN ('nvarchar', 'nchar')
                        THEN ty.name + N'(' + CASE WHEN c.max_length = -1 THEN 'MAX' ELSE CAST(c.max_length / 2 AS VARCHAR(10)) END + N')'
                    WHEN ty.name IN ('decimal', 'numeric')
                        THEN ty.name + N'(' + CAST(c.precision AS VARCHAR(10)) + N',' + CAST(c.scale AS VARCHAR(10)) + N')'
                    WHEN ty.name IN ('datetime2', 'datetimeoffset', 'time')
                        THEN ty.name + N'(' + CAST(c.scale AS VARCHAR(10)) + N')'
                    ELSE ty.name
                END +
                CASE
                    WHEN ic.column_id IS NOT NULL
                        THEN N' NOT NULL CONSTRAINT ' +
                             QUOTENAME('DF_' + @TableName + '_' + c.name) +
                             N' DEFAULT (NEXT VALUE FOR PkSequence.' + @TableName + N'SequenceObject)'
                    ELSE CASE WHEN c.is_nullable = 1 THEN N' NULL' ELSE N' NOT NULL' END
                END
            FROM BIClass.sys.columns c
            JOIN BIClass.sys.types ty
              ON c.user_type_id = ty.user_type_id
            LEFT JOIN BIClass.sys.identity_columns ic
              ON c.object_id = ic.object_id
             AND c.column_id = ic.column_id
            WHERE c.object_id = OBJECT_ID(@SourceObject)
            ORDER BY c.column_id
            FOR XML PATH(''), TYPE
        ).value('.', 'nvarchar(max)'), 1, 6, N'    ');

    /* Build PK list */
    SELECT @PKSQL =
        STUFF((
            SELECT
                N', ' + QUOTENAME(c.name)
            FROM BIClass.sys.key_constraints kc
            JOIN BIClass.sys.index_columns ic
              ON kc.parent_object_id = ic.object_id
             AND kc.unique_index_id = ic.index_id
            JOIN BIClass.sys.columns c
              ON ic.object_id = c.object_id
             AND ic.column_id = c.column_id
            WHERE kc.parent_object_id = OBJECT_ID(@SourceObject)
              AND kc.type = 'PK'
            ORDER BY ic.key_ordinal
            FOR XML PATH(''), TYPE
        ).value('.', 'nvarchar(max)'), 1, 2, N'');

    SET @CreateSQL = N'
CREATE TABLE ' + @TargetObject + N'
(
' + @ColumnSQL + N',
    [UserAuthorizationKey] INT NOT NULL,
    [DateAdded] DATETIME2(7) NULL CONSTRAINT ' + QUOTENAME('DF_' + @TableName + '_DateAdded') + N' DEFAULT (SYSDATETIME()),
    [DateOfLastUpdate] DATETIME2(7) NULL CONSTRAINT ' + QUOTENAME('DF_' + @TableName + '_DateOfLastUpdate') + N' DEFAULT (SYSDATETIME()),
    CONSTRAINT ' + QUOTENAME('PK_' + @TableName) + N' PRIMARY KEY (' + @PKSQL + N')
);';

    PRINT 'Creating ' + @TargetObject;
    EXEC sp_executesql @CreateSQL;

    SET @i += 1;
END;
GO