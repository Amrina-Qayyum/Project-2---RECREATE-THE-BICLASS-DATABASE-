USE G9_2;
GO

EXEC Project2.LoadStarSchemaData @GroupMemberUserAuthorizationKey = 1;
GO

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    SUM(p.rows) AS TotalRows
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
JOIN sys.partitions p
    ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
GROUP BY s.name, t.name
ORDER BY s.name, t.name;
GO

EXEC Process.usp_ShowWorkflowSteps;
GO

SELECT
    ua.GroupMemberFirstName,
    ua.GroupMemberLastName,
    COUNT(*) AS NumberOfProceduresWorkedOn,
    SUM(DATEDIFF(MILLISECOND, ws.StartingDateTime, ws.EndingDateTime)) AS TotalExecutionTimeMs
FROM Process.WorkflowSteps ws
JOIN DbSecurity.UserAuthorization ua
    ON ws.UserAuthorizationKey = ua.UserAuthorizationKey
GROUP BY
    ua.GroupMemberFirstName,
    ua.GroupMemberLastName
ORDER BY
    ua.GroupMemberLastName,
    ua.GroupMemberFirstName;
GO