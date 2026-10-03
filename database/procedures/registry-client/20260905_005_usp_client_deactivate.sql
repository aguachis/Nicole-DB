SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE OR ALTER PROCEDURE dbo.P_Client_Deactivate
    @UserId uniqueidentifier,@CompanyId uniqueidentifier,@ProfileId uniqueidentifier,@ClientId uniqueidentifier,@CorrelationId uniqueidentifier=NULL
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    DECLARE @Now datetime2(3)=SYSUTCDATETIME(); SET @CorrelationId=COALESCE(@CorrelationId,NEWID());
    IF dbo.fn_HasEffectivePermission(@UserId,@CompanyId,@ProfileId,N'client.deactivate')=0
    BEGIN
      SELECT CAST(3001 AS int) result_code,N'Permission or tenant membership denied.' result_message,@CorrelationId correlation_id,CAST(NULL AS nvarchar(20)) operation; RETURN;
    END;
    IF NOT EXISTS(SELECT 1 FROM dbo.Client WHERE ClientId=@ClientId AND CompanyId=@CompanyId)
    BEGIN
      SELECT CAST(2001 AS int) result_code,N'Client not found in the authorized company.' result_message,@CorrelationId correlation_id,CAST(NULL AS nvarchar(20)) operation; RETURN;
    END;
    IF EXISTS(SELECT 1 FROM dbo.Client WHERE ClientId=@ClientId AND CompanyId=@CompanyId AND Status='I')
    BEGIN
      SELECT CAST(0 AS int) result_code,N'Client is already inactive.' result_message,@CorrelationId correlation_id,N'NOOP' operation;
      SELECT @ClientId client_id;
      RETURN;
    END;
    BEGIN TRY
      BEGIN TRANSACTION;
      UPDATE dbo.Client SET Status='I',UpdatedBy=CONVERT(nvarchar(80),@UserId),UpdatedAt=@Now WHERE ClientId=@ClientId AND CompanyId=@CompanyId AND Status<>'I';
      IF @@ROWCOUNT=0
      BEGIN
        ROLLBACK TRANSACTION;
        SELECT CAST(2001 AS int) result_code,N'Active Client not found in the authorized company.' result_message,@CorrelationId correlation_id,CAST(NULL AS nvarchar(20)) operation; RETURN;
      END;
      COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
      IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;
      THROW;
    END CATCH;
    SELECT CAST(0 AS int) result_code,N'Client deactivated.' result_message,@CorrelationId correlation_id,N'DEACTIVATE' operation;
    SELECT @ClientId client_id;
END;
GO
