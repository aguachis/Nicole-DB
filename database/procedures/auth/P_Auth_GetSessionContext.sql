/*
Script: P_Auth_GetSessionContext.sql
Stored Procedure: dbo.P_Auth_GetSessionContext
Objetivo:
    Consultar el contexto completo de sesion para un usuario:
    datos de usuario, empresa, perfil y permisos efectivos.

Reglas:
    - Entradas requeridas: @UserId y @ProfileId elegido para esta sesion
    - Aplica solo registros activos (Status = 'A')
    - UserProfile valida que el perfil elegido este asignado activamente al usuario
    - Los permisos se obtienen exclusivamente del perfil elegido para esta sesion
    - Los errores tecnicos inesperados se propagan con THROW

Dependencias:
    - dbo.AppUser
    - dbo.Person
    - dbo.Company
    - dbo.Profile
    - dbo.UserProfile
    - dbo.ProfilePermission
    - dbo.Permission
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Auth_GetSessionContext
(
    @UserId UNIQUEIDENTIFIER,
    @ProfileId UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CompanyId UNIQUEIDENTIFIER;

    IF @UserId IS NULL OR @ProfileId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'UserId and ProfileId are required.' AS result_message;
        RETURN;
    END;

    SELECT @CompanyId = u.CompanyId
    FROM dbo.AppUser u
    WHERE u.UserId = @UserId;

    IF @CompanyId IS NULL
    BEGIN
        SELECT CAST(2001 AS INT) AS result_code,
               N'User not found.' AS result_message;
        RETURN;
    END;

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
    BEGIN
        SELECT CAST(2002 AS INT) AS result_code,
               N'User not found or inactive.' AS result_message;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Company c
        WHERE c.CompanyId = @CompanyId
          AND c.Status = 'A'
    )
    BEGIN
        SELECT CAST(2002 AS INT) AS result_code,
               N'User company is not active.' AS result_message;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.UserProfile up
        INNER JOIN dbo.Profile pr
            ON pr.ProfileId = up.ProfileId
           AND pr.CompanyId = up.CompanyId
        WHERE up.UserId = @UserId
          AND up.CompanyId = @CompanyId
          AND up.ProfileId = @ProfileId
          AND up.Status = 'A'
          AND pr.Status = 'A'
    )
    BEGIN
        SELECT CAST(3001 AS INT) AS result_code,
               N'Profile is not actively assigned to the user for this session.' AS result_message;
        RETURN;
    END;

    SELECT
        CAST(0 AS INT) AS result_code,
        N'Session context loaded successfully.' AS result_message;

    SELECT
        u.UserId,
        u.PersonId,
        u.Email,
        u.Username,
        u.IsBlocked,
        u.RequiresNewPassword,
        u.MustUpdate,
        u.Status,
        p.PersonKind AS PersonType,
        pi.IdentificationTypeId AS IdentificationType,
        pi.Identification,
        p.FirstName,
        p.MiddleName,
        p.LastName,
        p.TradeName AS BusinessName,
        p.Phone,
        CAST(NULL AS NVARCHAR(150)) AS PersonEmail,
        p.LegalName,
        p.TradeName,
        pi.IdentificationTypeCode
    FROM dbo.AppUser u
    INNER JOIN dbo.Person p
        ON p.PersonId = u.PersonId
    OUTER APPLY
    (
        SELECT TOP (1)
            pi.IdentificationTypeId,
            pi.Identification,
            it.Code AS IdentificationTypeCode
        FROM dbo.PersonIdentification pi
        INNER JOIN dbo.IdentificationType it
            ON it.IdentificationTypeId = pi.IdentificationTypeId
        WHERE pi.PersonId = p.PersonId
        ORDER BY CASE WHEN pi.IsPrimary = 1 THEN 0 ELSE 1 END, pi.PersonIdentificationId
    ) pi
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
