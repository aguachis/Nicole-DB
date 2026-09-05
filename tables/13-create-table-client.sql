/*
Script: 13-create-table-client.sql
Entidad: dbo.Client
Fuente: Propuesta normalizada para BD Nicole (snapshot comercial) 2026-07-25
Objetivo:
    Crear la tabla Client como snapshot comercial por empresa/persona.

Concepto:
    Client representa la vista comercial de una persona dentro de una empresa.
    Incluye atributos operativos (nombres comerciales, flags tributarios, cartera)
    que pueden divergir de la entidad canonica Person por requerimientos historicos.

Dependencias:
    - dbo.Company(CompanyId)
    - dbo.Person(PersonId)
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.Client', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.Client ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.Client
(
    ClientId UNIQUEIDENTIFIER NOT NULL,
    Identification NVARCHAR(20) NOT NULL,
    CompanyId UNIQUEIDENTIFIER NOT NULL,
    PersonId UNIQUEIDENTIFIER NOT NULL,
    BusinessName NVARCHAR(200) NOT NULL,
    TradeName NVARCHAR(150) NULL,
    AccountsReceivable NVARCHAR(20) NULL,
    IsTaxExempt BIT NOT NULL,
    IsSpecialTaxpayer BIT NOT NULL,
    RequiresAccounting BIT NOT NULL,
    Status CHAR(1) NOT NULL,
    AdditionalEmails NVARCHAR(250) NULL,
    Remarks NVARCHAR(500) NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_Client
        PRIMARY KEY CLUSTERED (ClientId),

    CONSTRAINT UQ_Client_Company_Person
        UNIQUE NONCLUSTERED (CompanyId, PersonId),

    CONSTRAINT UQ_Client_Company_Identification
        UNIQUE NONCLUSTERED (CompanyId, Identification)
);
GO

ALTER TABLE dbo.Client
ADD CONSTRAINT DF_Client_ClientId
    DEFAULT (NEWSEQUENTIALID()) FOR ClientId;
GO

ALTER TABLE dbo.Client
ADD CONSTRAINT DF_Client_IsTaxExempt
    DEFAULT ((0)) FOR IsTaxExempt;
GO

ALTER TABLE dbo.Client
ADD CONSTRAINT DF_Client_IsSpecialTaxpayer
    DEFAULT ((0)) FOR IsSpecialTaxpayer;
GO

ALTER TABLE dbo.Client
ADD CONSTRAINT DF_Client_RequiresAccounting
    DEFAULT ((0)) FOR RequiresAccounting;
GO

ALTER TABLE dbo.Client
ADD CONSTRAINT DF_Client_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.Client
ADD CONSTRAINT DF_Client_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.Client WITH CHECK
ADD CONSTRAINT FK_Client_Company
    FOREIGN KEY (CompanyId)
    REFERENCES dbo.Company (CompanyId);
GO

ALTER TABLE dbo.Client CHECK CONSTRAINT FK_Client_Company;
GO

ALTER TABLE dbo.Client WITH CHECK
ADD CONSTRAINT FK_Client_Person
    FOREIGN KEY (PersonId)
    REFERENCES dbo.Person (PersonId);
GO

ALTER TABLE dbo.Client CHECK CONSTRAINT FK_Client_Person;
GO

ALTER TABLE dbo.Client WITH CHECK
ADD CONSTRAINT FK_Client_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.Client CHECK CONSTRAINT FK_Client_Status;
GO

ALTER TABLE dbo.Client WITH CHECK
ADD CONSTRAINT CK_Client_Identification_NotBlank
    CHECK (LEN(LTRIM(RTRIM(Identification))) > 0);
GO

ALTER TABLE dbo.Client CHECK CONSTRAINT CK_Client_Identification_NotBlank;
GO

ALTER TABLE dbo.Client WITH CHECK
ADD CONSTRAINT CK_Client_BusinessName_NotBlank
    CHECK (LEN(LTRIM(RTRIM(BusinessName))) > 0);
GO

ALTER TABLE dbo.Client CHECK CONSTRAINT CK_Client_BusinessName_NotBlank;
GO