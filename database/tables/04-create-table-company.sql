/*
Script: 04-create-table-company.sql
Entidad: dbo.Company
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla Company segun la estructura actualmente existente en BD.

Concepto:
    Company representa la empresa legal dentro del modelo multiempresa.
    Los datos operativos por sucursal y punto de emision se documentan en
    CompanyBranch y CompanyEmissionPoint.

Dependencias:
    - dbo.Person(PersonId), para RepresentativeId
    - dbo.EntityStatus(StatusCode), para Status
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.Company', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.Company ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.Company
(
    CompanyId UNIQUEIDENTIFIER NOT NULL,
    Identification NVARCHAR(20) NOT NULL,
    TradeName NVARCHAR(150) NULL,
    BusinessName NVARCHAR(200) NOT NULL,
    MainAddress NVARCHAR(500) NULL,
    Email NVARCHAR(150) NULL,
    IsAccountingRequired BIT NOT NULL,
    SpecialTaxpayer NVARCHAR(50) NULL,
    Status CHAR(1) NOT NULL,
    RepresentativeId UNIQUEIDENTIFIER NULL,
    ParentCompanyId UNIQUEIDENTIFIER NULL,
    TaxpayerType NVARCHAR(50) NULL,
    ArtisanQualification NVARCHAR(10) NULL,
    Environment VARCHAR(30) NULL,
    Currency VARCHAR(3) NULL,
    Timezone VARCHAR(60) NULL,
    LanguageCode VARCHAR(3) NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_Company
        PRIMARY KEY CLUSTERED (CompanyId),

    CONSTRAINT UQ_Company_Identification
        UNIQUE NONCLUSTERED (Identification)
);
GO

ALTER TABLE dbo.Company
ADD CONSTRAINT DF_Company_CompanyId
    DEFAULT (NEWSEQUENTIALID()) FOR CompanyId;
GO

ALTER TABLE dbo.Company
ADD CONSTRAINT DF_Company_IsAccountingRequired
    DEFAULT ((0)) FOR IsAccountingRequired;
GO

ALTER TABLE dbo.Company
ADD CONSTRAINT DF_Company_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.Company
ADD CONSTRAINT DF_Company_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.Company WITH CHECK
ADD CONSTRAINT FK_Company_Parent
    FOREIGN KEY (ParentCompanyId)
    REFERENCES dbo.Company (CompanyId);
GO

ALTER TABLE dbo.Company CHECK CONSTRAINT FK_Company_Parent;
GO

ALTER TABLE dbo.Company WITH CHECK
ADD CONSTRAINT FK_Company_Representative
    FOREIGN KEY (RepresentativeId)
    REFERENCES dbo.Person (PersonId);
GO

ALTER TABLE dbo.Company CHECK CONSTRAINT FK_Company_Representative;
GO

ALTER TABLE dbo.Company WITH CHECK
ADD CONSTRAINT FK_Company_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.Company CHECK CONSTRAINT FK_Company_Status;
GO

ALTER TABLE dbo.Company WITH CHECK
ADD CONSTRAINT CK_Company_Currency
    CHECK (Currency IS NULL OR LEN(LTRIM(RTRIM(Currency))) = 3);
GO

ALTER TABLE dbo.Company CHECK CONSTRAINT CK_Company_Currency;
GO

ALTER TABLE dbo.Company WITH CHECK
ADD CONSTRAINT CK_Company_LanguageCode
    CHECK (LanguageCode IS NULL OR LEN(LTRIM(RTRIM(LanguageCode))) BETWEEN 2 AND 3);
GO

ALTER TABLE dbo.Company CHECK CONSTRAINT CK_Company_LanguageCode;
GO

ALTER TABLE dbo.Company WITH CHECK
ADD CONSTRAINT CK_Company_ParentCompany
    CHECK (ParentCompanyId IS NULL OR ParentCompanyId <> CompanyId);
GO

ALTER TABLE dbo.Company CHECK CONSTRAINT CK_Company_ParentCompany;
GO
