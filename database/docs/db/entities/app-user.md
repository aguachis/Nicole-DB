# Revision de Entidad - AppUser

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.AppUser`

## Objetivo

Representa la identidad de acceso a la aplicacion. Se relaciona con `Person` para los datos personales y con `UserCompany` para definir a que empresas puede acceder.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `UserId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `PersonId` | `uniqueidentifier` | No | FK a `Person.PersonId`. |
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
| `AppUser.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |
| `UserCompany.UserId -> AppUser.UserId` | Muchos a 1 | Empresas a las que accede el usuario. |

## Modelos de Aplicacion

- C#: `database/docs/db/entities/app-user/AppUser.cs`
- TypeScript: `database/docs/db/entities/app-user/app-user.ts`

## Scripts

- Esquema actual recibido desde BD: `database/docs/db/entities/app-user/00-current-schema.sql`
- Script normalizado para repo: `database/tables/07-create-table-app-user.sql`

## Notas

- La estructura actual usa `dbo.AppUser`, no `dbo.[User]`.
- `Username` es opcional y no tiene constraint de unicidad; el login canonico debe ser `Email`.
