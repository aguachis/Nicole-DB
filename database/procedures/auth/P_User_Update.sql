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
        SELECT CAST(1001 AS INT) AS result_code, N'UserId is required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF @Email IS NULL OR @Email = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'Email is required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF @UpdatedBy IS NULL OR @UpdatedBy = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'UpdatedBy is required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        WHERE u.UserId = @UserId
    )
    BEGIN
        SELECT CAST(2001 AS INT) AS result_code, N'User not found.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
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
        SELECT CAST(2002 AS INT) AS result_code, N'User is not active.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
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
        SELECT CAST(4001 AS INT) AS result_code, N'Email already exists.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
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
        SELECT CAST(4001 AS INT) AS result_code, N'Username already exists.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        WHERE u.UserId = @UserId
          AND u.Status = 'A'
          AND u.Email = @Email
          AND ISNULL(u.Username, N'') = ISNULL(@Username, N'')
          AND u.IsBlocked = ISNULL(@IsBlocked, u.IsBlocked)
          AND u.RequiresNewPassword = ISNULL(@RequiresNewPassword, u.RequiresNewPassword)
          AND u.MustUpdate = ISNULL(@MustUpdate, u.MustUpdate)
    )
    BEGIN
        SELECT CAST(0 AS INT) AS result_code,
               N'No changes applied. User already has the requested values.' AS result_message,
               N'NOOP' AS operation;

        SELECT
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
            N'UPDATE' AS operation;

        SELECT
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

        THROW;
    END CATCH
END;
GO
