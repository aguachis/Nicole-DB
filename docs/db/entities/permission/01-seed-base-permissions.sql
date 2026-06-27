/*
Script: 01-seed-base-permissions.sql
Objetivo:
    Insertar permisos base de administracion para el ERP inicial.

Uso:
    Ejecutar despues de crear dbo.Permission.
*/

SET NOCOUNT ON;
GO

DECLARE @CreatedBy NVARCHAR(80) = N'base.seed';

DECLARE @BasePermissions TABLE
(
    Code NVARCHAR(150) NOT NULL PRIMARY KEY,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(250) NULL,
    ModuleCode NVARCHAR(50) NOT NULL
);

INSERT INTO @BasePermissions (Code, Name, Description, ModuleCode)
VALUES
    (N'company.read', N'Consultar empresas', N'Permite consultar datos de empresa', N'company'),
    (N'company.update', N'Actualizar empresa', N'Permite actualizar datos de empresa', N'company'),
    (N'user.read', N'Consultar usuarios', N'Permite consultar usuarios de la empresa', N'user'),
    (N'user.create', N'Crear usuarios', N'Permite crear usuarios en la empresa', N'user'),
    (N'user.update', N'Actualizar usuarios', N'Permite actualizar usuarios', N'user'),
    (N'user.disable', N'Desactivar usuarios', N'Permite desactivar usuarios', N'user'),
    (N'profile.read', N'Consultar perfiles', N'Permite consultar perfiles', N'profile'),
    (N'profile.create', N'Crear perfiles', N'Permite crear perfiles', N'profile'),
    (N'profile.update', N'Actualizar perfiles', N'Permite actualizar perfiles', N'profile'),
    (N'profile.assign', N'Asignar perfiles', N'Permite asignar perfiles a usuarios', N'profile'),
    (N'permission.read', N'Consultar permisos', N'Permite consultar permisos', N'permission'),
    (N'permission.assign', N'Asignar permisos', N'Permite asignar permisos a perfiles', N'permission');

INSERT INTO dbo.Permission
(
    PermissionId,
    Code,
    Name,
    Description,
    ModuleCode,
    Status,
    CreatedBy,
    CreatedAt
)
SELECT
    NEWID(),
    bp.Code,
    bp.Name,
    bp.Description,
    bp.ModuleCode,
    'A',
    @CreatedBy,
    SYSDATETIME()
FROM @BasePermissions bp
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Permission p
    WHERE p.Code = bp.Code
);
GO
