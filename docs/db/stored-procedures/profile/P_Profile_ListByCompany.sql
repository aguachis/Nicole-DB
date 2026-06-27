/*
Script: P_Profile_ListByCompany.sql
Stored Procedure: dbo.P_Profile_ListByCompany
Objetivo:
    Listar perfiles activos de una empresa junto con la cantidad de permisos activos asignados.

Dependencias:
    - dbo.Profile
    - dbo.ProfilePermission
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Profile_ListByCompany
(
    @CompanyId UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @CompanyId IS NULL
        RAISERROR('CompanyId is required.', 16, 1);

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
    WHERE p.CompanyId = @CompanyId
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
        p.UpdatedAt
    ORDER BY p.Name;
END;
GO