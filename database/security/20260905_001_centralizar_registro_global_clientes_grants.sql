/*
  `nicole_app` is the explicit database role for runtime application logins.
  DBAs and migration principals are not members of this role and retain their
  existing rights. Execute after the five public procedures have been deployed.
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

IF DATABASE_PRINCIPAL_ID(N'nicole_app') IS NULL CREATE ROLE nicole_app;
IF OBJECT_ID(N'dbo.usp_Registry_ResolveIdentification',N'P') IS NULL
 OR OBJECT_ID(N'dbo.usp_Registry_PersistVerification',N'P') IS NULL
 OR OBJECT_ID(N'dbo.usp_Client_Create',N'P') IS NULL
 OR OBJECT_ID(N'dbo.usp_Client_Update',N'P') IS NULL
 OR OBJECT_ID(N'dbo.usp_Client_Deactivate',N'P') IS NULL
    THROW 51410, 'Deploy the approved registry/client procedures before applying runtime grants.', 1;

REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.Person FROM nicole_app;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.PersonIdentification FROM nicole_app;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.TaxRegistration FROM nicole_app;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.EconomicActivity FROM nicole_app;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.TaxRegistrationEconomicActivity FROM nicole_app;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.PersonVerification FROM nicole_app;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.RegistryAccessAudit FROM nicole_app;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.RegistryProvider FROM nicole_app;

GRANT EXECUTE ON dbo.usp_Registry_ResolveIdentification TO nicole_app;
GRANT EXECUTE ON dbo.usp_Registry_PersistVerification TO nicole_app;
GRANT EXECUTE ON dbo.usp_Client_Create TO nicole_app;
GRANT EXECUTE ON dbo.usp_Client_Update TO nicole_app;
GRANT EXECUTE ON dbo.usp_Client_Deactivate TO nicole_app;
GO
