/*
Script: P_Profile_Update.sql
Stored Procedure: dbo.P_Profile_Update
Objetivo:
    Actualizar el nombre y descripcion de un perfil activo de una empresa.

Dependencias:
    - dbo.Profile
    - dbo.Company
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Profile_Update
(
    @CompanyId UNIQUEIDENTIFIER,
    @ProfileId UNIQUEIDENTIFIER,
    @Name NVARCHAR(150),
    @Description NVARCHAR(250) = NULL,
    @UpdatedBy NVARCHAR(80)
)
AS
BEGIN
    SET NOCOUNT ON;

    SET @Name = LTRIM(RTRIM(@Name));
    SET @Description = NULLIF(LTRIM(RTRIM(@Description)), '');
    SET @UpdatedBy = LEFT(LTRIM(RTRIM(@UpdatedBy)), 80);

    IF @CompanyId IS NULL OR @ProfileId IS NULL OR @Name IS NULL OR @Name = ''
       OR @UpdatedBy IS NULL OR @UpdatedBy = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'CompanyId, ProfileId, Name and UpdatedBy are required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Company c
        WHERE c.CompanyId = @CompanyId
          AND c.Status = 'A'
    )
    BEGIN
        SELECT CAST(2002 AS INT) AS result_code,
               N'Company not found or inactive.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
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
        SELECT CAST(2001 AS INT) AS result_code,
               N'Profile not found or inactive for the company.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.Profile p
        WHERE p.CompanyId = @CompanyId
          AND p.Name = @Name
          AND p.ProfileId <> @ProfileId
    )
    BEGIN
        SELECT CAST(4001 AS INT) AS result_code,
               N'Profile name already exists for the company.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.Profile p
        WHERE p.ProfileId = @ProfileId
          AND p.CompanyId = @CompanyId
          AND p.Status = 'A'
          AND p.Name = @Name
          AND ISNULL(p.Description, N'') = ISNULL(@Description, N'')
    )
    BEGIN
        SELECT CAST(0 AS INT) AS result_code,
               N'No changes applied. Profile already has the requested values.' AS result_message,
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
            p.UpdatedAt,
            COUNT(pp.ProfilePermissionId) AS ActivePermissionCount
        FROM dbo.Profile p
        LEFT JOIN dbo.ProfilePermission pp
            ON pp.ProfileId = p.ProfileId
           AND pp.Status = 'A'
        WHERE p.ProfileId = @ProfileId
          AND p.CompanyId = @CompanyId
          AND p.Status = 'A'
        GROUP BY
            p.ProfileId,
            p.CompanyId,
            p.Name,
            p.Description,
            p.Status,
            p.CreatedBy,
            p.CreatedAt,
            p.UpdatedBy,
            p.UpdatedAt;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRAN;
        UPDATE dbo.Profile
        SET Name = @Name,
            Description = @Description,
            UpdatedBy = @UpdatedBy,
            UpdatedAt = SYSDATETIME()
        WHERE ProfileId = @ProfileId
          AND CompanyId = @CompanyId
          AND Status = 'A';

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            N'Profile updated successfully.' AS result_message,
            N'UPDATE' AS operation;

        SELECT
            p.ProfileId,
            p.CompanyId,
            p.Name,
            p.Description,
            p.Status,
            p.CreatedBy,
            p.CreatedAt,
            p.UpdatedBy,
            p.UpdatedAt,
            COUNT(pp.ProfilePermissionId) AS ActivePermissionCount
        FROM dbo.Profile p
        LEFT JOIN dbo.ProfilePermission pp
            ON pp.ProfileId = p.ProfileId
           AND pp.Status = 'A'
        WHERE p.ProfileId = @ProfileId
          AND p.CompanyId = @CompanyId
        GROUP BY
            p.ProfileId,
            p.CompanyId,
            p.Name,
            p.Description,
            p.Status,
            p.CreatedBy,
            p.CreatedAt,
            p.UpdatedBy,
            p.UpdatedAt;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH
END;
GO
