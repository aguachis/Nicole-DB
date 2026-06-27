/*
Script: 00-create-type-permission-code-list.sql
Objeto: dbo.PermissionCodeListType
Objetivo:
    Crear el tipo tabla que permite enviar codigos de permiso a los SPs de sincronizacion.
*/

IF TYPE_ID(N'dbo.PermissionCodeListType') IS NOT NULL
BEGIN
    PRINT 'El tipo dbo.PermissionCodeListType ya existe.';
END
ELSE
BEGIN
    EXEC
    (
        N'CREATE TYPE dbo.PermissionCodeListType AS TABLE
        (
            Code NVARCHAR(150) NOT NULL PRIMARY KEY
        );'
    );
END
GO