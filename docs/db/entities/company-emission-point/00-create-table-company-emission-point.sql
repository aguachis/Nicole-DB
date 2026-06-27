/*
Script: 00-create-table-company-emission-point.sql
Entidad: dbo.CompanyEmissionPoint
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla CompanyEmissionPoint segun la estructura actualmente existente en BD.

Concepto:
    CompanyEmissionPoint representa cada punto de emision asociado a una sucursal.

Dependencias:
    - dbo.CompanyBranch(CompanyBranchId)
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.CompanyEmissionPoint', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.CompanyEmissionPoint ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.CompanyEmissionPoint
(
    CompanyEmissionPointId UNIQUEIDENTIFIER NOT NULL,
    CompanyBranchId UNIQUEIDENTIFIER NOT NULL,
    EmissionPointCode VARCHAR(10) NOT NULL,
    Name NVARCHAR(150) NULL,
    Status CHAR(1) NOT NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_CompanyEmissionPoint
        PRIMARY KEY CLUSTERED (CompanyEmissionPointId),

    CONSTRAINT UQ_CompanyEmissionPoint_Branch_EmissionPointCode
        UNIQUE NONCLUSTERED (CompanyBranchId, EmissionPointCode)
);
GO

ALTER TABLE dbo.CompanyEmissionPoint
ADD CONSTRAINT DF_CompanyEmissionPoint_Id
    DEFAULT (NEWSEQUENTIALID()) FOR CompanyEmissionPointId;
GO

ALTER TABLE dbo.CompanyEmissionPoint
ADD CONSTRAINT DF_CompanyEmissionPoint_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.CompanyEmissionPoint
ADD CONSTRAINT DF_CompanyEmissionPoint_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.CompanyEmissionPoint WITH CHECK
ADD CONSTRAINT FK_CompanyEmissionPoint_CompanyBranch
    FOREIGN KEY (CompanyBranchId)
    REFERENCES dbo.CompanyBranch (CompanyBranchId);
GO

ALTER TABLE dbo.CompanyEmissionPoint CHECK CONSTRAINT FK_CompanyEmissionPoint_CompanyBranch;
GO

ALTER TABLE dbo.CompanyEmissionPoint WITH CHECK
ADD CONSTRAINT FK_CompanyEmissionPoint_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.CompanyEmissionPoint CHECK CONSTRAINT FK_CompanyEmissionPoint_Status;
GO

ALTER TABLE dbo.CompanyEmissionPoint WITH CHECK
ADD CONSTRAINT CK_CompanyEmissionPoint_Code_NotBlank
    CHECK (LEN(LTRIM(RTRIM(EmissionPointCode))) > 0);
GO

ALTER TABLE dbo.CompanyEmissionPoint CHECK CONSTRAINT CK_CompanyEmissionPoint_Code_NotBlank;
GO
