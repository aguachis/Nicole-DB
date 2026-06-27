/*
Script: 01-insert-mock-data.sql
Objetivo:
    Insertar datos mock minimos para validar las relaciones principales
    del modelo nuevo.

Uso:
    Ejecutar despues de crear las tablas base en este orden:
    - EntityStatus
    - IdentificationType
    - PersonType
    - Person
    - Company
    - CompanyBranch
    - CompanyEmissionPoint
    - AppUser
    - Profile
    - Permission
    - ProfilePermission
    - UserCompany
    - UserCompanyProfile

Notas:
    - El script es idempotente: no duplica registros si se vuelve a ejecutar.
    - Los UNIQUEIDENTIFIER son fijos para facilitar pruebas de integracion.
    - PasswordHash es un valor mock y no debe usarse en produccion.
*/

SET NOCOUNT ON;
GO

DECLARE @CreatedBy NVARCHAR(80) = N'mock.seed';

DECLARE @RepresentativePersonId UNIQUEIDENTIFIER = '11111111-1111-1111-1111-111111111111';
DECLARE @CompanyId UNIQUEIDENTIFIER = '22222222-2222-2222-2222-222222222222';
DECLARE @CompanyBranchId UNIQUEIDENTIFIER = '33333333-3333-3333-3333-333333333333';
DECLARE @CompanyEmissionPointId UNIQUEIDENTIFIER = '44444444-4444-4444-4444-444444444444';
DECLARE @UserId UNIQUEIDENTIFIER = '55555555-5555-5555-5555-555555555555';
DECLARE @ProfileId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666666';
DECLARE @UserCompanyId UNIQUEIDENTIFIER = '99999999-9999-9999-9999-999999999999';
DECLARE @UserCompanyProfileId UNIQUEIDENTIFIER = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';

IF NOT EXISTS (SELECT 1 FROM dbo.EntityStatus WHERE StatusCode = 'A')
BEGIN
    INSERT INTO dbo.EntityStatus
    (
        StatusCode,
        StatusName,
        StatusDescription,
        IsActive,
        SortOrder
    )
    VALUES
        ('A', N'Activo', N'Registro habilitado para uso operativo', 1, 1);
END;

IF NOT EXISTS (SELECT 1 FROM dbo.EntityStatus WHERE StatusCode = 'I')
BEGIN
    INSERT INTO dbo.EntityStatus
    (
        StatusCode,
        StatusName,
        StatusDescription,
        IsActive,
        SortOrder
    )
    VALUES
        ('I', N'Inactivo', N'Registro deshabilitado para uso operativo', 0, 2);
END;

IF NOT EXISTS (SELECT 1 FROM dbo.IdentificationType WHERE IdentificationTypeId = '04')
BEGIN
    INSERT INTO dbo.IdentificationType
    (
        IdentificationTypeId,
        Name,
        Description,
        Status
    )
    VALUES
        ('04', N'RUC', N'Registro Unico de Contribuyentes', 'A');
END;

IF NOT EXISTS (SELECT 1 FROM dbo.IdentificationType WHERE IdentificationTypeId = '05')
BEGIN
    INSERT INTO dbo.IdentificationType
    (
        IdentificationTypeId,
        Name,
        Description,
        Status
    )
    VALUES
        ('05', N'Cedula', N'Documento nacional de identidad', 'A');
END;

IF NOT EXISTS (SELECT 1 FROM dbo.PersonType WHERE PersonTypeId = 'N')
BEGIN
    INSERT INTO dbo.PersonType
    (
        PersonTypeId,
        Name,
        Description,
        Status
    )
    VALUES
        ('N', N'Persona natural', N'Persona individual con identidad civil', 'A');
END;

IF NOT EXISTS (SELECT 1 FROM dbo.PersonType WHERE PersonTypeId = 'J')
BEGIN
    INSERT INTO dbo.PersonType
    (
        PersonTypeId,
        Name,
        Description,
        Status
    )
    VALUES
        ('J', N'Persona juridica', N'Entidad legal como empresa o institucion', 'A');
END;

