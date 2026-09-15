# Diccionario: registro global de identidad tributaria

## Alcance

Definición introducida por `centralizar-registro-global-clientes`. Estas tablas son globales: no llevan `CompanyId` y no se deben modificar desde la aplicación con DML directo. El único límite por tenant en la consulta es la autorización y auditoría en `RegistryAccessAudit`.

## PersonIdentification

| Campo | Tipo | Regla |
| --- | --- | --- |
| `PersonIdentificationId` | `bigint identity` | PK. |
| `PersonId` | `uniqueidentifier` | FK a `Person`; propietario global de la identidad. |
| `IdentificationTypeId` | `char(2)` | FK a `IdentificationType`. |
| `Identification` | `nvarchar(64)` | Valor visible, no vacío. |
| `NormalizedIdentification` | computada persistida | `fn_NormalizeIdentification`; se usa para la unicidad. |
| `IsPrimary` | `bit` | Máximo una identidad primaria por persona. |
| `VerificationStatus` | `varchar(16)` | `Unverified`, `Verified`, `NotFound`, `Invalid`, `Expired` o `Error`. |
| `LastVerifiedAt`, `ExpiresAt` | `datetime2(3)` | Vigencia de la verificación. |
| auditoría | fecha y `AppUser` opcional | Creación/actualización. |

La segunda fase crea `UQ_PersonIdentification_Type_Normalized(IdentificationTypeId, NormalizedIdentification)` y `UQ_PersonIdentification_Id_Person(PersonIdentificationId, PersonId)`. La segunda clave hace posible la FK compuesta desde `Client`.

## TaxRegistration y actividad económica

`TaxRegistration` es 0..1 por `PersonIdentification` y solo admite una identificación cuyo tipo tenga `Code = 'RUC'`. Contiene estado tributario, clase de contribuyente, `TaxAddress`, obligación contable, inicio de actividades, proveedor, fuente y vigencias de verificación. `TaxAddress` tiene procedencia tributaria y no es una dirección de facturación del tenant.

`EconomicActivity` es un catálogo global (`ActivityCode` único). `TaxRegistrationEconomicActivity` resuelve la relación N:M, mantiene la referencia opaca del proveedor, `VerifiedAt` y como máximo una actividad primaria por registro. Ninguna de estas tablas guarda JSON de proveedor.

## Proveedor y verificaciones

| Tabla | Clave y relación | Datos permitidos |
| --- | --- | --- |
| `RegistryProvider` | PK `RegistryProviderId`; `Code` único | nombre, URL base no secreta, TTL de cache, estado y auditoría. Nunca credenciales. |
| `PersonVerification` | FK a `PersonIdentification` y `RegistryProvider` | resultado, consulta/vencimiento, hash SHA-256 de payload, id opaco de petición, código de fallo y correlación. No guarda payload bruto. |
| `RegistryAccessAudit` | FK a `Company`, `AppUser`, identidad y proveedor opcionales | resultado, fecha, correlación y código de razón. No duplica nombre, identificación, dirección ni payload. |
| `RegistryBackfillConflict` | FK opcional a persona, tipo y usuario que resuelve | conflicto, clave de origen, identificador normalizado, detalle limitado, detección y resolución. No autoriza una fusión automática. |

`RegistryAccessAudit.Outcome` admite `CacheHit`, `ProviderQueried`, `Denied`, `NotFound`, `Invalid`, `Unavailable` y `Error`; correlaciona la operación sin exponer PII en reportes de operación.

## Integridad y propietarios

- `PersonIdentification` es la única fuente canónica de la identidad global normalizada.
- `PersonVerification` guarda el historial de disponibilidad/resultado; una fila vigente y verificada puede atender una consulta desde cache.
- `TaxRegistration` y sus actividades son hechos globales verificados, no valores privados de una empresa.
- `Client` solo referencia una identidad facturable que pertenece a su `Person`; sus contactos y condiciones son datos propios del tenant.

## Scripts de definición

- DDL aditivo: `database/migrations/20260905_002_centralizar_registro_global_clientes_forward.sql`.
- Semillas: `database/seeds/20260905_001_centralizar_registro_global_clientes_identification_types.sql` y `database/seeds/20260905_002_centralizar_registro_global_clientes_registry_provider.sql`.
- Índices, unicidad global y guardas: `database/migrations/20260905_004_centralizar_registro_global_clientes_indexes_guards.sql`.
- Contrato de acceso: `database/docs/db/stored-procedures/registry-client.md`.
