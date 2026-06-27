# Revision de Entidad - UserCompany

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.UserCompany`

## Objetivo

Relaciona usuarios de la aplicacion con empresas. Permite que un usuario acceda a una o varias empresas y sirve como base para asignar perfiles por empresa mediante `UserCompanyProfile`.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `UserCompanyId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `UserId` | `uniqueidentifier` | No | FK a `AppUser.UserId`. |
| `CompanyId` | `uniqueidentifier` | No | FK a `Company.CompanyId`. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `CreatedBy` | `nvarchar(80)` | No | Usuario/proceso creador. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Usuario/proceso de actualizacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_UserCompany` | Primary key | `UserCompanyId` | Identificador unico. |
| `UQ_UserCompany_User_Company` | Unique | `UserId`, `CompanyId` | Evita duplicar acceso del mismo usuario a la misma empresa. |
| `UQ_UserCompany_UserCompanyId_CompanyId` | Unique | `UserCompanyId`, `CompanyId` | Soporta FK compuesta desde `UserCompanyProfile`. |
| `DF_UserCompany_UserCompanyId` | Default | `UserCompanyId` | `newsequentialid()`. |
| `DF_UserCompany_Status` | Default | `Status` | `A`. |
| `DF_UserCompany_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_UserCompany_Company` | Foreign key | `CompanyId` | Referencia `Company`. |
| `FK_UserCompany_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |
| `FK_UserCompany_User` | Foreign key | `UserId` | Referencia `AppUser`. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `UserCompany.UserId -> AppUser.UserId` | Muchos a 1 | Usuario con acceso a empresa. |
| `UserCompany.CompanyId -> Company.CompanyId` | Muchos a 1 | Empresa a la que accede el usuario. |
| `UserCompany.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |
| `UserCompanyProfile(UserCompanyId, CompanyId) -> UserCompany(UserCompanyId, CompanyId)` | Muchos a 1 | Valida que el perfil se asigne dentro de la misma empresa. |

## Modelos de Aplicacion

- C#: `docs/db/entities/user-company/UserCompany.cs`
- TypeScript: `docs/db/entities/user-company/user-company.ts`

## Scripts

- Esquema actual recibido desde BD: `docs/db/entities/user-company/00-current-schema.sql`
- Script normalizado para repo: `docs/db/entities/user-company/00-create-table-user-company.sql`

## Notas

- La estructura actual no declara indices adicionales fuera de la PK y los unique constraints.
- La estructura actual no declara un check directo para limitar `Status` a `A`/`I`; esa validez depende de la FK a `EntityStatus`.
