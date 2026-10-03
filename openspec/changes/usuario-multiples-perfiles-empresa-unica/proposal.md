## Why

El modelo actual permite un solo `ProfileId` por usuario en `AppUser`, por lo que no puede representar a una persona que desempeña varias funciones dentro de su unica empresa. Se necesita permitir multiples perfiles asignados, manteniendo aislados los permisos y usando un solo perfil elegido como contexto activo de cada sesion.

## What Changes

- Mantener `AppUser.CompanyId` como la empresa unica a la que pertenece cada usuario.
- Reemplazar la relacion directa `AppUser.ProfileId` por una asignacion de multiples perfiles mediante `UserProfile`, con integridad que impida vincular perfiles de otra empresa.
- Registrar asignaciones, revocaciones y reactivaciones exitosas en un historial de auditoria append-only, atomico con el cambio de la asignacion.
- Definir el modelo directamente en los scripts de creacion de la base nueva; no se requieren migraciones de datos ni scripts `ALTER` para transformar una base existente.
- Actualizar la creacion, asignacion, revocacion y consulta de perfiles de usuario para soportar varias asignaciones activas y preservar al menos un perfil activo por usuario.
- Permitir consultar los perfiles activos asignados y validar el `ProfileId` elegido al construir el contexto de sesion.
- Calcular permisos efectivos unicamente desde el perfil activo de la sesion; no sumar permisos de otros perfiles asignados.
- Actualizar la documentacion de integracion de login/perfiles, entidades y diagrama para reflejar el modelo.
- Definir `AppUser` sin una columna `ProfileId` unica y crear las asignaciones en `UserProfile` desde el esquema inicial.
- Estandarizar el contrato de respuesta en todos los procedimientos almacenados de `database/procedures`, incluidos los dominios de autenticacion, perfiles, clientes y catalogos.

## Capabilities

### New Capabilities

- `user-profile-session-selection`: consulta de perfiles permitidos y validacion del perfil activo usado para obtener permisos de sesion.
- `stored-procedure-response-contract`: contrato uniforme de estado, datos, codigos funcionales y errores tecnicos para todos los SP.

### Modified Capabilities

- `user-profile-assignment-sp`: cambiar asignacion/revocacion de un perfil unico por asignaciones multiples por usuario, empresa y perfil.
- `user-maintenance-sp`: crear usuarios con un perfil inicial asignado a traves de la relacion usuario-perfil.

## Impact

- Tablas y restricciones: `dbo.AppUser`, nuevas `dbo.UserProfile` y `dbo.UserProfileAudit`, `dbo.Profile` y relaciones con `dbo.EntityStatus`.
- Procedimientos: todos los SP de `database/procedures` (autenticacion, usuarios, perfiles/permisos, clientes y catalogos), incluyendo `P_UserProfile_Assign`, operaciones de revocacion/listado y `P_Auth_GetSessionContext`.
- Integracion/documentacion: contratos de integracion existentes afectados, `INTEGRACION_API_AUTH_LOGIN.md`, `INTEGRACION_API_USER_SECURITY_MAINTENANCE.md`, documentos de entidades y `database/docs/db/databse-diagrama.md`.
- Configuracion OpenSpec: `openspec/config.yaml` queda alineado con una empresa por usuario y multiples perfiles en esa empresa.
- No hay codigo de API ni UI en este repositorio; la API debe transportar el perfil seleccionado y tratarlo como contexto confiable solo despues de validarlo contra la asignacion activa.
- Los consumidores de todos los SP deben adaptarse al resultset inicial de estado y a los resultsets de datos posteriores; se excluyen funciones escalares o tabulares, que no tienen el contrato de resultsets de un SP.
- La base objetivo es nueva: el alcance incluye los scripts de creacion inicial del esquema y no incluye migrar datos ni alterar una base existente.
- El DBA debe revisar y ejecutar el orden de creacion de los scripts iniciales y certificar el despliegue; no se afirma que se hayan ejecutado.
