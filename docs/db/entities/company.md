# Revision de Entidad - Company

## Estado

Actualizada contra BD Nicole el 2026-06-19.

## Tabla

`dbo.Company`

## Objetivo

Representa la empresa legal dentro del modelo multiempresa del S.A.S. Sirve como raiz para usuarios por empresa, sucursales, puntos de emision y futuros modulos de inventario/facturacion.

## Campos

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `CompanyId` | `uniqueidentifier` | No | PK. Default `newsequentialid()`. |
| `Identification` | `nvarchar(20)` | No | Identificacion/RUC. Unico. |
| `TradeName` | `nvarchar(150)` | Si | Nombre comercial. |
| `BusinessName` | `nvarchar(200)` | No | Razon social. |
| `Email` | `nvarchar(150)` | Si | Correo de la empresa. |
| `IsAccountingRequired` | `bit` | No | Default `0`. |
| `SpecialTaxpayer` | `nvarchar(50)` | Si | Codigo o referencia de contribuyente especial. |
| `Status` | `char(1)` | No | Default `A`. FK a `EntityStatus`. |
| `RepresentativeId` | `uniqueidentifier` | Si | FK a `Person.PersonId`. |
| `ParentCompanyId` | `uniqueidentifier` | Si | FK a `Company.CompanyId`. |
| `TaxpayerType` | `nvarchar(50)` | Si | Tipo de contribuyente. |
| `ArtisanQualification` | `nvarchar(10)` | Si | Calificacion artesanal. |
| `Environment` | `varchar(30)` | Si | Ambiente operativo, por ejemplo `TEST` o `PROD`. |
| `Currency` | `varchar(3)` | Si | Codigo de moneda. Si existe, debe tener 3 caracteres. |
| `Timezone` | `varchar(60)` | Si | Zona horaria. |
| `LanguageCode` | `varchar(3)` | Si | Codigo de idioma entre 2 y 3 caracteres. |
| `CreatedBy` | `nvarchar(80)` | No | Usuario/proceso creador. |
| `CreatedAt` | `datetime2(0)` | No | Default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Usuario/proceso de actualizacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de actualizacion. |

## Constraints

| Constraint | Tipo | Columnas | Regla |
| --- | --- | --- | --- |
| `PK_Company` | Primary key | `CompanyId` | Identificador unico. |
| `UQ_Company_Identification` | Unique | `Identification` | No permite empresas duplicadas por identificacion. |
| `DF_Company_CompanyId` | Default | `CompanyId` | `newsequentialid()`. |
| `DF_Company_IsAccountingRequired` | Default | `IsAccountingRequired` | `0`. |
| `DF_Company_Status` | Default | `Status` | `A`. |
| `DF_Company_CreatedAt` | Default | `CreatedAt` | `sysdatetime()`. |
| `FK_Company_Parent` | Foreign key | `ParentCompanyId` | Referencia otra empresa. |
| `FK_Company_Representative` | Foreign key | `RepresentativeId` | Referencia `Person`. |
| `FK_Company_Status` | Foreign key | `Status` | Referencia `EntityStatus`. |
| `CK_Company_Currency` | Check | `Currency` | Null o longitud 3. |
| `CK_Company_LanguageCode` | Check | `LanguageCode` | Null o longitud entre 2 y 3. |
| `CK_Company_ParentCompany` | Check | `ParentCompanyId` | Evita que una empresa sea padre de si misma. |

## Relaciones

| Relacion | Cardinalidad | Uso |
| --- | --- | --- |
| `Company.ParentCompanyId -> Company.CompanyId` | 0..1 a 1 | Jerarquia empresarial opcional. |
| `Company.RepresentativeId -> Person.PersonId` | 0..1 a 1 | Representante legal. |
| `Company.Status -> EntityStatus.StatusCode` | Muchos a 1 | Estado canonico. |

## Modelos de Aplicacion

- C#: `docs/db/entities/company/Company.cs`
- TypeScript: `docs/db/entities/company/company.ts`

## Scripts

- Esquema actual recibido desde BD: `docs/db/entities/company/00-current-schema.sql`
- Script normalizado para repo: `tables/04-create-table-company.sql`

## Notas

- La estructura actual no contiene `OwnerPersonId`.
- Si el registro inicial necesita guardar propietario/titular distinto del representante, debe definirse una migracion futura o una relacion separada.
