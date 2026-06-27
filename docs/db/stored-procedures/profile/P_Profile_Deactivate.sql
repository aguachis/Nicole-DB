/*
Script: P_Profile_Deactivate.sql
Stored Procedure: dbo.P_Profile_Deactivate
Objetivo:
    Inactivar logicamente un perfil de una empresa.

Dependencias:
    - dbo.Profile
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Profile_Deactivate
(
    @CompanyId UNIQUEIDENTIFIER,
    @ProfileId UNIQUEIDENTIFIER,
    @UpdatedBy NVARCHAR(80)
)
AS
BEGIN
    SET NOCOUNT ON;

    SET @UpdatedBy = LEFT(LTRIM(RTRIM(@UpdatedBy)), 80);

    BEGIN TRY
        BEGIN TRAN;

        IF @CompanyId IS NULL
            RAISERROR('CompanyId is required.', 16, 1);

        IF @ProfileId IS NULL
            RAISERROR('ProfileId is required.', 16, 1);

        IF @UpdatedBy IS NULL OR @UpdatedBy = ''
            RAISERROR('UpdatedBy is required.', 16, 1);

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Profile p
            WHERE p.ProfileId = @ProfileId
              AND p.CompanyId = @CompanyId
              AND p.Status = 'A'
        )
            RAISERROR('Profile not found or already inactive for the company.', 16, 1);

        UPDATE dbo.Profile
        SET Status = 'I',
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
            p.UpdatedAt
        FROM dbo.Profile p
        WHERE p.ProfileId = @ProfileId
          AND p.CompanyId = @CompanyId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH
END;
GO