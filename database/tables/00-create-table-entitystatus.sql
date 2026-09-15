/*
Script: 00-create-table-entitystatus.sql
Entidad: dbo.EntityStatus
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla EntityStatus segun la estructura actualmente existente en BD.

Concepto:
    EntityStatus es el catalogo canonico para columnas Status CHAR(1).
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.EntityStatus', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.EntityStatus ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.EntityStatus
(
    StatusCode CHAR(1) NOT NULL,
    StatusName NVARCHAR(100) NOT NULL,
    StatusDescription NVARCHAR(255) NULL,
    IsActive BIT NOT NULL,
    SortOrder TINYINT NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_EntityStatus
        PRIMARY KEY CLUSTERED (StatusCode),

    CONSTRAINT UQ_EntityStatus_StatusName
        UNIQUE NONCLUSTERED (StatusName)
);
GO

ALTER TABLE dbo.EntityStatus
ADD CONSTRAINT DF_EntityStatus_IsActive
    DEFAULT ((1)) FOR IsActive;
GO

ALTER TABLE dbo.EntityStatus
ADD CONSTRAINT DF_EntityStatus_SortOrder
    DEFAULT ((0)) FOR SortOrder;
GO

ALTER TABLE dbo.EntityStatus
ADD CONSTRAINT DF_EntityStatus_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.EntityStatus WITH CHECK
ADD CONSTRAINT CK_EntityStatus_StatusCode
    CHECK (StatusCode = 'I' OR StatusCode = 'A');
GO

ALTER TABLE dbo.EntityStatus CHECK CONSTRAINT CK_EntityStatus_StatusCode;
GO
