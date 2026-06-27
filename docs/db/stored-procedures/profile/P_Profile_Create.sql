/*
Script: P_Profile_Create.sql
Stored Procedure: dbo.P_Profile_Create
Objetivo:
    Crear un perfil activo dentro de una empresa.

Dependencias:
    - dbo.Company
    - dbo.Profile
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Profile_Create
(
    @CompanyId UNIQUEIDENTIFIER,
    @Name NVARCHAR(150),
    @Description NVARCHAR(250) = NULL,
    @CreatedBy NVARCHAR(80)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ProfileId UNIQUEIDENTIFIER;

    SET @Name = LTRIM(RTRIM(@Name));
    SET @Description = NULLIF(LTRIM(RTRIM(@Description)), '');
    SET @CreatedBy = LEFT(LTRIM(RTRIM(@CreatedBy)), 80);

    BEGIN TRY
        BEGIN TRAN;

        IF @CompanyId IS NULL
            RAISERROR('CompanyId is required.', 16, 1);

        IF @Name IS NULL OR @Name = ''
            RAISERROR('Name is required.', 16, 1);

        IF @CreatedBy IS NULL OR @CreatedBy = ''
            RAISERROR('CreatedBy is required.', 16, 1);

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Company c
            WHERE c.CompanyId = @CompanyId
              AND c.Status = 'A'
        )
            RAISERROR('Company not found or inactive.', 16, 1);

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Profile p
            WHERE p.CompanyId = @CompanyId
              AND p.Name = @Name
        )
            RAISERROR('Profile name already exists for the company.', 16, 1);

        SET @ProfileId = NEWID();

        INSERT INTO dbo.Profile
        (
            ProfileId,
            CompanyId,
            Name,
            Description,
            Status,
            CreatedBy,
            CreatedAt
        )
        VALUES
        (
            @ProfileId,
            @CompanyId,
            @Name,
            @Description,
            'A',
            @CreatedBy,
            SYSDATETIME()
        );

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
            CAST(0 AS INT) AS ActivePermissionCount
        FROM dbo.Profile p
        WHERE p.ProfileId = @ProfileId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH
END;
GO