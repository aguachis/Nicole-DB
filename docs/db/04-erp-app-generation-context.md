# Contexto para Generar Aplicacion ERP - Base Inicial

## Objetivo del documento

Usar este archivo como contexto base cuando se escriba un prompt para generar la aplicacion ERP.

La aplicacion debe iniciar con modulos de autenticacion, empresa, usuarios, perfiles, roles y permisos usando las tablas descritas aqui.

## Stack esperado

El stack puede definirse en el prompt final, pero la aplicacion debe respetar estas reglas:

- Base de datos: SQL Server.
- Modelo multiempresa.
- Autenticacion por usuario.
- Autorizacion por permisos, no por nombre fijo de rol.
- Cada usuario puede pertenecer a una o varias empresas.
- Cada usuario puede tener perfiles distintos por empresa.
- Los permisos se asignan a perfiles, no directamente a usuarios.

## Modulos iniciales de la aplicacion

- Login.
- Registro inicial de empresa y usuario administrador.
- Selector de empresa activa.
- Gestion de usuarios por empresa.
- Gestion de perfiles por empresa.
- Gestion de permisos por perfil.
- Validacion de permisos para acciones del sistema.

## Tablas iniciales

### 1. EntityStatus

Catalogo canonico de estados.

Tabla: `dbo.EntityStatus`

Campos:

| Campo | Tipo | Reglas |
| --- | --- | --- |
| StatusCode | CHAR(1) | PK. Valores: `A`, `I` |
| StatusName | NVARCHAR(100) | Unico |
| StatusDescription | NVARCHAR(255) | Opcional |
| IsActive | BIT | Default `1` |
| SortOrder | TINYINT | Default `0` |
| CreatedAt | DATETIME2(0) | Default `SYSDATETIME()` |
| UpdatedAt | DATETIME2(0) | Opcional |

Datos iniciales:

```sql
INSERT INTO dbo.EntityStatus
(
    StatusCode,
    StatusName,
    StatusDescription,
    IsActive,
    SortOrder
)
VALUES
    ('A', N'Activo', N'Registro habilitado para uso operativo', 1, 1),
    ('I', N'Inactivo', N'Registro deshabilitado para uso operativo', 0, 2);
```

### 2. IdentificationType

Catalogo de tipos de identificacion.

Tabla: `dbo.IdentificationType`

Campos:

| Campo | Tipo | Reglas |
| --- | --- | --- |
| IdentificationTypeId | CHAR(2) | PK |
| Name | NVARCHAR(50) | Unico |
| Description | NVARCHAR(150) | Opcional |
| Status | CHAR(1) | FK a `EntityStatus` |
| CreatedAt | DATETIME2(0) | Default `SYSDATETIME()` |
| UpdatedAt | DATETIME2(0) | Opcional |

Datos iniciales:

```sql
INSERT INTO dbo.IdentificationType
(
    IdentificationTypeId,
    Name,
    Description,
    Status
)
VALUES
    ('04', N'RUC', N'Ruc', 'A'),
    ('05', N'CEDULA', N'Cedula', 'A'),
    ('06', N'PASAPORTE', N'Pasaporte', 'A'),
    ('07', N'CONSUMIDOR FINAL', N'Consumidor final', 'A'),
    ('08', N'IDENTIFICACION DEL EXTERIOR', N'Identificacion del exterior', 'A');
```

### 3. PersonType

Catalogo de tipos de persona.

Tabla: `dbo.PersonType`

Campos:

| Campo | Tipo | Reglas |
| --- | --- | --- |
| PersonTypeId | CHAR(1) | PK. Valores: `N`, `J` |
| Name | NVARCHAR(50) | Unico |
| Description | NVARCHAR(150) | Opcional |
| Status | CHAR(1) | FK a `EntityStatus` |
| CreatedAt | DATETIME2(0) | Default `SYSDATETIME()` |
| UpdatedAt | DATETIME2(0) | Opcional |

Datos iniciales:

```sql
INSERT INTO dbo.PersonType
(
    PersonTypeId,
    Name,
    Description,
    Status
)
VALUES
    ('N', N'Persona natural', N'Persona individual con identidad civil', 'A'),
    ('J', N'Persona juridica', N'Entidad legal como empresa o institucion', 'A');
```

### 4. Person

Entidad canonica para personas naturales y juridicas.

Tabla: `dbo.Person`

Campos principales:

