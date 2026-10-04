## Why

La base ya modela correctamente el single-tenant por `AppUser.CompanyId` y `UserProfile.CompanyId`, pero varios SP de mantenimiento y perfil siguen aceptando un `@CompanyId` sin validar la identidad, el perfil activo y el permiso efectivo del actor. Eso permite que un ejecutor con acceso al procedimiento pueda consultar o mutar datos de otra empresa si conoce el tenant objetivo, aunque la sesión del backend esté acotada por empresa.

El problema se observa especialmente en los SP de usuarios y perfiles, donde la seguridad efectiva no está uniformemente aplicada como sí ocurre en los procedimientos de clientes con `fn_HasEffectivePermission`.

## What Changes

- Reforzar la firma de los SP sensibles para incluir el identificador del actor y del perfil activo de sesión.
- Validar que el actor exista, esté activo, sea miembro de la empresa recibida y tenga un perfil activo para esa empresa.
- Requerir permiso efectivo antes de leer o modificar usuarios/perfiles, usando el mismo patrón de autorización que la capa de clientes.
- Cerrar la brecha de cross-tenant en listados, altas, cambios de estado, asignaciones y revocaciones de perfiles.
- Mantener el estándar de auditoría y no permitir autorizar por unión de perfiles ni por `CompanyId` sin identidad autenticada.
- Documentar el conjunto de SPs que deben corregirse y dejar explícito qué DBA debe verificar en SQL Server antes del despliegue.

**BREAKING**: La firma de varios SP administrativos debe cambiar para incluir `@ActorUserId` y `@ActorProfileId` (o equivalente) y, en algunos casos, el `@ProfileId` activo de la sesión. Los consumidores actuales deben enviar la identidad autenticada y no confiar solo en `@CompanyId`.

## Capabilities

### New Capabilities
- none

### Modified Capabilities
- `user-maintenance-sp`: las operaciones de alta, consulta, bloqueo/activación y actualización de usuarios deben exigir identidad del actor, pertenencia y permiso efectivo por empresa y perfil activo.
- `user-profile-assignment-sp`: la asignación y revocación de perfiles debe reforzar el mismo control de actor, compañía y permiso efectivo antes de modificar `UserProfile`.
- `registry-access-security`: la política de autorización efectiva por tenant y perfil activo debe aplicarse de manera consistente a toda operación sensible del backend, no solo a clientes.

## Impact

- Afecta los SPs de autenticación y mantenimiento de usuarios y perfiles:
  - `database/procedures/auth/P_User_List.sql`
  - `database/procedures/auth/P_User_Create.sql`
  - `database/procedures/profile/P_UserProfile_Assign.sql`
  - `database/procedures/profile/P_UserProfile_Revoke.sql`
  - `database/procedures/profile/P_UserProfile_ListByUser.sql`
  - `database/procedures/auth/P_Auth_GetSessionContext.sql` (como referencia de la política de sesión)
- Reutiliza la base de autorización efectiva ya implementada en:
  - `database/procedures/registry-client/20260905_006_registry_client_authorization_helpers.sql`
- Critico para la integridad del modelo multiempresa documentado en:
  - `database/docs/db/BACKEND_DATABASE_CONTEXT.md`
  - `database/docs/db/puntos_mejora.md`
- No implica nuevas tablas ni migraciones de esquema; es un cambio de contrato de procedimiento y validación de negocio.
