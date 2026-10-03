## ADDED Requirements

### Requirement: Consulta de perfiles disponibles para la sesion
El sistema MUST permitir consultar los perfiles activos asignados a un usuario autenticado, limitados a la empresa unica del usuario, para que la capa de aplicacion pueda obtener la seleccion de contexto.

#### Scenario: Usuario con perfiles activos
- **WHEN** la capa de aplicacion consulta los perfiles disponibles para un usuario activo
- **THEN** el sistema SHALL devolver unicamente las asignaciones y perfiles activos de `AppUser.CompanyId`

#### Scenario: Usuario sin perfiles activos
- **WHEN** la capa de aplicacion consulta los perfiles de un usuario activo que no tiene asignaciones activas
- **THEN** el sistema SHALL devolver una respuesta vacia de perfiles disponibles y no inferir permisos

### Requirement: Validacion del perfil activo en el contexto de sesion
El sistema MUST validar que el perfil elegido este asignado activamente al usuario y pertenezca a la empresa unica de este antes de devolver el contexto de sesion o permisos efectivos.

#### Scenario: Contexto de sesion con perfil asignado
- **WHEN** se solicita contexto para un `UserId` activo y un `ProfileId` asignado y activo de su empresa
- **THEN** el sistema SHALL devolver el contexto de esa empresa y los permisos activos asociados exclusivamente a ese perfil

#### Scenario: Contexto rechazado para perfil no asignado
- **WHEN** se solicita contexto con un perfil inexistente, inactivo, no asignado al usuario o de otra empresa
- **THEN** el sistema SHALL rechazar la solicitud y no devolver permisos

#### Scenario: Sesiones concurrentes con perfiles distintos
- **WHEN** el mismo usuario establece sesiones concurrentes usando distintos perfiles que tiene asignados
- **THEN** el sistema SHALL resolver cada contexto de forma independiente sin cambiar un perfil activo global en `AppUser`

### Requirement: Aislamiento de permisos por perfil activo
El sistema MUST calcular autorizacion efectiva con `UserId`, la empresa unica y el `ProfileId` validado para la sesion, sin combinar permisos de otros perfiles asignados.

#### Scenario: Perfil alternativo no amplia permisos de la sesion
- **WHEN** un usuario tiene varios perfiles asignados y uno de ellos es el perfil activo de la sesion
- **THEN** el sistema SHALL incluir unicamente los permisos del perfil activo en el contexto de autorizacion
