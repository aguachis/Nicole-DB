/*
Script: P_ProfilePermission_ReplaceByProfile.sql
Stored Procedure: dbo.P_ProfilePermission_ReplaceByProfile
Objetivo:
    Sincronizar el set final de permisos activos de un perfil dentro de una empresa.

Reglas:
    - El perfil debe pertenecer a la empresa y estar activo
    - Los permisos deben existir y estar activos
    - Las relaciones ausentes se inactivan de forma logica
    - Las relaciones existentes inactivas se reactivan

Dependencias:
    - dbo.Profile
    - dbo.Permission
    - dbo.ProfilePermission
    - dbo.PermissionCodeListType
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_ProfilePermission_ReplaceByProfile
(
    @CompanyId UNIQUEIDENTIFIER,
    @ProfileId UNIQUEIDENTIFIER,
    @PermissionCodes dbo.PermissionCodeListType READONLY,
    @UpdatedBy NVARCHAR(80)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NormalizedPermissionCodes TABLE
    (
        Code NVARCHAR(150) NOT NULL PRIMARY KEY
    );
    DECLARE @ChangedRows INT = 0;

    SET @UpdatedBy = LEFT(LTRIM(RTRIM(@UpdatedBy)), 80);

    IF @CompanyId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'CompanyId is required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF @ProfileId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'ProfileId is required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF @UpdatedBy IS NULL OR @UpdatedBy = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'UpdatedBy is required.' AS result_message,
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
        FROM @PermissionCodes pc
        WHERE NULLIF(LTRIM(RTRIM(pc.Code)), '') IS NULL
    )
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'PermissionCodes contains empty values.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    INSERT INTO @NormalizedPermissionCodes (Code)
    SELECT DISTINCT LTRIM(RTRIM(pc.Code))
    FROM @PermissionCodes pc;

    IF EXISTS
    (
        SELECT 1
        FROM @NormalizedPermissionCodes npc
        LEFT JOIN dbo.Permission pm
            ON pm.Code = npc.Code
           AND pm.Status = 'A'
        WHERE pm.PermissionId IS NULL
    )
    BEGIN
        SELECT CAST(4003 AS INT) AS result_code,
               N'One or more permission codes are invalid or inactive.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRAN;

        UPDATE pp
        SET pp.Status = 'A',
            pp.UpdatedBy = @UpdatedBy,
            pp.UpdatedAt = SYSDATETIME()
        FROM dbo.ProfilePermission pp
        INNER JOIN dbo.Permission pm
            ON pm.PermissionId = pp.PermissionId
           AND pm.Status = 'A'
        INNER JOIN @NormalizedPermissionCodes npc
            ON npc.Code = pm.Code
        WHERE pp.ProfileId = @ProfileId
          AND pp.Status = 'I';
        SET @ChangedRows += @@ROWCOUNT;

        UPDATE pp
        SET pp.Status = 'I',
            pp.UpdatedBy = @UpdatedBy,
            pp.UpdatedAt = SYSDATETIME()
        FROM dbo.ProfilePermission pp
        INNER JOIN dbo.Permission pm
            ON pm.PermissionId = pp.PermissionId
        LEFT JOIN @NormalizedPermissionCodes npc
            ON npc.Code = pm.Code
        WHERE pp.ProfileId = @ProfileId
          AND pp.Status = 'A'
          AND npc.Code IS NULL;
        SET @ChangedRows += @@ROWCOUNT;

        INSERT INTO dbo.ProfilePermission
        (
            ProfilePermissionId,
            ProfileId,
            PermissionId,
            Status,
            CreatedBy,
            CreatedAt
        )
        SELECT
            NEWID(),
            @ProfileId,
            pm.PermissionId,
            'A',
            @UpdatedBy,
            SYSDATETIME()
        FROM @NormalizedPermissionCodes npc
        INNER JOIN dbo.Permission pm
            ON pm.Code = npc.Code
           AND pm.Status = 'A'
        LEFT JOIN dbo.ProfilePermission pp
            ON pp.ProfileId = @ProfileId
           AND pp.PermissionId = pm.PermissionId
        WHERE pp.ProfilePermissionId IS NULL;
        SET @ChangedRows += @@ROWCOUNT;

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            N'Profile permissions synchronized successfully.' AS result_message,
            CASE WHEN @ChangedRows = 0 THEN N'NOOP' ELSE N'REPLACE' END AS operation;

        SELECT
            p.ProfileId,
            p.CompanyId,
            p.Name,
            p.Description,
            p.Status,
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
            p.Status;

        SELECT
            pm.PermissionId,
            pm.Code,
            pm.Name,
            pm.Description,
            pm.ModuleCode
        FROM dbo.ProfilePermission pp
        INNER JOIN dbo.Permission pm
            ON pm.PermissionId = pp.PermissionId
        WHERE pp.ProfileId = @ProfileId
          AND pp.Status = 'A'
          AND pm.Status = 'A'
        ORDER BY pm.ModuleCode, pm.Name, pm.Code;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH
END;
GO
