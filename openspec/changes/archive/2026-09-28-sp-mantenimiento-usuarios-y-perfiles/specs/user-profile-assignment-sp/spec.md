## ADDED Requirements

### Requirement: Asignacion de perfiles por usuario y empresa
El sistema MUST exponer un SP para asignar perfiles a usuarios en el contexto de una empresa, validando la existencia y vigencia de usuario, perfil y relacion de pertenencia.

#### Scenario: Asignacion exitosa de perfil
- **WHEN** se ejecuta el SP de asignacion con usuario valido, perfil valido y empresa habilitada
- **THEN** el sistema SHALL crear la relacion usuario-perfil-empresa y devolver `result_code = 0`

#### Scenario: Asignacion rechazada por relacion invalida
- **WHEN** se ejecuta el SP de asignacion para un usuario que no pertenece a la empresa indicada
- **THEN** el sistema SHALL rechazar la operacion con codigo funcional de validacion

### Requirement: Revocacion e idempotencia en asignaciones
El sistema SHALL exponer un SP para revocar perfiles y manejar de forma idempotente intentos repetidos de asignacion o revocacion.

#### Scenario: Revocacion exitosa
- **WHEN** se ejecuta el SP de revocacion sobre una asignacion vigente
- **THEN** el sistema SHALL desactivar o eliminar la asignacion segun convencion definida y devolver resultado exitoso

#### Scenario: Asignacion duplicada
- **WHEN** se intenta asignar un perfil que ya esta asignado y vigente para el mismo usuario y empresa
- **THEN** el sistema SHALL devolver un resultado idempotente sin duplicar registros

### Requirement: Trazabilidad de cambios en perfiles
El sistema MUST registrar metadatos minimos de auditoria para operaciones de asignacion y revocacion (usuario actor, fecha y operacion).

#### Scenario: Registro de auditoria en asignacion
- **WHEN** se completa una asignacion de perfil
- **THEN** el sistema SHALL persistir metadatos de auditoria asociados a la transaccion
