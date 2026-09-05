# Revision de Entidad - Permission

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.Permission`

## Objetivo

Cataloga permisos funcionales que la aplicacion debe validar para autorizar acciones. El backend debe usar `Code` como identificador tecnico estable, por ejemplo `user.create` o `company.read`.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `PermissionId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `Code` | `nvarchar(150)` | No | Codigo tecnico unico. No puede estar vacio. |
| `Name` | `nvarchar(150)` | No | Nombre funcional. No puede estar vacio. |
| `Description` | `nvarchar(250)` | Si | Descripcion funcional. |
| `ModuleCode` | `nvarchar(50)` | No | Modulo al que pertenece el permiso. No puede estar vacio. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `CreatedBy` | `nvarchar(80)` | No | Usuario/proceso creador. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Usuario/proceso de actualizacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_Permission` | Primary key | `PermissionId` | Identificador unico. |
| `UQ_Permission_Code` | Unique | `Code` | No permite codigos duplicados. |
| `DF_Permission_PermissionId` | Default | `PermissionId` | `newsequentialid()`. |
| `DF_Permission_Status` | Default | `Status` | `A`. |
| `DF_Permission_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_Permission_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |
| `CK_Permission_Code_NotBlank` | Check | `Code` | Evita codigo vacio. |
| `CK_Permission_ModuleCode_NotBlank` | Check | `ModuleCode` | Evita modulo vacio. |
| `CK_Permission_Name_NotBlank` | Check | `Name` | Evita nombre vacio. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `Permission.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |
| `ProfilePermission.PermissionId -> Permission.PermissionId` | Muchos a 1 | Asignacion de permisos a perfiles. |

## Modelos de Aplicacion

- C#: `docs/db/entities/permission/Permission.cs`
- TypeScript: `docs/db/entities/permission/permission.ts`

## Scripts

- Esquema actual recibido desde BD: `docs/db/entities/permission/00-current-schema.sql`
- Script normalizado para repo: `tables/09-create-table-permission.sql`

## Notas

- La estructura actual no declara indices adicionales fuera de la PK y el unique por `Code`.
- La estructura actual no declara un check directo para limitar `Status` a `A`/`I`; esa validez depende de la FK a `EntityStatus`.
