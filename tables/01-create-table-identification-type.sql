/*
Script: 01-create-table-identification-type.sql
Entidad: dbo.IdentificationType
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla IdentificationType segun la estructura actualmente existente en BD.

Concepto:
    IdentificationType cataloga los tipos de identificacion usados por Person.

Dependencias:
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.IdentificationType', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.IdentificationType ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.IdentificationType
(
    IdentificationTypeId CHAR(2) NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(150) NULL,
    Status CHAR(1) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_IdentificationType
        PRIMARY KEY CLUSTERED (IdentificationTypeId),

    CONSTRAINT UQ_IdentificationType_Name
        UNIQUE NONCLUSTERED (Name)
);
GO

ALTER TABLE dbo.IdentificationType
ADD CONSTRAINT DF_IdentificationType_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.IdentificationType
ADD CONSTRAINT DF_IdentificationType_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.IdentificationType WITH CHECK
ADD CONSTRAINT FK_IdentificationType_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.IdentificationType CHECK CONSTRAINT FK_IdentificationType_Status;
GO
