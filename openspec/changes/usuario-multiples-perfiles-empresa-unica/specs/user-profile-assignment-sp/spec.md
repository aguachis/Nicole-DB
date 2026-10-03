## MODIFIED Requirements

### Requirement: Asignacion de perfiles por usuario y empresa
El sistema MUST exponer un SP para asignar perfiles a usuarios mediante una relacion usuario-perfil, validando la existencia y vigencia del usuario, perfil y empresa. Un usuario SHALL pertenecer a una sola empresa, y cada perfil asignado MUST pertenecer a esa empresa.

#### Scenario: Asignacion exitosa de perfil adicional
- **WHEN** se ejecuta el SP con un usuario activo, un perfil activo de su empresa y una empresa activa
- **THEN** el sistema SHALL crear la asignacion sin reemplazar otros perfiles activos del usuario y devolver `result_code = 0`

#### Scenario: Asignacion rechazada por perfil de otra empresa
- **WHEN** se intenta asignar al usuario un perfil que pertenece a una empresa distinta de `AppUser.CompanyId`
- **THEN** el sistema SHALL rechazar la operacion sin crear la asignacion

#### Scenario: Asignacion duplicada
- **WHEN** se asigna un perfil que ya esta activo para el mismo usuario y empresa
- **THEN** el sistema SHALL responder con `result_code = 0`, `operation = 'NOOP'` y no crear filas duplicadas

### Requirement: Revocacion e idempotencia en asignaciones
El sistema SHALL permitir revocar una asignacion usuario-perfil de manera idempotente, conservando la trazabilidad y evitando que un usuario activo quede sin perfiles activos. Todo SP de comando SHALL devolver primero un resultset de estado con `result_code` y `result_message`; los resultados exitosos SHALL usar codigo cero y los resultados funcionales no exitosos SHALL usar codigos estables documentados.

#### Scenario: Revocacion exitosa con otro perfil activo
- **WHEN** se revoca una asignacion activa y el usuario conserva al menos otro perfil activo
- **THEN** el sistema SHALL inactivar solo esa asignacion, devolver `result_code = 0` y `operation = 'REVOKE'`

#### Scenario: Revocacion repetida
- **WHEN** se intenta revocar una asignacion que ya esta inactiva o no existe
- **THEN** el sistema SHALL devolver `result_code = 0` y `operation = 'NOOP'` sin crear ni reactivar asignaciones

#### Scenario: Rechazo al revocar el ultimo perfil
- **WHEN** se intenta revocar el unico perfil activo de un usuario activo
- **THEN** el sistema SHALL devolver un codigo funcional estable distinto de cero y conservar la asignacion activa

#### Scenario: Reactivacion de asignacion revocada
- **WHEN** se asigna nuevamente un perfil cuya relacion existente esta inactiva
- **THEN** el sistema SHALL reactivar la relacion existente, devolver `result_code = 0` y `operation = 'REACTIVATE'`, y no crear una fila duplicada

### Requirement: Historial inmutable de cambios en asignaciones
El sistema MUST registrar en un historial append-only cada asignacion, revocacion y reactivacion exitosa de un perfil de usuario. Cada evento MUST identificar usuario, empresa, perfil, operacion, actor y fecha/hora. La escritura del evento y el cambio de estado de la asignacion SHALL ser atomicos.

#### Scenario: Evento de auditoria en asignacion
- **WHEN** se asigna un perfil a un usuario y la operacion se completa exitosamente
- **THEN** el sistema SHALL insertar un evento de asignacion con usuario, empresa, perfil, actor y fecha/hora en el historial inmutable

#### Scenario: Evento de auditoria en revocacion o reactivacion
- **WHEN** se revoca o reactiva exitosamente una asignacion usuario-perfil
- **THEN** el sistema SHALL insertar un nuevo evento que identifique la operacion sin sobrescribir eventos anteriores

#### Scenario: Atomicidad entre asignacion e historial
- **WHEN** falla la insercion del evento de auditoria durante una asignacion, revocacion o reactivacion
- **THEN** el sistema SHALL revertir tambien el cambio de la asignacion

#### Scenario: Historial protegido contra alteracion
- **WHEN** un consumidor de negocio intenta modificar o eliminar un evento historico
- **THEN** el sistema SHALL impedir la alteracion y conservar el evento original

### Requirement: Manejo de errores tecnicos en procedimientos de asignacion
Los SP de asignacion y revocacion MUST revertir cualquier transaccion abierta y relanzar errores tecnicos con `THROW`; no SHALL convertirlos en codigos funcionales ni exponer el detalle interno del motor como `result_message`.

#### Scenario: Error tecnico durante una operacion
- **WHEN** ocurre una excepcion SQL inesperada durante una asignacion, revocacion o reactivacion
- **THEN** el sistema SHALL revertir el cambio y el evento de auditoria y relanzar la excepcion para que la capa de aplicacion la gestione como error tecnico

### Requirement: Proteccion al inactivar perfiles
El sistema SHALL impedir que la inactivacion de un perfil deje a un usuario activo sin ningun perfil activo asignado en su empresa.

#### Scenario: Perfil inactivado mientras existe otro perfil asignado
- **WHEN** se inactiva un perfil que esta asignado a un usuario activo que conserva otro perfil activo
- **THEN** el sistema SHALL permitir la operacion sin alterar las otras asignaciones

#### Scenario: Rechazo al inactivar el ultimo perfil disponible
- **WHEN** se intenta inactivar un perfil que es el unico perfil activo asignado a uno o mas usuarios activos
- **THEN** el sistema SHALL rechazar la operacion y mantener activo el perfil
