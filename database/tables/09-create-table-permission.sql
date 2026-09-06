/*
Script: 09-create-table-permission.sql
Entidad: dbo.Permission
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla Permission segun la estructura actualmente existente en BD.

Concepto:
    Permission cataloga capacidades funcionales que la aplicacion valida por codigo.

Dependencias:
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.Permission', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.Permission ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.Permission
(
    PermissionId UNIQUEIDENTIFIER NOT NULL,
    Code NVARCHAR(150) NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(250) NULL,
    ModuleCode NVARCHAR(50) NOT NULL,
    Status CHAR(1) NOT NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_Permission
        PRIMARY KEY CLUSTERED (PermissionId),

    CONSTRAINT UQ_Permission_Code
        UNIQUE NONCLUSTERED (Code)
);
GO

ALTER TABLE dbo.Permission
ADD CONSTRAINT DF_Permission_PermissionId
    DEFAULT (NEWSEQUENTIALID()) FOR PermissionId;
GO

ALTER TABLE dbo.Permission
ADD CONSTRAINT DF_Permission_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.Permission
ADD CONSTRAINT DF_Permission_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.Permission WITH CHECK
ADD CONSTRAINT FK_Permission_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.Permission CHECK CONSTRAINT FK_Permission_Status;
GO

ALTER TABLE dbo.Permission WITH CHECK
ADD CONSTRAINT CK_Permission_Code_NotBlank
    CHECK (LEN(LTRIM(RTRIM(Code))) > 0);
GO

ALTER TABLE dbo.Permission CHECK CONSTRAINT CK_Permission_Code_NotBlank;
GO

ALTER TABLE dbo.Permission WITH CHECK
ADD CONSTRAINT CK_Permission_ModuleCode_NotBlank
    CHECK (LEN(LTRIM(RTRIM(ModuleCode))) > 0);
GO

ALTER TABLE dbo.Permission CHECK CONSTRAINT CK_Permission_ModuleCode_NotBlank;
GO

ALTER TABLE dbo.Permission WITH CHECK
ADD CONSTRAINT CK_Permission_Name_NotBlank
    CHECK (LEN(LTRIM(RTRIM(Name))) > 0);
GO

ALTER TABLE dbo.Permission CHECK CONSTRAINT CK_Permission_Name_NotBlank;
GO
