# Entidad: Client

`dbo.Client` es la relación comercial entre una `Company` y una `Person` global. No duplica el nombre ni la identificación de la persona.

| Campo | Tipo | Regla |
| --- | --- | --- |
| `ClientId` | `uniqueidentifier` | PK. |
| `CompanyId` | `uniqueidentifier` | FK a `Company`. |
| `PersonId` | `uniqueidentifier` | FK a `Person`. |
| `DefaultBillingIdentificationId` | `bigint` | Junto con `PersonId`, FK a la identificación de esa misma persona. |
| `BillingAddress` | `nvarchar(500)` | Obligatoria y local a la empresa. |
| `Phone` | `nvarchar(50)` | Obligatorio y local a la empresa. |
| `Email` | `nvarchar(254)` | Obligatorio y local a la empresa. |
| `CreditLimit`, `PaymentTermDays` | valores comerciales | Opcionales; pertenecen al tenant. |
| `Status` | `char(1)` | Estado lógico local. |

Las claves únicas `(CompanyId, PersonId)` y `(ClientId, CompanyId)` impiden duplicar la relación y preparan una futura FK compuesta de documentos comerciales. La dirección, correo y teléfono provenientes de una sugerencia externa solo se guardan cuando el usuario los confirma explícitamente.
