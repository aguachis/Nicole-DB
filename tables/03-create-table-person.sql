/* Initial schema: global master. Identifications live in PersonIdentification. */
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.Person
(
    PersonId uniqueidentifier NOT NULL CONSTRAINT DF_Person_PersonId DEFAULT (NEWSEQUENTIALID()),
    PersonKind char(1) NOT NULL,
    LegalName nvarchar(250) NOT NULL,
    TradeName nvarchar(250) NULL,
    Status char(1) NOT NULL CONSTRAINT DF_Person_Status DEFAULT ('A'),
    CreatedBy nvarchar(80) NOT NULL,
    CreatedAt datetime2(0) NOT NULL CONSTRAINT DF_Person_CreatedAt DEFAULT (SYSDATETIME()),
    UpdatedBy nvarchar(80) NULL,
    UpdatedAt datetime2(0) NULL,
    CONSTRAINT PK_Person PRIMARY KEY CLUSTERED (PersonId),
    CONSTRAINT CK_Person_LegalName_NotBlank CHECK (LEN(LTRIM(RTRIM(LegalName)))>0),
    CONSTRAINT FK_Person_PersonKind FOREIGN KEY (PersonKind) REFERENCES dbo.PersonType(PersonTypeId),
    CONSTRAINT FK_Person_Status FOREIGN KEY (Status) REFERENCES dbo.EntityStatus(StatusCode)
);
GO
