USE G9_2;
GO

IF OBJECT_ID('Process.WorkflowSteps', 'U') IS NOT NULL
    DROP TABLE Process.WorkflowSteps;
GO

IF OBJECT_ID('DbSecurity.UserAuthorization', 'U') IS NOT NULL
    DROP TABLE DbSecurity.UserAuthorization;
GO

CREATE TABLE DbSecurity.UserAuthorization
(
    UserAuthorizationKey INT NOT NULL
        CONSTRAINT PK_UserAuthorization PRIMARY KEY
        CONSTRAINT DF_UserAuthorizationKey DEFAULT (NEXT VALUE FOR PkSequence.UserAuthorizationSequenceObject),

    ClassTime NCHAR(5) NULL
        CONSTRAINT DF_UserAuthorization_ClassTime DEFAULT ('9:15'),

    IndividualProject NVARCHAR(60) NULL
        CONSTRAINT DF_UserAuthorization_Project DEFAULT ('PROJECT 2 RECREATE THE BICLASS DATABASE STAR SCHEMA'),

    GroupMemberLastName NVARCHAR(35) NOT NULL,
    GroupMemberFirstName NVARCHAR(25) NOT NULL,
    GroupName NVARCHAR(20) NOT NULL,

    DateAdded DATETIME2 NULL
        CONSTRAINT DF_UserAuthorization_DateAdded DEFAULT (SYSDATETIME())
);
GO

CREATE TABLE Process.WorkflowSteps
(
    WorkFlowStepKey INT NOT NULL
        CONSTRAINT PK_WorkflowSteps PRIMARY KEY
        CONSTRAINT DF_WorkFlowStepKey DEFAULT (NEXT VALUE FOR PkSequence.WorkflowStepsSequenceObject),

    WorkFlowStepDescription NVARCHAR(100) NOT NULL,
    WorkFlowStepTableRowCount INT NULL
        CONSTRAINT DF_Workflow_RowCount DEFAULT (0),

    StartingDateTime DATETIME2(7) NULL
        CONSTRAINT DF_Workflow_Start DEFAULT (SYSDATETIME()),

    EndingDateTime DATETIME2(7) NULL
        CONSTRAINT DF_Workflow_End DEFAULT (SYSDATETIME()),

    ClassTime CHAR(5) NULL
        CONSTRAINT DF_Workflow_ClassTime DEFAULT ('9:15'),

    UserAuthorizationKey INT NOT NULL,

    CONSTRAINT FK_WorkflowSteps_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES DbSecurity.UserAuthorization(UserAuthorizationKey)
);
GO


--fix
USE G9_2;
GO

DELETE FROM Process.WorkflowSteps;
GO

DELETE FROM DbSecurity.UserAuthorization;
GO

ALTER SEQUENCE PkSequence.UserAuthorizationSequenceObject RESTART WITH 1;
GO

INSERT INTO DbSecurity.UserAuthorization
(GroupMemberLastName, GroupMemberFirstName, GroupName)
VALUES
('Liang', 'Frankie', 'EOS_grp_2'),
('Singh', 'Kanwaljit', 'EOS_grp_2'),
('Kaur', 'Prabhjot', 'EOS_grp_2'),
('Wang', 'Shuai', 'EOS_grp_2'),
('Singh', 'Samran', 'EOS_grp_2'),
('Cardoso', 'Salvador', 'EOS_grp_2');
GO

SELECT * 
FROM DbSecurity.UserAuthorization
ORDER BY UserAuthorizationKey;
GO