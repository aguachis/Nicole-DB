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

    IF @CompanyId IS NULL OR @Name IS NULL OR @Name = ''
       OR @CreatedBy IS NULL OR @CreatedBy = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'CompanyId, Name and CreatedBy are required.' AS result_message,
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

    IF EXISTS
    (
        SELECT 1
        FROM dbo.Profile p
        WHERE p.CompanyId = @CompanyId
          AND p.Name = @Name
    )
    BEGIN
        SELECT CAST(4001 AS INT) AS result_code,
               N'Profile name already exists for the company.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRAN;
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
            CAST(0 AS INT) AS result_code,
            N'Profile created successfully.' AS result_message,
            N'CREATE' AS operation;

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
