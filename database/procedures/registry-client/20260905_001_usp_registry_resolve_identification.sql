SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE OR ALTER PROCEDURE dbo.usp_Registry_ResolveIdentification
    @UserId uniqueidentifier,
    @CompanyId uniqueidentifier,
    @IdentificationTypeCode varchar(32),
    @Identification nvarchar(64),
    @CorrelationId uniqueidentifier = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    DECLARE @Now datetime2(3)=SYSUTCDATETIME(), @TypeId char(2), @Normalized nvarchar(64),
            @PersonIdentificationId bigint, @ProviderId smallint, @Outcome varchar(16), @Reason varchar(64),
            @CanAudit bit=0, @AuditUserId uniqueidentifier=NULL;
    SET @CorrelationId=COALESCE(@CorrelationId,NEWID());
    SET @Normalized=dbo.fn_NormalizeIdentification(@Identification);
    IF EXISTS(SELECT 1 FROM dbo.Company WHERE CompanyId=@CompanyId)
        SET @CanAudit=1;
    IF EXISTS(SELECT 1 FROM dbo.AppUser WHERE UserId=@UserId)
        SET @AuditUserId=@UserId;

    IF dbo.fn_HasEffectivePermission(@UserId,@CompanyId,N'client.read')=0
       AND dbo.fn_HasEffectivePermission(@UserId,@CompanyId,N'client.verify')=0
    BEGIN
        IF @CanAudit=1 INSERT dbo.RegistryAccessAudit(CompanyId,UserId,Outcome,OccurredAt,CorrelationId,ReasonCode)
            VALUES(@CompanyId,@AuditUserId,'Denied',@Now,@CorrelationId,'PermissionOrMembershipDenied');
        SELECT CAST(403 AS int) result_code,N'Permission or tenant membership denied.' result_message,@CorrelationId correlation_id;
        RETURN;
    END;
    SELECT @TypeId=IdentificationTypeId FROM dbo.IdentificationType
    WHERE Code=@IdentificationTypeCode AND IsActive=1;
    IF @TypeId IS NULL OR @Normalized=N''
    BEGIN
        INSERT dbo.RegistryAccessAudit(CompanyId,UserId,Outcome,OccurredAt,CorrelationId,ReasonCode)
        VALUES(@CompanyId,@AuditUserId,'Invalid',@Now,@CorrelationId,'ExactTypeAndIdentificationRequired');
        SELECT CAST(400 AS int) result_code,N'An active identification type and exact identification are required.' result_message,@CorrelationId correlation_id;
        RETURN;
    END;

    SELECT @PersonIdentificationId=pi.PersonIdentificationId
    FROM dbo.PersonIdentification pi
    WHERE pi.IdentificationTypeId=@TypeId AND pi.NormalizedIdentification=@Normalized;
    IF @PersonIdentificationId IS NULL
    BEGIN
        INSERT dbo.RegistryAccessAudit(CompanyId,UserId,Outcome,OccurredAt,CorrelationId,ReasonCode)
        VALUES(@CompanyId,@AuditUserId,'NotFound',@Now,@CorrelationId,'ExactIdentityNotFound');
        SELECT CAST(404 AS int) result_code,N'No matching identity was found.' result_message,@CorrelationId correlation_id;
        RETURN;
    END;

    SELECT TOP(1) @ProviderId=pv.RegistryProviderId
    FROM dbo.PersonVerification pv
    WHERE pv.PersonIdentificationId=@PersonIdentificationId AND pv.Result='Verified' AND pv.ExpiresAt>@Now
    ORDER BY pv.ExpiresAt DESC,pv.PersonVerificationId DESC;
    IF @ProviderId IS NOT NULL BEGIN SET @Outcome='CacheHit'; SET @Reason='VerifiedCache'; END
    ELSE BEGIN SET @Outcome='Unavailable'; SET @Reason='RefreshRequired'; END;

    BEGIN TRANSACTION;
    INSERT dbo.RegistryAccessAudit(CompanyId,UserId,PersonIdentificationId,RegistryProviderId,Outcome,OccurredAt,CorrelationId,ReasonCode)
    VALUES(@CompanyId,@AuditUserId,@PersonIdentificationId,@ProviderId,@Outcome,@Now,@CorrelationId,@Reason);
    COMMIT TRANSACTION;

    SELECT CASE WHEN @Outcome='CacheHit' THEN CAST(0 AS int) ELSE CAST(202 AS int) END AS result_code,
           CASE WHEN @Outcome='CacheHit' THEN N'Verified identity returned from cache.' ELSE N'Identity exists but requires backend refresh.' END AS result_message,
           @CorrelationId AS correlation_id,
           p.PersonId,p.LegalName,p.TradeName,p.PersonKind,it.Code AS IdentificationTypeCode,
           pi.Identification,pi.VerificationStatus,pi.LastVerifiedAt,pi.ExpiresAt,
           CASE WHEN @Outcome='CacheHit' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS IsCacheHit
    FROM dbo.PersonIdentification pi
    JOIN dbo.Person p ON p.PersonId=pi.PersonId
    JOIN dbo.IdentificationType it ON it.IdentificationTypeId=pi.IdentificationTypeId
    WHERE pi.PersonIdentificationId=@PersonIdentificationId;
END;
GO
