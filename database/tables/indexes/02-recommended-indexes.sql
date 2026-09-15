/*
Script: 02-recommended-indexes.sql
Objetivo:
    Crear indices no unicos recomendados para las consultas principales
    de autenticacion, seleccion de empresa y permisos efectivos.

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
    INCLUDE (UserId, Email, Status);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.UserCompany')
      AND name = N'IX_UserCompany_User_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_UserCompany_User_Status
    ON dbo.UserCompany (UserId, Status)
    INCLUDE (UserCompanyId, CompanyId);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.UserCompany')
      AND name = N'IX_UserCompany_Company_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_UserCompany_Company_Status
    ON dbo.UserCompany (CompanyId, Status)
    INCLUDE (UserCompanyId, UserId);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.UserCompanyProfile')
      AND name = N'IX_UserCompanyProfile_UserCompany_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_UserCompanyProfile_UserCompany_Status
    ON dbo.UserCompanyProfile (UserCompanyId, CompanyId, Status)
    INCLUDE (ProfileId);
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.UserCompanyProfile')
      AND name = N'IX_UserCompanyProfile_Profile_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_UserCompanyProfile_Profile_Status
    ON dbo.UserCompanyProfile (ProfileId, CompanyId, Status)
    INCLUDE (UserCompanyId);
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
