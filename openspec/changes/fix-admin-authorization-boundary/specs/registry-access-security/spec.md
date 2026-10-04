## MODIFIED Requirements

### Requirement: Effective tenant permissions control registry and clients
El sistema SHALL exigir autorizacion efectiva por `UserId`, `CompanyId` y `ProfileId` activo para toda operacion sensible de clientes y administracion de usuarios/perfiles. El backend MUST denegar cualquier operacion donde el actor no pertenezca al tenant indicado, no tenga un perfil activo para la sesion o no cuente con el permiso requerido por codigo funcional.

#### Scenario: Denegacion de acceso cruzado por tenant
- **WHEN** un usuario intenta invocar una operacion sensible con un `@CompanyId` distinto al de su empresa o con un perfil inactivo
- **THEN** el sistema SHALL denegar la operacion y SHALL no devolver datos ni aplicar cambios de otro tenant

#### Scenario: Permiso efectivo requerido para lectura administrativa
- **WHEN** el actor tiene acceso a la empresa pero no cuenta con el permiso requerido para leer o administrar usuarios o perfiles
- **THEN** el sistema SHALL responder con `permission denied` y SHALL registrar el resultado sin incluir PII en claro

### Requirement: Autorizacion efectiva por perfil activo y empresa
El sistema SHALL basar la autorizacion de los SP administrativos en el perfil activo elegido para la sesion, nunca en la union de perfiles del usuario ni en un `CompanyId` recibido sin validacion de identidad del actor.

#### Scenario: Perfil activo como unico origen de permisos
- **WHEN** un usuario posee varios perfiles de la misma empresa
- **THEN** los permisos efectivos de la operacion SHALL derivarse exclusivamente del perfil activo elegido para la sesion y no de la suma de permisos de otros perfiles

#### Scenario: Sesion con perfil no activo es rechazada
- **WHEN** la sesion intenta ejecutar una accion sensible con un perfil no activo o no asignado a la empresa del usuario
- **THEN** el sistema SHALL rechazar la accion y SHALL no permitir la operacion
