# Revision de Entidad - Profile

## Estado

Alineada al modelo single-tenant objetivo de la nueva base de datos.

## Tabla

`dbo.Profile`

## Objetivo

Representa un perfil funcional dentro de una empresa tenant. El mismo nombre puede existir en empresas distintas, pero no se repite dentro de una misma empresa. Un usuario de la empresa puede tener varias asignaciones en `UserProfile`; el perfil activo se elige por sesion.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `ProfileId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `CompanyId` | `uniqueidentifier` | No | FK a `Company.CompanyId`. |
| `Name` | `nvarchar(150)` | No | Nombre del perfil. Unico por empresa. No puede estar vacio. |
| `Description` | `nvarchar(250)` | Si | Descripcion funcional. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `CreatedBy` | `nvarchar(80)` | No | Usuario/proceso creador. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Usuario/proceso de actualizacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_Profile` | Primary key | `ProfileId` | Identificador unico. |
| `UQ_Profile_Company_Name` | Unique | `CompanyId`, `Name` | Evita perfiles duplicados por empresa. |
| `UQ_Profile_ProfileId_CompanyId` | Unique | `ProfileId`, `CompanyId` | Soporta la FK compuesta desde `UserProfile`. |
| `DF_Profile_ProfileId` | Default | `ProfileId` | `newsequentialid()`. |
| `DF_Profile_Status` | Default | `Status` | `A`. |
| `DF_Profile_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_Profile_Company` | Foreign key | `CompanyId` | Referencia `Company`. |
| `FK_Profile_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |
| `CK_Profile_Name_NotBlank` | Check | `Name` | Evita nombre vacio. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `Profile.CompanyId -> Company.CompanyId` | Muchos a 1 | Perfil definido por empresa. |
| `Profile.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |
| `ProfilePermission.ProfileId -> Profile.ProfileId` | Muchos a 1 | Permisos asignados al perfil. |
| `UserProfile.(ProfileId, CompanyId) -> Profile.(ProfileId, CompanyId)` | Muchos a 1 | Valida que el perfil asignado pertenezca a la empresa unica del usuario. |
| `UserProfile.UserId -> AppUser.UserId` | Muchos a 1 | Asignaciones multiples de perfiles por usuario. |

## Modelos de Aplicacion

- C#: `database/docs/db/entities/profile/Profile.cs`
- TypeScript: `database/docs/db/entities/profile/profile.ts`

## Scripts

- Esquema actual recibido desde BD: `database/docs/db/entities/profile/00-current-schema.sql`
- Script normalizado para repo: `database/tables/08-create-table-profile.sql`

## Notas

- La estructura actual no declara indices adicionales fuera de la PK y los unique constraints.
- La estructura actual no declara un check directo para limitar `Status` a `A`/`I`; esa validez depende de la FK a `EntityStatus`.
