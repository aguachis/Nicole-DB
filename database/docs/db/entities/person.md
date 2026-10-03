# Entidad: Person

`dbo.Person` es el maestro global de personas naturales y jurídicas. Es compartido por usuarios, representantes de empresa y clientes; no contiene datos comerciales ni contactos de un tenant.

| Campo | Tipo | Regla |
| --- | --- | --- |
| `PersonId` | `uniqueidentifier` | PK. |
| `PersonKind` | `char(1)` | FK a `PersonType`: `N` natural o `J` jurídica. |
| `LegalName` | `nvarchar(250)` | Obligatorio y no vacío. |
| `TradeName` | `nvarchar(250)` | Opcional. |
| `Status` | `char(1)` | FK a `EntityStatus`; predeterminado `A`. |
| auditoría | fechas y actor | Creación y actualización. |

`Person` no tiene cédula, RUC, correo, teléfono ni dirección. Las identificaciones están en `PersonIdentification`; los datos comerciales están en `Client` y pertenecen a una `Company` concreta.

La misma persona puede tener varias identificaciones y ser cliente de varias empresas, pero cada identificación normalizada corresponde a una sola persona global.
