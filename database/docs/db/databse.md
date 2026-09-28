# Planificación del diseño de base de datos

## Propósito

Este documento reúne el modelo de datos planificado e implementado para Nicole. Sirve como referencia funcional y técnica para crear nuevas tablas, revisar cambios de esquema y mantener la integridad entre módulos.

La fuente de verdad ejecutable son los scripts de [`database/tables/`](../../tables/). Este documento no reemplaza las restricciones, claves ni migraciones definidas en SQL.

## Alcance actual

El esquema contempla:

- Catálogos y estados comunes.
- Personas e identificaciones tributarias globales.
- Empresas, sucursales y puntos de emisión.
- Usuarios, perfiles y permisos por empresa.
- Consulta y verificación de identidades tributarias.
- Clientes como relación comercial por empresa.

## Convenciones de diseño

- El esquema de SQL Server es `dbo`.
- Las entidades principales usan `UNIQUEIDENTIFIER`; las entidades del registro tributario de alto volumen usan `BIGINT IDENTITY`.
- `EntityStatus` centraliza el estado lógico `A` (activo) e `I` (inactivo) de las entidades que usan la columna `Status`.
- Las tablas operativas incluyen, cuando aplica, auditoría mediante `CreatedBy`, `CreatedAt`, `UpdatedBy` y `UpdatedAt`.
- Las bajas son lógicas: se cambia `Status`; no se elimina información referenciada.
- Las relaciones se aplican con claves foráneas. Las restricciones `UNIQUE` previenen duplicados de negocio.
- Los perfiles no son globales: pertenecen a una empresa y se asignan al usuario dentro de esa misma empresa.

## Diagrama de relaciones

El diagrama completo, con los campos de cada tabla y sus relaciones, está en [`databse-diagrama.md`](databse-diagrama.md). Se separó del contenido de planificación para que el gráfico se pueda consultar sin reducir su legibilidad.

## Tablas y campos

### 1. Catálogos comunes

#### `EntityStatus`

Catálogo canónico del estado lógico de las entidades.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `StatusCode` | `CHAR(1)` | PK; solo `A` o `I`. |
| `StatusName` | `NVARCHAR(100)` | Único. |
| `StatusDescription` | `NVARCHAR(255)` | Opcional. |
| `IsActive` | `BIT` | Obligatorio; predeterminado `1`. |
| `SortOrder` | `TINYINT` | Obligatorio; predeterminado `0`. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

#### `IdentificationType`

Define las políticas de los tipos de identificación, incluidos los tipos aptos para facturación.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `IdentificationTypeId` | `CHAR(2)` | PK. |
| `Code` | `VARCHAR(32)` | Único. |
| `Name` | `NVARCHAR(50)` | Único. |
| `Description` | `NVARCHAR(150)` | Opcional. |
| `MinLength` | `TINYINT` | Obligatorio; mayor que cero. |
| `MaxLength` | `TINYINT` | Obligatorio; mayor o igual a `MinLength`. |
| `IsNumericOnly` | `BIT` | Obligatorio. |
| `AllowsNaturalPerson` | `BIT` | Obligatorio. |
| `AllowsLegalEntity` | `BIT` | Obligatorio; al menos una de las dos aplicabilidades debe ser verdadera. |
| `IsBillingAllowed` | `BIT` | Obligatorio. |
| `IsActive` | `BIT` | Obligatorio; predeterminado `1`. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

#### `PersonType`

Clasifica a una persona como natural o jurídica.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `PersonTypeId` | `CHAR(1)` | PK. |
| `Name` | `NVARCHAR(50)` | Único. |
| `Description` | `NVARCHAR(150)` | Opcional. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

#### `EconomicActivity`

Catálogo global de actividades económicas informadas por un proveedor tributario.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `EconomicActivityId` | `BIGINT IDENTITY` | PK. |
| `ActivityCode` | `NVARCHAR(32)` | Único. |
| `Name` | `NVARCHAR(300)` | Obligatorio. |
| `IsActive` | `BIT` | Obligatorio; predeterminado `1`. |

