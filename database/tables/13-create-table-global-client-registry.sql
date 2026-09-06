/* Initial schema: global tax identity registry. Run after AppUser and before Client. */
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE FUNCTION dbo.fn_NormalizeIdentification
(
    @Identification NVARCHAR(64)
)
RETURNS NVARCHAR(64)
WITH SCHEMABINDING
AS
BEGIN
    RETURN ISNULL(
        UPPER(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(@Identification)), N' ', N''), N'-', N''), N'.', N'')),
        N''
    );
END;
GO

CREATE TABLE dbo.RegistryProvider
(
    RegistryProviderId SMALLINT IDENTITY(1, 1) NOT NULL,
    Code VARCHAR(50) COLLATE Latin1_General_100_BIN2 NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    BaseUrl NVARCHAR(500) NULL,
    DefaultCacheMinutes INT NOT NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_RegistryProvider_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_RegistryProvider_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedByUserId UNIQUEIDENTIFIER NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedByUserId UNIQUEIDENTIFIER NULL,
    CONSTRAINT PK_RegistryProvider PRIMARY KEY (RegistryProviderId),
    CONSTRAINT UQ_RegistryProvider_Code UNIQUE (Code),
    CONSTRAINT CK_RegistryProvider_Cache CHECK (DefaultCacheMinutes > 0),
    CONSTRAINT FK_RegistryProvider_CreatedBy FOREIGN KEY (CreatedByUserId) REFERENCES dbo.AppUser (UserId),
    CONSTRAINT FK_RegistryProvider_UpdatedBy FOREIGN KEY (UpdatedByUserId) REFERENCES dbo.AppUser (UserId)
);

CREATE TABLE dbo.PersonIdentification(
 PersonIdentificationId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_PersonIdentification PRIMARY KEY,
 PersonId uniqueidentifier NOT NULL, IdentificationTypeId char(2) NOT NULL, Identification nvarchar(64) NOT NULL,
 NormalizedIdentification AS dbo.fn_NormalizeIdentification(Identification) PERSISTED NOT NULL,
 IsPrimary bit NOT NULL CONSTRAINT DF_PersonIdentification_IsPrimary DEFAULT(0),
 VerificationStatus varchar(16) COLLATE Latin1_General_100_BIN2 NOT NULL CONSTRAINT DF_PersonIdentification_VerificationStatus DEFAULT('Unverified'),
 LastVerifiedAt datetime2(3) NULL, ExpiresAt datetime2(3) NULL, CreatedAt datetime2(3) NOT NULL CONSTRAINT DF_PersonIdentification_CreatedAt DEFAULT(SYSUTCDATETIME()), CreatedByUserId uniqueidentifier NULL, UpdatedAt datetime2(3) NULL, UpdatedByUserId uniqueidentifier NULL,
 CONSTRAINT CK_PersonIdentification_NotBlank CHECK(LEN(LTRIM(RTRIM(Identification)))>0), CONSTRAINT CK_PersonIdentification_Status CHECK(VerificationStatus IN('Unverified','Verified','NotFound','Invalid','Expired','Error')),
 CONSTRAINT FK_PersonIdentification_Person FOREIGN KEY(PersonId) REFERENCES dbo.Person(PersonId), CONSTRAINT FK_PersonIdentification_Type FOREIGN KEY(IdentificationTypeId) REFERENCES dbo.IdentificationType(IdentificationTypeId),
 CONSTRAINT FK_PersonIdentification_CreatedBy FOREIGN KEY(CreatedByUserId) REFERENCES dbo.AppUser(UserId), CONSTRAINT FK_PersonIdentification_UpdatedBy FOREIGN KEY(UpdatedByUserId) REFERENCES dbo.AppUser(UserId),
 CONSTRAINT UQ_PersonIdentification_Type_Normalized UNIQUE(IdentificationTypeId,NormalizedIdentification), CONSTRAINT UQ_PersonIdentification_Id_Person UNIQUE(PersonIdentificationId,PersonId));
CREATE UNIQUE INDEX UX_PersonIdentification_OnePrimaryPerPerson ON dbo.PersonIdentification(PersonId) WHERE IsPrimary=1;

CREATE TABLE dbo.TaxRegistration(
 TaxRegistrationId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_TaxRegistration PRIMARY KEY, PersonIdentificationId bigint NOT NULL CONSTRAINT UQ_TaxRegistration_PersonIdentification UNIQUE,
 TaxStatus nvarchar(100) NULL, TaxpayerClass nvarchar(100) NULL, TaxAddress nvarchar(500) NULL, AccountingRequired bit NULL, StartedAt date NULL,
 RegistryProviderId smallint NOT NULL, Source varchar(20) COLLATE Latin1_General_100_BIN2 NOT NULL, VerifiedAt datetime2(3) NOT NULL, VerificationExpiresAt datetime2(3) NOT NULL,
 CONSTRAINT CK_TaxRegistration_Source CHECK(Source IN('Provider','Manual')), CONSTRAINT CK_TaxRegistration_Dates CHECK(VerificationExpiresAt>=VerifiedAt),
 CONSTRAINT FK_TaxRegistration_Identification FOREIGN KEY(PersonIdentificationId) REFERENCES dbo.PersonIdentification(PersonIdentificationId), CONSTRAINT FK_TaxRegistration_Provider FOREIGN KEY(RegistryProviderId) REFERENCES dbo.RegistryProvider(RegistryProviderId));

