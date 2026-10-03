CREATE TABLE dbo.AppUser
(
    UserId UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT DF_AppUser_UserId DEFAULT (NEWSEQUENTIALID()),
    PersonId UNIQUEIDENTIFIER NOT NULL,
    CompanyId UNIQUEIDENTIFIER NOT NULL,
    Username NVARCHAR(80) NULL,
    PasswordHash NVARCHAR(500) NOT NULL,
    Email NVARCHAR(150) NOT NULL,
    IsBlocked BIT NOT NULL
        CONSTRAINT DF_AppUser_IsBlocked DEFAULT ((0)),
    RequiresNewPassword BIT NOT NULL
        CONSTRAINT DF_AppUser_RequiresNewPassword DEFAULT ((0)),
    MustUpdate BIT NOT NULL
        CONSTRAINT DF_AppUser_MustUpdate DEFAULT ((0)),
    Status CHAR(1) NOT NULL
        CONSTRAINT DF_AppUser_Status DEFAULT ('A'),
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL
        CONSTRAINT DF_AppUser_CreatedAt DEFAULT (SYSDATETIME()),
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_AppUser PRIMARY KEY CLUSTERED (UserId),
    CONSTRAINT UQ_AppUser_Email UNIQUE NONCLUSTERED (Email),
    CONSTRAINT UQ_AppUser_UserId_CompanyId UNIQUE NONCLUSTERED (UserId, CompanyId),
    CONSTRAINT FK_AppUser_Person
        FOREIGN KEY (PersonId) REFERENCES dbo.Person (PersonId),
    CONSTRAINT FK_AppUser_Company
        FOREIGN KEY (CompanyId) REFERENCES dbo.Company (CompanyId),
    CONSTRAINT FK_AppUser_Status
        FOREIGN KEY (Status) REFERENCES dbo.EntityStatus (StatusCode),
    CONSTRAINT CK_AppUser_Email_NotBlank
        CHECK (LEN(LTRIM(RTRIM(Email))) > 0),
    CONSTRAINT CK_AppUser_PasswordHash_NotBlank
        CHECK (LEN(LTRIM(RTRIM(PasswordHash))) > 0)
);