### 2. Personas e identidad tributaria

#### `Person`

Maestro global de personas naturales y jurídicas. Una persona puede relacionarse con usuarios, empresas, identificaciones y clientes de varias empresas.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `PersonId` | `UNIQUEIDENTIFIER` | PK; predeterminado `NEWSEQUENTIALID()`. |
| `PersonKind` | `CHAR(1)` | FK a `PersonType`. |
| `LegalName` | `NVARCHAR(250)` | Obligatorio; no puede estar vacío. |
| `TradeName` | `NVARCHAR(250)` | Opcional. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `CreatedBy` | `NVARCHAR(80)` | Obligatorio. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedBy` | `NVARCHAR(80)` | Opcional. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

#### `PersonIdentification`

Mantiene las identificaciones de cada persona, normalizadas para impedir duplicados. Una persona puede tener varias; solo una puede marcarse como principal.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `PersonIdentificationId` | `BIGINT IDENTITY` | PK. |
| `PersonId` | `UNIQUEIDENTIFIER` | FK a `Person`. |
| `IdentificationTypeId` | `CHAR(2)` | FK a `IdentificationType`. |
| `Identification` | `NVARCHAR(64)` | Obligatorio; no puede estar vacío. |
| `NormalizedIdentification` | Calculado `NVARCHAR(64)` | Persistido mediante `fn_NormalizeIdentification`; parte de clave única. |
| `IsPrimary` | `BIT` | Obligatorio; predeterminado `0`; único por persona cuando vale `1`. |
| `VerificationStatus` | `VARCHAR(16)` | Obligatorio; `Unverified`, `Verified`, `NotFound`, `Invalid`, `Expired` o `Error`. |
| `LastVerifiedAt` | `DATETIME2(3)` | Opcional. |
| `ExpiresAt` | `DATETIME2(3)` | Opcional. |
| `CreatedAt` | `DATETIME2(3)` | Obligatorio; predeterminado `SYSUTCDATETIME()`. |
| `CreatedByUserId` | `UNIQUEIDENTIFIER` | FK opcional a `AppUser`. |
| `UpdatedAt` | `DATETIME2(3)` | Opcional. |
| `UpdatedByUserId` | `UNIQUEIDENTIFIER` | FK opcional a `AppUser`. |

Claves únicas: `(IdentificationTypeId, NormalizedIdentification)` y `(PersonIdentificationId, PersonId)`.

#### `TaxRegistration`

Almacena el registro tributario verificado de una identidad RUC. La restricción única de la identificación hace que la relación sea uno a cero/uno.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `TaxRegistrationId` | `BIGINT IDENTITY` | PK. |
| `PersonIdentificationId` | `BIGINT` | FK a `PersonIdentification`; único; debe corresponder a tipo `RUC`. |
| `TaxStatus` | `NVARCHAR(100)` | Opcional. |
| `TaxpayerClass` | `NVARCHAR(100)` | Opcional. |
| `TaxAddress` | `NVARCHAR(500)` | Opcional. |
| `AccountingRequired` | `BIT` | Opcional. |
| `StartedAt` | `DATE` | Opcional. |
| `RegistryProviderId` | `SMALLINT` | FK a `RegistryProvider`. |
| `Source` | `VARCHAR(20)` | Obligatorio; `Provider` o `Manual`. |
| `VerifiedAt` | `DATETIME2(3)` | Obligatorio. |
| `VerificationExpiresAt` | `DATETIME2(3)` | Obligatorio; no anterior a `VerifiedAt`. |

#### `TaxRegistrationEconomicActivity`

Tabla puente entre un registro tributario y sus actividades económicas.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `TaxRegistrationEconomicActivityId` | `BIGINT IDENTITY` | PK. |
| `TaxRegistrationId` | `BIGINT` | FK a `TaxRegistration`. |
| `EconomicActivityId` | `BIGINT` | FK a `EconomicActivity`. |
| `ProviderActivityId` | `NVARCHAR(128)` | Opcional. |
| `IsPrimary` | `BIT` | Obligatorio; predeterminado `0`; una actividad principal por registro. |
| `VerifiedAt` | `DATETIME2(3)` | Obligatorio. |

Clave única: `(TaxRegistrationId, EconomicActivityId)`.

#### `PersonVerification`

Conserva el historial de verificaciones de una identidad ante un proveedor.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `PersonVerificationId` | `BIGINT IDENTITY` | PK. |
| `PersonIdentificationId` | `BIGINT` | FK a `PersonIdentification`. |
| `RegistryProviderId` | `SMALLINT` | FK a `RegistryProvider`. |
| `Result` | `VARCHAR(16)` | Obligatorio; `Verified`, `NotFound`, `Invalid`, `Unavailable` o `Error`. |
| `QueriedAt` | `DATETIME2(3)` | Obligatorio. |
| `ExpiresAt` | `DATETIME2(3)` | Obligatorio. |
| `PayloadHash` | `VARBINARY(32)` | Opcional; huella de la respuesta. |
| `ProviderRequestId` | `NVARCHAR(128)` | Opcional. |
| `FailureCode` | `VARCHAR(64)` | Opcional. |
| `CorrelationId` | `UNIQUEIDENTIFIER` | Obligatorio; permite trazar la consulta. |

### 3. Estructura multiempresa

#### `Company`

Representa a la empresa legal dentro del modelo multiempresa. Puede tener una empresa matriz, un representante, sucursales, perfiles y clientes.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `CompanyId` | `UNIQUEIDENTIFIER` | PK; predeterminado `NEWSEQUENTIALID()`. |
| `Identification` | `NVARCHAR(20)` | Único; obligatorio. |
| `TradeName` | `NVARCHAR(150)` | Opcional. |
| `BusinessName` | `NVARCHAR(200)` | Obligatorio. |
| `MainAddress` | `NVARCHAR(500)` | Opcional. |
| `Email` | `NVARCHAR(150)` | Opcional. |
| `IsAccountingRequired` | `BIT` | Obligatorio; predeterminado `0`. |
| `SpecialTaxpayer` | `NVARCHAR(50)` | Opcional. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `RepresentativeId` | `UNIQUEIDENTIFIER` | FK opcional a `Person`. |
| `ParentCompanyId` | `UNIQUEIDENTIFIER` | FK opcional a `Company`; no puede referenciarse a sí misma. |
| `TaxpayerType` | `NVARCHAR(50)` | Opcional. |
| `ArtisanQualification` | `NVARCHAR(10)` | Opcional. |
| `Environment` | `VARCHAR(30)` | Opcional. |
| `Currency` | `VARCHAR(3)` | Opcional; exactamente tres caracteres si se informa. |
| `Timezone` | `VARCHAR(60)` | Opcional. |
| `LanguageCode` | `VARCHAR(3)` | Opcional; entre dos y tres caracteres si se informa. |
| `CreatedBy` | `NVARCHAR(80)` | Obligatorio. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedBy` | `NVARCHAR(80)` | Opcional. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

