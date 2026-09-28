## ADDED Requirements

### Requirement: SP de mantenimiento de usuarios
El sistema MUST exponer procedimientos almacenados para crear, actualizar, activar/inactivar y consultar usuarios de aplicacion con validaciones de negocio y consistencia transaccional.

#### Scenario: Alta de usuario exitosa
- **WHEN** se ejecuta el SP de alta con identificacion valida, username disponible y datos obligatorios completos
- **THEN** el sistema SHALL crear el usuario y devolver `result_code = 0` con mensaje de exito

#### Scenario: Alta rechazada por username duplicado
- **WHEN** se ejecuta el SP de alta con un username ya existente y vigente
- **THEN** el sistema SHALL rechazar la operacion y devolver un `result_code` de duplicidad sin crear registros

### Requirement: Validaciones de estado para mantenimiento
El sistema SHALL impedir operaciones de actualizacion o activacion/inactivacion cuando el usuario objetivo no exista o se encuentre en estado incompatible con la operacion solicitada.

#### Scenario: Actualizacion rechazada por usuario inexistente
- **WHEN** se ejecuta el SP de actualizacion con un `app_user_id` inexistente
- **THEN** el sistema SHALL devolver un `result_code` de no encontrado y no aplicar cambios

#### Scenario: Cambio de estado idempotente
- **WHEN** se solicita activar o inactivar un usuario que ya tiene el estado solicitado
- **THEN** el sistema SHALL responder con resultado idempotente y sin cambios adicionales

### Requirement: Contrato estandar de respuesta para SP de usuario
El sistema MUST devolver en todos los SP de usuario un contrato consistente con `result_code`, `result_message` y, cuando aplique, un dataset de salida con los datos relevantes.

#### Scenario: Respuesta de consulta operativa
- **WHEN** se ejecuta el SP de consulta de usuarios con filtros validos
- **THEN** el sistema SHALL retornar `result_code`, `result_message` y un conjunto tabular con los usuarios encontrados