| Campo | Tipo | Reglas |
| --- | --- | --- |
| PersonId | UNIQUEIDENTIFIER | PK, default `NEWSEQUENTIALID()` |
| IdentificationType | CHAR(2) | FK a `IdentificationType` |
| Identification | NVARCHAR(20) | Requerido |
| PersonType | CHAR(1) | FK a `PersonType` |
| LastName | NVARCHAR(80) | Requerido para persona natural |
| MiddleName | NVARCHAR(80) | Opcional |
| FirstName | NVARCHAR(200) | Requerido para persona natural |
| BusinessName | NVARCHAR(200) | Requerido para persona juridica |
| Gender | CHAR(1) | Opcional. Valores: `M`, `F` |
| BirthDate | DATE | Opcional |
| Address | NVARCHAR(300) | Opcional |
| Phone | NVARCHAR(50) | Opcional |
| Email | NVARCHAR(150) | Opcional |
| Province | CHAR(3) | Opcional |
| City | INT | Opcional |
| Remarks | NVARCHAR(500) | Opcional |
| Status | CHAR(1) | FK a `EntityStatus` |
| CreatedBy | NVARCHAR(80) | Requerido |
| CreatedAt | DATETIME2(0) | Default `SYSDATETIME()` |
| UpdatedBy | NVARCHAR(80) | Opcional |
| UpdatedAt | DATETIME2(0) | Opcional |

Reglas:

- `IdentificationType + Identification` debe ser unico.
- Si `PersonType = 'N'`, requiere `FirstName` y `LastName`.
- Si `PersonType = 'J'`, requiere `BusinessName`.

### 5. Company

Empresa legal o corporativa dentro del ERP.

Tabla: `dbo.Company`

Campos principales:

| Campo | Tipo | Reglas |
| --- | --- | --- |
| CompanyId | UNIQUEIDENTIFIER | PK, default `NEWSEQUENTIALID()` |
| Identification | NVARCHAR(20) | Unico, requerido |
| TradeName | NVARCHAR(150) | Opcional |
| BusinessName | NVARCHAR(200) | Requerido |
| Email | NVARCHAR(150) | Opcional |
| IsAccountingRequired | BIT | Default `0` |
| SpecialTaxpayer | NVARCHAR(50) | Opcional |
| Status | CHAR(1) | Estado |
| RepresentativeId | UNIQUEIDENTIFIER | FK opcional a `Person` |
| ParentCompanyId | UNIQUEIDENTIFIER | FK opcional a `Company` |
| TaxpayerType | NVARCHAR(50) | Opcional |
| ArtisanQualification | NVARCHAR(10) | Opcional |
| Environment | VARCHAR(30) | Ej: `TEST`, `PROD` |
| Currency | VARCHAR(3) | Ej: `USD` |
| Timezone | VARCHAR(60) | Ej: `America/Guayaquil` |
| LanguageCode | VARCHAR(3) | Ej: `es` |
| CreatedBy | NVARCHAR(80) | Requerido |
| CreatedAt | DATETIME2(0) | Default `SYSDATETIME()` |
| UpdatedBy | NVARCHAR(80) | Opcional |
| UpdatedAt | DATETIME2(0) | Opcional |

Reglas:

- `Identification` debe ser unico.
- `RepresentativeId` representa al representante legal.
- La estructura actual de BD no contiene `OwnerPersonId`.

### 6. AppUser

Identidad de acceso a la aplicacion.

Tabla: `dbo.AppUser`

Campos:

| Campo | Tipo | Reglas |
| --- | --- | --- |
| UserId | UNIQUEIDENTIFIER | PK, default `NEWSEQUENTIALID()` |
| PersonId | UNIQUEIDENTIFIER | FK a `Person` |
| Username | NVARCHAR(80) | Opcional |
| PasswordHash | NVARCHAR(500) | Requerido. Nunca texto plano |
| Email | NVARCHAR(150) | Unico, requerido |
| IsBlocked | BIT | Default `0` |
| RequiresNewPassword | BIT | Default `0` |
| MustUpdate | BIT | Default `0` |
| Status | CHAR(1) | FK a `EntityStatus` |
| CreatedBy | NVARCHAR(80) | Requerido |
| CreatedAt | DATETIME2(0) | Default `SYSDATETIME()` |
| UpdatedBy | NVARCHAR(80) | Opcional |
| UpdatedAt | DATETIME2(0) | Opcional |

Reglas:

- `Email` es unico globalmente.
- `PasswordHash` debe almacenar un hash seguro generado desde la aplicacion.
- El perfil del usuario no vive aqui.

