/*
Script: P_UserCompanyProfile_Revoke.sql
Stored Procedure: dbo.P_UserCompanyProfile_Revoke
Objetivo:
    Revocar un perfil de usuario por empresa con comportamiento idempotente.

Dependencias:
    - dbo.UserCompany
    - dbo.UserCompanyProfile
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_UserCompanyProfile_Revoke
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
    DECLARE @UserCompanyProfileId UNIQUEIDENTIFIER;
    DECLARE @CurrentStatus CHAR(1);

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

    SELECT
        @UserCompanyProfileId = ucp.UserCompanyProfileId,
        @CurrentStatus = ucp.Status
    FROM dbo.UserCompanyProfile ucp
    WHERE ucp.UserCompanyId = @UserCompanyId
      AND ucp.CompanyId = @CompanyId
      AND ucp.ProfileId = @ProfileId;

    IF @UserCompanyProfileId IS NULL
    BEGIN
        SELECT
            CAST(0 AS INT) AS result_code,
            N'No changes applied. Profile was not assigned.' AS result_message,
            N'NOOP' AS operation;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRAN;

        IF @CurrentStatus = 'A'
        BEGIN
            UPDATE dbo.UserCompanyProfile
            SET Status = 'I',
                UpdatedBy = @Actor,
                UpdatedAt = SYSDATETIME()
            WHERE UserCompanyProfileId = @UserCompanyProfileId;
        END;

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            CASE WHEN @CurrentStatus = 'A'
                THEN N'Profile assignment revoked successfully.'
                ELSE N'No changes applied. Profile assignment was already inactive.'
            END AS result_message,
            CASE WHEN @CurrentStatus = 'A' THEN N'REVOKE' ELSE N'NOOP' END AS operation,
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
        WHERE ucp.UserCompanyProfileId = @UserCompanyProfileId;
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
