/*
Script: P_Permission_List.sql
Stored Procedure: dbo.P_Permission_List
Objetivo:
    Listar permisos activos del catalogo global para poblar la pantalla de perfiles.

Dependencias:
    - dbo.Permission
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Permission_List
(
    @ModuleCode NVARCHAR(50) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    SET @ModuleCode = NULLIF(LTRIM(RTRIM(@ModuleCode)), '');

    SELECT
        p.PermissionId,
        p.Code,
        p.Name,
        p.Description,
        p.ModuleCode,
        p.Status
    FROM dbo.Permission p
    WHERE p.Status = 'A'
      AND (@ModuleCode IS NULL OR p.ModuleCode = @ModuleCode)
    ORDER BY p.ModuleCode, p.Name, p.Code;
END;
GO