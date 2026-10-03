# Revision de Seguridad - Roles y Permisos

## Estado

Definicion inicial para base nueva.

## Regla principal

Cada usuario pertenece a una sola empresa y puede tener varios perfiles dentro de ella. Cada sesion elige un perfil activo y nunca combina los permisos de perfiles alternativos.

Por eso el modelo recomendado es:

- `AppUser`: identidad de acceso
- `Company`: empresa tenant del usuario
- `Profile`: rol definido por empresa
- `UserProfile`: asignaciones activas/inactivas dentro de la empresa unica
- `UserProfileAudit`: historial append-only de asignaciones y revocaciones
- `Permission`: permiso funcional
- `ProfilePermission`: permisos asignados a cada rol

## Scripts base

- `database/tables/07-create-table-app-user.sql`
- `database/tables/08-create-table-profile.sql`
- `database/tables/11-create-table-user-profile.sql`
- `database/tables/12-create-table-user-profile-audit.sql`
- `database/tables/09-create-table-permission.sql`
- `database/tables/10-create-table-profile-permission.sql`

## Comentario de diseno

`AppUser` guarda directamente `CompanyId`, sin `ProfileId`. `UserProfile` usa las FKs compuestas `(UserId, CompanyId)` y `(ProfileId, CompanyId)` para impedir asignaciones fuera de la empresa unica del usuario. `UserProfileAudit` conserva los eventos de asignacion, reactivacion y revocacion en la misma transaccion que el cambio.
