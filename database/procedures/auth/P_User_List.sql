/*
Script: P_User_List.sql
Stored Procedure: dbo.P_User_List
Objetivo:
    Consultar usuarios con filtros operativos y salida tabular estandar.

Dependencias:
    - dbo.AppUser
    - dbo.Person
    - dbo.Company
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_User_List
(
    @CompanyId UNIQUEIDENTIFIER,
    @Status CHAR(1) = NULL,
    @Search NVARCHAR(150) = NULL,
    @ActorUserId UNIQUEIDENTIFIER = NULL,
    @ActorProfileId UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    SET @Status = NULLIF(UPPER(LTRIM(RTRIM(@Status))), '');
    SET @Search = NULLIF(LTRIM(RTRIM(@Search)), '');

    IF @CompanyId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'CompanyId is required.' AS result_message;
        RETURN;
    END;

    IF @ActorUserId IS NULL OR @ActorProfileId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'ActorUserId and ActorProfileId are required.' AS result_message;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        WHERE u.UserId = @ActorUserId
          AND u.CompanyId = @CompanyId
          AND u.Status = 'A'
          AND u.IsBlocked = 0
    )
    BEGIN
        SELECT CAST(2001 AS INT) AS result_code,
               N'Actor is not valid for this company.' AS result_message;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.UserProfile up
        WHERE up.UserId = @ActorUserId
          AND up.CompanyId = @CompanyId
          AND up.ProfileId = @ActorProfileId
          AND up.Status = 'A'
    )
    BEGIN
        SELECT CAST(3001 AS INT) AS result_code,
               N'Actor profile is not active for this session.' AS result_message;
        RETURN;
    END;

    IF dbo.fn_HasEffectivePermission(@ActorUserId, @CompanyId, @ActorProfileId, N'user.read') = 0
    BEGIN
        SELECT CAST(403 AS INT) AS result_code,
               N'Permission denied: user.read is required.' AS result_message;
        RETURN;
    END;

    IF @Status IS NOT NULL AND @Status NOT IN ('A', 'I')
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'Status must be A or I when provided.' AS result_message;
        RETURN;
    END;

    SELECT
        CAST(0 AS INT) AS result_code,
        N'Query executed successfully.' AS result_message;

    SELECT
        u.UserId,
        u.PersonId,
        u.CompanyId,
        u.Username,
        u.Email,
        u.IsBlocked,
        u.RequiresNewPassword,
        u.MustUpdate,
        u.Status,
        u.CreatedAt,
        u.UpdatedAt,
        pi.IdentificationTypeId AS IdentificationType,
        pi.Identification,
        p.FirstName,
        p.LastName,
        p.MiddleName,
        p.Phone,
        p.LastName AS lastName,
        p.MiddleName AS middleName,
        p.FirstName AS firstName,
        pi.Identification AS identification,
        p.Phone AS phone,
        p.PersonKind,
        p.LegalName,
        p.TradeName,
        pi.IdentificationTypeCode
    FROM dbo.AppUser u
    INNER JOIN dbo.Person p
        ON p.PersonId = u.PersonId
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
      AND u.CompanyId = @CompanyId
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
