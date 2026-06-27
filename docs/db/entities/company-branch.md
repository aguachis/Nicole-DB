# Revision de Entidad - CompanyBranch

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.CompanyBranch`

## Objetivo

Representa una sucursal o establecimiento operativo de una empresa. Es la entidad intermedia entre `Company` y los puntos de emision usados para facturacion.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `CompanyBranchId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `CompanyId` | `uniqueidentifier` | No | FK a `Company.CompanyId`. |
| `EstablishmentCode` | `varchar(10)` | No | Codigo de establecimiento. Unico por empresa. No puede estar vacio. |
| `BranchName` | `nvarchar(150)` | Si | Nombre de la sucursal. |
| `Address` | `nvarchar(300)` | Si | Direccion de la sucursal. |
| `Phone` | `nvarchar(50)` | Si | Telefono. |
| `Email` | `nvarchar(150)` | Si | Correo. |
| `City` | `int` | Si | Codigo de ciudad. |
| `Province` | `char(3)` | Si | Codigo de provincia. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `CreatedBy` | `nvarchar(80)` | No | Usuario/proceso creador. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Usuario/proceso de actualizacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_CompanyBranch` | Primary key | `CompanyBranchId` | Identificador unico. |
| `UQ_CompanyBranch_Company_EstablishmentCode` | Unique | `CompanyId`, `EstablishmentCode` | El codigo de establecimiento no se repite dentro de la misma empresa. |
| `DF_CompanyBranch_CompanyBranchId` | Default | `CompanyBranchId` | `newsequentialid()`. |
| `DF_CompanyBranch_Status` | Default | `Status` | `A`. |
| `DF_CompanyBranch_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_CompanyBranch_Company` | Foreign key | `CompanyId` | Referencia `Company`. |
| `FK_CompanyBranch_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |
| `CK_CompanyBranch_EstablishmentCode_NotBlank` | Check | `EstablishmentCode` | Evita codigo vacio. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `CompanyBranch.CompanyId -> Company.CompanyId` | Muchos a 1 | Una empresa puede tener varias sucursales. |
| `CompanyBranch.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |

## Modelos de Aplicacion

- C#: `docs/db/entities/company-branch/CompanyBranch.cs`
- TypeScript: `docs/db/entities/company-branch/company-branch.ts`

## Scripts

- Esquema actual recibido desde BD: `docs/db/entities/company-branch/00-current-schema.sql`
- Script normalizado para repo: `docs/db/entities/company-branch/00-create-table-company-branch.sql`

## Notas

- La estructura actual no declara indices adicionales fuera de la PK y el unique por `CompanyId + EstablishmentCode`.
- La estructura actual no declara un check directo para limitar `Status` a `A`/`I`; esa validez depende de la FK a `EntityStatus`.
