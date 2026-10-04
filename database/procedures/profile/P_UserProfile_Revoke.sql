/*
Script: P_UserProfile_Revoke.sql
Stored Procedure: dbo.P_UserProfile_Revoke
Objetivo:
    Revocar una asignacion de perfil sin dejar a un usuario activo sin perfiles.

Dependencias:
    - dbo.AppUser
    - dbo.Company
    - dbo.Profile
    - dbo.UserProfile
    - dbo.UserProfileAudit
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_UserProfile_Revoke
(
    @CompanyId UNIQUEIDENTIFIER,
    @UserId UNIQUEIDENTIFIER,
    @ProfileId UNIQUEIDENTIFIER,
    @Actor NVARCHAR(80),
    @ActorUserId UNIQUEIDENTIFIER = NULL,
    @ActorProfileId UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @CurrentCompanyId UNIQUEIDENTIFIER;
    DECLARE @CurrentUserStatus CHAR(1);
    DECLARE @LockedProfileId UNIQUEIDENTIFIER;
    DECLARE @UserProfileId UNIQUEIDENTIFIER;
    DECLARE @AssignmentStatus CHAR(1);
    DECLARE @RemainingActiveProfiles INT;
    DECLARE @Operation NVARCHAR(20);

    SET @Actor = LEFT(LTRIM(RTRIM(@Actor)), 80);

    IF @CompanyId IS NULL OR @UserId IS NULL OR @ProfileId IS NULL
       OR @ActorUserId IS NULL OR @ActorProfileId IS NULL
       OR @Actor IS NULL OR @Actor = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'CompanyId, UserId, ProfileId, ActorUserId, ActorProfileId and Actor are required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        WHERE u.UserId = @ActorUserId
          AND u.CompanyId = @CompanyId
          AND u.Status = 'A'
          AND u.IsBlocked = 0
    )
    BEGIN
        SELECT CAST(2001 AS INT) AS result_code,
               N'Actor is not valid for this company.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.UserProfile up
        WHERE up.UserId = @ActorUserId
          AND up.CompanyId = @CompanyId
          AND up.ProfileId = @ActorProfileId
          AND up.Status = 'A'
    )
    BEGIN
        SELECT CAST(3001 AS INT) AS result_code,
               N'Actor profile is not active for this session.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF dbo.fn_HasEffectivePermission(@ActorUserId, @CompanyId, @ActorProfileId, N'profile.revoke') = 0
    BEGIN
        SELECT CAST(403 AS INT) AS result_code,
               N'Permission denied: profile.revoke is required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRAN;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Company c WITH (HOLDLOCK)
            WHERE c.CompanyId = @CompanyId
              AND c.Status = 'A'
        )
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(2002 AS INT) AS result_code,
                   N'Company is inactive.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        SELECT
            @CurrentCompanyId = u.CompanyId,
            @CurrentUserStatus = u.Status
        FROM dbo.AppUser u WITH (UPDLOCK, HOLDLOCK)
        WHERE u.UserId = @UserId;

        IF @CurrentCompanyId IS NULL
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(2001 AS INT) AS result_code,
                   N'User not found.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF @CurrentUserStatus <> 'A'
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(2002 AS INT) AS result_code,
                   N'User is inactive.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF @CurrentCompanyId <> @CompanyId
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(3001 AS INT) AS result_code,
                   N'User does not belong to the authorized company.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        SELECT @LockedProfileId = p.ProfileId
        FROM dbo.Profile p WITH (HOLDLOCK)
        WHERE p.ProfileId = @ProfileId
          AND p.CompanyId = @CompanyId;

        SELECT
            @UserProfileId = up.UserProfileId,
            @AssignmentStatus = up.Status
        FROM dbo.UserProfile up WITH (UPDLOCK, HOLDLOCK)
        WHERE up.UserId = @UserId
          AND up.CompanyId = @CompanyId
          AND up.ProfileId = @ProfileId;

        IF @UserProfileId IS NULL OR @AssignmentStatus = 'I'
        BEGIN
            SET @Operation = N'NOOP';
        END
        ELSE
        BEGIN
            SELECT @RemainingActiveProfiles = COUNT(*)
            FROM dbo.UserProfile up WITH (HOLDLOCK)
            INNER JOIN dbo.Profile p WITH (HOLDLOCK)
                ON p.ProfileId = up.ProfileId
               AND p.CompanyId = up.CompanyId
            WHERE up.UserId = @UserId
              AND up.CompanyId = @CompanyId
              AND up.Status = 'A'
              AND p.Status = 'A'
              AND up.ProfileId <> @ProfileId;

            IF @RemainingActiveProfiles = 0
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(4002 AS INT) AS result_code,
                       N'Cannot revoke the last active profile assigned to an active user.' AS result_message,
                       CAST(NULL AS NVARCHAR(20)) AS operation;
                RETURN;
            END;

            UPDATE dbo.UserProfile
            SET Status = 'I',
                UpdatedBy = @Actor,
                UpdatedAt = SYSDATETIME()
            WHERE UserProfileId = @UserProfileId;

            INSERT INTO dbo.UserProfileAudit
            (
                UserId,
                CompanyId,
                ProfileId,
                OperationCode,
                Actor
            )
            VALUES
            (
                @UserId,
                @CompanyId,
                @ProfileId,
                'REVOKE',
                @Actor
            );

            SET @Operation = N'REVOKE';
        END;

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            CASE @Operation
                WHEN N'REVOKE' THEN N'User profile revoked successfully.'
                ELSE N'No changes applied. The profile assignment is already inactive or does not exist.'
            END AS result_message,
            @Operation AS operation;

        SELECT
            up.UserId,
            up.CompanyId,
            up.ProfileId,
            up.Status,
            up.CreatedBy,
            up.CreatedAt,
            up.UpdatedBy,
            up.UpdatedAt
        FROM dbo.UserProfile up
        WHERE up.UserProfileId = @UserProfileId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH
END;
GO
