USE G9_2;
GO

CREATE OR ALTER PROCEDURE Process.usp_TrackWorkFlow
    @WorkFlowStepDescription NVARCHAR(100),
    @WorkFlowStepTableRowCount INT,
    @StartingDateTime DATETIME2(7),
    @EndingDateTime DATETIME2(7),
    @UserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Process.WorkflowSteps
    (
        WorkFlowStepDescription,
        WorkFlowStepTableRowCount,
        StartingDateTime,
        EndingDateTime,
        ClassTime,
        UserAuthorizationKey
    )
    VALUES
    (
        @WorkFlowStepDescription,
        @WorkFlowStepTableRowCount,
        @StartingDateTime,
        @EndingDateTime,
        '9:15',
        @UserAuthorizationKey
    );
END;
GO

CREATE OR ALTER PROCEDURE Process.usp_ShowWorkflowSteps
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ws.WorkFlowStepKey,
        ws.WorkFlowStepDescription,
        ws.WorkFlowStepTableRowCount,
        ws.StartingDateTime,
        ws.EndingDateTime,
        DATEDIFF(MILLISECOND, ws.StartingDateTime, ws.EndingDateTime) AS ExecutionTimeMs,
        ws.ClassTime,
        ws.UserAuthorizationKey,
        ua.GroupMemberFirstName,
        ua.GroupMemberLastName,
        ua.GroupName
    FROM Process.WorkflowSteps ws
    JOIN DbSecurity.UserAuthorization ua
      ON ws.UserAuthorizationKey = ua.UserAuthorizationKey
    ORDER BY ws.WorkFlowStepKey;
END;
GO

