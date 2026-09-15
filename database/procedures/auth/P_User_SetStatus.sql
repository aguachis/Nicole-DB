/*
Script: P_User_SetStatus.sql
Stored Procedure: dbo.P_User_SetStatus
Objetivo:
    Activar o inactivar un usuario de forma idempotente.

Dependencias:
    - dbo.AppUser
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_User_SetStatus
(
    @UserId UNIQUEIDENTIFIER,
    @Status CHAR(1),
    @UpdatedBy NVARCHAR(80)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentStatus CHAR(1);

    SET @Status = UPPER(LTRIM(RTRIM(@Status)));
    SET @UpdatedBy = LEFT(LTRIM(RTRIM(@UpdatedBy)), 80);

    IF @UserId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'UserId is required.' AS result_message;
        RETURN;
    END;

    IF @Status NOT IN ('A', 'I')
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'Status must be A or I.' AS result_message;
        RETURN;
    END;

    IF @UpdatedBy IS NULL OR @UpdatedBy = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'UpdatedBy is required.' AS result_message;
        RETURN;
    END;

    SELECT @CurrentStatus = u.Status
    FROM dbo.AppUser u
    WHERE u.UserId = @UserId;

    IF @CurrentStatus IS NULL
    BEGIN
        SELECT CAST(2001 AS INT) AS result_code, N'User not found.' AS result_message;
        RETURN;
    END;

    IF @CurrentStatus = @Status
    BEGIN
        SELECT
            CAST(0 AS INT) AS result_code,
            N'No changes applied. User is already in target status.' AS result_message,
            u.UserId,
            u.PersonId,
            u.Username,
            u.Email,
            u.IsBlocked,
            u.RequiresNewPassword,
            u.MustUpdate,
            u.Status,
            u.CreatedBy,
            u.CreatedAt,
            u.UpdatedBy,
            u.UpdatedAt
        FROM dbo.AppUser u
        WHERE u.UserId = @UserId;

        RETURN;
    END;

    BEGIN TRY
        BEGIN TRAN;

        UPDATE dbo.AppUser
        SET Status = @Status,
            UpdatedBy = @UpdatedBy,
            UpdatedAt = SYSDATETIME()
        WHERE UserId = @UserId;

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            N'User status updated successfully.' AS result_message,
            u.UserId,
            u.PersonId,
            u.Username,
            u.Email,
            u.IsBlocked,
            u.RequiresNewPassword,
            u.MustUpdate,
            u.Status,
            u.CreatedBy,
            u.CreatedAt,
            u.UpdatedBy,
            u.UpdatedAt
        FROM dbo.AppUser u
        WHERE u.UserId = @UserId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        SELECT
            CAST(-5000 AS INT) AS result_code,
            ERROR_MESSAGE() AS result_message;
    END CATCH
END;
GO
