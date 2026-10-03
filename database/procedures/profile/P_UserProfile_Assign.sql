/*
Script: P_UserProfile_Assign.sql
Stored Procedure: dbo.P_UserProfile_Assign
Objetivo:
    Agregar o reactivar un perfil del usuario dentro de su empresa unica.

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

CREATE OR ALTER PROCEDURE dbo.P_UserProfile_Assign
(
    @CompanyId UNIQUEIDENTIFIER,
    @UserId UNIQUEIDENTIFIER,
    @ProfileId UNIQUEIDENTIFIER,
    @Actor NVARCHAR(80)
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @CurrentCompanyId UNIQUEIDENTIFIER;
    DECLARE @CurrentUserStatus CHAR(1);
    DECLARE @UserProfileId UNIQUEIDENTIFIER;
    DECLARE @CurrentAssignmentStatus CHAR(1);
    DECLARE @Operation NVARCHAR(20);
    DECLARE @OperationCode VARCHAR(20);

    SET @Actor = LEFT(LTRIM(RTRIM(@Actor)), 80);

    IF @CompanyId IS NULL OR @UserId IS NULL OR @ProfileId IS NULL
       OR @Actor IS NULL OR @Actor = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'CompanyId, UserId, ProfileId and Actor are required.' AS result_message,
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
                   N'Company is not active.' AS result_message,
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
            SELECT CAST(2001 AS INT) AS result_code, N'User not found.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF @CurrentUserStatus <> 'A'
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(2002 AS INT) AS result_code, N'User is inactive.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF @CurrentCompanyId <> @CompanyId
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(4003 AS INT) AS result_code, N'User does not belong to this company.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Profile p WITH (HOLDLOCK)
            WHERE p.ProfileId = @ProfileId
              AND p.CompanyId = @CompanyId
        )
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(2001 AS INT) AS result_code,
                   N'Profile not found for company.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
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
            ROLLBACK TRAN;
            SELECT CAST(2002 AS INT) AS result_code,
                   N'Profile is inactive.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        SELECT
            @UserProfileId = up.UserProfileId,
            @CurrentAssignmentStatus = up.Status
        FROM dbo.UserProfile up WITH (UPDLOCK, HOLDLOCK)
        WHERE up.UserId = @UserId
          AND up.ProfileId = @ProfileId;

        IF @CurrentAssignmentStatus = 'A'
        BEGIN
            SET @Operation = N'NOOP';
        END
        ELSE IF @CurrentAssignmentStatus = 'I'
        BEGIN
            UPDATE dbo.UserProfile
            SET Status = 'A',
                UpdatedBy = @Actor,
                UpdatedAt = SYSDATETIME()
            WHERE UserProfileId = @UserProfileId;

            SET @Operation = N'REACTIVATE';
            SET @OperationCode = 'REACTIVATE';
        END
        ELSE
        BEGIN
            SET @UserProfileId = NEWID();

            INSERT INTO dbo.UserProfile
            (
                UserProfileId,
                UserId,
                CompanyId,
                ProfileId,
                Status,
                CreatedBy,
                CreatedAt
            )
            VALUES
            (
                @UserProfileId,
                @UserId,
                @CompanyId,
                @ProfileId,
                'A',
                @Actor,
                SYSDATETIME()
            );

            SET @Operation = N'ASSIGN';
            SET @OperationCode = 'ASSIGN';
        END;

        IF @Operation IN (N'ASSIGN', N'REACTIVATE')
        BEGIN
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
                @OperationCode,
                @Actor
            );
        END;

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            CASE @Operation
                WHEN N'ASSIGN' THEN N'User profile assigned successfully.'
                WHEN N'REACTIVATE' THEN N'User profile reactivated successfully.'
                ELSE N'No changes applied. User already has this profile.'
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