### 7. UserCompany

Relacion entre usuario y empresa.

Tabla: `dbo.UserCompany`

Campos:

| Campo | Tipo | Reglas |
| --- | --- | --- |
| UserCompanyId | UNIQUEIDENTIFIER | PK, default `NEWSEQUENTIALID()` |
| UserId | UNIQUEIDENTIFIER | FK a `AppUser` |
| CompanyId | UNIQUEIDENTIFIER | FK a `Company` |
| Status | CHAR(1) | FK a `EntityStatus` |
| CreatedBy | NVARCHAR(80) | Requerido |
| CreatedAt | DATETIME2(0) | Default `SYSDATETIME()` |
| UpdatedBy | NVARCHAR(80) | Opcional |
| UpdatedAt | DATETIME2(0) | Opcional |

Reglas:

- `UserId + CompanyId` debe ser unico.
- Un usuario puede estar en varias empresas.
- Una empresa puede tener varios usuarios.

### 8. Profile

Rol o perfil definido dentro de una empresa.

Tabla: `dbo.Profile`

Campos:

| Campo | Tipo | Reglas |
| --- | --- | --- |
| ProfileId | UNIQUEIDENTIFIER | PK, default `NEWSEQUENTIALID()` |
| CompanyId | UNIQUEIDENTIFIER | FK a `Company` |
| Name | NVARCHAR(150) | Requerido |
| Description | NVARCHAR(250) | Opcional |
| Status | CHAR(1) | FK a `EntityStatus` |
| CreatedBy | NVARCHAR(80) | Requerido |
| CreatedAt | DATETIME2(0) | Default `SYSDATETIME()` |
| UpdatedBy | NVARCHAR(80) | Opcional |
| UpdatedAt | DATETIME2(0) | Opcional |

Reglas:

- `CompanyId + Name` debe ser unico.
- El perfil depende de la empresa.
- Ejemplos: `ADMIN`, `CAJERO`, `CONSULTA`.

### 9. Permission

Permiso funcional del sistema.

Tabla: `dbo.Permission`

Campos:

| Campo | Tipo | Reglas |
| --- | --- | --- |
| PermissionId | UNIQUEIDENTIFIER | PK, default `NEWSEQUENTIALID()` |
| Code | NVARCHAR(150) | Unico, requerido |
| Name | NVARCHAR(150) | Requerido |
| Description | NVARCHAR(250) | Opcional |
| ModuleCode | NVARCHAR(50) | Requerido |
| Status | CHAR(1) | FK a `EntityStatus` |
| CreatedBy | NVARCHAR(80) | Requerido |
| CreatedAt | DATETIME2(0) | Default `SYSDATETIME()` |
| UpdatedBy | NVARCHAR(80) | Opcional |
| UpdatedAt | DATETIME2(0) | Opcional |

Reglas:

- `Code` es el identificador tecnico que debe usar la app.
- Ejemplos: `user.read`, `user.create`, `company.read`.

### 10. ProfilePermission

Permisos asignados a cada perfil.

Tabla: `dbo.ProfilePermission`

Campos:

| Campo | Tipo | Reglas |
| --- | --- | --- |
| ProfilePermissionId | UNIQUEIDENTIFIER | PK, default `NEWSEQUENTIALID()` |
| ProfileId | UNIQUEIDENTIFIER | FK a `Profile` |
| PermissionId | UNIQUEIDENTIFIER | FK a `Permission` |
| Status | CHAR(1) | FK a `EntityStatus` |
| CreatedBy | NVARCHAR(80) | Requerido |
| CreatedAt | DATETIME2(0) | Default `SYSDATETIME()` |
| UpdatedBy | NVARCHAR(80) | Opcional |
| UpdatedAt | DATETIME2(0) | Opcional |

Reglas:

- `ProfileId + PermissionId` debe ser unico.
- Los permisos se asignan al perfil, no directamente al usuario.

### 11. UserCompanyProfile

Perfil asignado a un usuario dentro de una empresa.

Tabla: `dbo.UserCompanyProfile`

Campos:

