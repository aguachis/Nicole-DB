/*
Script: 10-create-table-profile-permission.sql
Entidad: dbo.ProfilePermission
Fuente: Script actual de BD Nicole recibido el 2026-06-19
Objetivo:
    Crear la tabla ProfilePermission segun la estructura actualmente existente en BD.

Concepto:
    ProfilePermission relaciona perfiles con permisos funcionales.

Dependencias:
    - dbo.Profile(ProfileId)
    - dbo.Permission(PermissionId)
    - dbo.EntityStatus(StatusCode)
*/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.ProfilePermission', N'U') IS NOT NULL
BEGIN
    PRINT 'La tabla dbo.ProfilePermission ya existe.';
    RETURN;
END
GO

CREATE TABLE dbo.ProfilePermission
(
    ProfilePermissionId UNIQUEIDENTIFIER NOT NULL,
    ProfileId UNIQUEIDENTIFIER NOT NULL,
    PermissionId UNIQUEIDENTIFIER NOT NULL,
    Status CHAR(1) NOT NULL,
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL,
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,

    CONSTRAINT PK_ProfilePermission
        PRIMARY KEY CLUSTERED (ProfilePermissionId),

    CONSTRAINT UQ_ProfilePermission_Profile_Permission
        UNIQUE NONCLUSTERED (ProfileId, PermissionId)
);
GO

ALTER TABLE dbo.ProfilePermission
ADD CONSTRAINT DF_ProfilePermission_Id
    DEFAULT (NEWSEQUENTIALID()) FOR ProfilePermissionId;
GO

ALTER TABLE dbo.ProfilePermission
ADD CONSTRAINT DF_ProfilePermission_Status
    DEFAULT ('A') FOR Status;
GO

ALTER TABLE dbo.ProfilePermission
ADD CONSTRAINT DF_ProfilePermission_CreatedAt
    DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

ALTER TABLE dbo.ProfilePermission WITH CHECK
ADD CONSTRAINT FK_ProfilePermission_Permission
    FOREIGN KEY (PermissionId)
    REFERENCES dbo.Permission (PermissionId);
GO

ALTER TABLE dbo.ProfilePermission CHECK CONSTRAINT FK_ProfilePermission_Permission;
GO

ALTER TABLE dbo.ProfilePermission WITH CHECK
ADD CONSTRAINT FK_ProfilePermission_Profile
    FOREIGN KEY (ProfileId)
    REFERENCES dbo.Profile (ProfileId);
GO

ALTER TABLE dbo.ProfilePermission CHECK CONSTRAINT FK_ProfilePermission_Profile;
GO

ALTER TABLE dbo.ProfilePermission WITH CHECK
ADD CONSTRAINT FK_ProfilePermission_Status
    FOREIGN KEY (Status)
    REFERENCES dbo.EntityStatus (StatusCode);
GO

ALTER TABLE dbo.ProfilePermission CHECK CONSTRAINT FK_ProfilePermission_Status;
GO
