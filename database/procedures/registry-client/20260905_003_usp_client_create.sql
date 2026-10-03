SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Client_Create
    @UserId UNIQUEIDENTIFIER,
    @CompanyId UNIQUEIDENTIFIER,
    @ProfileId UNIQUEIDENTIFIER,
    @PersonId UNIQUEIDENTIFIER,
    @DefaultBillingIdentificationId BIGINT = NULL,
    @BillingAddress NVARCHAR(500) = NULL,
    @Phone NVARCHAR(50) = NULL,
    @Email NVARCHAR(254) = NULL,
    @CreditLimit DECIMAL(18,2) = NULL,
    @PaymentTermDays SMALLINT = NULL,
    @CorrelationId UNIQUEIDENTIFIER = NULL,
    @IdentificationTypeCode VARCHAR(32) = NULL,
    @Identification NVARCHAR(64) = NULL,
    @PersonKind CHAR(1) = NULL,
    @LegalName NVARCHAR(250) = NULL,
    @TradeName NVARCHAR(250) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @Now DATETIME2(3) = SYSUTCDATETIME(),
            @ClientId UNIQUEIDENTIFIER = NEWID(),
            @TypeId CHAR(2),
            @Normalized NVARCHAR(64),
            @ResolvedIdentificationId BIGINT,
            @ExistingPersonStatus CHAR(1);

    SET @CorrelationId = COALESCE(@CorrelationId, NEWID());
    SET @IdentificationTypeCode = NULLIF(UPPER(LTRIM(RTRIM(@IdentificationTypeCode))), '');
    SET @Identification = NULLIF(LTRIM(RTRIM(@Identification)), N'');
    SET @PersonKind = NULLIF(UPPER(LTRIM(RTRIM(@PersonKind))), '');
    SET @LegalName = NULLIF(LTRIM(RTRIM(@LegalName)), N'');
    SET @TradeName = NULLIF(LTRIM(RTRIM(@TradeName)), N'');

    IF dbo.fn_HasEffectivePermission(@UserId, @CompanyId, @ProfileId, N'client.create') = 0
    BEGIN
        SELECT CAST(3001 AS INT) AS result_code,
               N'Permission or tenant membership denied.' AS result_message,
               @CorrelationId AS correlation_id,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF NULLIF(LTRIM(RTRIM(@BillingAddress)), N'') IS NULL
       OR NULLIF(LTRIM(RTRIM(@Phone)), N'') IS NULL
       OR NULLIF(LTRIM(RTRIM(@Email)), N'') IS NULL
       OR @Email NOT LIKE N'%_@_%._%'
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'BillingAddress, Phone, and a syntactically valid Email are required local inputs.' AS result_message,
               @CorrelationId AS correlation_id,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    IF @PersonId IS NULL
    BEGIN
        SET @Normalized = dbo.fn_NormalizeIdentification(@Identification);

        IF @IdentificationTypeCode IS NULL OR @Normalized IS NULL OR @Normalized = N''
           OR @PersonKind IS NULL OR @PersonKind NOT IN ('N', 'J') OR @LegalName IS NULL
        BEGIN
            SELECT CAST(1001 AS INT) AS result_code,
                   N'Identification type, identification, person kind, and legal name are required when PersonId is null.' AS result_message,
                   @CorrelationId AS correlation_id,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        SELECT @TypeId = IdentificationTypeId
        FROM dbo.IdentificationType
        WHERE Code = @IdentificationTypeCode;

        IF @TypeId IS NULL
        BEGIN
            SELECT CAST(1002 AS INT) AS result_code,
                   N'Identification type is not supported.' AS result_message,
                   @CorrelationId AS correlation_id,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.IdentificationType it
            WHERE it.IdentificationTypeId = @TypeId
              AND it.IsActive = 1
        )
        BEGIN
            SELECT CAST(2002 AS INT) AS result_code,
                   N'Identification type is inactive.' AS result_message,
                   @CorrelationId AS correlation_id,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.IdentificationType it
            WHERE it.IdentificationTypeId = @TypeId
              AND LEN(@Normalized) BETWEEN it.MinLength AND it.MaxLength
              AND (it.IsNumericOnly = 0 OR @Normalized NOT LIKE N'%[^0-9]%')
              AND ((@PersonKind = 'N' AND it.AllowsNaturalPerson = 1)
                OR (@PersonKind = 'J' AND it.AllowsLegalEntity = 1))
        )
        BEGIN
            SELECT CAST(1001 AS INT) AS result_code,
                   N'Identification does not satisfy its configured metadata.' AS result_message,
                   @CorrelationId AS correlation_id,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;
    END
    ELSE IF @IdentificationTypeCode IS NOT NULL OR @Identification IS NOT NULL
         OR @PersonKind IS NOT NULL OR @LegalName IS NOT NULL OR @TradeName IS NOT NULL
    BEGIN
        SELECT CAST(1001 AS INT) AS result_code,
               N'Manual person fields cannot be supplied when PersonId is provided.' AS result_message,
               @CorrelationId AS correlation_id,
               CAST(NULL AS NVARCHAR(20)) AS operation;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @PersonId IS NULL
        BEGIN
            SELECT @PersonId = pi.PersonId,
                   @ResolvedIdentificationId = pi.PersonIdentificationId,
                   @ExistingPersonStatus = p.Status
            FROM dbo.PersonIdentification pi WITH (UPDLOCK, HOLDLOCK)
            INNER JOIN dbo.Person p ON p.PersonId = pi.PersonId
            WHERE pi.IdentificationTypeId = @TypeId
              AND pi.NormalizedIdentification = @Normalized;

            IF @PersonId IS NOT NULL AND @ExistingPersonStatus <> 'A'
            BEGIN
                ROLLBACK TRANSACTION;
                SELECT CAST(2002 AS INT) AS result_code,
                       N'Global person found but inactive.' AS result_message,
                       @CorrelationId AS correlation_id,
                       CAST(NULL AS NVARCHAR(20)) AS operation;
                RETURN;
            END;

            IF @PersonId IS NULL
            BEGIN
                SET @PersonId = NEWID();

                INSERT dbo.Person
                (
                    PersonId, PersonKind, LegalName, TradeName, Status, CreatedBy, CreatedAt
                )
                VALUES
                (
                    @PersonId, @PersonKind, @LegalName, @TradeName, 'A', CONVERT(NVARCHAR(80), @UserId), @Now
                );

                INSERT dbo.PersonIdentification
                (
                    PersonId, IdentificationTypeId, Identification, IsPrimary, CreatedAt, CreatedByUserId
                )
                VALUES
                (
                    @PersonId, @TypeId, @Identification, 1, @Now, @UserId
                );

                SET @ResolvedIdentificationId = CONVERT(BIGINT, SCOPE_IDENTITY());
            END;

            SET @DefaultBillingIdentificationId = COALESCE(@DefaultBillingIdentificationId, @ResolvedIdentificationId);
        END
        ELSE IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Person p WITH (UPDLOCK, HOLDLOCK)
            WHERE p.PersonId = @PersonId
              AND p.Status = 'A'
        )
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT CAST(2001 AS INT) AS result_code,
                   N'Active global person not found.' AS result_message,
                   @CorrelationId AS correlation_id,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF @DefaultBillingIdentificationId IS NULL OR NOT EXISTS
        (
            SELECT 1
            FROM dbo.PersonIdentification pi
            INNER JOIN dbo.IdentificationType it ON it.IdentificationTypeId = pi.IdentificationTypeId
            WHERE pi.PersonIdentificationId = @DefaultBillingIdentificationId
              AND pi.PersonId = @PersonId
              AND it.IsActive = 1
              AND it.IsBillingAllowed = 1
        )
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT CAST(4003 AS INT) AS result_code,
                   N'Default billing identification must belong to the Person and be billable.' AS result_message,
                   @CorrelationId AS correlation_id,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Client
            WHERE CompanyId = @CompanyId
              AND PersonId = @PersonId
        )
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT CAST(4001 AS INT) AS result_code,
                   N'The Person is already a client of the authorized company.' AS result_message,
                   @CorrelationId AS correlation_id,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        INSERT dbo.Client
        (
            ClientId, CompanyId, PersonId, DefaultBillingIdentificationId,
            BillingAddress, Phone, Email, CreditLimit, PaymentTermDays,
            Status, CreatedBy, CreatedAt
        )
        VALUES
        (
            @ClientId, @CompanyId, @PersonId, @DefaultBillingIdentificationId,
            @BillingAddress, @Phone, @Email, @CreditLimit, @PaymentTermDays,
            'A', CONVERT(NVARCHAR(80), @UserId), @Now
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH;

    SELECT CAST(0 AS INT) AS result_code,
           N'Client created.' AS result_message,
           @CorrelationId AS correlation_id,
           N'CREATE' AS operation;

    SELECT
           @ClientId AS client_id,
           @PersonId AS person_id,
           @DefaultBillingIdentificationId AS default_billing_identification_id;
END;
GO
