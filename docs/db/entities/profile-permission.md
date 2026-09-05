# Revision de Entidad - ProfilePermission

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.ProfilePermission`

## Objetivo

Relaciona perfiles con permisos funcionales. Es la tabla puente que define que acciones puede ejecutar un perfil dentro del sistema.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `ProfilePermissionId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `ProfileId` | `uniqueidentifier` | No | FK a `Profile.ProfileId`. |
| `PermissionId` | `uniqueidentifier` | No | FK a `Permission.PermissionId`. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `CreatedBy` | `nvarchar(80)` | No | Usuario/proceso creador. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Usuario/proceso de actualizacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_ProfilePermission` | Primary key | `ProfilePermissionId` | Identificador unico. |
| `UQ_ProfilePermission_Profile_Permission` | Unique | `ProfileId`, `PermissionId` | Evita duplicar el mismo permiso en un perfil. |
| `DF_ProfilePermission_Id` | Default | `ProfilePermissionId` | `newsequentialid()`. |
| `DF_ProfilePermission_Status` | Default | `Status` | `A`. |
| `DF_ProfilePermission_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_ProfilePermission_Permission` | Foreign key | `PermissionId` | Referencia `Permission`. |
| `FK_ProfilePermission_Profile` | Foreign key | `ProfileId` | Referencia `Profile`. |
| `FK_ProfilePermission_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `ProfilePermission.ProfileId -> Profile.ProfileId` | Muchos a 1 | Perfil que recibe permisos. |
| `ProfilePermission.PermissionId -> Permission.PermissionId` | Muchos a 1 | Permiso asignado. |
| `ProfilePermission.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |

## Modelos de Aplicacion

- C#: `docs/db/entities/profile-permission/ProfilePermission.cs`
- TypeScript: `docs/db/entities/profile-permission/profile-permission.ts`

## Scripts

- Esquema actual recibido desde BD: `docs/db/entities/profile-permission/00-current-schema.sql`
- Script normalizado para repo: `tables/10-create-table-profile-permission.sql`

## Notas

- La estructura actual no declara indices adicionales fuera de la PK y el unique por `ProfileId + PermissionId`.
- La estructura actual no declara un check directo para limitar `Status` a `A`/`I`; esa validez depende de la FK a `EntityStatus`.
