# Revision de Entidad - Profile

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.Profile`

## Objetivo

Representa un perfil o rol dentro de una empresa. El modelo es multiempresa: el mismo nombre de perfil puede existir en empresas distintas, pero no se repite dentro de la misma empresa.

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
| `UQ_Profile_ProfileId_CompanyId` | Unique | `ProfileId`, `CompanyId` | Soporta FK compuesta desde `UserCompanyProfile`. |
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
| `UserCompanyProfile(ProfileId, CompanyId) -> Profile(ProfileId, CompanyId)` | Muchos a 1 | Valida que el perfil pertenezca a la empresa del usuario. |

## Modelos de Aplicacion

- C#: `docs/db/entities/profile/Profile.cs`
- TypeScript: `docs/db/entities/profile/profile.ts`

## Scripts

- Esquema actual recibido desde BD: `docs/db/entities/profile/00-current-schema.sql`
- Script normalizado para repo: `tables/08-create-table-profile.sql`

## Notas

- La estructura actual no declara indices adicionales fuera de la PK y los unique constraints.
- La estructura actual no declara un check directo para limitar `Status` a `A`/`I`; esa validez depende de la FK a `EntityStatus`.
