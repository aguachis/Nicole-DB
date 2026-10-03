## Why

El registro global debe reutilizar una persona ya conocida por cualquier empresa del ERP, pero la consulta a cédula o RUC es solo un mecanismo de prellenado cuando esa identidad todavía no existe. El modelo vigente conserva proveedores, respuestas, vigencias, trazas y datos tributarios que no son necesarios para registrar clientes y contradicen la retención mínima acordada.

## What Changes

- Reemplazar el flujo de verificación y caché de proveedor por una resolución backend de identificaciones globales: buscar primero en `PersonIdentification`; solo ante ausencia el backend consulta el servicio externo y presenta una sugerencia editable.
- Permitir que el alta de cliente reutilice una `Person` global existente o cree, en la misma transacción, una `Person` e identificación manual confirmadas por el usuario cuando no exista coincidencia o el servicio no responda.
- Excluir de la definición inicial las tablas, tipos, semillas, permisos, procedimientos y relaciones dedicados a retener proveedores, verificaciones, auditoría de registro y datos tributarios/económicos que por ahora no se usarán.
- Simplificar `PersonIdentification` para que represente identidad global y reglas de formato/facturación, sin estado ni fechas de verificación externa.
- Mantener `Client` como relación comercial aislada por `Company`: dirección de facturación, correo, teléfono, crédito y plazo se confirman y almacenan solo en el tenant activo.
- Actualizar contratos backend, seguridad, diccionarios, documentación de relaciones y ambos diagramas, incluido el gráfico Mermaid, para reflejar el flujo sin persistencia de datos técnicos del servicio.

## Capabilities

### New Capabilities

- `manual-global-person-resolution`: resolución exacta de una identidad desde el maestro global y alta manual asistida por una consulta externa no persistida.

### Modified Capabilities

- `global-tax-identity-registry`: convertir el registro global en un maestro mínimo de personas e identificaciones sin datos de proveedor ni tributarios.
- `tenant-client-relationship`: permitir la creación atómica de un cliente reutilizando o creando su persona global, sin copiar contactos entre tenants.
- `registry-access-security`: sustituir la seguridad de verificaciones/caché por autorización backend de la resolución exacta y del alta manual, sin registro técnico de proveedor.

## Impact

- DDL base para que no se definan `RegistryProvider`, `PersonVerification`, `RegistryAccessAudit`, `TaxRegistration`, `EconomicActivity`, `TaxRegistrationEconomicActivity`, el tipo `RegistryEconomicActivityListType` ni las columnas de verificación de `PersonIdentification`.
- Procedimientos `P_Registry_*` y `P_Client_*`, permisos `client.verify`, grants de `nicole_app` y semillas asociadas.
- Contrato backend/API de registro y clientes: el backend consulta el servicio externo solo tras un resultado local inexistente; el navegador no persiste ni recibe el payload completo como registro de base de datos.
- Documentación en `database/docs/db/entities/`, `databse.md`, `BACKEND_DATABASE_CONTEXT.md`, integración API, los diagramas `ER_DIAGRAM.md` y `databse-diagrama.md`, y sus relaciones Mermaid.
- La base de datos es nueva y está en definición: no hay datos ni objetos desplegados que preservar.