IF NOT EXISTS (
    SELECT 1
    FROM dbo.Person
    WHERE IdentificationType = '05'
      AND Identification = N'0912345678'
)
BEGIN
    INSERT INTO dbo.Person
    (
        PersonId,
        IdentificationType,
        Identification,
        PersonType,
        LastName,
        MiddleName,
        FirstName,
        Gender,
        BirthDate,
        Address,
        Phone,
        Email,
        Province,
        City,
        Remarks,
        Status,
        CreatedBy
    )
    VALUES
    (
        @RepresentativePersonId,
        '05',
        N'0912345678',
        'N',
        N'Garcia',
        N'Lopez',
        N'Nicole',
        'F',
        '1990-05-15',
        N'Av. 9 de Octubre 100 y Malecon',
        N'0999999999',
        N'nicole.mock@example.com',
        'GYE',
        901,
        N'Persona mock para pruebas de empresa y usuario',
        'A',
        @CreatedBy
    );
END;

SELECT @RepresentativePersonId = PersonId
FROM dbo.Person
WHERE IdentificationType = '05'
  AND Identification = N'0912345678';

IF NOT EXISTS (SELECT 1 FROM dbo.Company WHERE Identification = N'0999999999001')
BEGIN
    INSERT INTO dbo.Company
    (
        CompanyId,
        Identification,
        TradeName,
        BusinessName,
        Email,
        IsAccountingRequired,
        SpecialTaxpayer,
        Status,
        RepresentativeId,
        TaxpayerType,
        ArtisanQualification,
        Environment,
        Currency,
        Timezone,
        LanguageCode,
        CreatedBy
    )
    VALUES
    (
        @CompanyId,
        N'0999999999001',
        N'Nicole Mock Store',
        N'Nicole Mock Store S.A.S.',
        N'empresa.mock@example.com',
        1,
        NULL,
        'A',
        @RepresentativePersonId,
        N'SOCIEDAD',
        NULL,
        'TEST',
        'USD',
        'America/Guayaquil',
        'es',
        @CreatedBy
    );
END;

SELECT @CompanyId = CompanyId
FROM dbo.Company
WHERE Identification = N'0999999999001';

IF NOT EXISTS (
    SELECT 1
    FROM dbo.CompanyBranch
    WHERE CompanyId = @CompanyId
      AND EstablishmentCode = '001'
)
BEGIN
    INSERT INTO dbo.CompanyBranch
    (
        CompanyBranchId,
        CompanyId,
        EstablishmentCode,
        BranchName,
        Address,
        Phone,
        Email,
        City,
        Province,
        Status,
        CreatedBy
    )
    VALUES
    (
        @CompanyBranchId,
        @CompanyId,
        '001',
        N'Matriz',
        N'Av. 9 de Octubre 100 y Malecon',
        N'042222222',
        N'matriz.mock@example.com',
        901,
        'GYE',
        'A',
        @CreatedBy
    );
END;

SELECT @CompanyBranchId = CompanyBranchId
FROM dbo.CompanyBranch
WHERE CompanyId = @CompanyId
  AND EstablishmentCode = '001';

IF NOT EXISTS (
    SELECT 1
    FROM dbo.CompanyEmissionPoint
    WHERE CompanyBranchId = @CompanyBranchId
      AND EmissionPointCode = '001'
)
BEGIN
    INSERT INTO dbo.CompanyEmissionPoint
    (
        CompanyEmissionPointId,
        CompanyBranchId,
        EmissionPointCode,
        Name,
        Status,
        CreatedBy
    )
    VALUES
    (
        @CompanyEmissionPointId,
        @CompanyBranchId,
        '001',
        N'Caja principal',
        'A',
        @CreatedBy
    );
END;

IF NOT EXISTS (SELECT 1 FROM dbo.AppUser WHERE Email = N'nicole.mock@example.com')
BEGIN
    INSERT INTO dbo.AppUser
    (
        UserId,
        PersonId,
        Username,
        PasswordHash,
        Email,
        IsBlocked,
        RequiresNewPassword,
        MustUpdate,
        Status,
        CreatedBy
    )
    VALUES
    (
        @UserId,
        @RepresentativePersonId,
        N'nicole.admin',
        N'mock-password-hash-change-me',
        N'nicole.mock@example.com',
        0,
        1,
        0,
        'A',
        @CreatedBy
    );
END;

SELECT @UserId = UserId
FROM dbo.AppUser
WHERE Email = N'nicole.mock@example.com';

