SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE OR ALTER PROCEDURE dbo.usp_Client_Deactivate
    @UserId uniqueidentifier,@CompanyId uniqueidentifier,@ClientId uniqueidentifier,@CorrelationId uniqueidentifier=NULL
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON; SET @CorrelationId=COALESCE(@CorrelationId,NEWID());
    IF dbo.fn_HasEffectivePermission(@UserId,@CompanyId,N'client.deactivate')=0
    BEGIN SELECT CAST(403 AS int) result_code,N'Permission or tenant membership denied.' result_message,@CorrelationId correlation_id; RETURN; END;
    BEGIN TRANSACTION;
    UPDATE dbo.Client SET Status='I',UpdatedBy=CONVERT(nvarchar(80),@UserId),UpdatedAt=SYSUTCDATETIME() WHERE ClientId=@ClientId AND CompanyId=@CompanyId AND Status<>'I';
    IF @@ROWCOUNT=0 BEGIN ROLLBACK TRANSACTION; SELECT CAST(404 AS int) result_code,N'Active Client not found in the authorized company.' result_message,@CorrelationId correlation_id; RETURN; END;
    COMMIT TRANSACTION;
    SELECT CAST(0 AS int) result_code,N'Client deactivated.' result_message,@CorrelationId correlation_id,@ClientId client_id;
END;
GO
