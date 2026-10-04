## MODIFIED Requirements

### Requirement: SP de mantenimiento de usuarios
El sistema MUST exponer procedimientos almacenados para crear, consultar, actualizar y cambiar estado de usuarios de aplicacion con validaciones de negocio y consistencia transaccional; ademas, MUST exigir la identidad del actor autenticado, la pertenencia del actor a la empresa indicada y el permiso efectivo del perfil activo antes de ejecutar cualquier lectura o escritura sobre usuarios del tenant.

#### Scenario: Consulta de usuarios rechazada sin actor valido
- **WHEN** un usuario intenta ejecutar un SP de consulta con `@CompanyId` pero sin `@ActorUserId` o sin un perfil activo valido para la empresa
- **THEN** el sistema SHALL devolver un error funcional de autenticacion/autorizacion y SHALL no devolver filas del tenant objetivo

#### Scenario: Actor sin permiso efectivo
- **WHEN** el actor pertenece a la empresa pero no posee el permiso efectivo requerido para leer o modificar usuarios
- **THEN** el sistema SHALL denegar la operacion con resultado de `permission denied` y SHALL no aplicar cambios

#### Scenario: Usuario de otra empresa no puede listar usuarios del tenant objetivo
- **WHEN** un actor intenta consultar usuarios de una empresa distinta a la suya usando un `@CompanyId` arbitrario
- **THEN** el sistema SHALL rechazar la solicitud por no cumplir la regla de pertenencia a la empresa y SHALL no exponer datos cruzados

### Requirement: Contrato estandar de respuesta para SP de usuario
El sistema MUST devolver en todos los SP de usuario un contrato consistente con `result_code`, `result_message` y, cuando aplique, un dataset de salida, pero SHALL insertar la validacion de actor, empresa y perfil activo antes del resultado exitoso.

#### Scenario: Respuesta consistente para autorizacion fallida
- **WHEN** la validacion de actor, empresa o permiso efectivo falla
- **THEN** el sistema SHALL responder con un `result_code` funcional y un `result_message` explicito, sin retornar datos de usuario ajenos

#### Scenario: Respuesta exitosa despues de validacion efectiva
- **WHEN** el actor es valido, pertenece a la empresa indicada y tiene el permiso requerido
- **THEN** el sistema SHALL ejecutar la operacion y retornar `result_code = 0` junto con el dataset esperado
