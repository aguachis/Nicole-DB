/*
Script: 01-app-user-unique-username-filtered.sql
Objetivo:
    Evitar usernames duplicados cuando Username tenga valor.

Notas:
    - Username es opcional.
    - Ejecutar solo si la aplicacion permitira buscar o iniciar sesion por Username.
    - Antes de ejecutar, validar duplicados existentes.
*/

SET NOCOUNT ON;
GO

IF EXISTS
(
    SELECT Username
    FROM dbo.AppUser
    WHERE Username IS NOT NULL
    GROUP BY Username
    HAVING COUNT(*) > 1
)
BEGIN
    THROW 50001, 'Existen usernames duplicados. Corrija los datos antes de crear el indice unico filtrado.', 1;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.AppUser')
      AND name = N'UX_AppUser_Username_NotNull'
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_AppUser_Username_NotNull
    ON dbo.AppUser (Username)
    WHERE Username IS NOT NULL;
END;
GO