#### `CompanyBranch`

Representa una sucursal o establecimiento de una empresa.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `CompanyBranchId` | `UNIQUEIDENTIFIER` | PK; predeterminado `NEWSEQUENTIALID()`. |
| `CompanyId` | `UNIQUEIDENTIFIER` | FK a `Company`. |
| `EstablishmentCode` | `VARCHAR(10)` | Obligatorio; único por empresa y no vacío. |
| `BranchName` | `NVARCHAR(150)` | Opcional. |
| `Address` | `NVARCHAR(300)` | Opcional. |
| `Phone` | `NVARCHAR(50)` | Opcional. |
| `Email` | `NVARCHAR(150)` | Opcional. |
| `City` | `INT` | Opcional. |
| `Province` | `CHAR(3)` | Opcional. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `CreatedBy` | `NVARCHAR(80)` | Obligatorio. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedBy` | `NVARCHAR(80)` | Opcional. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

Clave única: `(CompanyId, EstablishmentCode)`.

#### `CompanyEmissionPoint`

Representa un punto de emisión asociado a una sucursal.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `CompanyEmissionPointId` | `UNIQUEIDENTIFIER` | PK; predeterminado `NEWSEQUENTIALID()`. |
| `CompanyBranchId` | `UNIQUEIDENTIFIER` | FK a `CompanyBranch`. |
| `EmissionPointCode` | `VARCHAR(10)` | Obligatorio; único por sucursal y no vacío. |
| `Name` | `NVARCHAR(150)` | Opcional. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `CreatedBy` | `NVARCHAR(80)` | Obligatorio. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedBy` | `NVARCHAR(80)` | Opcional. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