| Campo | Tipo | Reglas |
| --- | --- | --- |
| UserCompanyProfileId | UNIQUEIDENTIFIER | PK, default `NEWSEQUENTIALID()` |
| UserCompanyId | UNIQUEIDENTIFIER | FK compuesta con `CompanyId` a `UserCompany` |
| CompanyId | UNIQUEIDENTIFIER | Parte de validacion multiempresa |
| ProfileId | UNIQUEIDENTIFIER | FK compuesta con `CompanyId` a `Profile` |
| Status | CHAR(1) | FK a `EntityStatus` |
| CreatedBy | NVARCHAR(80) | Requerido |
| CreatedAt | DATETIME2(0) | Default `SYSDATETIME()` |
| UpdatedBy | NVARCHAR(80) | Opcional |
| UpdatedAt | DATETIME2(0) | Opcional |

Reglas:

- `UserCompanyId + ProfileId` debe ser unico.
- Valida que el perfil pertenezca a la misma empresa del usuario.
- Reemplaza el modelo de `UserProfile` global.

## Relacion general

```text
Person
  -> AppUser
      -> UserCompany
          -> Company
          -> UserCompanyProfile
              -> Profile
                  -> ProfilePermission
                      -> Permission
```

## Regla principal de autorizacion

La aplicacion no debe preguntar solo si el usuario es `ADMIN`.

Debe validar si el usuario tiene un permiso dentro de la empresa activa.

Ejemplo:

```text
Usuario autenticado: nicole.admin
Empresa activa: Nicole Mock Store
Accion requerida: crear usuario
Permiso requerido: user.create
```

La accion se permite solo si `nicole.admin` tiene un perfil activo en esa empresa y ese perfil tiene el permiso `user.create`.

## Permisos iniciales sugeridos

| Codigo | Nombre | Modulo |
| --- | --- | --- |
| company.read | Consultar empresas | company |
| company.update | Actualizar empresa | company |
| user.read | Consultar usuarios | user |
| user.create | Crear usuarios | user |
| user.update | Actualizar usuarios | user |
| user.disable | Desactivar usuarios | user |
| profile.read | Consultar perfiles | profile |
| profile.create | Crear perfiles | profile |
| profile.update | Actualizar perfiles | profile |
| profile.assign | Asignar perfiles | profile |
| permission.read | Consultar permisos | permission |
| permission.assign | Asignar permisos | permission |

## Perfiles iniciales sugeridos

| Perfil | Descripcion |
| --- | --- |
| ADMIN | Administrador total de la empresa |
| CAJERO | Operacion basica de caja y ventas |
| CONSULTA | Usuario de solo lectura |

Matriz inicial:

| Perfil | Permisos |
| --- | --- |
| ADMIN | Todos los permisos iniciales |
| CAJERO | Ningun permiso de administracion de usuarios/perfiles en esta fase |
| CONSULTA | `company.read`, `user.read`, `profile.read`, `permission.read` |

## Datos mock base

Estos datos sirven como semilla para pruebas de desarrollo.

```sql
DECLARE @CreatedBy NVARCHAR(80) = N'mock.seed';

DECLARE @RepresentativePersonId UNIQUEIDENTIFIER = '11111111-1111-1111-1111-111111111111';
DECLARE @CompanyId UNIQUEIDENTIFIER = '22222222-2222-2222-2222-222222222222';
DECLARE @AdminUserId UNIQUEIDENTIFIER = '55555555-5555-5555-5555-555555555555';
DECLARE @CashierUserId UNIQUEIDENTIFIER = '55555555-5555-5555-5555-555555555556';
DECLARE @ReadOnlyUserId UNIQUEIDENTIFIER = '55555555-5555-5555-5555-555555555557';

DECLARE @AdminProfileId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666666';
DECLARE @CashierProfileId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666667';
DECLARE @ReadOnlyProfileId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666668';

DECLARE @AdminUserCompanyId UNIQUEIDENTIFIER = '99999999-9999-9999-9999-999999999999';
DECLARE @CashierUserCompanyId UNIQUEIDENTIFIER = '99999999-9999-9999-9999-999999999998';
DECLARE @ReadOnlyUserCompanyId UNIQUEIDENTIFIER = '99999999-9999-9999-9999-999999999997';

INSERT INTO dbo.Person
(
    PersonId,
    IdentificationType,
    Identification,
    PersonType,
    LastName,
    FirstName,
    Gender,
    Phone,
    Email,
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
    N'Nicole',
    'F',
    N'0999999999',
    N'nicole.mock@example.com',
    'A',
    @CreatedBy
);

INSERT INTO dbo.Company
(
    CompanyId,
    Identification,
    TradeName,
    BusinessName,
    Email,
    IsAccountingRequired,
    Status,
    RepresentativeId,
    TaxpayerType,
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
    'A',
    @RepresentativePersonId,
    N'SOCIEDAD',
    'TEST',
    'USD',
    'America/Guayaquil',
    'es',
    @CreatedBy
);

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
    @AdminUserId,
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
    (@AdminProfileId, @CompanyId, N'ADMIN', N'Administrador total de la empresa', 'A', @CreatedBy),
    (@CashierProfileId, @CompanyId, N'CAJERO', N'Operacion basica de caja y ventas', 'A', @CreatedBy),
    (@ReadOnlyProfileId, @CompanyId, N'CONSULTA', N'Usuario de solo lectura', 'A', @CreatedBy);

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
    @AdminUserCompanyId,
    @AdminUserId,
    @CompanyId,
    'A',
    @CreatedBy
);

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
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    @AdminUserCompanyId,
    @CompanyId,
    @AdminProfileId,
    'A',
    @CreatedBy
);
```

