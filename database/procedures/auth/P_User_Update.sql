/*
Script: P_User_Update.sql
Stored Procedure: dbo.P_User_Update
Objetivo:
    Actualizar datos de un usuario de aplicacion activo.

Dependencias:
    - dbo.AppUser
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_User_Update
(
    @UserId UNIQUEIDENTIFIER,
    @Email NVARCHAR(150),
    @Username NVARCHAR(80) = NULL,
    @IsBlocked BIT = NULL,
    @RequiresNewPassword BIT = NULL,
    @MustUpdate BIT = NULL,
    @UpdatedBy NVARCHAR(80)
)
AS
BEGIN
    SET NOCOUNT ON;

    SET @Email = LOWER(LTRIM(RTRIM(@Email)));
    SET @Username = NULLIF(LTRIM(RTRIM(@Username)), '');
    SET @UpdatedBy = LEFT(LTRIM(RTRIM(@UpdatedBy)), 80);

    IF @UserId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'UserId is required.' AS result_message;
        RETURN;
    END;

    IF @Email IS NULL OR @Email = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'Email is required.' AS result_message;
        RETURN;
    END;

    IF @UpdatedBy IS NULL OR @UpdatedBy = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'UpdatedBy is required.' AS result_message;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        WHERE u.UserId = @UserId
    )
    BEGIN
        SELECT CAST(2001 AS INT) AS result_code, N'User not found.' AS result_message;
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
        SELECT CAST(2002 AS INT) AS result_code, N'User is not active.' AS result_message;
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        WHERE u.Email = @Email
          AND u.UserId <> @UserId
    )
    BEGIN
        SELECT CAST(2005 AS INT) AS result_code, N'Email already exists.' AS result_message;
        RETURN;
    END;

    IF @Username IS NOT NULL
       AND EXISTS
       (
           SELECT 1
           FROM dbo.AppUser u
           WHERE u.Username = @Username
             AND u.UserId <> @UserId
       )
    BEGIN
        SELECT CAST(2003 AS INT) AS result_code, N'Username already exists.' AS result_message;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRAN;

        UPDATE dbo.AppUser
        SET Email = @Email,
            Username = @Username,
            IsBlocked = ISNULL(@IsBlocked, IsBlocked),
            RequiresNewPassword = ISNULL(@RequiresNewPassword, RequiresNewPassword),
            MustUpdate = ISNULL(@MustUpdate, MustUpdate),
            UpdatedBy = @UpdatedBy,
            UpdatedAt = SYSDATETIME()
        WHERE UserId = @UserId
          AND Status = 'A';

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            N'User updated successfully.' AS result_message,
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
