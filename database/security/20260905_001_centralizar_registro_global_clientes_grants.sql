/*
  `nicole_app` is the explicit database role for runtime application logins.
  The role receives only the public person-resolution and client procedures.
  Execute after those procedures have been created.
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

IF DATABASE_PRINCIPAL_ID(N'nicole_app') IS NULL CREATE ROLE nicole_app;
IF OBJECT_ID(N'dbo.P_Person_ResolveIdentification',N'P') IS NULL
 OR OBJECT_ID(N'dbo.P_Client_Create',N'P') IS NULL
 OR OBJECT_ID(N'dbo.P_Client_Update',N'P') IS NULL
 OR OBJECT_ID(N'dbo.P_Client_Deactivate',N'P') IS NULL
    THROW 51410, 'Create the approved person/client procedures before applying runtime grants.', 1;

REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.Person FROM nicole_app;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.PersonIdentification FROM nicole_app;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.Client FROM nicole_app;

GRANT EXECUTE ON dbo.P_Person_ResolveIdentification TO nicole_app;
GRANT EXECUTE ON dbo.P_Client_Create TO nicole_app;
GRANT EXECUTE ON dbo.P_Client_Update TO nicole_app;
GRANT EXECUTE ON dbo.P_Client_Deactivate TO nicole_app;
GO
