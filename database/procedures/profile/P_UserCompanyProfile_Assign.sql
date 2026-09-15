/*
Script: P_UserCompanyProfile_Assign.sql
Stored Procedure: dbo.P_UserCompanyProfile_Assign
Objetivo:
    Asignar un perfil a un usuario dentro de una empresa con comportamiento idempotente.

Dependencias:
    - dbo.AppUser
    - dbo.Profile
    - dbo.UserCompany
    - dbo.UserCompanyProfile
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_UserCompanyProfile_Assign
(
    @CompanyId UNIQUEIDENTIFIER,
    @UserId UNIQUEIDENTIFIER,
    @ProfileId UNIQUEIDENTIFIER,
    @Actor NVARCHAR(80)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserCompanyId UNIQUEIDENTIFIER;
    DECLARE @ExistingUserCompanyProfileId UNIQUEIDENTIFIER;
    DECLARE @ExistingStatus CHAR(1);
    DECLARE @Operation NVARCHAR(20);

    SET @Actor = LEFT(LTRIM(RTRIM(@Actor)), 80);

    IF @CompanyId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'CompanyId is required.' AS result_message;
        RETURN;
    END;

    IF @UserId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'UserId is required.' AS result_message;
        RETURN;
    END;

    IF @ProfileId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'ProfileId is required.' AS result_message;
        RETURN;
    END;

    IF @Actor IS NULL OR @Actor = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'Actor is required.' AS result_message;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        WHERE u.UserId = @UserId
          AND u.Status = 'A'
    )
    BEGIN
        SELECT CAST(2001 AS INT) AS result_code, N'User not found or inactive.' AS result_message;
        RETURN;
    END;

    SELECT @UserCompanyId = uc.UserCompanyId
    FROM dbo.UserCompany uc
    WHERE uc.UserId = @UserId
      AND uc.CompanyId = @CompanyId
      AND uc.Status = 'A';

    IF @UserCompanyId IS NULL
    BEGIN
        SELECT CAST(2101 AS INT) AS result_code, N'User does not belong to active company context.' AS result_message;
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
        SELECT CAST(2102 AS INT) AS result_code, N'Profile not found or inactive for company.' AS result_message;
        RETURN;
    END;

    SELECT
        @ExistingUserCompanyProfileId = ucp.UserCompanyProfileId,
        @ExistingStatus = ucp.Status
    FROM dbo.UserCompanyProfile ucp
    WHERE ucp.UserCompanyId = @UserCompanyId
      AND ucp.ProfileId = @ProfileId;

    BEGIN TRY
        BEGIN TRAN;

        IF @ExistingUserCompanyProfileId IS NULL
        BEGIN
            SET @ExistingUserCompanyProfileId = NEWID();
            SET @Operation = N'INSERT';

            INSERT INTO dbo.UserCompanyProfile
            (
                UserCompanyProfileId,
                UserCompanyId,
                CompanyId,
                ProfileId,
                Status,
                CreatedBy,
                CreatedAt
            )
            VALUES
            (
                @ExistingUserCompanyProfileId,
                @UserCompanyId,
                @CompanyId,
                @ProfileId,
                'A',
                @Actor,
                SYSDATETIME()
            );
        END
        ELSE IF @ExistingStatus = 'I'
        BEGIN
            SET @Operation = N'REACTIVATE';

            UPDATE dbo.UserCompanyProfile
            SET Status = 'A',
                UpdatedBy = @Actor,
                UpdatedAt = SYSDATETIME()
            WHERE UserCompanyProfileId = @ExistingUserCompanyProfileId;
        END
        ELSE
        BEGIN
            SET @Operation = N'NOOP';
        END;

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            CASE @Operation
                WHEN N'INSERT' THEN N'Profile assigned successfully.'
                WHEN N'REACTIVATE' THEN N'Profile assignment reactivated successfully.'
                ELSE N'No changes applied. Profile was already assigned.'
            END AS result_message,
            @Operation AS operation,
            ucp.UserCompanyProfileId,
            ucp.UserCompanyId,
            ucp.CompanyId,
            ucp.ProfileId,
            ucp.Status,
            ucp.CreatedBy,
            ucp.CreatedAt,
            ucp.UpdatedBy,
            ucp.UpdatedAt
        FROM dbo.UserCompanyProfile ucp
        WHERE ucp.UserCompanyProfileId = @ExistingUserCompanyProfileId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        SELECT
            CAST(-5000 AS INT) AS result_code,
            ERROR_MESSAGE() AS result_message,
            N'ERROR' AS operation;
    END CATCH
END;
GO
