# Diseno: registro global de clientes para instalacion inicial

## Contexto

Nicole se crea en una base SQL Server vacia. Los scripts son DDL definitivo, seeds minimos y SPs; no contienen logica de migracion, compatibilidad, backfill, remediacion ni rollback de datos.

## Modelo final

- `Company` es el tenant. Conserva sus datos fiscales y agrega `MainAddress` nullable.
- `Person` es global: `PersonId`, `PersonKind`, `LegalName` y `TradeName`. No contiene identificacion ni contacto comercial de tenant.
- `IdentificationType` contiene codigo estable y politica de validacion/facturacion.
- `PersonIdentification` tiene la identidad visible, normalizada y globalmente unica por tipo. Su clave candidata `(PersonIdentificationId, PersonId)` permite probar pertenencia.
- `TaxRegistration` es 0..1 para una identidad RUC; `EconomicActivity` y su tabla puente registran actividades verificadas.
- `PersonVerification` conserva resultado, vigencia, proveedor, hash y correlacion sin JSON. `RegistryAccessAudit` audita acceso por empresa sin duplicar PII.
- `Client` es la relacion de `Company` con `Person`; mantiene direccion de facturacion, telefono, email, credito y plazo. Su FK compuesta prueba que la identificacion facturable pertenece a la persona. `(ClientId, CompanyId)` prepara la futura factura.

## Seguridad y SP

SQL no realiza HTTP ni almacena secretos. El backend consulta al proveedor y llama `usp_Registry_PersistVerification` con datos estructurados. `usp_Registry_ResolveIdentification` solo permite coincidencia exacta y cache vigente. Los SP `usp_Client_*` exigen `UserId`, `CompanyId` y permiso efectivo; el rol `nicole_app` recibe `EXECUTE`, no DML directo global.

## Orden de creacion

El manifiesto SQLCMD crea catalogos, maestros, seguridad, tablas globales, `Client`, seeds, SPs y grants respetando sus FKs. Se ejecuta una sola vez sobre una base vacia. El DBA conserva la evidencia de su propia ejecucion; este repositorio no conecta ni prueba SQL Server.
