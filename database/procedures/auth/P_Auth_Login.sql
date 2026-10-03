/*
Script: P_Auth_Login.sql
Stored Procedure: dbo.P_Auth_Login
Objetivo:
    Consultar los datos necesarios para que el backend valide el login por email.

Reglas:
    - El login oficial es Email
    - El backend debe comparar la clave plana contra PasswordHash usando su verificador seguro
    - Devuelve UserExists = 0 cuando no existe, el usuario esta inactivo o bloqueado

Dependencias:
    - dbo.AppUser
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Auth_Login
(
    @Email NVARCHAR(150)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserId UNIQUEIDENTIFIER;
    DECLARE @StoredPasswordHash NVARCHAR(500);

    SET @Email = LOWER(LTRIM(RTRIM(@Email)));

    IF @Email IS NULL
        OR @Email = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'Email is required.' AS result_message;
        RETURN;
    END;

    SELECT
        CAST(0 AS INT) AS result_code,
        N'Login lookup completed.' AS result_message;

    SELECT
        @UserId = u.UserId,
        @StoredPasswordHash = u.PasswordHash
    FROM dbo.AppUser u
    WHERE u.Email = @Email
      AND u.Status = 'A'
      AND u.IsBlocked = 0;

    SELECT
        CAST(CASE WHEN @UserId IS NULL THEN 0 ELSE 1 END AS BIT) AS UserExists,
        @UserId AS UserId,
        @StoredPasswordHash AS PasswordHash;
END;
GO
