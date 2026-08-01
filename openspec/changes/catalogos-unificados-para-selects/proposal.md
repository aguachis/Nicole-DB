## Why

Las pantallas de usuario, cliente y mantenimiento administrativo necesitan consumir catálogos comunes para selects sin depender de IDs físicos, tablas concretas o lógica duplicada en cada formulario. Hoy cada catálogo se modela por separado, pero no existe una forma unificada y estable de pedirlos desde la UI con una sola clave funcional.

## What Changes

- Definir una capa unificada de consulta de catálogos para selects de la UI.
- Exponer los catálogos mediante una clave funcional estable, por ejemplo `STATUS`, `IDENTIFICATION` y `PERSON_TYPE`.
- Mantener como fuente de verdad las tablas existentes `EntityStatus`, `IdentificationType` y `PersonType`.
- Devolver por defecto solo registros activos en la respuesta de catálogo.
- Establecer un endpoint unificado por clave, por ejemplo `/api/catalogs/{key}`.
- Mantener fuera de este primer corte a `Permission` y a cualquier catálogo que todavía no exista como entidad, como `ClientType`.

## Capabilities

### New Capabilities
- `catalog-lookups`: consulta unificada de catálogos para selects de UI con claves funcionales estables y respuesta normalizada.

### Modified Capabilities
- None.

## Impact

- Afecta los contratos de API que alimentan selects en pantallas de usuarios, clientes y mantenimiento.
- Afecta la documentación de integración que hoy consume `EntityStatus`, `IdentificationType` y `PersonType` por separado.
- Puede requerir un nuevo patrón de endpoint o servicio de lectura para catálogos compartidos.
- Debe mantenerse compatible con los catálogos existentes y no cambiar la semántica de `Permission` en esta primera versión.