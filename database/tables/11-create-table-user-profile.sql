/*
Script: 11-create-table-user-profile.sql
Entidad: dbo.UserProfile
Objetivo:
    Relacionar cada usuario con uno o varios perfiles de su empresa unica.

Dependencias:
    - dbo.AppUser(UserId, CompanyId)
    - dbo.Profile(ProfileId, CompanyId)
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.UserProfile', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.UserProfile ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.UserProfile
(
    UserProfileId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_UserProfile_UserProfileId DEFAULT (NEWSEQUENTIALID()),
    UserId UNIQUEIDENTIFIER NOT NULL,
    CompanyId UNIQUEIDENTIFIER NOT NULL,
    ProfileId UNIQUEIDENTIFIER NOT NULL,
    Status CHAR(1) NOT NULL CONSTRAINT DF_UserProfile_Status DEFAULT ('A'),
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_UserProfile_CreatedAt DEFAULT (SYSDATETIME()),
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_UserProfile
        PRIMARY KEY CLUSTERED (UserProfileId),

    CONSTRAINT UQ_UserProfile_User_Profile
        UNIQUE NONCLUSTERED (UserId, ProfileId),

    CONSTRAINT FK_UserProfile_AppUser_Company
        FOREIGN KEY (UserId, CompanyId)
        REFERENCES dbo.AppUser (UserId, CompanyId),

    CONSTRAINT FK_UserProfile_Profile_Company
        FOREIGN KEY (ProfileId, CompanyId)
        REFERENCES dbo.Profile (ProfileId, CompanyId),

    CONSTRAINT FK_UserProfile_Status
        FOREIGN KEY (Status)
        REFERENCES dbo.EntityStatus (StatusCode)
);
GO