## Datos mock de permisos

```sql
DECLARE @CreatedBy NVARCHAR(80) = N'mock.seed';
DECLARE @AdminProfileId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666666';
DECLARE @ReadOnlyProfileId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666668';

DECLARE @CompanyRead UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777700';
DECLARE @CompanyUpdate UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777701';
DECLARE @UserRead UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777702';
DECLARE @UserCreate UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777703';
DECLARE @UserUpdate UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777704';
DECLARE @UserDisable UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777705';
DECLARE @ProfileRead UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777706';
DECLARE @ProfileCreate UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777707';
DECLARE @ProfileUpdate UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777708';
DECLARE @ProfileAssign UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777709';
DECLARE @PermissionRead UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777710';
DECLARE @PermissionAssign UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777711';

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
VALUES
    (@CompanyRead, N'company.read', N'Consultar empresas', N'Permite consultar datos de empresa', N'company', 'A', @CreatedBy),
    (@CompanyUpdate, N'company.update', N'Actualizar empresa', N'Permite actualizar datos de empresa', N'company', 'A', @CreatedBy),
    (@UserRead, N'user.read', N'Consultar usuarios', N'Permite consultar usuarios de la empresa', N'user', 'A', @CreatedBy),
    (@UserCreate, N'user.create', N'Crear usuarios', N'Permite crear usuarios en la empresa', N'user', 'A', @CreatedBy),
    (@UserUpdate, N'user.update', N'Actualizar usuarios', N'Permite actualizar usuarios', N'user', 'A', @CreatedBy),
    (@UserDisable, N'user.disable', N'Desactivar usuarios', N'Permite desactivar usuarios', N'user', 'A', @CreatedBy),
    (@ProfileRead, N'profile.read', N'Consultar perfiles', N'Permite consultar perfiles', N'profile', 'A', @CreatedBy),
    (@ProfileCreate, N'profile.create', N'Crear perfiles', N'Permite crear perfiles', N'profile', 'A', @CreatedBy),
    (@ProfileUpdate, N'profile.update', N'Actualizar perfiles', N'Permite actualizar perfiles', N'profile', 'A', @CreatedBy),
    (@ProfileAssign, N'profile.assign', N'Asignar perfiles', N'Permite asignar perfiles a usuarios', N'profile', 'A', @CreatedBy),
    (@PermissionRead, N'permission.read', N'Consultar permisos', N'Permite consultar permisos', N'permission', 'A', @CreatedBy),
    (@PermissionAssign, N'permission.assign', N'Asignar permisos', N'Permite asignar permisos a perfiles', N'permission', 'A', @CreatedBy);

INSERT INTO dbo.ProfilePermission
(
    ProfileId,
    PermissionId,
    Status,
    CreatedBy
)
SELECT @AdminProfileId, PermissionId, 'A', @CreatedBy
FROM dbo.Permission
WHERE Code IN
(
    N'company.read',
    N'company.update',
    N'user.read',
    N'user.create',
    N'user.update',
    N'user.disable',
    N'profile.read',
    N'profile.create',
    N'profile.update',
    N'profile.assign',
    N'permission.read',
    N'permission.assign'
);

INSERT INTO dbo.ProfilePermission
(
    ProfileId,
    PermissionId,
    Status,
    CreatedBy
)
SELECT @ReadOnlyProfileId, PermissionId, 'A', @CreatedBy
FROM dbo.Permission
WHERE Code IN
(
    N'company.read',
    N'user.read',
    N'profile.read',
    N'permission.read'
);
```

## Consulta para obtener permisos efectivos

