USE G9_2;
GO

CREATE OR ALTER PROCEDURE Project2.Load_DimOccupation
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7) = SYSDATETIME();

    ;WITH DistinctOccupations AS
    (
        SELECT DISTINCT
            old.Occupation
        FROM FileUpload.OriginallyLoadedData old
        WHERE old.Occupation IS NOT NULL
          AND NOT EXISTS
          (
              SELECT 1
              FROM [CH01-01-Dimension].[DimOccupation] d
              WHERE d.Occupation = old.Occupation
          )
    )
    INSERT INTO [CH01-01-Dimension].[DimOccupation]
    (
        OccupationKey,
        Occupation,
        UserAuthorizationKey
    )
    SELECT
        NEXT VALUE FOR PkSequence.DimOccupationSequenceObject,
        dox.Occupation,
        @GroupMemberUserAuthorizationKey
    FROM DistinctOccupations dox;

    DECLARE @Rows INT = @@ROWCOUNT;
    DECLARE @EndTime DATETIME2(7) = SYSDATETIME();

    EXEC Process.usp_TrackWorkFlow
        @WorkFlowStepDescription = 'Load DimOccupation',
        @WorkFlowStepTableRowCount = @Rows,
        @StartingDateTime = @StartTime,
        @EndingDateTime = @EndTime,
        @UserAuthorizationKey = @GroupMemberUserAuthorizationKey;
END;
GO

CREATE OR ALTER PROCEDURE Project2.Load_DimOrderDate
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7) = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimOrderDate]
    (
        OrderDate,
        MonthName,
        MonthNumber,
        Year,
        UserAuthorizationKey
    )
    SELECT DISTINCT
        old.OrderDate,
        old.MonthName,
        old.MonthNumber,
        old.Year,
        @GroupMemberUserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData old
    WHERE old.OrderDate IS NOT NULL
      AND NOT EXISTS
      (
          SELECT 1
          FROM [CH01-01-Dimension].[DimOrderDate] d
          WHERE d.OrderDate = old.OrderDate
      );

    DECLARE @Rows INT = @@ROWCOUNT;
    DECLARE @EndTime DATETIME2(7) = SYSDATETIME();

    EXEC Process.usp_TrackWorkFlow
        @WorkFlowStepDescription = 'Load DimOrderDate',
        @WorkFlowStepTableRowCount = @Rows,
        @StartingDateTime = @StartTime,
        @EndingDateTime = @EndTime,
        @UserAuthorizationKey = @GroupMemberUserAuthorizationKey;
END;
GO

CREATE OR ALTER PROCEDURE Project2.Load_DimCustomer
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7) = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimCustomer]
    (
        CustomerName,
        UserAuthorizationKey
    )
    SELECT DISTINCT
        old.CustomerName,
        @GroupMemberUserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData old
    WHERE old.CustomerName IS NOT NULL
      AND NOT EXISTS
      (
          SELECT 1
          FROM [CH01-01-Dimension].[DimCustomer] d
          WHERE d.CustomerName = old.CustomerName
      );

    DECLARE @Rows INT = @@ROWCOUNT;
    DECLARE @EndTime DATETIME2(7) = SYSDATETIME();

    EXEC Process.usp_TrackWorkFlow
        @WorkFlowStepDescription = 'Load DimCustomer',
        @WorkFlowStepTableRowCount = @Rows,
        @StartingDateTime = @StartTime,
        @EndingDateTime = @EndTime,
        @UserAuthorizationKey = @GroupMemberUserAuthorizationKey;
END;
GO

CREATE OR ALTER PROCEDURE Project2.Load_DimTerritory
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7) = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimTerritory]
    (
        TerritoryRegion,
        TerritoryCountry,
        TerritoryGroup,
        UserAuthorizationKey
    )
    SELECT DISTINCT
        old.TerritoryRegion,
        old.TerritoryCountry,
        old.TerritoryGroup,
        @GroupMemberUserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData old
    WHERE old.TerritoryRegion IS NOT NULL
      AND old.TerritoryCountry IS NOT NULL
      AND old.TerritoryGroup IS NOT NULL
      AND NOT EXISTS
      (
          SELECT 1
          FROM [CH01-01-Dimension].[DimTerritory] d
          WHERE d.TerritoryRegion = old.TerritoryRegion
            AND d.TerritoryCountry = old.TerritoryCountry
            AND d.TerritoryGroup = old.TerritoryGroup
      );

    DECLARE @Rows INT = @@ROWCOUNT;
    DECLARE @EndTime DATETIME2(7) = SYSDATETIME();

    EXEC Process.usp_TrackWorkFlow
        @WorkFlowStepDescription = 'Load DimTerritory',
        @WorkFlowStepTableRowCount = @Rows,
        @StartingDateTime = @StartTime,
        @EndingDateTime = @EndTime,
        @UserAuthorizationKey = @GroupMemberUserAuthorizationKey;