Clave única: `(CompanyBranchId, EmissionPointCode)`.

### 4. Seguridad y acceso

#### `AppUser`

Identidad de acceso a la aplicación. El acceso a cada empresa se resuelve mediante `UserCompany`.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `UserId` | `UNIQUEIDENTIFIER` | PK; predeterminado `NEWSEQUENTIALID()`. |
| `PersonId` | `UNIQUEIDENTIFIER` | FK a `Person`. |
| `Username` | `NVARCHAR(80)` | Opcional; índice único filtrado cuando tiene valor. |
| `PasswordHash` | `NVARCHAR(500)` | Obligatorio; no puede estar vacío. |
| `Email` | `NVARCHAR(150)` | Único y obligatorio; no puede estar vacío. |
| `IsBlocked` | `BIT` | Obligatorio; predeterminado `0`. |
| `RequiresNewPassword` | `BIT` | Obligatorio; predeterminado `0`. |
| `MustUpdate` | `BIT` | Obligatorio; predeterminado `0`. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `CreatedBy` | `NVARCHAR(80)` | Obligatorio. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedBy` | `NVARCHAR(80)` | Opcional. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

#### `Profile`

Rol definido dentro de una empresa, por ejemplo `ADMIN`, `CAJERO` o `CONSULTA`.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `ProfileId` | `UNIQUEIDENTIFIER` | PK; predeterminado `NEWSEQUENTIALID()`. |
| `CompanyId` | `UNIQUEIDENTIFIER` | FK a `Company`. |
| `Name` | `NVARCHAR(150)` | Obligatorio; único por empresa y no vacío. |
| `Description` | `NVARCHAR(250)` | Opcional. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `CreatedBy` | `NVARCHAR(80)` | Obligatorio. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedBy` | `NVARCHAR(80)` | Opcional. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

Claves únicas: `(CompanyId, Name)` y `(ProfileId, CompanyId)`. La segunda soporta la FK compuesta en `UserCompanyProfile`.

#### `Permission`

Catálogo de capacidades funcionales de la aplicación; se asignan a perfiles, no directamente a usuarios.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `PermissionId` | `UNIQUEIDENTIFIER` | PK; predeterminado `NEWSEQUENTIALID()`. |
| `Code` | `NVARCHAR(150)` | Único, obligatorio y no vacío; ejemplo: `user.create`. |
| `Name` | `NVARCHAR(150)` | Obligatorio; no vacío. |
| `Description` | `NVARCHAR(250)` | Opcional. |
| `ModuleCode` | `NVARCHAR(50)` | Obligatorio; no vacío. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `CreatedBy` | `NVARCHAR(80)` | Obligatorio. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedBy` | `NVARCHAR(80)` | Opcional. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

#### `ProfilePermission`

Tabla puente que otorga permisos a un perfil.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `ProfilePermissionId` | `UNIQUEIDENTIFIER` | PK; predeterminado `NEWSEQUENTIALID()`. |
| `ProfileId` | `UNIQUEIDENTIFIER` | FK a `Profile`. |
| `PermissionId` | `UNIQUEIDENTIFIER` | FK a `Permission`. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `CreatedBy` | `NVARCHAR(80)` | Obligatorio. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedBy` | `NVARCHAR(80)` | Opcional. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

