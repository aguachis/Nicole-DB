SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE OR ALTER PROCEDURE dbo.usp_Client_Create
    @UserId uniqueidentifier, @CompanyId uniqueidentifier, @PersonId uniqueidentifier,
    @DefaultBillingIdentificationId bigint, @BillingAddress nvarchar(500), @Phone nvarchar(50), @Email nvarchar(254),
    @CreditLimit decimal(18,2)=NULL, @PaymentTermDays smallint=NULL, @CorrelationId uniqueidentifier=NULL
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    DECLARE @Now datetime2(3)=SYSUTCDATETIME(), @ClientId uniqueidentifier=NEWID();
    SET @CorrelationId=COALESCE(@CorrelationId,NEWID());
    IF dbo.fn_HasEffectivePermission(@UserId,@CompanyId,N'client.create')=0
    BEGIN
      IF EXISTS(SELECT 1 FROM dbo.Company WHERE CompanyId=@CompanyId)
        INSERT dbo.RegistryAccessAudit(CompanyId,UserId,Outcome,OccurredAt,CorrelationId,ReasonCode)
        VALUES(@CompanyId,CASE WHEN EXISTS(SELECT 1 FROM dbo.AppUser WHERE UserId=@UserId) THEN @UserId END,'Denied',@Now,@CorrelationId,'ClientCreateDenied');
      SELECT CAST(403 AS int) result_code,N'Permission or tenant membership denied.' result_message,@CorrelationId correlation_id; RETURN;
    END;
    IF NULLIF(LTRIM(RTRIM(@BillingAddress)),N'') IS NULL OR NULLIF(LTRIM(RTRIM(@Phone)),N'') IS NULL OR NULLIF(LTRIM(RTRIM(@Email)),N'') IS NULL OR @Email NOT LIKE N'%_@_%._%'
    BEGIN SELECT CAST(400 AS int) result_code,N'BillingAddress, Phone, and a syntactically valid Email are required local inputs.' result_message,@CorrelationId correlation_id; RETURN; END;
    IF NOT EXISTS
    (SELECT 1 FROM dbo.PersonIdentification pi JOIN dbo.IdentificationType it ON it.IdentificationTypeId=pi.IdentificationTypeId
    WHERE pi.PersonIdentificationId=@DefaultBillingIdentificationId AND pi.PersonId=@PersonId
      AND it.IsActive=1 AND it.IsBillingAllowed=1 AND pi.VerificationStatus<>'Invalid')
    BEGIN SELECT CAST(422 AS int) result_code,N'Default billing identification must belong to the Person and be billable.' result_message,@CorrelationId correlation_id; RETURN; END;
    BEGIN TRY
      BEGIN TRANSACTION;
      INSERT dbo.Client(ClientId,CompanyId,PersonId,DefaultBillingIdentificationId,BillingAddress,Phone,Email,CreditLimit,PaymentTermDays,Status,CreatedBy,CreatedAt)
      VALUES(@ClientId,@CompanyId,@PersonId,@DefaultBillingIdentificationId,@BillingAddress,@Phone,@Email,@CreditLimit,@PaymentTermDays,'A',CONVERT(nvarchar(80),@UserId),@Now);
      COMMIT TRANSACTION;
    END TRY BEGIN CATCH IF @@TRANCOUNT>0 ROLLBACK TRANSACTION; THROW; END CATCH;
    SELECT CAST(0 AS int) result_code,N'Client created.' result_message,@CorrelationId correlation_id,@ClientId client_id;
END;
GO
