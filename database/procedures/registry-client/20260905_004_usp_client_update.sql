SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE OR ALTER PROCEDURE dbo.usp_Client_Update
    @UserId uniqueidentifier,@CompanyId uniqueidentifier,@ClientId uniqueidentifier,@DefaultBillingIdentificationId bigint,
    @BillingAddress nvarchar(500),@Phone nvarchar(50),@Email nvarchar(254),@CreditLimit decimal(18,2)=NULL,@PaymentTermDays smallint=NULL,@CorrelationId uniqueidentifier=NULL
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON; SET @CorrelationId=COALESCE(@CorrelationId,NEWID());
    IF dbo.fn_HasEffectivePermission(@UserId,@CompanyId,N'client.update')=0
    BEGIN SELECT CAST(403 AS int) result_code,N'Permission or tenant membership denied.' result_message,@CorrelationId correlation_id; RETURN; END;
    IF NOT EXISTS(SELECT 1 FROM dbo.Client WHERE ClientId=@ClientId AND CompanyId=@CompanyId)
    BEGIN SELECT CAST(404 AS int) result_code,N'Client not found in the authorized company.' result_message,@CorrelationId correlation_id; RETURN; END;
    IF NULLIF(LTRIM(RTRIM(@BillingAddress)),N'') IS NULL OR NULLIF(LTRIM(RTRIM(@Phone)),N'') IS NULL OR NULLIF(LTRIM(RTRIM(@Email)),N'') IS NULL OR @Email NOT LIKE N'%_@_%._%'
    BEGIN SELECT CAST(400 AS int) result_code,N'BillingAddress, Phone, and a syntactically valid Email are required local inputs.' result_message,@CorrelationId correlation_id; RETURN; END;
    IF NOT EXISTS(SELECT 1 FROM dbo.Client c JOIN dbo.PersonIdentification pi ON pi.PersonIdentificationId=@DefaultBillingIdentificationId AND pi.PersonId=c.PersonId JOIN dbo.IdentificationType it ON it.IdentificationTypeId=pi.IdentificationTypeId WHERE c.ClientId=@ClientId AND c.CompanyId=@CompanyId AND it.IsActive=1 AND it.IsBillingAllowed=1 AND pi.VerificationStatus<>'Invalid')
    BEGIN SELECT CAST(422 AS int) result_code,N'Default billing identification must belong to the Client Person and be billable.' result_message,@CorrelationId correlation_id; RETURN; END;
    BEGIN TRANSACTION;
    UPDATE dbo.Client SET DefaultBillingIdentificationId=@DefaultBillingIdentificationId,BillingAddress=@BillingAddress,Phone=@Phone,Email=@Email,CreditLimit=@CreditLimit,PaymentTermDays=@PaymentTermDays,UpdatedBy=CONVERT(nvarchar(80),@UserId),UpdatedAt=SYSUTCDATETIME() WHERE ClientId=@ClientId AND CompanyId=@CompanyId;
    COMMIT TRANSACTION;
    SELECT CAST(0 AS int) result_code,N'Client updated.' result_message,@CorrelationId correlation_id,@ClientId client_id;
END;
GO
