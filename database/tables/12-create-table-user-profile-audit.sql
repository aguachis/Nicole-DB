/*
Script: 12-create-table-user-profile-audit.sql
Entidad: dbo.UserProfileAudit
Objetivo:
    Conservar un historial append-only de asignaciones y revocaciones de perfiles.

Dependencias:
    - dbo.UserProfile(UserId, ProfileId)
    - dbo.AppUser(UserId, CompanyId)
    - dbo.Profile(ProfileId, CompanyId)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.UserProfileAudit', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.UserProfileAudit ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.UserProfileAudit
(
    UserProfileAuditId BIGINT IDENTITY(1,1) NOT NULL,
    UserId UNIQUEIDENTIFIER NOT NULL,
    CompanyId UNIQUEIDENTIFIER NOT NULL,
    ProfileId UNIQUEIDENTIFIER NOT NULL,
    OperationCode VARCHAR(20) NOT NULL,
    Actor NVARCHAR(80) NOT NULL,
    OccurredAt DATETIME2(3) NOT NULL CONSTRAINT DF_UserProfileAudit_OccurredAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_UserProfileAudit
        PRIMARY KEY CLUSTERED (UserProfileAuditId),

    CONSTRAINT FK_UserProfileAudit_UserProfile
        FOREIGN KEY (UserId, ProfileId)
        REFERENCES dbo.UserProfile (UserId, ProfileId),

    CONSTRAINT FK_UserProfileAudit_AppUser_Company
        FOREIGN KEY (UserId, CompanyId)
        REFERENCES dbo.AppUser (UserId, CompanyId),

    CONSTRAINT FK_UserProfileAudit_Profile_Company
        FOREIGN KEY (ProfileId, CompanyId)
        REFERENCES dbo.Profile (ProfileId, CompanyId),

    CONSTRAINT CK_UserProfileAudit_OperationCode
        CHECK (OperationCode IN ('ASSIGN', 'REVOKE', 'REACTIVATE')),

    CONSTRAINT CK_UserProfileAudit_Actor_NotBlank
        CHECK (LEN(LTRIM(RTRIM(Actor))) > 0)
);
GO

CREATE NONCLUSTERED INDEX IX_UserProfileAudit_User_Company_Profile_OccurredAt
    ON dbo.UserProfileAudit (UserId, CompanyId, ProfileId, OccurredAt DESC);
GO

CREATE TRIGGER dbo.TR_UserProfileAudit_AppendOnly
ON dbo.UserProfileAudit
INSTEAD OF UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    THROW 51420, 'UserProfileAudit is append-only; UPDATE and DELETE are not allowed.', 1;
END;
GO
