/*
Script: 00-create-table-persontype.sql
Entidad: dbo.PersonType
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla PersonType segun la estructura actualmente existente en BD.

Concepto:
    PersonType cataloga si una persona es natural o juridica.

Dependencias:
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.PersonType', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.PersonType ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.PersonType
(
    PersonTypeId CHAR(1) NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(150) NULL,
    Status CHAR(1) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_PersonType
        PRIMARY KEY CLUSTERED (PersonTypeId),

    CONSTRAINT UQ_PersonType_Name
        UNIQUE NONCLUSTERED (Name)
);
GO

ALTER TABLE dbo.PersonType
ADD CONSTRAINT DF_PersonType_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.PersonType
ADD CONSTRAINT DF_PersonType_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.PersonType WITH CHECK
ADD CONSTRAINT FK_PersonType_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.PersonType CHECK CONSTRAINT FK_PersonType_Status;
GO
