/*
Script: P_Auth_GetSessionContext.sql
Stored Procedure: dbo.P_Auth_GetSessionContext
Objetivo:
    Consultar el contexto completo de sesion para un usuario:
    datos de usuario, empresa, perfil y permisos efectivos.

Reglas:
    - Entrada requerida: @UserId
    - Aplica solo registros activos (Status = 'A')
    - Valida cardinalidad operativa esperada:
      1 usuario activo -> 1 empresa activa -> 1 perfil activo
    - Si detecta inconsistencias, detiene la ejecucion con RAISERROR

Dependencias:
    - dbo.AppUser
    - dbo.Person
    - dbo.UserCompany
    - dbo.Company
    - dbo.UserCompanyProfile
    - dbo.Profile
    - dbo.ProfilePermission
    - dbo.Permission
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Auth_GetSessionContext
(
    @UserId UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserCompanyId UNIQUEIDENTIFIER;
    DECLARE @CompanyId UNIQUEIDENTIFIER;
    DECLARE @ProfileId UNIQUEIDENTIFIER;
    DECLARE @ActiveCompanyCount INT;
    DECLARE @ActiveProfileCount INT;

    IF @UserId IS NULL
        RAISERROR('UserId is required.', 16, 1);

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        INNER JOIN dbo.Person p
            ON p.PersonId = u.PersonId
        WHERE u.UserId = @UserId
          AND u.Status = 'A'
          AND p.Status = 'A'
    )
        RAISERROR('User not found or inactive.', 16, 1);

    SELECT
        @ActiveCompanyCount = COUNT(*)
    FROM dbo.UserCompany uc
    INNER JOIN dbo.Company c
        ON c.CompanyId = uc.CompanyId
    WHERE uc.UserId = @UserId
      AND uc.Status = 'A'
      AND c.Status = 'A';

    IF @ActiveCompanyCount = 0
        RAISERROR('User has no active company.', 16, 1);

    IF @ActiveCompanyCount > 1
        RAISERROR('User has more than one active company.', 16, 1);

    SELECT TOP 1
        @UserCompanyId = uc.UserCompanyId,
        @CompanyId = uc.CompanyId
    FROM dbo.UserCompany uc
    INNER JOIN dbo.Company c
        ON c.CompanyId = uc.CompanyId
    WHERE uc.UserId = @UserId
      AND uc.Status = 'A'
      AND c.Status = 'A'
    ORDER BY uc.CreatedAt ASC;

    SELECT
        @ActiveProfileCount = COUNT(*)
    FROM dbo.UserCompanyProfile ucp
    INNER JOIN dbo.Profile pr
        ON pr.ProfileId = ucp.ProfileId
       AND pr.CompanyId = ucp.CompanyId
    WHERE ucp.UserCompanyId = @UserCompanyId
      AND ucp.CompanyId = @CompanyId
      AND ucp.Status = 'A'
      AND pr.Status = 'A';

    IF @ActiveProfileCount = 0
        RAISERROR('User has no active profile for the company.', 16, 1);

    IF @ActiveProfileCount > 1
        RAISERROR('User has more than one active profile for the company.', 16, 1);

    SELECT TOP 1
        @ProfileId = ucp.ProfileId
    FROM dbo.UserCompanyProfile ucp
    INNER JOIN dbo.Profile pr
        ON pr.ProfileId = ucp.ProfileId
       AND pr.CompanyId = ucp.CompanyId
    WHERE ucp.UserCompanyId = @UserCompanyId
      AND ucp.CompanyId = @CompanyId
      AND ucp.Status = 'A'
      AND pr.Status = 'A'
    ORDER BY ucp.CreatedAt ASC;

    SELECT
        u.UserId,
        u.PersonId,
        u.Email,
        u.Username,
        u.IsBlocked,
        u.RequiresNewPassword,
        u.MustUpdate,
        u.Status,
        p.PersonType,
        p.IdentificationType,
        p.Identification,
        p.FirstName,
        p.MiddleName,
        p.LastName,
        p.BusinessName,
        p.Phone,
        p.Email AS PersonEmail
    FROM dbo.AppUser u
    INNER JOIN dbo.Person p
        ON p.PersonId = u.PersonId
    WHERE u.UserId = @UserId
      AND u.Status = 'A'
      AND p.Status = 'A';

    SELECT
        c.CompanyId,
        c.Identification,
        c.BusinessName,
        c.TradeName,
        c.Email,
        c.Currency,
        c.Timezone,
        c.LanguageCode,
        c.Environment,
        c.Status
    FROM dbo.Company c
    WHERE c.CompanyId = @CompanyId
      AND c.Status = 'A';

    SELECT
        pr.ProfileId,
        pr.CompanyId,
        pr.Name,
        pr.Description,
        pr.Status
    FROM dbo.Profile pr
    WHERE pr.ProfileId = @ProfileId
      AND pr.CompanyId = @CompanyId
      AND pr.Status = 'A';

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
