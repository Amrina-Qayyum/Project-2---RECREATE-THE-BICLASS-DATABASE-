USE G9_2;
GO

CREATE OR ALTER PROCEDURE Project2.Load_DimProductCategory
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7) = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimProductCategory]
    (
        ProductCategory,
        UserAuthorizationKey
    )
    SELECT DISTINCT
        old.ProductCategory,
        @GroupMemberUserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData old
    WHERE old.ProductCategory IS NOT NULL
      AND NOT EXISTS
      (
          SELECT 1
          FROM [CH01-01-Dimension].[DimProductCategory] d
          WHERE d.ProductCategory = old.ProductCategory
      );

    DECLARE @Rows INT = @@ROWCOUNT;
    DECLARE @EndTime DATETIME2(7) = SYSDATETIME();

    EXEC Process.usp_TrackWorkFlow
        @WorkFlowStepDescription = 'Load DimProductCategory',
        @WorkFlowStepTableRowCount = @Rows,
        @StartingDateTime = @StartTime,
        @EndingDateTime = @EndTime,
        @UserAuthorizationKey = @GroupMemberUserAuthorizationKey;
END;
GO

CREATE OR ALTER PROCEDURE Project2.Load_DimProductSubcategory
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7) = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimProductSubcategory]
    (
        ProductCategoryKey,
        ProductSubcategory,
        UserAuthorizationKey
    )
    SELECT DISTINCT
        pc.ProductCategoryKey,
        old.ProductSubcategory,
        @GroupMemberUserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData old
    JOIN [CH01-01-Dimension].[DimProductCategory] pc
      ON pc.ProductCategory = old.ProductCategory
    WHERE old.ProductSubcategory IS NOT NULL
      AND NOT EXISTS
      (
          SELECT 1
          FROM [CH01-01-Dimension].[DimProductSubcategory] d
          WHERE d.ProductSubcategory = old.ProductSubcategory
      );

    DECLARE @Rows INT = @@ROWCOUNT;
    DECLARE @EndTime DATETIME2(7) = SYSDATETIME();

    EXEC Process.usp_TrackWorkFlow
        @WorkFlowStepDescription = 'Load DimProductSubcategory',
        @WorkFlowStepTableRowCount = @Rows,
        @StartingDateTime = @StartTime,
        @EndingDateTime = @EndTime,
        @UserAuthorizationKey = @GroupMemberUserAuthorizationKey;
END;
GO

CREATE OR ALTER PROCEDURE Project2.Load_SalesManagers
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7) = SYSDATETIME();

    ;WITH DistinctManagers AS
    (
        SELECT DISTINCT
            old.SalesManager
        FROM FileUpload.OriginallyLoadedData old
        WHERE old.SalesManager IS NOT NULL
          AND NOT EXISTS
          (
              SELECT 1
              FROM [CH01-01-Dimension].[SalesManagers] d
              WHERE d.SalesManager = old.SalesManager
          )
    )
    INSERT INTO [CH01-01-Dimension].[SalesManagers]
    (
        SalesManagerKey,
        SalesManager,
        UserAuthorizationKey
    )
    SELECT
        NEXT VALUE FOR PkSequence.SalesManagersSequenceObject,
        dm.SalesManager,
        @GroupMemberUserAuthorizationKey
    FROM DistinctManagers dm;

    DECLARE @Rows INT = @@ROWCOUNT;
    DECLARE @EndTime DATETIME2(7) = SYSDATETIME();

    EXEC Process.usp_TrackWorkFlow
        @WorkFlowStepDescription = 'Load SalesManagers',
        @WorkFlowStepTableRowCount = @Rows,
        @StartingDateTime = @StartTime,
        @EndingDateTime = @EndTime,
        @UserAuthorizationKey = @GroupMemberUserAuthorizationKey;
END;
GO

CREATE OR ALTER PROCEDURE Project2.Load_DimGender
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7) = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimGender]
    (
        Gender,
        GenderDescription,
        UserAuthorizationKey
    )
    SELECT DISTINCT
        old.Gender,
        old.Gender,
        @GroupMemberUserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData old
    WHERE old.Gender IS NOT NULL
      AND NOT EXISTS
      (
          SELECT 1
          FROM [CH01-01-Dimension].[DimGender] d
          WHERE d.Gender = old.Gender
      );

    DECLARE @Rows INT = @@ROWCOUNT;
    DECLARE @EndTime DATETIME2(7) = SYSDATETIME();

    EXEC Process.usp_TrackWorkFlow
        @WorkFlowStepDescription = 'Load DimGender',
        @WorkFlowStepTableRowCount = @Rows,
        @StartingDateTime = @StartTime,
        @EndingDateTime = @EndTime,
        @UserAuthorizationKey = @GroupMemberUserAuthorizationKey;
END;
GO

CREATE OR ALTER PROCEDURE Project2.Load_DimMaritalStatus
    @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7) = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimMaritalStatus]
    (
        MaritalStatus,
        MaritalStatusDescription,
        UserAuthorizationKey
    )
    SELECT DISTINCT
        old.MaritalStatus,
        old.MaritalStatus,
        @GroupMemberUserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData old
    WHERE old.MaritalStatus IS NOT NULL
      AND NOT EXISTS
      (
          SELECT 1
          FROM [CH01-01-Dimension].[DimMaritalStatus] d
          WHERE d.MaritalStatus = old.MaritalStatus
      );

    DECLARE @Rows INT = @@ROWCOUNT;
    DECLARE @EndTime DATETIME2(7) = SYSDATETIME();

    EXEC Process.usp_TrackWorkFlow
        @WorkFlowStepDescription = 'Load DimMaritalStatus',
        @WorkFlowStepTableRowCount = @Rows,
        @StartingDateTime = @StartTime,
        @EndingDateTime = @EndTime,
        @UserAuthorizationKey = @GroupMemberUserAuthorizationKey;
END;
GO