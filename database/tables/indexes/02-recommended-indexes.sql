/*
Script: 02-recommended-indexes.sql
Objetivo:
    Crear indices no unicos recomendados para las consultas principales
    de autenticacion, pertenencia tenant y permisos efectivos.

Notas:
    - No cambia reglas de negocio.
    - Ejecutar despues de crear todas las tablas core.
*/

SET NOCOUNT ON;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.AppUser')
      AND name = N'IX_AppUser_PersonId'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_AppUser_PersonId
    ON dbo.AppUser (PersonId)
    INCLUDE (UserId, Email, CompanyId, Status);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.AppUser')
      AND name = N'IX_AppUser_Company_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_AppUser_Company_Status
    ON dbo.AppUser (CompanyId, Status)
    INCLUDE (UserId, PersonId, Email);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.UserProfile')
      AND name = N'IX_UserProfile_User_Company_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_UserProfile_User_Company_Status
    ON dbo.UserProfile (UserId, CompanyId, Status)
    INCLUDE (ProfileId);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.UserProfile')
      AND name = N'IX_UserProfile_Profile_Company_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_UserProfile_Profile_Company_Status
    ON dbo.UserProfile (ProfileId, CompanyId, Status)
    INCLUDE (UserId);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.ProfilePermission')
      AND name = N'IX_ProfilePermission_Profile_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ProfilePermission_Profile_Status
    ON dbo.ProfilePermission (ProfileId, Status)
    INCLUDE (PermissionId);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.Permission')
      AND name = N'IX_Permission_Module_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Permission_Module_Status
    ON dbo.Permission (ModuleCode, Status)
    INCLUDE (PermissionId, Code, Name);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.CompanyBranch')
      AND name = N'IX_CompanyBranch_Company_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_CompanyBranch_Company_Status
    ON dbo.CompanyBranch (CompanyId, Status)
    INCLUDE (CompanyBranchId, EstablishmentCode, BranchName);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.CompanyEmissionPoint')
      AND name = N'IX_CompanyEmissionPoint_Branch_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_CompanyEmissionPoint_Branch_Status
    ON dbo.CompanyEmissionPoint (CompanyBranchId, Status)
    INCLUDE (CompanyEmissionPointId, EmissionPointCode, Name);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.Client')
      AND name = N'IX_Client_Company_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Client_Company_Status
    ON dbo.Client (CompanyId, Status)
    INCLUDE (ClientId, PersonId, Identification, BusinessName);
END;
GO
