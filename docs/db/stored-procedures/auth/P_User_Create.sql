/*
Script: P_User_Create.sql
Stored Procedure: dbo.P_User_Create
Objetivo:
    Crear un usuario de aplicacion con validaciones de negocio y contrato de respuesta estandar.

Dependencias:
    - dbo.Person
    - dbo.AppUser
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_User_Create
(
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

    DECLARE @UserId UNIQUEIDENTIFIER;
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
        SELECT CAST(1001 AS INT) AS result_code, N'Email is required.' AS result_message;
        RETURN;
    END;

    IF @PasswordHash IS NULL OR @PasswordHash = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'PasswordHash is required.' AS result_message;
        RETURN;
    END;

    IF @CreatedBy IS NULL OR @CreatedBy = ''
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code, N'CreatedBy is required.' AS result_message;
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        WHERE u.Email = @Email
    )
    BEGIN
        SELECT CAST(2005 AS INT) AS result_code, N'Email already exists.' AS result_message;
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
        SELECT CAST(2003 AS INT) AS result_code, N'Username already exists.' AS result_message;
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
                SELECT CAST(2004 AS INT) AS result_code, N'Person not found or inactive.' AS result_message;
                RETURN;
            END;
        END
        ELSE
        BEGIN
            IF @PersonIdentificationType IS NULL OR @PersonIdentificationType = ''
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(1001 AS INT) AS result_code, N'PersonIdentificationType is required when PersonId is null.' AS result_message;
                RETURN;
            END;

            IF @PersonIdentification IS NULL OR @PersonIdentification = ''
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(1001 AS INT) AS result_code, N'PersonIdentification is required when PersonId is null.' AS result_message;
                RETURN;
            END;

            SELECT
                @PersonId = p.PersonId,
                @ExistingPersonStatus = p.Status
            FROM dbo.Person p
            WHERE p.IdentificationType = @PersonIdentificationType
              AND p.Identification = @PersonIdentification;

            IF @PersonId IS NOT NULL AND @ExistingPersonStatus <> 'A'
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(2004 AS INT) AS result_code, N'Person found but inactive.' AS result_message;
                RETURN;
            END;

            IF @PersonId IS NULL
            BEGIN
                IF @PersonFirstName IS NULL OR @PersonFirstName = ''
                BEGIN
                    ROLLBACK TRAN;
                    SELECT CAST(1001 AS INT) AS result_code, N'PersonFirstName is required when creating person.' AS result_message;
                    RETURN;
                END;

                IF @PersonLastName IS NULL OR @PersonLastName = ''
                BEGIN
                    ROLLBACK TRAN;
                    SELECT CAST(1001 AS INT) AS result_code, N'PersonLastName is required when creating person.' AS result_message;
                    RETURN;
                END;

                SET @PersonId = NEWID();

                INSERT INTO dbo.Person
                (
                    PersonId,
                    IdentificationType,
                    Identification,
                    PersonType,
                    LastName,
                    MiddleName,
                    FirstName,
                    Phone,
                    Email,
                    Status,
                    CreatedBy,
                    CreatedAt
                )
                VALUES
                (
                    @PersonId,
                    @PersonIdentificationType,
                    @PersonIdentification,
                    'N',
                    @PersonLastName,
                    @PersonMiddleName,
                    @PersonFirstName,
                    @PersonPhone,
                    @Email,
                    'A',
                    @CreatedBy,
                    SYSDATETIME()
                );
            END;
        END;

        SET @UserId = NEWID();

        INSERT INTO dbo.AppUser
        (
            UserId,
            PersonId,
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

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            N'User created successfully.' AS result_message,
            u.UserId,
            u.PersonId,
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

        SELECT
            CAST(-5000 AS INT) AS result_code,
            ERROR_MESSAGE() AS result_message;
    END CATCH
END;
GO
