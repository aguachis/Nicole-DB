/*
Script: 00-create-table-user-company-profile.sql
Entidad: dbo.UserCompanyProfile
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla UserCompanyProfile segun la estructura actualmente existente en BD.

Concepto:
    UserCompanyProfile asigna perfiles a usuarios dentro de una empresa.

Dependencias:
    - dbo.UserCompany(UserCompanyId, CompanyId)
    - dbo.Profile(ProfileId, CompanyId)
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.UserCompanyProfile', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.UserCompanyProfile ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.UserCompanyProfile
(
    UserCompanyProfileId UNIQUEIDENTIFIER NOT NULL,
    UserCompanyId UNIQUEIDENTIFIER NOT NULL,
    CompanyId UNIQUEIDENTIFIER NOT NULL,
    ProfileId UNIQUEIDENTIFIER NOT NULL,
    Status CHAR(1) NOT NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_UserCompanyProfile
        PRIMARY KEY CLUSTERED (UserCompanyProfileId),

    CONSTRAINT UQ_UserCompanyProfile_UserCompany_Profile
        UNIQUE NONCLUSTERED (UserCompanyId, ProfileId)
);
GO

ALTER TABLE dbo.UserCompanyProfile
ADD CONSTRAINT DF_UserCompanyProfile_Id
    DEFAULT (NEWSEQUENTIALID()) FOR UserCompanyProfileId;
GO

ALTER TABLE dbo.UserCompanyProfile
ADD CONSTRAINT DF_UserCompanyProfile_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.UserCompanyProfile
ADD CONSTRAINT DF_UserCompanyProfile_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.UserCompanyProfile WITH CHECK
ADD CONSTRAINT FK_UserCompanyProfile_Profile
    FOREIGN KEY (ProfileId, CompanyId)
    REFERENCES dbo.Profile (ProfileId, CompanyId);
GO

ALTER TABLE dbo.UserCompanyProfile CHECK CONSTRAINT FK_UserCompanyProfile_Profile;
GO

ALTER TABLE dbo.UserCompanyProfile WITH CHECK
ADD CONSTRAINT FK_UserCompanyProfile_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.UserCompanyProfile CHECK CONSTRAINT FK_UserCompanyProfile_Status;
GO

ALTER TABLE dbo.UserCompanyProfile WITH CHECK
ADD CONSTRAINT FK_UserCompanyProfile_UserCompany
    FOREIGN KEY (UserCompanyId, CompanyId)
    REFERENCES dbo.UserCompany (UserCompanyId, CompanyId);
GO

ALTER TABLE dbo.UserCompanyProfile CHECK CONSTRAINT FK_UserCompanyProfile_UserCompany;
GO