Clave única: `(ProfileId, PermissionId)`.

#### `UserCompany`

Tabla puente que habilita a un usuario para acceder a una empresa.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `UserCompanyId` | `UNIQUEIDENTIFIER` | PK; predeterminado `NEWSEQUENTIALID()`. |
| `UserId` | `UNIQUEIDENTIFIER` | FK a `AppUser`. |
| `CompanyId` | `UNIQUEIDENTIFIER` | FK a `Company`. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `CreatedBy` | `NVARCHAR(80)` | Obligatorio. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedBy` | `NVARCHAR(80)` | Opcional. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

Claves únicas: `(UserId, CompanyId)` y `(UserCompanyId, CompanyId)`. La segunda soporta la FK compuesta en `UserCompanyProfile`.

#### `UserCompanyProfile`

Asigna uno o más perfiles a un usuario dentro de una empresa. Las claves foráneas compuestas garantizan que tanto el acceso como el perfil pertenecen a la misma empresa.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `UserCompanyProfileId` | `UNIQUEIDENTIFIER` | PK; predeterminado `NEWSEQUENTIALID()`. |
| `UserCompanyId` | `UNIQUEIDENTIFIER` | Junto con `CompanyId`, FK a `UserCompany`. |
| `CompanyId` | `UNIQUEIDENTIFIER` | Parte de ambas FKs compuestas. |
| `ProfileId` | `UNIQUEIDENTIFIER` | Junto con `CompanyId`, FK a `Profile`. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `CreatedBy` | `NVARCHAR(80)` | Obligatorio. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedBy` | `NVARCHAR(80)` | Opcional. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

Clave única: `(UserCompanyId, ProfileId)`.

### 5. Proveedor y auditoría del registro tributario

#### `RegistryProvider`

Configura cada fuente externa desde la cual se consultan identificaciones y datos tributarios.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `RegistryProviderId` | `SMALLINT IDENTITY` | PK. |
| `Code` | `VARCHAR(50)` | Único. |
| `Name` | `NVARCHAR(150)` | Obligatorio. |
| `BaseUrl` | `NVARCHAR(500)` | Opcional. |
| `DefaultCacheMinutes` | `INT` | Obligatorio; mayor que cero. |
| `IsActive` | `BIT` | Obligatorio; predeterminado `1`. |
| `CreatedAt` | `DATETIME2(3)` | Obligatorio; predeterminado `SYSUTCDATETIME()`. |
| `CreatedByUserId` | `UNIQUEIDENTIFIER` | FK opcional a `AppUser`. |
| `UpdatedAt` | `DATETIME2(3)` | Opcional. |
| `UpdatedByUserId` | `UNIQUEIDENTIFIER` | FK opcional a `AppUser`. |

#### `RegistryAccessAudit`

Audita las consultas al registro global por empresa y permite rastrear el resultado con un identificador de correlación.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `RegistryAccessAuditId` | `BIGINT IDENTITY` | PK. |
| `CompanyId` | `UNIQUEIDENTIFIER` | FK a `Company`. |
| `UserId` | `UNIQUEIDENTIFIER` | FK opcional a `AppUser`. |
| `PersonIdentificationId` | `BIGINT` | FK opcional a `PersonIdentification`. |
| `RegistryProviderId` | `SMALLINT` | FK opcional a `RegistryProvider`. |
| `Outcome` | `VARCHAR(16)` | Obligatorio; `CacheHit`, `ProviderQueried`, `Denied`, `NotFound`, `Invalid`, `Unavailable` o `Error`. |
| `OccurredAt` | `DATETIME2(3)` | Obligatorio; predeterminado `SYSUTCDATETIME()`. |
| `CorrelationId` | `UNIQUEIDENTIFIER` | Obligatorio. |
| `ReasonCode` | `VARCHAR(64)` | Opcional. |

