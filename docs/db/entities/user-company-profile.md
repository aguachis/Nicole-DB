# Revision de Entidad - UserCompanyProfile

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.UserCompanyProfile`

## Objetivo

Asigna perfiles a usuarios dentro de una empresa. Esta tabla materializa la regla principal de seguridad: un usuario puede tener perfiles distintos segun la empresa activa.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `UserCompanyProfileId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `UserCompanyId` | `uniqueidentifier` | No | Parte de FK compuesta a `UserCompany`. |
| `CompanyId` | `uniqueidentifier` | No | Valida la empresa en ambas FKs compuestas. |
| `ProfileId` | `uniqueidentifier` | No | Parte de FK compuesta a `Profile`. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `CreatedBy` | `nvarchar(80)` | No | Usuario/proceso creador. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Usuario/proceso de actualizacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_UserCompanyProfile` | Primary key | `UserCompanyProfileId` | Identificador unico. |
| `UQ_UserCompanyProfile_UserCompany_Profile` | Unique | `UserCompanyId`, `ProfileId` | Evita duplicar el mismo perfil para una relacion usuario-empresa. |
| `DF_UserCompanyProfile_Id` | Default | `UserCompanyProfileId` | `newsequentialid()`. |
| `DF_UserCompanyProfile_Status` | Default | `Status` | `A`. |
| `DF_UserCompanyProfile_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_UserCompanyProfile_Profile` | Foreign key compuesta | `ProfileId`, `CompanyId` | Referencia `Profile(ProfileId, CompanyId)`. |
| `FK_UserCompanyProfile_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |
| `FK_UserCompanyProfile_UserCompany` | Foreign key compuesta | `UserCompanyId`, `CompanyId` | Referencia `UserCompany(UserCompanyId, CompanyId)`. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `UserCompanyProfile(UserCompanyId, CompanyId) -> UserCompany(UserCompanyId, CompanyId)` | Muchos a 1 | Garantiza que el usuario pertenece a la empresa. |
| `UserCompanyProfile(ProfileId, CompanyId) -> Profile(ProfileId, CompanyId)` | Muchos a 1 | Garantiza que el perfil pertenece a la misma empresa. |
| `UserCompanyProfile.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |

## Modelos de Aplicacion

- C#: `docs/db/entities/user-company-profile/UserCompanyProfile.cs`
- TypeScript: `docs/db/entities/user-company-profile/user-company-profile.ts`

## Scripts

- Esquema actual recibido desde BD: `docs/db/entities/user-company-profile/00-current-schema.sql`
- Script normalizado para repo: `tables/12-create-table-user-company-profile.sql`

## Notas

- Las FKs compuestas son intencionales: evitan asignar a un usuario un perfil de otra empresa.
- La estructura actual no declara indices adicionales fuera de la PK y el unique por `UserCompanyId + ProfileId`.
- La estructura actual no declara un check directo para limitar `Status` a `A`/`I`; esa validez depende de la FK a `EntityStatus`.
