/* Initial schema: global person identifications. Run after AppUser and before Client. */
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

CREATE TABLE dbo.PersonIdentification
(
    PersonIdentificationId BIGINT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_PersonIdentification PRIMARY KEY,
    PersonId UNIQUEIDENTIFIER NOT NULL,
    IdentificationTypeId CHAR(2) NOT NULL,
    Identification NVARCHAR(64) NOT NULL,
    NormalizedIdentification AS dbo.fn_NormalizeIdentification(Identification) PERSISTED NOT NULL,
    IsPrimary BIT NOT NULL CONSTRAINT DF_PersonIdentification_IsPrimary DEFAULT (0),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_PersonIdentification_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedByUserId UNIQUEIDENTIFIER NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedByUserId UNIQUEIDENTIFIER NULL,
    CONSTRAINT CK_PersonIdentification_NotBlank
        CHECK (LEN(LTRIM(RTRIM(Identification))) > 0),
    CONSTRAINT FK_PersonIdentification_Person
        FOREIGN KEY (PersonId) REFERENCES dbo.Person (PersonId),
    CONSTRAINT FK_PersonIdentification_Type
        FOREIGN KEY (IdentificationTypeId) REFERENCES dbo.IdentificationType (IdentificationTypeId),
    CONSTRAINT FK_PersonIdentification_CreatedBy
        FOREIGN KEY (CreatedByUserId) REFERENCES dbo.AppUser (UserId),
    CONSTRAINT FK_PersonIdentification_UpdatedBy
        FOREIGN KEY (UpdatedByUserId) REFERENCES dbo.AppUser (UserId),
    CONSTRAINT UQ_PersonIdentification_Type_Normalized
        UNIQUE (IdentificationTypeId, NormalizedIdentification),
    CONSTRAINT UQ_PersonIdentification_Id_Person
        UNIQUE (PersonIdentificationId, PersonId)
);
GO

CREATE UNIQUE INDEX UX_PersonIdentification_OnePrimaryPerPerson
    ON dbo.PersonIdentification (PersonId)
    WHERE IsPrimary = 1;
GO