### 6. Clientes

#### `Client`

Representa la relación comercial entre una empresa y una persona. La persona es global, pero el cliente, sus condiciones comerciales y sus datos de facturación son propios de cada empresa.

| Campo | Tipo | Reglas |
| --- | --- | --- |
| `ClientId` | `UNIQUEIDENTIFIER` | PK; predeterminado `NEWSEQUENTIALID()`. |
| `CompanyId` | `UNIQUEIDENTIFIER` | FK a `Company`. |
| `PersonId` | `UNIQUEIDENTIFIER` | FK a `Person`. |
| `DefaultBillingIdentificationId` | `BIGINT` | Con `PersonId`, FK a `PersonIdentification`; asegura que la identificación sea de la misma persona. |
| `BillingAddress` | `NVARCHAR(500)` | Obligatorio; no vacío. |
| `Phone` | `NVARCHAR(50)` | Obligatorio; no vacío. |
| `Email` | `NVARCHAR(254)` | Obligatorio; formato básico de correo. |
| `CreditLimit` | `DECIMAL(18,2)` | Opcional; no negativo. |
| `PaymentTermDays` | `SMALLINT` | Opcional; entre 0 y 3650. |
| `AccountsReceivable` | `NVARCHAR(20)` | Opcional. |
| `Status` | `CHAR(1)` | FK a `EntityStatus`; predeterminado `A`. |
| `Remarks` | `NVARCHAR(500)` | Opcional. |
| `CreatedBy` | `NVARCHAR(80)` | Obligatorio. |
| `CreatedAt` | `DATETIME2(0)` | Obligatorio; predeterminado `SYSDATETIME()`. |
| `UpdatedBy` | `NVARCHAR(80)` | Opcional. |
| `UpdatedAt` | `DATETIME2(0)` | Opcional. |

Claves únicas: `(CompanyId, PersonId)` y `(ClientId, CompanyId)`. La segunda se reserva para una futura FK compuesta desde documentos comerciales, como una factura.

## Reglas de negocio críticas

1. Una persona es global; un cliente es local a una empresa. Por ello, la misma persona puede ser cliente de varias empresas, pero solo una vez por cada empresa.
2. Las identificaciones son globales y se normalizan antes de validar su unicidad. La identificación predeterminada de facturación debe pertenecer a la persona del cliente.
3. Un registro tributario solo puede existir para una identificación de tipo `RUC` y solo una vez por identidad.
4. Una empresa puede contener sucursales y cada sucursal puede contener puntos de emisión.
5. Un usuario obtiene acceso a una empresa mediante `UserCompany`; sus permisos efectivos proceden de los perfiles asignados en `UserCompanyProfile` y de los permisos de esos perfiles.
6. `UserCompanyProfile` impide asignar al usuario un perfil de otra empresa mediante las FKs compuestas con `CompanyId`.
7. La información de proveedores, verificaciones y auditoría del registro global debe conservarse para trazabilidad; no debe sustituir sin rastro los resultados previos.

## Próximas decisiones de diseño

- Definir la entidad de comprobantes electrónicos/facturas y su relación compuesta con `Client(ClientId, CompanyId)`.
- Confirmar los catálogos de ciudad, provincia, cuentas por cobrar y demás valores que hoy son campos libres.
- Definir la matriz inicial de permisos por módulo y los perfiles plantilla para nuevas empresas.
- Precisar la política de retención, cifrado y acceso a los datos de verificación tributaria y auditoría.
- Revisar índices con datos y patrones de consulta reales antes de agregar índices adicionales.

## Scripts relacionados

- Creación de tablas: [`database/tables/`](../../tables/).
- Índices: [`database/tables/indexes/`](../../tables/indexes/).
- Diagrama de referencia simplificado: [`ER_DIAGRAM.md`](ER_DIAGRAM.md).
- Contexto de integración con backend: [`BACKEND_DATABASE_CONTEXT.md`](BACKEND_DATABASE_CONTEXT.md).
