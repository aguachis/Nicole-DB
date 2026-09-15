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
        pi.IdentificationTypeId AS IdentificationType,
        pi.Identification,
        p.LegalName AS FirstName,
        CAST(NULL AS NVARCHAR(80)) AS LastName,
        CAST(NULL AS NVARCHAR(80)) AS MiddleName,
        CAST(NULL AS NVARCHAR(50)) AS Phone,
        CAST(NULL AS NVARCHAR(80)) AS lastName,
        CAST(NULL AS NVARCHAR(80)) AS middleName,
        p.LegalName AS firstName,
        pi.Identification AS identification,
        CAST(NULL AS NVARCHAR(50)) AS phone,
        p.PersonKind,
        p.LegalName,
        p.TradeName,
        pi.IdentificationTypeCode
    FROM dbo.AppUser u
    INNER JOIN dbo.Person p
        ON p.PersonId = u.PersonId
    LEFT JOIN dbo.UserCompany uc
        ON uc.UserId = u.UserId
       AND uc.Status = 'A'
    OUTER APPLY
    (
        SELECT TOP (1)
            pi.PersonIdentificationId,
            pi.IdentificationTypeId,
            pi.Identification,
            it.Code AS IdentificationTypeCode
        FROM dbo.PersonIdentification pi
        INNER JOIN dbo.IdentificationType it
            ON it.IdentificationTypeId = pi.IdentificationTypeId
        WHERE pi.PersonId = p.PersonId
        ORDER BY CASE WHEN pi.IsPrimary = 1 THEN 0 ELSE 1 END, pi.PersonIdentificationId
    ) pi
    WHERE (@Status IS NULL OR u.Status = @Status)
      AND (@CompanyId IS NULL OR uc.CompanyId = @CompanyId)
      AND (
            @Search IS NULL
            OR u.Email LIKE '%' + @Search + '%'
            OR u.Username LIKE '%' + @Search + '%'
            OR pi.Identification LIKE '%' + @Search + '%'
            OR p.LegalName LIKE '%' + @Search + '%'
            OR p.TradeName LIKE '%' + @Search + '%'
      )
    ORDER BY u.CreatedAt DESC;
END;
GO
