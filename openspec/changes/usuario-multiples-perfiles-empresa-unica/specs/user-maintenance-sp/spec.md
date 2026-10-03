## MODIFIED Requirements

### Requirement: SP de mantenimiento de usuarios
El sistema MUST exponer procedimientos almacenados para crear, actualizar, activar/inactivar y consultar usuarios de aplicacion con validaciones de negocio y consistencia transaccional. La creacion de un usuario SHALL recibir un perfil inicial valido de la empresa unica y crear su asignacion en la relacion usuario-perfil dentro de la misma transaccion.

#### Scenario: Alta de usuario exitosa
- **WHEN** se ejecuta el SP de alta con identificacion valida, username disponible, datos obligatorios completos y un perfil inicial activo de la empresa indicada
- **THEN** el sistema SHALL crear el usuario y su primera asignacion en `UserProfile` de forma atomica y devolver `result_code = 0` con mensaje de exito

#### Scenario: Alta rechazada por username duplicado
- **WHEN** se ejecuta el SP de alta con un username ya existente y vigente
- **THEN** el sistema SHALL rechazar la operacion y devolver un `result_code` de duplicidad sin crear registros

#### Scenario: Alta rechazada por perfil de otra empresa
- **WHEN** el perfil inicial no pertenece a la empresa indicada para el nuevo usuario
- **THEN** el sistema SHALL rechazar la operacion y no dejar creado el usuario ni una asignacion parcial

## ADDED Requirements

### Requirement: Contrato estandar de respuesta para SP de usuario
El sistema MUST devolver en todos los SP de usuario primero un resultset de estado de una fila con `result_code` y `result_message`; cuando aplique, los datos de negocio SHALL devolverse en resultsets posteriores, con orden y columnas documentados. El codigo cero SHALL indicar exito, incluidos resultados idempotentes identificados con `operation = 'NOOP'` en operaciones de comando. Los codigos funcionales SHALL ser estables y unicos por condicion; los consumidores MUST decidir por codigo y no interpretar `result_message`. Los errores tecnicos SHALL revertir transacciones y relanzarse con `THROW`, sin convertirse en codigos funcionales.

#### Scenario: Respuesta de consulta operativa
- **WHEN** se ejecuta un SP de consulta de usuarios con filtros validos
- **THEN** el sistema SHALL retornar primero el estado y luego un conjunto tabular con los usuarios encontrados, incluso si el conjunto no contiene filas

#### Scenario: Error funcional de validacion
- **WHEN** un SP de usuario rechaza la operacion por una condicion de negocio esperada
- **THEN** el sistema SHALL retornar un codigo funcional estable y un mensaje descriptivo sin efectuar cambios

#### Scenario: Error tecnico inesperado
- **WHEN** ocurre una excepcion SQL inesperada en un SP de usuario
- **THEN** el sistema SHALL revertir la transaccion y propagar el error tecnico sin incluir detalles internos en un resultset funcional

### Requirement: Integridad de la empresa unica del usuario
Los procedimientos de mantenimiento SHALL conservar `AppUser.CompanyId` como la unica empresa del usuario y MUST validar que las asignaciones de perfiles correspondan a esa empresa.

#### Scenario: Actualizacion no cambia la empresa mediante asignacion de perfil
- **WHEN** se asigna un perfil a un usuario existente
- **THEN** el sistema SHALL mantener `AppUser.CompanyId` sin cambios y aceptar unicamente perfiles de esa empresa
