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

    BEGIN TRY
        BEGIN TRAN;

        IF @CompanyId IS NULL
            RAISERROR('CompanyId is required.', 16, 1);

        IF @ProfileId IS NULL
            RAISERROR('ProfileId is required.', 16, 1);

        IF @Name IS NULL OR @Name = ''
            RAISERROR('Name is required.', 16, 1);

        IF @UpdatedBy IS NULL OR @UpdatedBy = ''
            RAISERROR('UpdatedBy is required.', 16, 1);

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Company c
            WHERE c.CompanyId = @CompanyId
              AND c.Status = 'A'
        )
            RAISERROR('Company not found or inactive.', 16, 1);

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Profile p
            WHERE p.ProfileId = @ProfileId
              AND p.CompanyId = @CompanyId
              AND p.Status = 'A'
        )
            RAISERROR('Profile not found or inactive for the company.', 16, 1);

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Profile p
            WHERE p.CompanyId = @CompanyId
              AND p.Name = @Name
              AND p.ProfileId <> @ProfileId
        )
            RAISERROR('Profile name already exists for the company.', 16, 1);

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