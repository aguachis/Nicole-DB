/*
Script: 00-create-table-appuser.sql
Entidad: dbo.AppUser
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla AppUser segun la estructura actualmente existente en BD.

Concepto:
    AppUser representa la identidad de acceso a la aplicacion.

Dependencias:
    - dbo.Person(PersonId)
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.AppUser', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.AppUser ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.AppUser
(
    UserId UNIQUEIDENTIFIER NOT NULL,
    PersonId UNIQUEIDENTIFIER NOT NULL,
    Username NVARCHAR(80) NULL,
    PasswordHash NVARCHAR(500) NOT NULL,
    Email NVARCHAR(150) NOT NULL,
    IsBlocked BIT NOT NULL,
    RequiresNewPassword BIT NOT NULL,
    MustUpdate BIT NOT NULL,
    Status CHAR(1) NOT NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_AppUser
        PRIMARY KEY CLUSTERED (UserId),

    CONSTRAINT UQ_AppUser_Email
        UNIQUE NONCLUSTERED (Email)
);
GO

ALTER TABLE dbo.AppUser
ADD CONSTRAINT DF_AppUser_UserId
    DEFAULT (NEWSEQUENTIALID()) FOR UserId;
GO

ALTER TABLE dbo.AppUser
ADD CONSTRAINT DF_AppUser_IsBlocked
    DEFAULT ((0)) FOR IsBlocked;
GO

ALTER TABLE dbo.AppUser
ADD CONSTRAINT DF_AppUser_RequiresNewPassword
    DEFAULT ((0)) FOR RequiresNewPassword;
GO

ALTER TABLE dbo.AppUser
ADD CONSTRAINT DF_AppUser_MustUpdate
    DEFAULT ((0)) FOR MustUpdate;
GO

ALTER TABLE dbo.AppUser
ADD CONSTRAINT DF_AppUser_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.AppUser
ADD CONSTRAINT DF_AppUser_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.AppUser WITH CHECK
ADD CONSTRAINT FK_AppUser_Person
    FOREIGN KEY (PersonId)
    REFERENCES dbo.Person (PersonId);
GO

ALTER TABLE dbo.AppUser CHECK CONSTRAINT FK_AppUser_Person;
GO

ALTER TABLE dbo.AppUser WITH CHECK
ADD CONSTRAINT FK_AppUser_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.AppUser CHECK CONSTRAINT FK_AppUser_Status;
GO

ALTER TABLE dbo.AppUser WITH CHECK
ADD CONSTRAINT CK_AppUser_Email_NotBlank
    CHECK (LEN(LTRIM(RTRIM(Email))) > 0);
GO

ALTER TABLE dbo.AppUser CHECK CONSTRAINT CK_AppUser_Email_NotBlank;
GO

ALTER TABLE dbo.AppUser WITH CHECK
ADD CONSTRAINT CK_AppUser_PasswordHash_NotBlank
    CHECK (LEN(LTRIM(RTRIM(PasswordHash))) > 0);
GO

ALTER TABLE dbo.AppUser CHECK CONSTRAINT CK_AppUser_PasswordHash_NotBlank;
GO
