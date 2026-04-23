USE G9_2;
GO

CREATE OR ALTER PROCEDURE Project2.DropForeignKeysFromStarSchemaData
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimProduct'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimProduct];

    IF EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_SalesManagers'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_SalesManagers];

    IF EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimMaritalStatus'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimMaritalStatus];

    IF EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimGender'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimGender];

    IF EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimOccupation'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimOccupation];

    IF EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimOrderDate'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimOrderDate];

    IF EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimTerritory'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimTerritory];

    IF EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimCustomer'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimCustomer];

    IF EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_DimProduct_DimProductSubcategory'
          AND parent_object_id = OBJECT_ID('[CH01-01-Dimension].[DimProduct]')
    )
        ALTER TABLE [CH01-01-Dimension].[DimProduct] DROP CONSTRAINT [FK_DimProduct_DimProductSubcategory];

    IF EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_DimProductSubcategory_DimProductCategory'
          AND parent_object_id = OBJECT_ID('[CH01-01-Dimension].[DimProductSubcategory]')
    )
        ALTER TABLE [CH01-01-Dimension].[DimProductSubcategory] DROP CONSTRAINT [FK_DimProductSubcategory_DimProductCategory];
END;
GO

CREATE OR ALTER PROCEDURE Project2.AddForeignKeysToStarSchemaData
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_DimProductSubcategory_DimProductCategory'
          AND parent_object_id = OBJECT_ID('[CH01-01-Dimension].[DimProductSubcategory]')
    )
        ALTER TABLE [CH01-01-Dimension].[DimProductSubcategory]
        ADD CONSTRAINT [FK_DimProductSubcategory_DimProductCategory]
        FOREIGN KEY (ProductCategoryKey)
        REFERENCES [CH01-01-Dimension].[DimProductCategory](ProductCategoryKey);

    IF NOT EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_DimProduct_DimProductSubcategory'
          AND parent_object_id = OBJECT_ID('[CH01-01-Dimension].[DimProduct]')
    )
        ALTER TABLE [CH01-01-Dimension].[DimProduct]
        ADD CONSTRAINT [FK_DimProduct_DimProductSubcategory]
        FOREIGN KEY (ProductSubcategoryKey)
        REFERENCES [CH01-01-Dimension].[DimProductSubcategory](ProductSubcategoryKey);

    IF NOT EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimProduct'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data]
        ADD CONSTRAINT [FK_Data_DimProduct]
        FOREIGN KEY (ProductKey)
        REFERENCES [CH01-01-Dimension].[DimProduct](ProductKey);

    IF NOT EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_SalesManagers'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data]
        ADD CONSTRAINT [FK_Data_SalesManagers]
        FOREIGN KEY (SalesManagerKey)
        REFERENCES [CH01-01-Dimension].[SalesManagers](SalesManagerKey);

    IF NOT EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimMaritalStatus'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data]
        ADD CONSTRAINT [FK_Data_DimMaritalStatus]
        FOREIGN KEY (MaritalStatus)
        REFERENCES [CH01-01-Dimension].[DimMaritalStatus](MaritalStatus);

    IF NOT EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimGender'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data]
        ADD CONSTRAINT [FK_Data_DimGender]
        FOREIGN KEY (Gender)
        REFERENCES [CH01-01-Dimension].[DimGender](Gender);

    IF NOT EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimOccupation'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data]
        ADD CONSTRAINT [FK_Data_DimOccupation]
        FOREIGN KEY (OccupationKey)
        REFERENCES [CH01-01-Dimension].[DimOccupation](OccupationKey);

    IF NOT EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimOrderDate'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data]
        ADD CONSTRAINT [FK_Data_DimOrderDate]
        FOREIGN KEY (OrderDate)
        REFERENCES [CH01-01-Dimension].[DimOrderDate](OrderDate);

    IF NOT EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimTerritory'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data]
        ADD CONSTRAINT [FK_Data_DimTerritory]
        FOREIGN KEY (TerritoryKey)
        REFERENCES [CH01-01-Dimension].[DimTerritory](TerritoryKey);

    IF NOT EXISTS (
        SELECT 1
        FROM sys.foreign_keys
        WHERE name = 'FK_Data_DimCustomer'
          AND parent_object_id = OBJECT_ID('[CH01-01-Fact].[Data]')
    )
        ALTER TABLE [CH01-01-Fact].[Data]
        ADD CONSTRAINT [FK_Data_DimCustomer]
        FOREIGN KEY (CustomerKey)
        REFERENCES [CH01-01-Dimension].[DimCustomer](CustomerKey);