CREATE TABLE dbo.EconomicActivity(EconomicActivityId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_EconomicActivity PRIMARY KEY, ActivityCode nvarchar(32) NOT NULL CONSTRAINT UQ_EconomicActivity_Code UNIQUE, Name nvarchar(300) NOT NULL, IsActive bit NOT NULL CONSTRAINT DF_EconomicActivity_IsActive DEFAULT(1));
CREATE TABLE dbo.TaxRegistrationEconomicActivity(TaxRegistrationEconomicActivityId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_TaxRegistrationEconomicActivity PRIMARY KEY, TaxRegistrationId bigint NOT NULL, EconomicActivityId bigint NOT NULL, ProviderActivityId nvarchar(128) NULL, IsPrimary bit NOT NULL CONSTRAINT DF_TaxRegistrationEconomicActivity_IsPrimary DEFAULT(0), VerifiedAt datetime2(3) NOT NULL, CONSTRAINT UQ_TaxRegistrationEconomicActivity UNIQUE(TaxRegistrationId,EconomicActivityId), CONSTRAINT FK_TREA_Registration FOREIGN KEY(TaxRegistrationId) REFERENCES dbo.TaxRegistration(TaxRegistrationId), CONSTRAINT FK_TREA_Activity FOREIGN KEY(EconomicActivityId) REFERENCES dbo.EconomicActivity(EconomicActivityId));
CREATE UNIQUE INDEX UX_TREA_OnePrimary ON dbo.TaxRegistrationEconomicActivity(TaxRegistrationId) WHERE IsPrimary=1;

CREATE TABLE dbo.PersonVerification(PersonVerificationId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_PersonVerification PRIMARY KEY, PersonIdentificationId bigint NOT NULL, RegistryProviderId smallint NOT NULL, Result varchar(16) COLLATE Latin1_General_100_BIN2 NOT NULL, QueriedAt datetime2(3) NOT NULL, ExpiresAt datetime2(3) NOT NULL, PayloadHash varbinary(32) NULL, ProviderRequestId nvarchar(128) NULL, FailureCode varchar(64) NULL, CorrelationId uniqueidentifier NOT NULL, CONSTRAINT CK_PersonVerification_Result CHECK(Result IN('Verified','NotFound','Invalid','Unavailable','Error')), CONSTRAINT FK_PersonVerification_Identity FOREIGN KEY(PersonIdentificationId) REFERENCES dbo.PersonIdentification(PersonIdentificationId), CONSTRAINT FK_PersonVerification_Provider FOREIGN KEY(RegistryProviderId) REFERENCES dbo.RegistryProvider(RegistryProviderId));

CREATE TABLE dbo.RegistryAccessAudit(RegistryAccessAuditId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_RegistryAccessAudit PRIMARY KEY, CompanyId uniqueidentifier NOT NULL, UserId uniqueidentifier NULL, PersonIdentificationId bigint NULL, RegistryProviderId smallint NULL, Outcome varchar(16) COLLATE Latin1_General_100_BIN2 NOT NULL, OccurredAt datetime2(3) NOT NULL CONSTRAINT DF_RegistryAccessAudit_OccurredAt DEFAULT(SYSUTCDATETIME()), CorrelationId uniqueidentifier NOT NULL, ReasonCode varchar(64) NULL, CONSTRAINT CK_RegistryAccessAudit_Outcome CHECK(Outcome IN('CacheHit','ProviderQueried','Denied','NotFound','Invalid','Unavailable','Error')), CONSTRAINT FK_RegistryAccessAudit_Company FOREIGN KEY(CompanyId) REFERENCES dbo.Company(CompanyId), CONSTRAINT FK_RegistryAccessAudit_User FOREIGN KEY(UserId) REFERENCES dbo.AppUser(UserId), CONSTRAINT FK_RegistryAccessAudit_Identity FOREIGN KEY(PersonIdentificationId) REFERENCES dbo.PersonIdentification(PersonIdentificationId), CONSTRAINT FK_RegistryAccessAudit_Provider FOREIGN KEY(RegistryProviderId) REFERENCES dbo.RegistryProvider(RegistryProviderId));

CREATE TRIGGER dbo.tr_TaxRegistration_RequireRuc ON dbo.TaxRegistration AFTER INSERT,UPDATE AS
BEGIN
 SET NOCOUNT ON;
 IF EXISTS(SELECT 1 FROM inserted i JOIN dbo.PersonIdentification pi ON pi.PersonIdentificationId=i.PersonIdentificationId JOIN dbo.IdentificationType it ON it.IdentificationTypeId=pi.IdentificationTypeId WHERE it.Code<>'RUC')
   THROW 51101,'TaxRegistration requires a RUC identification.',1;
END;
GO
