## 1. Modelo relacional inicial

- [x] 1.1 Crear `dbo.UserProfile` con PK, estado, auditoria, unicidad de usuario-perfil y FKs compuestas que garanticen la empresa coincidente.
- [x] 1.2 Crear `dbo.UserProfileAudit` append-only con identificadores de usuario, empresa, perfil, operacion, actor y fecha/hora; impedir borrados en cascada desde la asignacion.
- [x] 1.3 Definir `dbo.AppUser` desde el inicio con `CompanyId` y sin la columna `ProfileId` ni la FK compuesta a `Profile`.
- [x] 1.4 Organizar los scripts de creacion inicial para que `AppUser`, `Profile`, `UserProfile` y `UserProfileAudit` se creen en orden valido, sin generar migracion de datos ni scripts `ALTER` para transformar una base existente.
- [x] 1.5 Revisar indices de consulta por usuario/perfil/estado y evitar duplicar indices cubiertos por claves UNIQUE.

## 2. Procedimientos de usuario y perfiles

- [x] 2.1 Modificar `P_UserProfile_Assign` para agregar o reactivar una asignacion sin reemplazar otros perfiles, registrar el evento append-only en la misma transaccion y respetar el contrato estandar de respuesta.
- [x] 2.2 Crear el procedimiento de revocacion y el listado de perfiles activos por usuario; impedir revocar el ultimo perfil activo, registrar la revocacion atomica con su evento historico y documentar codigos funcionales y resultsets.
- [x] 2.3 Actualizar el alta de usuario para crear `AppUser` y su perfil inicial en una misma transaccion, registrando tambien el evento inicial de asignacion.
- [x] 2.4 Revisar `P_Profile_Deactivate` para impedir que la inactivacion de un perfil deje a usuarios activos sin otro perfil activo.

## 3. Contexto de autenticacion y autorizacion

- [x] 3.1 Actualizar `P_Auth_GetSessionContext` para recibir el perfil elegido, validar que este asignado y activo para el usuario y empresa, devolver permisos solo de ese perfil y respetar el contrato de resultsets.
- [x] 3.2 Actualizar los contratos de integracion de login, mantenimiento de usuarios y perfiles para describir la consulta/seleccion del perfil y el contexto activo.
- [x] 3.3 Documentar que el perfil activo es por sesion, no se almacena globalmente en `AppUser` y no se combinan permisos de otros perfiles.

## 4. Contrato global de stored procedures

- [x] 4.1 Inventariar los 20 SP de `database/procedures`, sus codigos/resultsets actuales y consumidores documentados; separar las funciones que quedan excluidas.
- [x] 4.2 Definir y documentar el catalogo central de codigos funcionales estables, unicos y distintos de HTTP, eliminando reutilizaciones ambiguas.
- [x] 4.3 Actualizar cada SP para que emita primero una fila de estado, luego sus datos en resultsets documentados, use `operation` solo en comandos y relance errores tecnicos con `THROW`.
- [x] 4.4 Actualizar los documentos de integracion afectados para consumir el estado inicial, los datasets posteriores y los errores tecnicos.

## 5. Documentacion y verificacion

- [x] 5.1 Actualizar la documentacion de `AppUser`, `Profile`, seguridad, la entidad `UserProfile` y el diagrama ER.
- [x] 5.2 Revisar referencias a `AppUser.ProfileId` y a `UserCompany`/`UserCompanyProfile` en artefactos vigentes para alinear el modelo y no introducir membresia multiempresa.
- [x] 5.3 Validar estaticamente los escenarios de specs para contrato de resultsets, codigos, errores tecnicos, asignacion, duplicidad, reactivacion, revocacion, eventos append-only, atomicidad del historial, ultimo perfil, empresa incorrecta, sesiones concurrentes y aislamiento de permisos.
- [x] 5.4 Ejecutar validacion estatica de OpenSpec y entregar al DBA la lista de comprobacion para la creacion inicial; no declarar DDL ejecutado desde el repositorio.
