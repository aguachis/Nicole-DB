SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF TYPE_ID(N'dbo.RegistryEconomicActivityListType') IS NULL
    EXEC(N'CREATE TYPE dbo.RegistryEconomicActivityListType AS TABLE
    (
        ActivityCode nvarchar(32) NOT NULL PRIMARY KEY,
        ActivityName nvarchar(300) NOT NULL,
        ProviderActivityId nvarchar(128) NULL,
        IsPrimary bit NOT NULL
    );');
GO
CREATE OR ALTER PROCEDURE dbo.usp_Registry_PersistVerification
    @UserId uniqueidentifier,
    @CompanyId uniqueidentifier,
    @ProviderCode varchar(50),
    @IdentificationTypeCode varchar(32),
    @Identification nvarchar(64),
    @PersonKind char(1),
    @LegalName nvarchar(250),
    @TradeName nvarchar(250)=NULL,
    @LegacyFirstName nvarchar(200)=NULL,
    @LegacyLastName nvarchar(80)=NULL,
    @RelatedIdentificationTypeCode varchar(32)=NULL,
    @RelatedIdentification nvarchar(64)=NULL,
    @VerificationResult varchar(16),
    @QueriedAt datetime2(3),
    @ExpiresAt datetime2(3),
    @PayloadCanonical nvarchar(max)=NULL,
    @ProviderRequestId nvarchar(128)=NULL,
    @FailureCode varchar(64)=NULL,
    @TaxStatus nvarchar(100)=NULL,
    @TaxpayerClass nvarchar(100)=NULL,
    @TaxAddress nvarchar(500)=NULL,
    @AccountingRequired bit=NULL,
    @StartedAt date=NULL,
    @Activities dbo.RegistryEconomicActivityListType READONLY,
    @CorrelationId uniqueidentifier=NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    DECLARE @Now datetime2(3)=SYSUTCDATETIME(),@ProviderId smallint,@TypeId char(2),@RelatedTypeId char(2),
            @Normalized nvarchar(64),@RelatedNormalized nvarchar(64),@PersonId uniqueidentifier,
            @RelatedPersonId uniqueidentifier,@PersonIdentificationId bigint,@RelatedIdentificationId bigint,
            @TaxRegistrationId bigint,@PayloadHash varbinary(32),@AuditOutcome varchar(16),@LegacyActor nvarchar(80);
    SET @CorrelationId=COALESCE(@CorrelationId,NEWID());
    SET @Normalized=dbo.fn_NormalizeIdentification(@Identification);
    SET @RelatedNormalized=dbo.fn_NormalizeIdentification(@RelatedIdentification);
    SET @LegacyActor=CONVERT(nvarchar(80),@UserId);
    IF dbo.fn_HasEffectivePermission(@UserId,@CompanyId,N'client.verify')=0
    BEGIN
        IF EXISTS(SELECT 1 FROM dbo.Company WHERE CompanyId=@CompanyId)
            INSERT dbo.RegistryAccessAudit(CompanyId,UserId,Outcome,OccurredAt,CorrelationId,ReasonCode)
            VALUES(@CompanyId,CASE WHEN EXISTS(SELECT 1 FROM dbo.AppUser WHERE UserId=@UserId) THEN @UserId END,'Denied',@Now,@CorrelationId,'PersistVerificationDenied');
        SELECT CAST(403 AS int) result_code,N'Permission or tenant membership denied.' result_message,@CorrelationId correlation_id;
        RETURN;
    END;
    IF @PersonKind NOT IN ('N','J') OR NULLIF(LTRIM(RTRIM(@LegalName)),N'') IS NULL OR @Normalized=N''
    BEGIN SELECT CAST(400 AS int) result_code,N'PersonKind, LegalName, and exact identification are required.' result_message,@CorrelationId correlation_id; RETURN; END;
    IF @VerificationResult NOT IN ('Verified','NotFound','Invalid','Unavailable','Error') OR @QueriedAt IS NULL OR @ExpiresAt IS NULL OR @ExpiresAt<@QueriedAt
    BEGIN SELECT CAST(400 AS int) result_code,N'Verification result and valid UTC timestamps are required.' result_message,@CorrelationId correlation_id; RETURN; END;
    SELECT @ProviderId=RegistryProviderId FROM dbo.RegistryProvider WHERE Code=@ProviderCode AND IsActive=1;
    SELECT @TypeId=IdentificationTypeId FROM dbo.IdentificationType WHERE Code=@IdentificationTypeCode AND IsActive=1;
    IF @ProviderId IS NULL OR @TypeId IS NULL
    BEGIN SELECT CAST(400 AS int) result_code,N'Active provider and identification type are required.' result_message,@CorrelationId correlation_id; RETURN; END;
    IF EXISTS
    (
        SELECT 1 FROM dbo.IdentificationType WHERE IdentificationTypeId=@TypeId AND
        (LEN(@Normalized) NOT BETWEEN MinLength AND MaxLength OR (IsNumericOnly=1 AND @Normalized LIKE N'%[^0-9]%')
         OR (@PersonKind='N' AND AllowsNaturalPerson=0) OR (@PersonKind='J' AND AllowsLegalEntity=0))
    ) BEGIN SELECT CAST(422 AS int) result_code,N'Identification does not satisfy its configured metadata.' result_message,@CorrelationId correlation_id; RETURN; END;
    IF @PersonKind='N' AND (NULLIF(LTRIM(RTRIM(@LegacyFirstName)),N'') IS NULL OR NULLIF(LTRIM(RTRIM(@LegacyLastName)),N'') IS NULL)
    BEGIN SELECT CAST(422 AS int) result_code,N'Natural-person legacy first and last names are required until legacy columns are retired.' result_message,@CorrelationId correlation_id; RETURN; END;
    IF @RelatedIdentificationTypeCode IS NOT NULL
    BEGIN
        SELECT @RelatedTypeId=IdentificationTypeId FROM dbo.IdentificationType WHERE Code=@RelatedIdentificationTypeCode AND IsActive=1;
        IF @RelatedTypeId IS NULL OR @RelatedNormalized=N''
        BEGIN SELECT CAST(400 AS int) result_code,N'Related identification must be an active exact type/value pair.' result_message,@CorrelationId correlation_id; RETURN; END;
    END;
    IF @StartedAt=CONVERT(date,'00010101') SET @StartedAt=NULL;
    IF (SELECT COUNT(*) FROM @Activities WHERE IsPrimary=1)>1
    BEGIN SELECT CAST(422 AS int) result_code,N'At most one economic activity may be primary.' result_message,@CorrelationId correlation_id; RETURN; END;
    SET @PayloadHash=CASE WHEN @PayloadCanonical IS NULL THEN NULL ELSE HASHBYTES('SHA2_256',CONVERT(varbinary(max),@PayloadCanonical)) END;

    BEGIN TRY
      BEGIN TRANSACTION;
      SELECT @PersonId=pi.PersonId,@PersonIdentificationId=pi.PersonIdentificationId
      FROM dbo.PersonIdentification pi WITH(UPDLOCK,HOLDLOCK) WHERE pi.IdentificationTypeId=@TypeId AND pi.NormalizedIdentification=@Normalized;
      IF @RelatedTypeId IS NOT NULL
      BEGIN
        SELECT @RelatedPersonId=pi.PersonId,@RelatedIdentificationId=pi.PersonIdentificationId
        FROM dbo.PersonIdentification pi WITH(UPDLOCK,HOLDLOCK) WHERE pi.IdentificationTypeId=@RelatedTypeId AND pi.NormalizedIdentification=@RelatedNormalized;
        IF @PersonId IS NOT NULL AND @RelatedPersonId IS NOT NULL AND @PersonId<>@RelatedPersonId
            THROW 51500, 'Related cedula/RUC resolves to a different Person.', 1;
        SET @PersonId=COALESCE(@PersonId,@RelatedPersonId);
      END;
      IF @PersonId IS NULL
      BEGIN
        SET @PersonId=NEWID();
        INSERT dbo.Person(PersonId,IdentificationType,Identification,PersonType,LastName,FirstName,BusinessName,Status,CreatedBy,CreatedAt,LegalName,TradeName,PersonKind)
        VALUES(@PersonId,@TypeId,@Identification,@PersonKind,
               CASE WHEN @PersonKind='N' THEN @LegacyLastName ELSE NULL END,
               CASE WHEN @PersonKind='N' THEN @LegacyFirstName ELSE NULL END,
               CASE WHEN @PersonKind='J' THEN @LegalName ELSE NULL END,
               'A',@LegacyActor,@Now,@LegalName,@TradeName,@PersonKind);
      END
      ELSE
      BEGIN
        UPDATE dbo.Person SET LegalName=@LegalName,TradeName=@TradeName,PersonKind=@PersonKind,UpdatedBy=@LegacyActor,UpdatedAt=@Now WHERE PersonId=@PersonId;
      END;
      IF @PersonIdentificationId IS NULL
      BEGIN
        INSERT dbo.PersonIdentification(PersonId,IdentificationTypeId,Identification,IsPrimary,VerificationStatus,LastVerifiedAt,ExpiresAt,CreatedAt,CreatedByUserId)
        VALUES(@PersonId,@TypeId,@Identification,CASE WHEN NOT EXISTS(SELECT 1 FROM dbo.PersonIdentification WHERE PersonId=@PersonId AND IsPrimary=1) THEN 1 ELSE 0 END,
               CASE @VerificationResult WHEN 'Verified' THEN 'Verified' WHEN 'NotFound' THEN 'NotFound' WHEN 'Invalid' THEN 'Invalid' ELSE 'Error' END,
               @QueriedAt,@ExpiresAt,@Now,@UserId);
        SET @PersonIdentificationId=SCOPE_IDENTITY();
      END
      ELSE UPDATE dbo.PersonIdentification SET VerificationStatus=CASE @VerificationResult WHEN 'Verified' THEN 'Verified' WHEN 'NotFound' THEN 'NotFound' WHEN 'Invalid' THEN 'Invalid' ELSE 'Error' END,LastVerifiedAt=@QueriedAt,ExpiresAt=@ExpiresAt,UpdatedAt=@Now,UpdatedByUserId=@UserId WHERE PersonIdentificationId=@PersonIdentificationId;
      INSERT dbo.PersonVerification(PersonIdentificationId,RegistryProviderId,Result,QueriedAt,ExpiresAt,PayloadHash,ProviderRequestId,FailureCode,CorrelationId,CreatedAt,CreatedByUserId)
      VALUES(@PersonIdentificationId,@ProviderId,@VerificationResult,@QueriedAt,@ExpiresAt,@PayloadHash,@ProviderRequestId,@FailureCode,@CorrelationId,@Now,@UserId);
      IF @VerificationResult='Verified' AND EXISTS(SELECT 1 FROM dbo.IdentificationType WHERE IdentificationTypeId=@TypeId AND Code='RUC')
      BEGIN
        SELECT @TaxRegistrationId=TaxRegistrationId FROM dbo.TaxRegistration WITH(UPDLOCK,HOLDLOCK) WHERE PersonIdentificationId=@PersonIdentificationId;
        IF @TaxRegistrationId IS NULL
        BEGIN
          INSERT dbo.TaxRegistration(PersonIdentificationId,TaxStatus,TaxpayerClass,TaxAddress,AccountingRequired,StartedAt,RegistryProviderId,Source,VerifiedAt,VerificationExpiresAt,CreatedAt,CreatedByUserId)
          VALUES(@PersonIdentificationId,@TaxStatus,@TaxpayerClass,@TaxAddress,@AccountingRequired,@StartedAt,@ProviderId,'Provider',@QueriedAt,@ExpiresAt,@Now,@UserId);
          SET @TaxRegistrationId=SCOPE_IDENTITY();
        END
        ELSE UPDATE dbo.TaxRegistration SET TaxStatus=@TaxStatus,TaxpayerClass=@TaxpayerClass,TaxAddress=@TaxAddress,AccountingRequired=@AccountingRequired,StartedAt=@StartedAt,RegistryProviderId=@ProviderId,Source='Provider',VerifiedAt=@QueriedAt,VerificationExpiresAt=@ExpiresAt,UpdatedAt=@Now,UpdatedByUserId=@UserId WHERE TaxRegistrationId=@TaxRegistrationId;
        INSERT dbo.EconomicActivity(ActivityCode,Name,IsActive,CreatedAt,CreatedByUserId)
        SELECT a.ActivityCode,a.ActivityName,1,@Now,@UserId FROM @Activities a
        WHERE NOT EXISTS(SELECT 1 FROM dbo.EconomicActivity ea WHERE ea.ActivityCode=a.ActivityCode);
        UPDATE x SET ProviderActivityId=a.ProviderActivityId,IsPrimary=a.IsPrimary,VerifiedAt=@QueriedAt,UpdatedAt=@Now,UpdatedByUserId=@UserId
        FROM dbo.TaxRegistrationEconomicActivity x JOIN dbo.EconomicActivity ea ON ea.EconomicActivityId=x.EconomicActivityId JOIN @Activities a ON a.ActivityCode=ea.ActivityCode WHERE x.TaxRegistrationId=@TaxRegistrationId;
        INSERT dbo.TaxRegistrationEconomicActivity(TaxRegistrationId,EconomicActivityId,ProviderActivityId,IsPrimary,VerifiedAt,CreatedAt,CreatedByUserId)
        SELECT @TaxRegistrationId,ea.EconomicActivityId,a.ProviderActivityId,a.IsPrimary,@QueriedAt,@Now,@UserId FROM @Activities a JOIN dbo.EconomicActivity ea ON ea.ActivityCode=a.ActivityCode
        WHERE NOT EXISTS(SELECT 1 FROM dbo.TaxRegistrationEconomicActivity x WHERE x.TaxRegistrationId=@TaxRegistrationId AND x.EconomicActivityId=ea.EconomicActivityId);
      END;
      SET @AuditOutcome=CASE @VerificationResult WHEN 'Verified' THEN 'ProviderQueried' WHEN 'NotFound' THEN 'NotFound' WHEN 'Invalid' THEN 'Invalid' WHEN 'Unavailable' THEN 'Unavailable' ELSE 'Error' END;
      INSERT dbo.RegistryAccessAudit(CompanyId,UserId,PersonIdentificationId,RegistryProviderId,Outcome,OccurredAt,CorrelationId,ReasonCode)
      VALUES(@CompanyId,@UserId,@PersonIdentificationId,@ProviderId,@AuditOutcome,@Now,@CorrelationId,@FailureCode);
      COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
      IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;
      THROW;
    END CATCH;
    SELECT CAST(0 AS int) result_code,N'Provider response persisted.' result_message,@CorrelationId correlation_id,@PersonId person_id,@PersonIdentificationId person_identification_id;
END;
GO
