/*
Script: 00-create-table-profile.sql
Entidad: dbo.Profile
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla Profile segun la estructura actualmente existente en BD.

Concepto:
    Profile representa un rol o perfil definido dentro de una empresa.

Dependencias:
    - dbo.Company(CompanyId)
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.Profile', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.Profile ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.Profile
(
    ProfileId UNIQUEIDENTIFIER NOT NULL,
    CompanyId UNIQUEIDENTIFIER NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(250) NULL,
    Status CHAR(1) NOT NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_Profile
        PRIMARY KEY CLUSTERED (ProfileId),

    CONSTRAINT UQ_Profile_Company_Name
        UNIQUE NONCLUSTERED (CompanyId, Name),

    CONSTRAINT UQ_Profile_ProfileId_CompanyId
        UNIQUE NONCLUSTERED (ProfileId, CompanyId)
);
GO

ALTER TABLE dbo.Profile
ADD CONSTRAINT DF_Profile_ProfileId
    DEFAULT (NEWSEQUENTIALID()) FOR ProfileId;
GO

ALTER TABLE dbo.Profile
ADD CONSTRAINT DF_Profile_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.Profile
ADD CONSTRAINT DF_Profile_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.Profile WITH CHECK
ADD CONSTRAINT FK_Profile_Company
    FOREIGN KEY (CompanyId)
    REFERENCES dbo.Company (CompanyId);
GO

ALTER TABLE dbo.Profile CHECK CONSTRAINT FK_Profile_Company;
GO

ALTER TABLE dbo.Profile WITH CHECK
ADD CONSTRAINT FK_Profile_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.Profile CHECK CONSTRAINT FK_Profile_Status;
GO

ALTER TABLE dbo.Profile WITH CHECK
ADD CONSTRAINT CK_Profile_Name_NotBlank
    CHECK (LEN(LTRIM(RTRIM(Name))) > 0);
GO

ALTER TABLE dbo.Profile CHECK CONSTRAINT CK_Profile_Name_NotBlank;
GO
