SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Person_ResolveIdentification
    @UserId UNIQUEIDENTIFIER,
    @CompanyId UNIQUEIDENTIFIER,
    @IdentificationTypeCode VARCHAR(32),
    @Identification NVARCHAR(64),
    @CorrelationId UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TypeId CHAR(2), @Normalized NVARCHAR(64);

    SET @CorrelationId = COALESCE(@CorrelationId, NEWID());
    SET @Normalized = dbo.fn_NormalizeIdentification(@Identification);

    IF dbo.fn_HasEffectivePermission(@UserId, @CompanyId, N'client.create') = 0
    BEGIN
        SELECT CAST(403 AS INT) AS result_code,
               N'Permission or tenant membership denied.' AS result_message,
               @CorrelationId AS correlation_id;
        RETURN;
    END;

    SELECT @TypeId = IdentificationTypeId
    FROM dbo.IdentificationType
    WHERE Code = @IdentificationTypeCode
      AND IsActive = 1;

    IF @TypeId IS NULL OR @Normalized = N''
    BEGIN
        SELECT CAST(400 AS INT) AS result_code,
               N'An active identification type and exact identification are required.' AS result_message,
               @CorrelationId AS correlation_id;
        RETURN;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.PersonIdentification pi
        INNER JOIN dbo.Person p ON p.PersonId = pi.PersonId
        WHERE pi.IdentificationTypeId = @TypeId
          AND pi.NormalizedIdentification = @Normalized
          AND p.Status = 'A'
    )
    BEGIN
        SELECT CAST(404 AS INT) AS result_code,
               N'No matching global identity was found.' AS result_message,
               @CorrelationId AS correlation_id;
        RETURN;
    END;

    SELECT CAST(0 AS INT) AS result_code,
           N'Global identity found.' AS result_message,
           @CorrelationId AS correlation_id,
           p.PersonId,
           p.PersonKind,
           p.LegalName,
           p.TradeName,
           pi.PersonIdentificationId,
           it.Code AS IdentificationTypeCode,
           pi.Identification,
           it.IsBillingAllowed
    FROM dbo.PersonIdentification pi
    INNER JOIN dbo.Person p ON p.PersonId = pi.PersonId
    INNER JOIN dbo.IdentificationType it ON it.IdentificationTypeId = pi.IdentificationTypeId
    WHERE pi.IdentificationTypeId = @TypeId
      AND pi.NormalizedIdentification = @Normalized
      AND p.Status = 'A';
END;
GO
