# Revision de Entidad - IdentificationType

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.IdentificationType`

## Objetivo

Catalogo de tipos de identificacion usados por `Person`. Permite distinguir RUC, cedula, pasaporte y otros tipos requeridos por procesos tributarios o comerciales.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `IdentificationTypeId` | `char(2)` | No | PK. Codigo del tipo de identificacion. |
| `Name` | `nvarchar(50)` | No | Nombre unico. |
| `Description` | `nvarchar(150)` | Si | Descripcion funcional. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_IdentificationType` | Primary key | `IdentificationTypeId` | Identificador unico. |
| `UQ_IdentificationType_Name` | Unique | `Name` | No permite nombres duplicados. |
| `DF_IdentificationType_Status` | Default | `Status` | `A`. |
| `DF_IdentificationType_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_IdentificationType_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |

## Valores Esperados

| Codigo | Nombre sugerido |
| --- | --- |
| `04` | RUC |
| `05` | CEDULA |
| `06` | PASAPORTE |
| `07` | CONSUMIDOR FINAL |
| `08` | IDENTIFICACION DEL EXTERIOR |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `IdentificationType.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |
| `Person.IdentificationType -> IdentificationType.IdentificationTypeId` | Muchos a 1 | Tipo de identificacion de la persona. |

## Modelos de Aplicacion

- C#: `database/docs/db/entities/identification-type/IdentificationType.cs`
- TypeScript: `database/docs/db/entities/identification-type/identification-type.ts`

## Scripts

- Esquema actual recibido desde BD: `database/docs/db/entities/identification-type/00-current-schema.sql`
- Script normalizado para repo: `database/tables/01-create-table-identification-type.sql`

## Notas

- La estructura actual no declara indices adicionales fuera de la PK y el unique por `Name`.
- La estructura actual no declara un check directo para limitar `Status` a `A`/`I`; esa validez depende de la FK a `EntityStatus`.
- Los datos iniciales se mantienen en `database/seeds/99-insert-mock-data.sql`.

## Extensión: registro global de clientes (2026-09-05)

El identificador físico `IdentificationTypeId char(2)` se conserva como clave para compatibilidad. La migración agrega los metadatos operativos `Code`, `MinLength`, `MaxLength`, `IsNumericOnly`, `AllowsNaturalPerson`, `AllowsLegalEntity`, `IsBillingAllowed` e `IsActive`.

`Code` es el código estable del contrato backend (`CEDULA`, `RUC`, etc.). Los procedimientos reciben ese código y resuelven el `IdentificationTypeId` internamente. Las validaciones de longitud, formato y clase de persona se aplican a `PersonIdentification`; no deben ser reimplementadas por un consumidor SQL. Un tipo asociado a un `TaxRegistration` no puede recodificarse desde `RUC`.

DDL: `database/migrations/20260905_002_centralizar_registro_global_clientes_forward.sql`; metadatos iniciales: `database/seeds/20260905_001_centralizar_registro_global_clientes_identification_types.sql`.
