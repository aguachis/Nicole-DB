# Diccionario de datos de Nicole

La fuente ejecutable del esquema es `database/tables/` y el manifiesto de creación inicial. El modelo de acceso es single-tenant por usuario; los datos comerciales de clientes siguen separados por empresa.

## Identidad global

`Person` representa a una persona natural (`N`) o jurídica (`J`) con `LegalName` obligatorio y `TradeName` opcional. `PersonIdentification` almacena tipo, valor visible, valor normalizado, identificación primaria y auditoría; la combinación de tipo y valor normalizado es única globalmente.

La identificación se busca de forma exacta. Una respuesta de cédula o RUC que el backend obtenga tras una ausencia local se reduce a una sugerencia de formulario y solo se persisten los campos confirmados por el usuario.

## Clientes por empresa

`Client` enlaza una `Company` con una `Person`. Sus campos locales son `BillingAddress`, `Phone`, `Email`, `CreditLimit` y `PaymentTermDays`. La misma persona puede ser cliente de varias empresas, pero no puede repetirse dentro de la misma empresa.

La FK compuesta `(DefaultBillingIdentificationId, PersonId)` asegura que la identificación de facturación pertenece a la persona enlazada. La clave `(ClientId, CompanyId)` permite a futuro relacionar documentos comerciales sin romper el aislamiento multiempresa.

## Seguridad

Los procedimientos validan permisos efectivos mediante `AppUser -> Profile -> ProfilePermission -> Permission`; `AppUser.CompanyId` delimita el tenant del usuario. El rol `nicole_app` ejecuta procedimientos públicos y no tiene DML directo sobre `Person`, `PersonIdentification` ni `Client`.

## Entidades principales

| Área | Entidades |
| --- | --- |
| Catálogos | `EntityStatus`, `IdentificationType`, `PersonType` |
| Maestro global | `Person`, `PersonIdentification` |
| Tenants | `Company`, `CompanyBranch`, `CompanyEmissionPoint`, `Client` |
| Seguridad | `AppUser`, `Profile`, `Permission`, `ProfilePermission` |

Los diagramas de relaciones están en [ER_DIAGRAM.md](ER_DIAGRAM.md) y [databse-diagrama.md](databse-diagrama.md).
