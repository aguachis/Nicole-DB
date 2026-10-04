/*
Script: P_UserProfile_ListByUser.sql
Stored Procedure: dbo.P_UserProfile_ListByUser
Objetivo:
    Consultar los perfiles activos asignados a un usuario de su empresa unica.

Dependencias:
    - dbo.AppUser
    - dbo.Company
    - dbo.Profile
    - dbo.UserProfile
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_UserProfile_ListByUser
(
    @UserId UNIQUEIDENTIFIER,
    @ActorUserId UNIQUEIDENTIFIER = NULL,
    @ActorProfileId UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentCompanyId UNIQUEIDENTIFIER;
    DECLARE @CurrentUserStatus CHAR(1);

    IF @UserId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'UserId is required.' AS result_message;
        RETURN;
    END;

    IF @ActorUserId IS NULL OR @ActorProfileId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'ActorUserId and ActorProfileId are required.' AS result_message;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        WHERE u.UserId = @ActorUserId
          AND u.Status = 'A'
          AND u.IsBlocked = 0
    )
    BEGIN
        SELECT CAST(2001 AS INT) AS result_code,
               N'Actor is not valid.' AS result_message;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.UserProfile up
        WHERE up.UserId = @ActorUserId
          AND up.ProfileId = @ActorProfileId
          AND up.Status = 'A'
    )
    BEGIN
        SELECT CAST(3001 AS INT) AS result_code,
               N'Actor profile is not active for this session.' AS result_message;
        RETURN;
    END;

    IF dbo.fn_HasEffectivePermission(@ActorUserId, (SELECT u.CompanyId FROM dbo.AppUser u WHERE u.UserId = @ActorUserId), @ActorProfileId, N'profile.read') = 0
    BEGIN
        SELECT CAST(403 AS INT) AS result_code,
               N'Permission denied: profile.read is required.' AS result_message;
        RETURN;
    END;

    SELECT
        @CurrentCompanyId = u.CompanyId,
        @CurrentUserStatus = u.Status
    FROM dbo.AppUser u
    WHERE u.UserId = @UserId;

    IF @CurrentCompanyId IS NULL
    BEGIN
        SELECT CAST(2001 AS INT) AS result_code,
               N'User not found.' AS result_message;
        RETURN;
    END;

    IF @CurrentUserStatus <> 'A'
    BEGIN
        SELECT CAST(2002 AS INT) AS result_code,
               N'User is inactive.' AS result_message;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Company c
        WHERE c.CompanyId = @CurrentCompanyId
          AND c.Status = 'A'
    )
    BEGIN
        SELECT CAST(2002 AS INT) AS result_code,
               N'Company is inactive.' AS result_message;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.AppUser au
        WHERE au.UserId = @ActorUserId
          AND au.CompanyId = @CurrentCompanyId
    )
    BEGIN
        SELECT CAST(3001 AS INT) AS result_code,
               N'Actor does not belong to the target company.' AS result_message;
        RETURN;
    END;

    SELECT
        CAST(0 AS INT) AS result_code,
        N'Query executed successfully.' AS result_message;

    SELECT
        up.UserId,
        up.CompanyId,
        up.ProfileId,
        p.Name,
        p.Description,
        up.Status,
        up.CreatedAt AS AssignedAt
    FROM dbo.UserProfile up
    INNER JOIN dbo.Profile p
        ON p.ProfileId = up.ProfileId
       AND p.CompanyId = up.CompanyId
    WHERE up.UserId = @UserId
      AND up.CompanyId = @CurrentCompanyId
      AND up.Status = 'A'
      AND p.Status = 'A'
    ORDER BY p.Name, up.ProfileId;
END;
GO
