/* Initial schema: tenant-scoped commercial relationship. Run after PersonIdentification. */
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.Client
(
    ClientId UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT DF_Client_ClientId DEFAULT (NEWSEQUENTIALID()),
    CompanyId UNIQUEIDENTIFIER NOT NULL,
    PersonId UNIQUEIDENTIFIER NOT NULL,
    DefaultBillingIdentificationId BIGINT NOT NULL,
    BillingAddress NVARCHAR(500) NOT NULL,
    Phone NVARCHAR(50) NOT NULL,
    Email NVARCHAR(254) NOT NULL,
    CreditLimit DECIMAL(18, 2) NULL,
    PaymentTermDays SMALLINT NULL,
    AccountsReceivable NVARCHAR(20) NULL,
    Status CHAR(1) NOT NULL CONSTRAINT DF_Client_Status DEFAULT ('A'),
    Remarks NVARCHAR(500) NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL
        CONSTRAINT DF_Client_CreatedAt DEFAULT (SYSDATETIME()),
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_Client PRIMARY KEY CLUSTERED (ClientId),
    CONSTRAINT UQ_Client_Company_Person UNIQUE (CompanyId, PersonId),
    CONSTRAINT UQ_Client_Client_Company UNIQUE (ClientId, CompanyId),
    CONSTRAINT CK_Client_BillingAddress_NotBlank
        CHECK (LEN(LTRIM(RTRIM(BillingAddress))) > 0),
    CONSTRAINT CK_Client_Phone_NotBlank
        CHECK (LEN(LTRIM(RTRIM(Phone))) > 0),
    CONSTRAINT CK_Client_Email
        CHECK (LEN(LTRIM(RTRIM(Email))) > 0 AND Email LIKE N'%_@_%._%'),
    CONSTRAINT CK_Client_CreditLimit
        CHECK (CreditLimit IS NULL OR CreditLimit >= 0),
    CONSTRAINT CK_Client_PaymentTermDays
        CHECK (PaymentTermDays IS NULL OR PaymentTermDays BETWEEN 0 AND 3650),
    CONSTRAINT FK_Client_Company
        FOREIGN KEY (CompanyId) REFERENCES dbo.Company (CompanyId),
    CONSTRAINT FK_Client_Person
        FOREIGN KEY (PersonId) REFERENCES dbo.Person (PersonId),
    CONSTRAINT FK_Client_Status
        FOREIGN KEY (Status) REFERENCES dbo.EntityStatus (StatusCode),
    CONSTRAINT FK_Client_BillingIdentity
        FOREIGN KEY (DefaultBillingIdentificationId, PersonId)
        REFERENCES dbo.PersonIdentification (PersonIdentificationId, PersonId)
);
GO

CREATE INDEX IX_Client_Company_Status
    ON dbo.Client (CompanyId, Status)
    INCLUDE (PersonId, DefaultBillingIdentificationId, CreditLimit, PaymentTermDays);
GO
