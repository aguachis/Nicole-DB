# Revision de Entidad - EntityStatus

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.EntityStatus`

## Objetivo

Catalogo canonico para los estados basicos usados por las entidades del sistema. Normaliza columnas `Status char(1)` en tablas como `Company`, `CompanyBranch` y `CompanyEmissionPoint`.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `StatusCode` | `char(1)` | No | PK. Valores permitidos: `A`, `I`. |
| `StatusName` | `nvarchar(100)` | No | Nombre unico del estado. |
| `StatusDescription` | `nvarchar(255)` | Si | Descripcion funcional. |
| `IsActive` | `bit` | No | Default `1`. |
| `SortOrder` | `tinyint` | No | Default `0`. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_EntityStatus` | Primary key | `StatusCode` | Identificador del estado. |
| `UQ_EntityStatus_StatusName` | Unique | `StatusName` | No permite nombres duplicados. |
| `DF_EntityStatus_IsActive` | Default | `IsActive` | `1`. |
| `DF_EntityStatus_SortOrder` | Default | `SortOrder` | `0`. |
| `DF_EntityStatus_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `CK_EntityStatus_StatusCode` | Check | `StatusCode` | Solo permite `A` o `I`. |

## Valores Esperados

| Codigo | Nombre sugerido | Uso |
| --- | --- | --- |
| `A` | Activo | Registro habilitado para uso operativo. |
| `I` | Inactivo | Registro deshabilitado para uso operativo. |

## Relaciones

Esta tabla es referenciada por entidades con columna `Status`, por ejemplo:

- `Company.Status`
- `CompanyBranch.Status`
- `CompanyEmissionPoint.Status`

## Modelos de Aplicacion

- C#: `docs/db/entities/status/EntityStatus.cs`
- TypeScript: `docs/db/entities/status/entity-status.ts`

## Scripts

- Esquema actual recibido desde BD: `docs/db/entities/status/00-current-schema.sql`
- Script normalizado para repo: `tables/00-create-table-entitystatus.sql`

## Notas

- La estructura actual no declara indices adicionales fuera de la PK y el unique por `StatusName`.
- Los datos iniciales se mantienen en `seeds/99-insert-mock-data.sql`.
