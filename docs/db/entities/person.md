# Revision de Entidad - Person

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.Person`

## Objetivo

Representa personas naturales y juridicas en una sola entidad canonica. Es usada por usuarios, representantes legales de empresas y futuras entidades comerciales como clientes o proveedores.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `PersonId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `IdentificationType` | `char(2)` | No | FK a `IdentificationType`. |
| `Identification` | `nvarchar(20)` | No | Identificacion. Unica junto con `IdentificationType`. No puede estar vacia. |
| `PersonType` | `char(1)` | No | FK a `PersonType`. Define persona natural (`N`) o juridica (`J`). |
| `LastName` | `nvarchar(80)` | Si | Requerido si `PersonType = 'N'`. |
| `MiddleName` | `nvarchar(80)` | Si | Segundo apellido o nombre intermedio. |
| `FirstName` | `nvarchar(200)` | Si | Requerido si `PersonType = 'N'`. |
| `BusinessName` | `nvarchar(200)` | Si | Requerido si `PersonType = 'J'`. |
| `Gender` | `char(1)` | Si | Null, `M` o `F`. |
| `BirthDate` | `date` | Si | Fecha de nacimiento. |
| `Address` | `nvarchar(300)` | Si | Direccion. |
| `Phone` | `nvarchar(50)` | Si | Telefono. |
| `Email` | `nvarchar(150)` | Si | Correo. |
| `Province` | `char(3)` | Si | Codigo de provincia. |
| `City` | `int` | Si | Codigo de ciudad. |
| `Remarks` | `nvarchar(500)` | Si | Observaciones. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `CreatedBy` | `nvarchar(80)` | No | Usuario/proceso creador. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Usuario/proceso de actualizacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_Person` | Primary key | `PersonId` | Identificador unico. |
| `UQ_Person_IdentificationType_Identification` | Unique | `IdentificationType`, `Identification` | Evita identidades duplicadas. |
| `DF_Person_PersonId` | Default | `PersonId` | `newsequentialid()`. |
| `DF_Person_Status` | Default | `Status` | `A`. |
| `DF_Person_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_Person_IdentificationType` | Foreign key | `IdentificationType` | Referencia `IdentificationType`. |
| `FK_Person_PersonType` | Foreign key | `PersonType` | Referencia `PersonType`. |
| `FK_Person_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |
| `CK_Person_Gender` | Check | `Gender` | Permite null, `M` o `F`. |
| `CK_Person_Identification_NotBlank` | Check | `Identification` | Evita identificacion vacia. |
| `CK_Person_NaturalOrLegalData` | Check | `PersonType`, nombres | Persona natural requiere `FirstName` y `LastName`; juridica requiere `BusinessName`. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `Person.IdentificationType -> IdentificationType.IdentificationTypeId` | Muchos a 1 | Tipo de identificacion. |
| `Person.PersonType -> PersonType.PersonTypeId` | Muchos a 1 | Tipo de persona. |
| `Person.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |
| `Company.RepresentativeId -> Person.PersonId` | Muchos a 1 | Representante legal. |
| `AppUser.PersonId -> Person.PersonId` | Muchos a 1 | Persona asociada al usuario. |

## Modelos de Aplicacion

- C#: `docs/db/entities/person/Person.cs`
- TypeScript: `docs/db/entities/person/person.ts`

## Scripts

- Esquema actual recibido desde BD: `docs/db/entities/person/00-current-schema.sql`
- Script normalizado para repo: `tables/03-create-table-person.sql`

## Notas

- La estructura actual no declara indices adicionales fuera de la PK y el unique por `IdentificationType + Identification`.
- La estructura actual no declara un check directo para limitar `Status` a `A`/`I`; esa validez depende de la FK a `EntityStatus`.
