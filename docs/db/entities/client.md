# Revision de Entidad - Client

## Estado

Definida como propuesta normalizada para snapshot comercial el 2026-07-25.

## Tabla

`dbo.Client`

## Objetivo

Representa el snapshot comercial de un cliente para una empresa especifica. Permite registrar datos de operacion (razon social comercial, flags tributarios y observaciones) sin depender exclusivamente de la version vigente de `Person`.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `ClientId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `Identification` | `nvarchar(20)` | No | Identificacion comercial del cliente dentro de la empresa. No vacia. |
| `CompanyId` | `uniqueidentifier` | No | FK a `Company.CompanyId`. |
| `PersonId` | `uniqueidentifier` | No | FK a `Person.PersonId`. |
| `BusinessName` | `nvarchar(200)` | No | Razon social en contexto comercial. No vacia. |
| `TradeName` | `nvarchar(150)` | Si | Nombre comercial. |
| `AccountsReceivable` | `nvarchar(20)` | Si | Referencia de cartera/cuenta por cobrar. |
| `IsTaxExempt` | `bit` | No | Default `0`. Indicador de exento tributario. |
| `IsSpecialTaxpayer` | `bit` | No | Default `0`. Indicador de contribuyente especial. |
| `RequiresAccounting` | `bit` | No | Default `0`. Indicador de exigencia contable. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `AdditionalEmails` | `nvarchar(250)` | Si | Correos adicionales separados por politica de aplicacion. |
| `Remarks` | `nvarchar(500)` | Si | Observaciones operativas. |
| `CreatedBy` | `nvarchar(80)` | No | Usuario/proceso creador. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Usuario/proceso de actualizacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_Client` | Primary key | `ClientId` | Identificador unico. |
| `UQ_Client_Company_Person` | Unique | `CompanyId`, `PersonId` | Evita duplicar cliente para la misma persona dentro de la misma empresa. |
| `UQ_Client_Company_Identification` | Unique | `CompanyId`, `Identification` | Evita identificaciones duplicadas dentro de la misma empresa. |
| `DF_Client_ClientId` | Default | `ClientId` | `newsequentialid()`. |
| `DF_Client_IsTaxExempt` | Default | `IsTaxExempt` | `0`. |
| `DF_Client_IsSpecialTaxpayer` | Default | `IsSpecialTaxpayer` | `0`. |
| `DF_Client_RequiresAccounting` | Default | `RequiresAccounting` | `0`. |
| `DF_Client_Status` | Default | `Status` | `A`. |
| `DF_Client_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_Client_Company` | Foreign key | `CompanyId` | Referencia `Company`. |
| `FK_Client_Person` | Foreign key | `PersonId` | Referencia `Person`. |
| `FK_Client_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |
| `CK_Client_Identification_NotBlank` | Check | `Identification` | Evita identificacion vacia. |
| `CK_Client_BusinessName_NotBlank` | Check | `BusinessName` | Evita razon social vacia. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `Client.CompanyId -> Company.CompanyId` | Muchos a 1 | Contexto multiempresa del cliente. |
| `Client.PersonId -> Person.PersonId` | Muchos a 1 | Vinculo canonico con persona. |
| `Client.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |

## Indices recomendados

| Indice | Columnas | Include | Uso |
| --- | --- | --- | --- |
| `IX_Client_Company_Status` | `CompanyId`, `Status` | `ClientId`, `PersonId`, `Identification`, `BusinessName` | Listados y filtros operativos por empresa/estado. |

## Scripts

- Script normalizado para repo: `tables/13-create-table-client.sql`
- Indice recomendado integrado en: `tables/indexes/02-recommended-indexes.sql`

## Notas

- `Client` se define como snapshot comercial: los datos de nombre/identificacion pueden diferir de `Person` por historico de operacion.
- La aplicacion debe documentar la politica de sincronizacion (manual, automatica o solo alta inicial) entre `Person` y `Client`.
