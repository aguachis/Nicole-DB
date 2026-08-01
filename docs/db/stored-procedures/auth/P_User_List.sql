/*
Script: P_User_List.sql
Stored Procedure: dbo.P_User_List
Objetivo:
    Consultar usuarios con filtros operativos y salida tabular estandar.

Dependencias:
    - dbo.AppUser
    - dbo.Person
    - dbo.UserCompany
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_User_List
(
    @CompanyId UNIQUEIDENTIFIER = NULL,
    @Status CHAR(1) = NULL,
    @Search NVARCHAR(150) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    SET @Status = NULLIF(UPPER(LTRIM(RTRIM(@Status))), '');
    SET @Search = NULLIF(LTRIM(RTRIM(@Search)), '');

    IF @Status IS NOT NULL AND @Status NOT IN ('A', 'I')
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'Status must be A or I when provided.' AS result_message;
        RETURN;
    END;

    SELECT
        CAST(0 AS INT) AS result_code,
        N'Query executed successfully.' AS result_message,
        u.UserId,
        u.PersonId,
        u.Username,
        u.Email,
        u.IsBlocked,
        u.RequiresNewPassword,
        u.MustUpdate,
        u.Status,
        u.CreatedAt,
        u.UpdatedAt,
        uc.CompanyId,
        p.IdentificationType,
        p.Identification,
        p.FirstName,
        p.LastName,
        p.MiddleName,
        p.Phone,
        p.LastName AS lastName,
        p.MiddleName AS middleName,
        p.FirstName AS firstName,
        p.Identification AS identification,
        p.Phone AS phone
    FROM dbo.AppUser u
    INNER JOIN dbo.Person p
        ON p.PersonId = u.PersonId
    LEFT JOIN dbo.UserCompany uc
        ON uc.UserId = u.UserId
       AND uc.Status = 'A'
    WHERE (@Status IS NULL OR u.Status = @Status)
      AND (@CompanyId IS NULL OR uc.CompanyId = @CompanyId)
      AND (
            @Search IS NULL
            OR u.Email LIKE '%' + @Search + '%'
            OR u.Username LIKE '%' + @Search + '%'
            OR p.Identification LIKE '%' + @Search + '%'
            OR p.FirstName LIKE '%' + @Search + '%'
            OR p.LastName LIKE '%' + @Search + '%'
      )
    ORDER BY u.CreatedAt DESC;
END;
GO