IF NOT EXISTS (
    SELECT 1
    FROM dbo.Profile
    WHERE CompanyId = @CompanyId
      AND Name = N'ADMIN'
)
BEGIN
    INSERT INTO dbo.Profile
    (
        ProfileId,
        CompanyId,
        Name,
        Description,
        Status,
        CreatedBy
    )
    VALUES
    (
        @ProfileId,
        @CompanyId,
        N'ADMIN',
        N'Perfil administrador mock',
        'A',
        @CreatedBy
    );
END;

SELECT @ProfileId = ProfileId
FROM dbo.Profile
WHERE CompanyId = @CompanyId
  AND Name = N'ADMIN';

DECLARE @BasePermissions TABLE
(
    Code NVARCHAR(150) NOT NULL PRIMARY KEY,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(250) NULL,
    ModuleCode NVARCHAR(50) NOT NULL
);

INSERT INTO @BasePermissions (Code, Name, Description, ModuleCode)
VALUES
    (N'company.read', N'Consultar empresas', N'Permite consultar datos de empresa', N'company'),
    (N'company.update', N'Actualizar empresa', N'Permite actualizar datos de empresa', N'company'),
    (N'user.read', N'Consultar usuarios', N'Permite consultar usuarios de la empresa', N'user'),
    (N'user.create', N'Crear usuarios', N'Permite crear usuarios en la empresa', N'user'),
    (N'user.update', N'Actualizar usuarios', N'Permite actualizar usuarios', N'user'),
    (N'user.disable', N'Desactivar usuarios', N'Permite desactivar usuarios', N'user'),
    (N'profile.read', N'Consultar perfiles', N'Permite consultar perfiles', N'profile'),
    (N'profile.create', N'Crear perfiles', N'Permite crear perfiles', N'profile'),
    (N'profile.update', N'Actualizar perfiles', N'Permite actualizar perfiles', N'profile'),
    (N'profile.assign', N'Asignar perfiles', N'Permite asignar perfiles a usuarios', N'profile'),
    (N'permission.read', N'Consultar permisos', N'Permite consultar permisos', N'permission'),
    (N'permission.assign', N'Asignar permisos', N'Permite asignar permisos a perfiles', N'permission');

INSERT INTO dbo.Permission
(
    PermissionId,
    Code,
    Name,
    Description,
    ModuleCode,
    Status,
    CreatedBy
)
SELECT
    NEWID(),
    bp.Code,
    bp.Name,
    bp.Description,
    bp.ModuleCode,
    'A',
    @CreatedBy
FROM @BasePermissions bp
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Permission p
    WHERE p.Code = bp.Code
);

INSERT INTO dbo.ProfilePermission
(
    ProfilePermissionId,
    ProfileId,
    PermissionId,
    Status,
    CreatedBy
)
SELECT
    NEWID(),
    @ProfileId,
    p.PermissionId,
    'A',
    @CreatedBy
FROM dbo.Permission p
INNER JOIN @BasePermissions bp
    ON bp.Code = p.Code
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.ProfilePermission pp
    WHERE pp.ProfileId = @ProfileId
      AND pp.PermissionId = p.PermissionId
);

IF NOT EXISTS (
    SELECT 1
    FROM dbo.UserCompany
    WHERE UserId = @UserId
      AND CompanyId = @CompanyId
)
BEGIN
    INSERT INTO dbo.UserCompany
    (
        UserCompanyId,
        UserId,
        CompanyId,
        Status,
        CreatedBy
    )
    VALUES
    (
        @UserCompanyId,
        @UserId,
        @CompanyId,
        'A',
        @CreatedBy
    );
END;

SELECT @UserCompanyId = UserCompanyId
FROM dbo.UserCompany
WHERE UserId = @UserId
  AND CompanyId = @CompanyId;

IF NOT EXISTS (
    SELECT 1
    FROM dbo.UserCompanyProfile
    WHERE UserCompanyId = @UserCompanyId
      AND ProfileId = @ProfileId
)
BEGIN
    INSERT INTO dbo.UserCompanyProfile
    (
        UserCompanyProfileId,
        UserCompanyId,
        CompanyId,
        ProfileId,
        Status,
        CreatedBy
    )
    VALUES
    (
        @UserCompanyProfileId,
        @UserCompanyId,
        @CompanyId,
        @ProfileId,
        'A',
        @CreatedBy
    );
END;
GO
