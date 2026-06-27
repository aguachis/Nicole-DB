# Revision de Entidad - CompanyEmissionPoint

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.CompanyEmissionPoint`

## Objetivo

Representa un punto de emision asociado a una sucursal. Es clave para facturacion, porque permite identificar el punto operativo desde el que se emiten documentos.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `CompanyEmissionPointId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `CompanyBranchId` | `uniqueidentifier` | No | FK a `CompanyBranch.CompanyBranchId`. |
| `EmissionPointCode` | `varchar(10)` | No | Codigo de punto de emision. Unico por sucursal. No puede estar vacio. |
| `Name` | `nvarchar(150)` | Si | Nombre descriptivo del punto de emision. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `CreatedBy` | `nvarchar(80)` | No | Usuario/proceso creador. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Usuario/proceso de actualizacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_CompanyEmissionPoint` | Primary key | `CompanyEmissionPointId` | Identificador unico. |
| `UQ_CompanyEmissionPoint_Branch_EmissionPointCode` | Unique | `CompanyBranchId`, `EmissionPointCode` | El punto de emision no se repite dentro de la misma sucursal. |
| `DF_CompanyEmissionPoint_Id` | Default | `CompanyEmissionPointId` | `newsequentialid()`. |
| `DF_CompanyEmissionPoint_Status` | Default | `Status` | `A`. |
| `DF_CompanyEmissionPoint_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_CompanyEmissionPoint_CompanyBranch` | Foreign key | `CompanyBranchId` | Referencia `CompanyBranch`. |
| `FK_CompanyEmissionPoint_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |
| `CK_CompanyEmissionPoint_Code_NotBlank` | Check | `EmissionPointCode` | Evita codigo vacio. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `CompanyEmissionPoint.CompanyBranchId -> CompanyBranch.CompanyBranchId` | Muchos a 1 | Una sucursal puede tener varios puntos de emision. |
| `CompanyEmissionPoint.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |

## Modelos de Aplicacion

- C#: `docs/db/entities/company-emission-point/CompanyEmissionPoint.cs`
- TypeScript: `docs/db/entities/company-emission-point/company-emission-point.ts`

## Scripts

- Esquema actual recibido desde BD: `docs/db/entities/company-emission-point/00-current-schema.sql`
- Script normalizado para repo: `docs/db/entities/company-emission-point/00-create-table-company-emission-point.sql`

## Notas

- La estructura actual no declara indices adicionales fuera de la PK y el unique por `CompanyBranchId + EmissionPointCode`.
- La estructura actual no declara un check directo para limitar `Status` a `A`/`I`; esa validez depende de la FK a `EntityStatus`.
