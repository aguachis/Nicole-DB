/* Initial schema: identification policy catalog. */
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.IdentificationType
(
    IdentificationTypeId char(2) NOT NULL,
    Code varchar(32) NOT NULL,
    Name nvarchar(50) NOT NULL,
    Description nvarchar(150) NULL,
    MinLength tinyint NOT NULL,
    MaxLength tinyint NOT NULL,
    IsNumericOnly bit NOT NULL,
    AllowsNaturalPerson bit NOT NULL,
    AllowsLegalEntity bit NOT NULL,
    IsBillingAllowed bit NOT NULL,
    IsActive bit NOT NULL CONSTRAINT DF_IdentificationType_IsActive DEFAULT (1),
    Status char(1) NOT NULL CONSTRAINT DF_IdentificationType_Status DEFAULT ('A'),
    CreatedAt datetime2(0) NOT NULL CONSTRAINT DF_IdentificationType_CreatedAt DEFAULT (SYSDATETIME()),
    UpdatedAt datetime2(0) NULL,
    CONSTRAINT PK_IdentificationType PRIMARY KEY CLUSTERED (IdentificationTypeId),
    CONSTRAINT UQ_IdentificationType_Code UNIQUE NONCLUSTERED (Code),
    CONSTRAINT UQ_IdentificationType_Name UNIQUE NONCLUSTERED (Name),
    CONSTRAINT CK_IdentificationType_Length CHECK (MinLength > 0 AND MaxLength >= MinLength),
    CONSTRAINT CK_IdentificationType_Applicability CHECK (AllowsNaturalPerson=1 OR AllowsLegalEntity=1),
    CONSTRAINT FK_IdentificationType_Status FOREIGN KEY (Status) REFERENCES dbo.EntityStatus(StatusCode)
);
GO
