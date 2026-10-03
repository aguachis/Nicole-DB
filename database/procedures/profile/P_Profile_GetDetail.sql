/*
Script: P_Profile_GetDetail.sql
Stored Procedure: dbo.P_Profile_GetDetail
Objetivo:
    Consultar el detalle de un perfil activo de una empresa y sus permisos activos asignados.

Dependencias:
    - dbo.Profile
    - dbo.ProfilePermission
    - dbo.Permission
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Profile_GetDetail
(
    @CompanyId UNIQUEIDENTIFIER,
    @ProfileId UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @CompanyId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'CompanyId is required.' AS result_message;
        RETURN;
    END;

    IF @ProfileId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'ProfileId is required.' AS result_message;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Profile p
        WHERE p.ProfileId = @ProfileId
          AND p.CompanyId = @CompanyId
          AND p.Status = 'A'
    )
    BEGIN
        SELECT CAST(2001 AS INT) AS result_code,
               N'Profile not found for the company.' AS result_message;
        RETURN;
    END;

    SELECT
        CAST(0 AS INT) AS result_code,
        N'Query executed successfully.' AS result_message;

    SELECT
        p.ProfileId,
        p.CompanyId,
        p.Name,
        p.Description,
        p.Status,
        p.CreatedBy,
        p.CreatedAt,
        p.UpdatedBy,
        p.UpdatedAt,
        COUNT(pp.ProfilePermissionId) AS ActivePermissionCount
    FROM dbo.Profile p
    LEFT JOIN dbo.ProfilePermission pp
        ON pp.ProfileId = p.ProfileId
       AND pp.Status = 'A'
    WHERE p.ProfileId = @ProfileId
      AND p.CompanyId = @CompanyId
      AND p.Status = 'A'
    GROUP BY
        p.ProfileId,
        p.CompanyId,
        p.Name,
        p.Description,
        p.Status,
        p.CreatedBy,
        p.CreatedAt,
        p.UpdatedBy,
        p.UpdatedAt;

    SELECT
        pm.PermissionId,
        pm.Code,
        pm.Name,
        pm.Description,
        pm.ModuleCode
    FROM dbo.ProfilePermission pp
    INNER JOIN dbo.Permission pm
        ON pm.PermissionId = pp.PermissionId
    WHERE pp.ProfileId = @ProfileId
      AND pp.Status = 'A'
      AND pm.Status = 'A'
    ORDER BY pm.ModuleCode, pm.Name, pm.Code;
END;
GO
