# Revision de Entidad - AppUser

## Estado

Definicion objetivo para la nueva base de datos; modelo single-tenant por usuario.

## Tabla

`dbo.AppUser`

## Objetivo

Representa la identidad de acceso a la aplicacion y su unica empresa tenant. Los datos personales se mantienen en `Person`; sus multiples perfiles se asignan mediante `UserProfile`.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `UserId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `PersonId` | `uniqueidentifier` | No | FK a `Person.PersonId`. |
| `CompanyId` | `uniqueidentifier` | No | FK a `Company.CompanyId`; cada usuario pertenece a una sola empresa. |
| `Username` | `nvarchar(80)` | Si | Alias opcional. No tiene unique constraint en la estructura actual. |
| `PasswordHash` | `nvarchar(500)` | No | Hash de contrasena. No puede estar vacio. |
| `Email` | `nvarchar(150)` | No | Correo de login. Unico. No puede estar vacio. |
| `IsBlocked` | `bit` | No | Default `0`. |
| `RequiresNewPassword` | `bit` | No | Default `0`. |
| `MustUpdate` | `bit` | No | Default `0`. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `CreatedBy` | `nvarchar(80)` | No | Usuario/proceso creador. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Usuario/proceso de actualizacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_AppUser` | Primary key | `UserId` | Identificador unico. |
| `UQ_AppUser_Email` | Unique | `Email` | No permite correos duplicados. |
| `UQ_AppUser_UserId_CompanyId` | Unique | `UserId`, `CompanyId` | Clave candidata para validar por FK compuesta la empresa de cada asignacion. |
| `FK_AppUser_Company` | Foreign key | `CompanyId` | Referencia la empresa tenant. |
| `DF_AppUser_UserId` | Default | `UserId` | `newsequentialid()`. |
| `DF_AppUser_IsBlocked` | Default | `IsBlocked` | `0`. |
| `DF_AppUser_RequiresNewPassword` | Default | `RequiresNewPassword` | `0`. |
| `DF_AppUser_MustUpdate` | Default | `MustUpdate` | `0`. |
| `DF_AppUser_Status` | Default | `Status` | `A`. |
| `DF_AppUser_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_AppUser_Person` | Foreign key | `PersonId` | Referencia `Person`. |
| `FK_AppUser_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |
| `CK_AppUser_Email_NotBlank` | Check | `Email` | Evita email vacio. |
| `CK_AppUser_PasswordHash_NotBlank` | Check | `PasswordHash` | Evita hash vacio. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `AppUser.PersonId -> Person.PersonId` | Muchos a 1 | Persona asociada al usuario. |
| `AppUser.CompanyId -> Company.CompanyId` | Muchos a 1 | Cada usuario queda asignado a una sola empresa; una empresa puede tener muchos usuarios. |
| `AppUser.(UserId, CompanyId) -> UserProfile.(UserId, CompanyId)` | 1 a muchos | Todas las asignaciones mantienen la empresa unica del usuario. |
| `AppUser.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |

## Modelos de Aplicacion

- C#: `database/docs/db/entities/app-user/AppUser.cs`
- TypeScript: `database/docs/db/entities/app-user/app-user.ts`
- Asignaciones de perfil: `database/docs/db/entities/user-profile.md`

## Scripts

- Esquema actual recibido desde BD: `database/docs/db/entities/app-user/00-current-schema.sql`
- Script normalizado para repo: `database/tables/07-create-table-app-user.sql`

## Notas

- La estructura actual usa `dbo.AppUser`, no `dbo.[User]`.
- `Username` es opcional y no tiene constraint de unicidad; el login canonico debe ser `Email`.
- La empresa es obligatoria y unica por usuario; las asignaciones de perfiles viven en `UserProfile`.
