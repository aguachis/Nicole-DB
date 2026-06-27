/*
Script: 00-create-table-user-company.sql
Entidad: dbo.UserCompany
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla UserCompany segun la estructura actualmente existente en BD.

Concepto:
    UserCompany relaciona usuarios con las empresas a las que tienen acceso.

Dependencias:
    - dbo.AppUser(UserId)
    - dbo.Company(CompanyId)
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.UserCompany', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.UserCompany ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.UserCompany
(
    UserCompanyId UNIQUEIDENTIFIER NOT NULL,
    UserId UNIQUEIDENTIFIER NOT NULL,
    CompanyId UNIQUEIDENTIFIER NOT NULL,
    Status CHAR(1) NOT NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_UserCompany
        PRIMARY KEY CLUSTERED (UserCompanyId),

    CONSTRAINT UQ_UserCompany_User_Company
        UNIQUE NONCLUSTERED (UserId, CompanyId),

    CONSTRAINT UQ_UserCompany_UserCompanyId_CompanyId
        UNIQUE NONCLUSTERED (UserCompanyId, CompanyId)
);
GO

ALTER TABLE dbo.UserCompany
ADD CONSTRAINT DF_UserCompany_UserCompanyId
    DEFAULT (NEWSEQUENTIALID()) FOR UserCompanyId;
GO

ALTER TABLE dbo.UserCompany
ADD CONSTRAINT DF_UserCompany_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.UserCompany
ADD CONSTRAINT DF_UserCompany_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.UserCompany WITH CHECK
ADD CONSTRAINT FK_UserCompany_Company
    FOREIGN KEY (CompanyId)
    REFERENCES dbo.Company (CompanyId);
GO

ALTER TABLE dbo.UserCompany CHECK CONSTRAINT FK_UserCompany_Company;
GO

ALTER TABLE dbo.UserCompany WITH CHECK
ADD CONSTRAINT FK_UserCompany_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.UserCompany CHECK CONSTRAINT FK_UserCompany_Status;
GO

ALTER TABLE dbo.UserCompany WITH CHECK
ADD CONSTRAINT FK_UserCompany_User
    FOREIGN KEY (UserId)
    REFERENCES dbo.AppUser (UserId);
GO

ALTER TABLE dbo.UserCompany CHECK CONSTRAINT FK_UserCompany_User;
GO