```sql
SELECT DISTINCT
    p.Code,
    p.Name,
    p.ModuleCode
FROM dbo.AppUser u
INNER JOIN dbo.UserCompany uc
    ON uc.UserId = u.UserId
   AND uc.Status = 'A'
INNER JOIN dbo.UserCompanyProfile ucp
    ON ucp.UserCompanyId = uc.UserCompanyId
   AND ucp.CompanyId = uc.CompanyId
   AND ucp.Status = 'A'
INNER JOIN dbo.Profile pr
    ON pr.ProfileId = ucp.ProfileId
   AND pr.CompanyId = uc.CompanyId
   AND pr.Status = 'A'
INNER JOIN dbo.ProfilePermission pp
    ON pp.ProfileId = pr.ProfileId
   AND pp.Status = 'A'
INNER JOIN dbo.Permission p
    ON p.PermissionId = pp.PermissionId
   AND p.Status = 'A'
WHERE u.UserId = @UserId
  AND uc.CompanyId = @CompanyId;
```

## Validacion para crear usuario

Antes de crear un usuario en una empresa, la app debe validar el permiso `user.create`.

```sql
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.UserCompany uc
    INNER JOIN dbo.UserCompanyProfile ucp
        ON ucp.UserCompanyId = uc.UserCompanyId
       AND ucp.CompanyId = uc.CompanyId
       AND ucp.Status = 'A'
    INNER JOIN dbo.Profile pr
        ON pr.ProfileId = ucp.ProfileId
       AND pr.CompanyId = uc.CompanyId
       AND pr.Status = 'A'
    INNER JOIN dbo.ProfilePermission pp
        ON pp.ProfileId = pr.ProfileId
       AND pp.Status = 'A'
    INNER JOIN dbo.Permission p
        ON p.PermissionId = pp.PermissionId
       AND p.Status = 'A'
    WHERE uc.UserId = @CurrentUserId
      AND uc.CompanyId = @CompanyId
      AND uc.Status = 'A'
      AND p.Code = N'user.create'
)
BEGIN
    RAISERROR('No tiene permisos para crear usuarios en esta empresa.', 16, 1);
    RETURN;
END;
```

## Pantallas iniciales sugeridas

### Login

Campos:

- Usuario o email.
- Contrasena.

Resultado:

- Si el usuario pertenece a una sola empresa, entrar directo.
- Si pertenece a varias empresas, mostrar selector de empresa.

### Selector de empresa

Mostrar empresas activas desde `UserCompany`.

### Usuarios

Permisos:

- Ver lista: `user.read`.
- Crear: `user.create`.
- Editar: `user.update`.
- Desactivar: `user.disable`.
- Asignar perfil: `profile.assign`.

### Perfiles

Permisos:

- Ver lista: `profile.read`.
- Crear: `profile.create`.
- Editar: `profile.update`.
- Asignar permisos: `permission.assign`.

### Permisos

Permisos:

- Ver catalogo: `permission.read`.
- Asignar a perfil: `permission.assign`.

## Prompt base sugerido

```text
Genera una aplicacion ERP inicial usando SQL Server y un modelo multiempresa.

Usa como base las tablas:
EntityStatus, IdentificationType, PersonType, Person, Company, AppUser, UserCompany, Profile, Permission, ProfilePermission y UserCompanyProfile.

La autenticacion se hace con AppUser.
La empresa activa se obtiene desde UserCompany.
Los roles/perfiles dependen de la empresa mediante Profile.
La asignacion de perfil a usuario se hace con UserCompanyProfile.
Los permisos se asignan al perfil mediante ProfilePermission.
La aplicacion debe validar acciones usando Permission.Code, por ejemplo user.create para crear usuarios.

Construye pantallas iniciales de:
- Login
- Selector de empresa
- Gestion de usuarios
- Gestion de perfiles
- Gestion de permisos por perfil

No uses UserProfile global.
No valides acciones solo por nombre de perfil como ADMIN.
Valida siempre por permiso efectivo del usuario en la empresa activa.
```

## Archivos SQL fuente

- `tables/00-create-table-entitystatus.sql`
- `tables/01-create-table-identification-type.sql`
- `tables/02-create-table-person-type.sql`
- `tables/03-create-table-person.sql`
- `tables/04-create-table-company.sql`
- `tables/07-create-table-app-user.sql`
- `tables/11-create-table-user-company.sql`
- `tables/08-create-table-profile.sql`
- `tables/09-create-table-permission.sql`
- `tables/10-create-table-profile-permission.sql`
- `tables/12-create-table-user-company-profile.sql`