END;
GO

CREATE OR ALTER PROCEDURE Project2.TruncateStarSchemaData
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE [CH01-01-Fact].[Data];
    TRUNCATE TABLE [CH01-01-Dimension].[DimProduct];
    TRUNCATE TABLE [CH01-01-Dimension].[DimProductSubcategory];
    TRUNCATE TABLE [CH01-01-Dimension].[DimProductCategory];
    TRUNCATE TABLE [CH01-01-Dimension].[SalesManagers];
    TRUNCATE TABLE [CH01-01-Dimension].[DimCustomer];
    TRUNCATE TABLE [CH01-01-Dimension].[DimTerritory];
    TRUNCATE TABLE [CH01-01-Dimension].[DimOccupation];
    TRUNCATE TABLE [CH01-01-Dimension].[DimMaritalStatus];
    TRUNCATE TABLE [CH01-01-Dimension].[DimGender];
    TRUNCATE TABLE [CH01-01-Dimension].[DimOrderDate];

    ALTER SEQUENCE PkSequence.DataSequenceObject RESTART WITH 1;
    ALTER SEQUENCE PkSequence.DimProductSequenceObject RESTART WITH 1;
    ALTER SEQUENCE PkSequence.DimProductSubcategorySequenceObject RESTART WITH 1;
    ALTER SEQUENCE PkSequence.DimProductCategorySequenceObject RESTART WITH 1;
    ALTER SEQUENCE PkSequence.SalesManagersSequenceObject RESTART WITH 1;
    ALTER SEQUENCE PkSequence.DimCustomerSequenceObject RESTART WITH 1;
    ALTER SEQUENCE PkSequence.DimTerritorySequenceObject RESTART WITH 1;
    ALTER SEQUENCE PkSequence.DimOccupationSequenceObject RESTART WITH 1;
END;
GO

CREATE OR ALTER PROCEDURE Project2.LoadStarSchemaData
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    EXEC Project2.DropForeignKeysFromStarSchemaData;
    EXEC Project2.TruncateStarSchemaData;

    EXEC Project2.Load_DimProductCategory    @GroupMemberUserAuthorizationKey;
    EXEC Project2.Load_DimProductSubcategory @GroupMemberUserAuthorizationKey;
    EXEC Project2.Load_SalesManagers         @GroupMemberUserAuthorizationKey;
    EXEC Project2.Load_DimGender             @GroupMemberUserAuthorizationKey;
    EXEC Project2.Load_DimMaritalStatus      @GroupMemberUserAuthorizationKey;
    EXEC Project2.Load_DimOccupation         @GroupMemberUserAuthorizationKey;
    EXEC Project2.Load_DimOrderDate          @GroupMemberUserAuthorizationKey;
    EXEC Project2.Load_DimCustomer           @GroupMemberUserAuthorizationKey;
    EXEC Project2.Load_DimTerritory          @GroupMemberUserAuthorizationKey;
    EXEC Project2.Load_DimProduct            @GroupMemberUserAuthorizationKey;
    EXEC Project2.Load_Data                  @GroupMemberUserAuthorizationKey;

    EXEC Project2.AddForeignKeysToStarSchemaData;
END;
GO