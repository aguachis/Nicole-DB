/*
Script: 03-create-table-person.sql
Entidad: dbo.Person
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla Person segun la estructura actualmente existente en BD.

Concepto:
    Person representa personas naturales y juridicas en una sola entidad.

Dependencias:
    - dbo.IdentificationType(IdentificationTypeId)
    - dbo.PersonType(PersonTypeId)
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.Person', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.Person ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.Person
(
    PersonId UNIQUEIDENTIFIER NOT NULL,
    IdentificationType CHAR(2) NOT NULL,
    Identification NVARCHAR(20) NOT NULL,
    PersonType CHAR(1) NOT NULL,
    LastName NVARCHAR(80) NULL,
    MiddleName NVARCHAR(80) NULL,
    FirstName NVARCHAR(200) NULL,
    BusinessName NVARCHAR(200) NULL,
    Gender CHAR(1) NULL,
    BirthDate DATE NULL,
    Address NVARCHAR(300) NULL,
    Phone NVARCHAR(50) NULL,
    Email NVARCHAR(150) NULL,
    Province CHAR(3) NULL,
    City INT NULL,
    Remarks NVARCHAR(500) NULL,
    Status CHAR(1) NOT NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_Person
        PRIMARY KEY CLUSTERED (PersonId),

    CONSTRAINT UQ_Person_IdentificationType_Identification
        UNIQUE NONCLUSTERED (IdentificationType, Identification)
);
GO

ALTER TABLE dbo.Person
ADD CONSTRAINT DF_Person_PersonId
    DEFAULT (NEWSEQUENTIALID()) FOR PersonId;
GO

ALTER TABLE dbo.Person
ADD CONSTRAINT DF_Person_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.Person
ADD CONSTRAINT DF_Person_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.Person WITH CHECK
ADD CONSTRAINT FK_Person_IdentificationType
    FOREIGN KEY (IdentificationType)
    REFERENCES dbo.IdentificationType (IdentificationTypeId);
GO

ALTER TABLE dbo.Person CHECK CONSTRAINT FK_Person_IdentificationType;
GO

ALTER TABLE dbo.Person WITH CHECK
ADD CONSTRAINT FK_Person_PersonType
    FOREIGN KEY (PersonType)
    REFERENCES dbo.PersonType (PersonTypeId);
GO

ALTER TABLE dbo.Person CHECK CONSTRAINT FK_Person_PersonType;
GO

ALTER TABLE dbo.Person WITH CHECK
ADD CONSTRAINT FK_Person_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.Person CHECK CONSTRAINT FK_Person_Status;
GO

ALTER TABLE dbo.Person WITH CHECK
ADD CONSTRAINT CK_Person_Gender
    CHECK (Gender IS NULL OR (Gender = 'F' OR Gender = 'M'));
GO

ALTER TABLE dbo.Person CHECK CONSTRAINT CK_Person_Gender;
GO

ALTER TABLE dbo.Person WITH CHECK
ADD CONSTRAINT CK_Person_Identification_NotBlank
    CHECK (LEN(LTRIM(RTRIM(Identification))) > 0);
GO

ALTER TABLE dbo.Person CHECK CONSTRAINT CK_Person_Identification_NotBlank;
GO

ALTER TABLE dbo.Person WITH CHECK
ADD CONSTRAINT CK_Person_NaturalOrLegalData
    CHECK (
        PersonType = 'N'
        AND LEN(LTRIM(RTRIM(ISNULL(FirstName, '')))) > 0
        AND LEN(LTRIM(RTRIM(ISNULL(LastName, '')))) > 0
        OR PersonType = 'J'
        AND LEN(LTRIM(RTRIM(ISNULL(BusinessName, '')))) > 0
    );
GO

ALTER TABLE dbo.Person CHECK CONSTRAINT CK_Person_NaturalOrLegalData;
GO
