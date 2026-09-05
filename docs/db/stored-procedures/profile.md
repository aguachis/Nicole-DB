# Stored Procedures - Profile

## Estado

Definicion inicial para base nueva.

## Objetivo

Cubrir el mantenimiento de perfiles por empresa y la asignacion de permisos a cada perfil.

## Alcance de esta etapa

- listar perfiles por empresa
- consultar detalle de un perfil
- crear perfil
- actualizar perfil
- inactivar perfil
- listar permisos disponibles para asignacion
- sincronizar permisos activos de un perfil

## Procedimientos principales

- `types/00-create-type-permission-code-list.sql`
- `procedures/profile/P_Permission_List.sql`
- `procedures/profile/P_Profile_ListByCompany.sql`
- `procedures/profile/P_Profile_GetDetail.sql`
- `procedures/profile/P_Profile_Create.sql`
- `procedures/profile/P_Profile_Update.sql`
- `procedures/profile/P_Profile_Deactivate.sql`
- `procedures/profile/P_ProfilePermission_ReplaceByProfile.sql`
- `procedures/profile/P_UserCompanyProfile_Assign.sql`
- `procedures/profile/P_UserCompanyProfile_Revoke.sql`

## Regla importante

`Profile` es tenant-scoped por `CompanyId`. Toda operacion de escritura debe validar empresa, perfil y auditoria. La eliminacion se implementa como baja logica usando `Status = 'I'`.

## Flujo recomendado para frontend/backend

1. listar perfiles de la empresa
2. crear o actualizar perfil
3. consultar permisos disponibles
4. sincronizar permisos del perfil con el set final enviado por el backend

## Notas de implementacion

- `Permission` se trata como catalogo global de solo lectura en esta etapa.
- La asignacion de permisos usa un TVP `dbo.PermissionCodeListType` para evitar payloads ambiguos dentro de SQL Server.
- `P_ProfilePermission_ReplaceByProfile` reactiva, inserta o inactiva relaciones segun el set final recibido.

## Nomenclatura y ubicacion de SP

- Dominio auth (`procedures/auth/`): prefijo `P_User_` para mantenimiento de usuario.
- Dominio profile (`procedures/profile/`): prefijo `P_UserCompanyProfile_` para asignacion/revocacion por empresa.
- Operaciones de asignacion deben validar usuario activo, pertenencia `UserCompany` activa y perfil activo de la misma empresa.

## Matriz minima de validaciones en asignacion de perfiles

- `P_UserCompanyProfile_Assign`: valida `CompanyId`, `UserId`, `ProfileId`, `Actor`, pertenencia activa y perfil activo; inserta, reactiva o retorna no-op.
- `P_UserCompanyProfile_Revoke`: valida `CompanyId`, `UserId`, `ProfileId`, `Actor` y pertenencia activa; inactiva o retorna no-op idempotente.