END;
GO

CREATE OR ALTER PROCEDURE Project2.Load_DimProduct
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7) = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimProduct]
    (
        ProductSubcategoryKey,
        ProductCategory,
        ProductSubcategory,
        ProductCode,
        ProductName,
        Color,
        ModelName,
        UserAuthorizationKey
    )
    SELECT DISTINCT
        psc.ProductSubcategoryKey,
        old.ProductCategory,
        old.ProductSubcategory,
        old.ProductCode,
        old.ProductName,
        old.Color,
        old.ModelName,
        @GroupMemberUserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData old
    JOIN [CH01-01-Dimension].[DimProductSubcategory] psc
      ON psc.ProductSubcategory = old.ProductSubcategory
    WHERE old.ProductName IS NOT NULL
      AND NOT EXISTS
      (
          SELECT 1
          FROM [CH01-01-Dimension].[DimProduct] d
          WHERE d.ProductName = old.ProductName
            AND ISNULL(d.ProductCode, '') = ISNULL(old.ProductCode, '')
      );

    DECLARE @Rows INT = @@ROWCOUNT;
    DECLARE @EndTime DATETIME2(7) = SYSDATETIME();

    EXEC Process.usp_TrackWorkFlow
        @WorkFlowStepDescription = 'Load DimProduct',
        @WorkFlowStepTableRowCount = @Rows,
        @StartingDateTime = @StartTime,
        @EndingDateTime = @EndTime,
        @UserAuthorizationKey = @GroupMemberUserAuthorizationKey;
END;
GO

CREATE OR ALTER PROCEDURE Project2.Load_Data
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7) = SYSDATETIME();

    INSERT INTO [CH01-01-Fact].[Data]
    (
        SalesKey,
        ProductKey,
        SalesManagerKey,
        MaritalStatus,
        Gender,
        OccupationKey,
        OrderDate,
        TerritoryKey,
        CustomerKey,
        ProductStandardCost,
        SalesAmount,
        OrderQuantity,
        UnitPrice,
        UserAuthorizationKey
    )
    SELECT
        old.SalesKey,
        dp.ProductKey,
        sm.SalesManagerKey,
        old.MaritalStatus,
        old.Gender,
        occ.OccupationKey,
        old.OrderDate,
        dt.TerritoryKey,
        dc.CustomerKey,
        old.ProductStandardCost,
        old.SalesAmount,
        old.OrderQuantity,
        old.UnitPrice,
        @GroupMemberUserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData old
    JOIN [CH01-01-Dimension].[DimProduct] dp
      ON dp.ProductName = old.ProductName
     AND ISNULL(dp.ProductCode, '') = ISNULL(old.ProductCode, '')
    JOIN [CH01-01-Dimension].[SalesManagers] sm
      ON sm.SalesManager = old.SalesManager
    JOIN [CH01-01-Dimension].[DimOccupation] occ
      ON occ.Occupation = old.Occupation
    JOIN [CH01-01-Dimension].[DimTerritory] dt
      ON dt.TerritoryRegion = old.TerritoryRegion
     AND dt.TerritoryCountry = old.TerritoryCountry
     AND dt.TerritoryGroup = old.TerritoryGroup
    JOIN [CH01-01-Dimension].[DimCustomer] dc
      ON dc.CustomerName = old.CustomerName
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM [CH01-01-Fact].[Data] f
        WHERE f.SalesKey = old.SalesKey
    );

    DECLARE @Rows INT = @@ROWCOUNT;
    DECLARE @EndTime DATETIME2(7) = SYSDATETIME();

    EXEC Process.usp_TrackWorkFlow
        @WorkFlowStepDescription = 'Load Data',
        @WorkFlowStepTableRowCount = @Rows,
        @StartingDateTime = @StartTime,
        @EndingDateTime = @EndTime,
        @UserAuthorizationKey = @GroupMemberUserAuthorizationKey;
END;
GO