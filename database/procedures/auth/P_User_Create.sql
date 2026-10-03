/*
Script: P_User_Create.sql
Stored Procedure: dbo.P_User_Create
Objetivo:
    Crear un usuario de aplicacion con validaciones de negocio y contrato de respuesta estandar.

Dependencias:
    - dbo.Person
    - dbo.AppUser
    - dbo.Company
    - dbo.Profile
    - dbo.UserProfile
    - dbo.UserProfileAudit
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_User_Create
(
    @CompanyId UNIQUEIDENTIFIER,
    @ProfileId UNIQUEIDENTIFIER,
    @PersonId UNIQUEIDENTIFIER = NULL,
    @PersonIdentificationType CHAR(2) = NULL,
    @PersonIdentification NVARCHAR(20) = NULL,
    @PersonFirstName NVARCHAR(200) = NULL,
    @PersonMiddleName NVARCHAR(80) = NULL,
    @PersonLastName NVARCHAR(80) = NULL,
    @PersonPhone NVARCHAR(50) = NULL,
    @Email NVARCHAR(150),
    @PasswordHash NVARCHAR(500),
    @Username NVARCHAR(80) = NULL,
    @CreatedBy NVARCHAR(80)
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @UserId UNIQUEIDENTIFIER;
    DECLARE @UserProfileId UNIQUEIDENTIFIER;
    DECLARE @ExistingPersonStatus CHAR(1);

    SET @Email = LOWER(LTRIM(RTRIM(@Email)));
    SET @PasswordHash = LTRIM(RTRIM(@PasswordHash));
    SET @Username = NULLIF(LTRIM(RTRIM(@Username)), '');
    SET @PersonIdentificationType = NULLIF(UPPER(LTRIM(RTRIM(@PersonIdentificationType))), '');
    SET @PersonIdentification = NULLIF(LTRIM(RTRIM(@PersonIdentification)), '');
    SET @PersonFirstName = NULLIF(LTRIM(RTRIM(@PersonFirstName)), '');
    SET @PersonMiddleName = NULLIF(LTRIM(RTRIM(@PersonMiddleName)), '');
    SET @PersonLastName = NULLIF(LTRIM(RTRIM(@PersonLastName)), '');
    SET @PersonPhone = NULLIF(LTRIM(RTRIM(@PersonPhone)), '');
    SET @CreatedBy = LEFT(LTRIM(RTRIM(@CreatedBy)), 80);

    IF @Email IS NULL OR @Email = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'Email is required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF @PasswordHash IS NULL OR @PasswordHash = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'PasswordHash is required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF @CreatedBy IS NULL OR @CreatedBy = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'CreatedBy is required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF @CompanyId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'CompanyId is required.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF @ProfileId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'ProfileId is required.' AS result_message,
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
        SELECT CAST(2002 AS INT) AS result_code, N'Company not found or inactive.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Profile pr
        WHERE pr.ProfileId = @ProfileId
          AND pr.CompanyId = @CompanyId
          AND pr.Status = 'A'
    )
    BEGIN
        SELECT CAST(2002 AS INT) AS result_code, N'Profile not found or inactive for company.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        WHERE u.Email = @Email
    )
    BEGIN
        SELECT CAST(4001 AS INT) AS result_code, N'Email already exists.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF @Username IS NOT NULL
       AND EXISTS
       (
           SELECT 1
           FROM dbo.AppUser u
           WHERE u.Username = @Username
       )
    BEGIN
        SELECT CAST(4001 AS INT) AS result_code, N'Username already exists.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRAN;

        IF @PersonId IS NOT NULL
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM dbo.Person p
                WHERE p.PersonId = @PersonId
                  AND p.Status = 'A'
            )
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(2002 AS INT) AS result_code, N'Person not found or inactive.' AS result_message,
                       CAST(NULL AS NVARCHAR(20)) AS operation;
                RETURN;
            END;
        END
        ELSE
        BEGIN
            IF @PersonIdentificationType IS NULL OR @PersonIdentificationType = ''
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(1001 AS INT) AS result_code, N'PersonIdentificationType is required when PersonId is null.' AS result_message,
                       CAST(NULL AS NVARCHAR(20)) AS operation;
                RETURN;
            END;

            IF @PersonIdentification IS NULL OR @PersonIdentification = ''
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(1001 AS INT) AS result_code, N'PersonIdentification is required when PersonId is null.' AS result_message,
                       CAST(NULL AS NVARCHAR(20)) AS operation;
                RETURN;
            END;

            IF NOT EXISTS
            (
                SELECT 1
                FROM dbo.IdentificationType it
                WHERE it.IdentificationTypeId = @PersonIdentificationType
            )
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(1002 AS INT) AS result_code,
                       N'PersonIdentificationType is not supported.' AS result_message,
                       CAST(NULL AS NVARCHAR(20)) AS operation;
                RETURN;
            END;

            IF NOT EXISTS
            (
                SELECT 1
                FROM dbo.IdentificationType it
                WHERE it.IdentificationTypeId = @PersonIdentificationType
                  AND it.IsActive = 1
            )
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(2002 AS INT) AS result_code,
                       N'PersonIdentificationType is inactive.' AS result_message,
                       CAST(NULL AS NVARCHAR(20)) AS operation;
                RETURN;
            END;

            IF NOT EXISTS
            (
                SELECT 1
                FROM dbo.IdentificationType it
                WHERE it.IdentificationTypeId = @PersonIdentificationType
                  AND it.AllowsNaturalPerson = 1
                  AND LEN(dbo.fn_NormalizeIdentification(@PersonIdentification)) BETWEEN it.MinLength AND it.MaxLength
                  AND (it.IsNumericOnly = 0 OR dbo.fn_NormalizeIdentification(@PersonIdentification) NOT LIKE N'%[^0-9]%')
            )
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(1001 AS INT) AS result_code, N'PersonIdentification does not satisfy its active natural-person type policy.' AS result_message,
                       CAST(NULL AS NVARCHAR(20)) AS operation;
                RETURN;
            END;

            SELECT
                @PersonId = p.PersonId,
                @ExistingPersonStatus = p.Status
            FROM dbo.PersonIdentification pi WITH (UPDLOCK, HOLDLOCK)
            INNER JOIN dbo.Person p ON p.PersonId = pi.PersonId
            WHERE pi.IdentificationTypeId = @PersonIdentificationType
              AND pi.NormalizedIdentification = dbo.fn_NormalizeIdentification(@PersonIdentification);

            IF @PersonId IS NOT NULL AND @ExistingPersonStatus <> 'A'
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(2002 AS INT) AS result_code, N'Person found but inactive.' AS result_message,
                       CAST(NULL AS NVARCHAR(20)) AS operation;
                RETURN;
            END;

            IF @PersonId IS NULL
            BEGIN
                IF @PersonFirstName IS NULL OR @PersonFirstName = ''
                BEGIN
                    ROLLBACK TRAN;
                    SELECT CAST(1001 AS INT) AS result_code, N'PersonFirstName is required when creating person.' AS result_message,
                           CAST(NULL AS NVARCHAR(20)) AS operation;
                    RETURN;
                END;

                IF @PersonLastName IS NULL OR @PersonLastName = ''
                BEGIN
                    ROLLBACK TRAN;
                    SELECT CAST(1001 AS INT) AS result_code, N'PersonLastName is required when creating person.' AS result_message,
                           CAST(NULL AS NVARCHAR(20)) AS operation;
                    RETURN;
                END;

                SET @PersonId = NEWID();

                INSERT INTO dbo.Person
                (
                    PersonId,
                    PersonKind,
                    LegalName,
                    TradeName,
                    Status,
                    CreatedBy,
                    CreatedAt
                )
                VALUES
                (
                    @PersonId,
                    'N',
                    LTRIM(RTRIM(CONCAT(@PersonFirstName, N' ', COALESCE(@PersonMiddleName + N' ', N''), @PersonLastName))),
                    NULL,
                    'A',
                    @CreatedBy,
                    SYSDATETIME()
                );

                INSERT INTO dbo.PersonIdentification
                (
                    PersonId,
                    IdentificationTypeId,
                    Identification,
                    IsPrimary
                )
                VALUES
                (
                    @PersonId,
                    @PersonIdentificationType,
                    @PersonIdentification,
                    1
                );
            END;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Profile p WITH (HOLDLOCK)
            WHERE p.ProfileId = @ProfileId
              AND p.CompanyId = @CompanyId
              AND p.Status = 'A'
        )
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(2002 AS INT) AS result_code,
                   N'Profile is inactive or unavailable for company.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        SET @UserId = NEWID();
        SET @UserProfileId = NEWID();

        INSERT INTO dbo.AppUser
        (
            UserId,
            PersonId,
            CompanyId,
            Username,
            PasswordHash,
            Email,
            IsBlocked,
            RequiresNewPassword,
            MustUpdate,
            Status,
            CreatedBy,
            CreatedAt
        )
        VALUES
        (
            @UserId,
            @PersonId,
            @CompanyId,
            @Username,
            @PasswordHash,
            @Email,
            0,
            0,
            0,
            'A',
            @CreatedBy,
            SYSDATETIME()
        );

        INSERT INTO dbo.UserProfile
        (
            UserProfileId,
            UserId,
            CompanyId,
            ProfileId,
            Status,
            CreatedBy,
            CreatedAt
        )
        VALUES
        (
            @UserProfileId,
            @UserId,
            @CompanyId,
            @ProfileId,
            'A',
            @CreatedBy,
            SYSDATETIME()
        );

        INSERT INTO dbo.UserProfileAudit
        (
            UserId,
            CompanyId,
            ProfileId,
            OperationCode,
            Actor
        )
        VALUES
        (
            @UserId,
            @CompanyId,
            @ProfileId,
            'ASSIGN',
            @CreatedBy
        );

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            N'User created successfully.' AS result_message,
            N'CREATE' AS operation;

        SELECT
            u.UserId,
            u.PersonId,
            u.CompanyId,
            @ProfileId AS ProfileId,
            @UserProfileId AS UserProfileId,
            u.Username,
            u.Email,
            u.IsBlocked,
            u.RequiresNewPassword,
            u.MustUpdate,
            u.Status,
            u.CreatedBy,
            u.CreatedAt,
            u.UpdatedBy,
            u.UpdatedAt
        FROM dbo.AppUser u
        WHERE u.UserId = @UserId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH
END;
GO
