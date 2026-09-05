/*
Script: 05-create-table-company-branch.sql
Entidad: dbo.CompanyBranch
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla CompanyBranch segun la estructura actualmente existente en BD.

Concepto:
    CompanyBranch representa cada sucursal o establecimiento operativo de una empresa.

Dependencias:
    - dbo.Company(CompanyId)
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.CompanyBranch', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.CompanyBranch ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.CompanyBranch
(
    CompanyBranchId UNIQUEIDENTIFIER NOT NULL,
    CompanyId UNIQUEIDENTIFIER NOT NULL,
    EstablishmentCode VARCHAR(10) NOT NULL,
    BranchName NVARCHAR(150) NULL,
    Address NVARCHAR(300) NULL,
    Phone NVARCHAR(50) NULL,
    Email NVARCHAR(150) NULL,
    City INT NULL,
    Province CHAR(3) NULL,
    Status CHAR(1) NOT NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_CompanyBranch
        PRIMARY KEY CLUSTERED (CompanyBranchId),

    CONSTRAINT UQ_CompanyBranch_Company_EstablishmentCode
        UNIQUE NONCLUSTERED (CompanyId, EstablishmentCode)
);
GO

ALTER TABLE dbo.CompanyBranch
ADD CONSTRAINT DF_CompanyBranch_CompanyBranchId
    DEFAULT (NEWSEQUENTIALID()) FOR CompanyBranchId;
GO

ALTER TABLE dbo.CompanyBranch
ADD CONSTRAINT DF_CompanyBranch_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.CompanyBranch
ADD CONSTRAINT DF_CompanyBranch_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.CompanyBranch WITH CHECK
ADD CONSTRAINT FK_CompanyBranch_Company
    FOREIGN KEY (CompanyId)
    REFERENCES dbo.Company (CompanyId);
GO

ALTER TABLE dbo.CompanyBranch CHECK CONSTRAINT FK_CompanyBranch_Company;
GO

ALTER TABLE dbo.CompanyBranch WITH CHECK
ADD CONSTRAINT FK_CompanyBranch_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.CompanyBranch CHECK CONSTRAINT FK_CompanyBranch_Status;
GO

ALTER TABLE dbo.CompanyBranch WITH CHECK
ADD CONSTRAINT CK_CompanyBranch_EstablishmentCode_NotBlank
    CHECK (LEN(LTRIM(RTRIM(EstablishmentCode))) > 0);
GO

ALTER TABLE dbo.CompanyBranch CHECK CONSTRAINT CK_CompanyBranch_EstablishmentCode_NotBlank;
GO
