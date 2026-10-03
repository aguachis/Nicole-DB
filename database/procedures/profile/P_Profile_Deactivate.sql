/*
Script: P_Profile_Deactivate.sql
Stored Procedure: dbo.P_Profile_Deactivate
Objetivo:
    Inactivar logicamente un perfil de una empresa.

Dependencias:
    - dbo.Profile
    - dbo.AppUser
    - dbo.UserProfile
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Profile_Deactivate
(
    @CompanyId UNIQUEIDENTIFIER,
    @ProfileId UNIQUEIDENTIFIER,
    @UpdatedBy NVARCHAR(80)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ProfileStatus CHAR(1);

    SET @UpdatedBy = LEFT(LTRIM(RTRIM(@UpdatedBy)), 80);

    IF @CompanyId IS NULL OR @ProfileId IS NULL
       OR @UpdatedBy IS NULL OR @UpdatedBy = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'CompanyId, ProfileId and UpdatedBy are required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRAN;

        SELECT @ProfileStatus = p.Status
        FROM dbo.Profile p WITH (UPDLOCK, HOLDLOCK)
        WHERE p.ProfileId = @ProfileId
          AND p.CompanyId = @CompanyId;

        IF @ProfileStatus IS NULL
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(2001 AS INT) AS result_code,
                   N'Profile not found for the company.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF @ProfileStatus = 'I'
        BEGIN
            COMMIT TRAN;
            SELECT CAST(0 AS INT) AS result_code,
                   N'Profile is already inactive.' AS result_message,
                   N'NOOP' AS operation;

            SELECT
                p.ProfileId,
                p.CompanyId,
                p.Name,
                p.Description,
                p.Status,
                p.CreatedBy,
                p.CreatedAt,
                p.UpdatedBy,
                p.UpdatedAt
            FROM dbo.Profile p
            WHERE p.ProfileId = @ProfileId
              AND p.CompanyId = @CompanyId;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.UserProfile targetAssignment WITH (UPDLOCK, HOLDLOCK)
            INNER JOIN dbo.AppUser u WITH (UPDLOCK, HOLDLOCK)
                ON u.UserId = targetAssignment.UserId
               AND u.CompanyId = targetAssignment.CompanyId
            WHERE targetAssignment.CompanyId = @CompanyId
              AND targetAssignment.ProfileId = @ProfileId
              AND targetAssignment.Status = 'A'
              AND u.Status = 'A'
              AND NOT EXISTS
              (
                  SELECT 1
                  FROM dbo.UserProfile otherAssignment WITH (UPDLOCK, HOLDLOCK)
                  INNER JOIN dbo.Profile otherProfile WITH (UPDLOCK, HOLDLOCK)
                      ON otherProfile.ProfileId = otherAssignment.ProfileId
                     AND otherProfile.CompanyId = otherAssignment.CompanyId
                  WHERE otherAssignment.UserId = targetAssignment.UserId
                    AND otherAssignment.CompanyId = targetAssignment.CompanyId
                    AND otherAssignment.ProfileId <> @ProfileId
                    AND otherAssignment.Status = 'A'
                    AND otherProfile.Status = 'A'
              )
        )
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(4002 AS INT) AS result_code,
                   N'Cannot deactivate the last active profile assigned to an active user.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        UPDATE dbo.Profile
        SET Status = 'I',
            UpdatedBy = @UpdatedBy,
            UpdatedAt = SYSDATETIME()
        WHERE ProfileId = @ProfileId
          AND CompanyId = @CompanyId
          AND Status = 'A';

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            N'Profile deactivated successfully.' AS result_message,
            N'DEACTIVATE' AS operation;

        SELECT
            p.ProfileId,
            p.CompanyId,
            p.Name,
            p.Description,
            p.Status,
            p.CreatedBy,
            p.CreatedAt,
            p.UpdatedBy,
            p.UpdatedAt
        FROM dbo.Profile p
        WHERE p.ProfileId = @ProfileId
          AND p.CompanyId = @CompanyId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH
END;
GO
