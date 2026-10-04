## MODIFIED Requirements

### Requirement: Asignacion de perfiles por usuario y empresa
El sistema MUST exponer un SP para asignar y revocar perfiles a usuarios en el contexto de una empresa, validando la existencia y vigencia de usuario, perfil y relacion de pertenencia. Ademas, MUST confirmar que el actor autenticado pertenece a la misma empresa, usa un perfil activo habilitado para la sesion y tiene el permiso efectivo requerido antes de ejecutar la modificacion.

#### Scenario: Asignacion exitosa de perfil con actor autorizado
- **WHEN** se ejecuta el SP de asignacion con usuario objetivo, perfil valido, empresa activa y actor con permiso efectivo
- **THEN** el sistema SHALL crear la relacion usuario-perfil-empresa y devolver `result_code = 0`

#### Scenario: Asignacion rechazada por actor no autorizado
- **WHEN** el actor intenta asignar perfiles a un usuario de otra empresa o sin permiso efectivo para `profile.assign`
- **THEN** el sistema SHALL rechazar la operacion y SHALL no crear ni reactivar registros de `UserProfile`

#### Scenario: Revocacion rechazada por empresa cruzada
- **WHEN** un perfil activo de un tenant distinto intenta revocar un perfil de otro tenant como parametro de `@CompanyId`
- **THEN** el sistema SHALL denegar la operacion por violacion de la frontera single-tenant

### Requirement: Revocacion e idempotencia en asignaciones
El sistema SHALL exponer un SP para revocar perfiles y manejar de forma idempotente intentos repetidos de asignacion o revocacion, pero SHALL hacerlo solo despues de validar la identidad del actor y el permiso vigente del perfil activo de sesion.

#### Scenario: Revocacion exitosa con auditoria
- **WHEN** se ejecuta la revocacion sobre una asignacion vigente y el actor es autorizado
- **THEN** el sistema SHALL desactivar la asignacion, registrar auditoria y devolver resultado exitoso

#### Scenario: Operacion idempotente rechazando actor invalido
- **WHEN** el actor no cumple la validacion de empresa o perfil activo
- **THEN** el sistema SHALL no mutar la relacion ni aceptar la operacion como idempotente, y SHALL responder con codigo funcional de validacion

### Requirement: Trazabilidad de cambios en perfiles
El sistema MUST registrar metadatos minimos de auditoria para operaciones de asignacion y revocacion (usuario actor, usuario objetivo, empresa, perfil, fecha y operacion) y MUST asociar ese registro a la identidad autentica que ejecuta la accion.

#### Scenario: Registro de auditoria en asignacion autorizada
- **WHEN** se completa una asignacion de perfil por un actor autorizado
- **THEN** el sistema SHALL persistir metadatos de auditoria asociados a la transaccion y a la empresa correcta
