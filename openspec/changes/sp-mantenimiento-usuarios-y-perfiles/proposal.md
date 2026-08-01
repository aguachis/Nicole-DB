## Why

Actualmente no existe un set estandarizado de procedimientos almacenados para el mantenimiento de usuarios ni para la asignacion de perfiles por usuario/empresa, lo que dificulta la consistencia transaccional y la integracion entre base de datos y API. Esta implementacion es necesaria ahora para habilitar una capa de datos estable, auditable y reutilizable para los modulos de seguridad.

## What Changes

- Crear procedimientos almacenados para mantenimiento de usuarios (crear, actualizar, activar/inactivar, consulta por filtros operativos).
- Crear procedimientos almacenados para asignacion y revocacion de perfiles a usuarios por contexto de empresa.
- Estandarizar contratos de entrada/salida de SP (codigos de resultado, mensajes y payload tabular).
- Incorporar validaciones de negocio en SP (estado de usuario, existencia de perfil, pertenencia a empresa, duplicados).
- Crear documentacion de integracion para API con ejemplos de consumo de SP, mapeo de parametros y manejo de errores.

## Capabilities

### New Capabilities
- `user-maintenance-sp`: Gestion transaccional de mantenimiento de usuarios mediante SP con validaciones y resultados estandar.
- `user-profile-assignment-sp`: Asignacion y revocacion de perfiles de usuario por empresa mediante SP idempotentes y auditables.
- `api-integration-md-for-user-security-sp`: Documento de integracion para el proyecto API con contratos, flujos y ejemplos de uso de SP de seguridad.

### Modified Capabilities
- None.

## Impact

- Afecta scripts SQL en `docs/db/stored-procedures/auth/` y/o `docs/db/stored-procedures/profile/`.
- Afecta artefactos de documentacion en `docs/db/integrations/` para consumo desde API.
- Impacta el modulo de seguridad de base de datos (`app-user`, `profile`, `user-company`, `user-company-profile`).
- Requiere alinear convenciones de nombres y codigos de respuesta con los documentos de `docs/db/02-conventions.md`.
