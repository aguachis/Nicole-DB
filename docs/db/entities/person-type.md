# Revision de Entidad - PersonType

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.PersonType`

## Objetivo

Catalogo base para clasificar personas como naturales o juridicas. La tabla `Person` depende de este catalogo mediante `Person.PersonType`.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `PersonTypeId` | `char(1)` | No | PK. Codigo del tipo de persona. |
| `Name` | `nvarchar(50)` | No | Nombre unico. |
| `Description` | `nvarchar(150)` | Si | Descripcion funcional. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_PersonType` | Primary key | `PersonTypeId` | Identificador unico. |
| `UQ_PersonType_Name` | Unique | `Name` | No permite nombres duplicados. |
| `DF_PersonType_Status` | Default | `Status` | `A`. |
| `DF_PersonType_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_PersonType_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |

## Valores Esperados

| Codigo | Nombre sugerido | Uso |
| --- | --- | --- |
| `N` | Persona natural | Persona individual. |
| `J` | Persona juridica | Empresa, institucion o entidad legal. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `PersonType.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |
| `Person.PersonType -> PersonType.PersonTypeId` | Muchos a 1 | Tipo de persona. |

## Modelos de Aplicacion

- C#: `docs/db/entities/person-type/PersonType.cs`
- TypeScript: `docs/db/entities/person-type/person-type.ts`

## Scripts

- Esquema actual recibido desde BD: `docs/db/entities/person-type/00-current-schema.sql`
- Script normalizado para repo: `tables/02-create-table-person-type.sql`

## Notas

- La estructura actual no declara indices adicionales fuera de la PK y el unique por `Name`.
- La estructura actual no declara checks directos para limitar `PersonTypeId` a `N`/`J` ni `Status` a `A`/`I`.
- Los datos iniciales se mantienen en `seeds/99-insert-mock-data.sql`.
