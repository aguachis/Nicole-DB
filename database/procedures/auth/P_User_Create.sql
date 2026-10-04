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
    @PersonIdentificationTypeCode VARCHAR(32) = NULL,
    @PersonIdentification NVARCHAR(20) = NULL,
    @PersonFirstName NVARCHAR(200) = NULL,
    @PersonMiddleName NVARCHAR(80) = NULL,
    @PersonLastName NVARCHAR(80) = NULL,
    @PersonPhone NVARCHAR(50) = NULL,
    @Email NVARCHAR(150),
    @PasswordHash NVARCHAR(500),
    @Username NVARCHAR(80) = NULL,
    @CreatedBy NVARCHAR(80),
    @ActorUserId UNIQUEIDENTIFIER = NULL,
    @ActorProfileId UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @UserId UNIQUEIDENTIFIER;
    DECLARE @UserProfileId UNIQUEIDENTIFIER;
    DECLARE @ExistingPersonStatus CHAR(1);
    DECLARE @ValidatedPersonIdentificationTypeId CHAR(2);
    DECLARE @NormalizedPersonIdentification NVARCHAR(64);
    DECLARE @IdentificationResultCode INT;
    DECLARE @IdentificationResultMessage NVARCHAR(250);

    SET @Email = LOWER(LTRIM(RTRIM(@Email)));
    SET @PasswordHash = LTRIM(RTRIM(@PasswordHash));
    SET @Username = NULLIF(LTRIM(RTRIM(@Username)), '');
    SET @PersonIdentificationTypeCode = NULLIF(UPPER(LTRIM(RTRIM(@PersonIdentificationTypeCode))), '');
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

    IF @ActorUserId IS NULL OR @ActorProfileId IS NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'ActorUserId and ActorProfileId are required.' AS result_message,
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
        FROM dbo.AppUser u
        WHERE u.UserId = @ActorUserId
          AND u.CompanyId = @CompanyId
          AND u.Status = 'A'
          AND u.IsBlocked = 0
    )
    BEGIN
        SELECT CAST(2001 AS INT) AS result_code,
               N'Actor is not valid for this company.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
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
               N'Actor profile is not active for this session.' AS result_message,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF dbo.fn_HasEffectivePermission(@ActorUserId, @CompanyId, @ActorProfileId, N'user.create') = 0
    BEGIN
        SELECT CAST(403 AS INT) AS result_code,
               N'Permission denied: user.create is required.' AS result_message,
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

            IF @PersonFirstName IS NOT NULL OR @PersonMiddleName IS NOT NULL OR @PersonLastName IS NOT NULL OR @PersonPhone IS NOT NULL
            BEGIN
                UPDATE dbo.Person
                SET
                    FirstName = CASE WHEN @PersonFirstName IS NOT NULL THEN @PersonFirstName ELSE FirstName END,
                    MiddleName = CASE WHEN @PersonMiddleName IS NOT NULL THEN @PersonMiddleName ELSE MiddleName END,
                    LastName = CASE WHEN @PersonLastName IS NOT NULL THEN @PersonLastName ELSE LastName END,
                    Phone = CASE WHEN @PersonPhone IS NOT NULL THEN @PersonPhone ELSE Phone END,
                    LegalName = LTRIM(RTRIM(
                        CONCAT(
                            COALESCE(CASE WHEN @PersonFirstName IS NOT NULL THEN @PersonFirstName ELSE FirstName END, N''),
                            N' ',
                            COALESCE(CASE WHEN @PersonMiddleName IS NOT NULL THEN @PersonMiddleName ELSE MiddleName END + N' ', N''),
                            COALESCE(CASE WHEN @PersonLastName IS NOT NULL THEN @PersonLastName ELSE LastName END, N'')
                        )
                    )),
                    UpdatedBy = @CreatedBy,
                    UpdatedAt = SYSDATETIME()
                WHERE PersonId = @PersonId;
            END;
        END
        ELSE
        BEGIN
            IF @PersonIdentification IS NULL OR @PersonIdentification = ''
            BEGIN
                ROLLBACK TRAN;
                SELECT CAST(1001 AS INT) AS result_code, N'PersonIdentification is required when PersonId is null.' AS result_message,
                       CAST(NULL AS NVARCHAR(20)) AS operation;
                RETURN;
            END;

            EXEC dbo.P_Identification_ValidateInput
                @IdentificationTypeCode = @PersonIdentificationTypeCode,
                @Identification = @PersonIdentification,
                @PersonKind = 'N',
                @IdentificationTypeId = @ValidatedPersonIdentificationTypeId OUTPUT,
                @NormalizedIdentification = @NormalizedPersonIdentification OUTPUT,
                @ResultCode = @IdentificationResultCode OUTPUT,
                @ResultMessage = @IdentificationResultMessage OUTPUT;

            IF @IdentificationResultCode <> 0
            BEGIN
                ROLLBACK TRAN;
                SELECT @IdentificationResultCode AS result_code, @IdentificationResultMessage AS result_message,
                       CAST(NULL AS NVARCHAR(20)) AS operation;
                RETURN;
            END;

            SELECT
                @PersonId = p.PersonId,
                @ExistingPersonStatus = p.Status
            FROM dbo.PersonIdentification pi WITH (UPDLOCK, HOLDLOCK)
            INNER JOIN dbo.Person p ON p.PersonId = pi.PersonId
            WHERE pi.IdentificationTypeId = @ValidatedPersonIdentificationTypeId
              AND pi.NormalizedIdentification = @NormalizedPersonIdentification;

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
                    FirstName,
                    MiddleName,
                    LastName,
                    LegalName,
                    TradeName,
                    Phone,
                    Status,
                    CreatedBy,
                    CreatedAt
                )
                VALUES
                (
                    @PersonId,
                    'N',
                    @PersonFirstName,
                    @PersonMiddleName,
                    @PersonLastName,
                    LTRIM(RTRIM(CONCAT(@PersonFirstName, N' ', COALESCE(@PersonMiddleName + N' ', N''), @PersonLastName))),
                    NULL,
                    @PersonPhone,
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
                    @ValidatedPersonIdentificationTypeId,
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
