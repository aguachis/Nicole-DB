# Documento de Trabajo - Nueva Base de Datos

## Objetivo

Este documento concentra las decisiones de diseno, creacion y optimizacion de la nueva base de datos del ERP.

La idea es usarlo como bitacora tecnica viva: cada decision importante debe quedar registrada antes de convertirla en scripts definitivos.

## Alcance

- Diseno de entidades nuevas
- Revision de entidades existentes
- Normalizacion de nombres, llaves y relaciones
- Optimizacion de indices
- Estandarizacion de estados y auditoria
- Revision de stored procedures
- Definicion de reglas de seguridad, roles, perfiles y permisos
- Preparacion de scripts de migracion cuando aplique

## Principios de trabajo

- Documentar primero la decision funcional y tecnica
- Evitar duplicar entidades con la misma responsabilidad
- Preferir relaciones explicitas mediante foreign keys
- Separar claramente modelo nuevo y modelo legacy
- Mantener scripts por entidad para facilitar revision y ejecucion controlada
- Validar indices contra patrones reales de consulta
- Evitar cambios de ruptura sin estrategia de migracion

## Decision 001 - Seguridad, roles y perfiles

### Estado

Aprobada como modelo objetivo inicial.

### Regla principal

El rol depende de la empresa.

Por lo tanto, un usuario no debe tener un perfil global unico. Un mismo usuario puede tener distintos perfiles segun la empresa a la que accede.

Ejemplos:

- Usuario A es `ADMIN` en Empresa 1
- Usuario A es `CAJERO` en Empresa 2
- Usuario B es `CONSULTA` en Empresa 1

### Entidades del modelo

- `AppUser`: identidad de acceso del usuario.
- `Company`: empresa a la que el usuario puede acceder.
- `Profile`: rol o perfil definido dentro de una empresa.
- `Permission`: permiso funcional del sistema.
- `ProfilePermission`: permisos asignados a un perfil.
- `UserCompany`: relacion entre usuario y empresa.
- `UserCompanyProfile`: perfil del usuario dentro de una empresa.

### Relacion conceptual

```text
AppUser
  -> UserCompany
      -> Company
      -> UserCompanyProfile
          -> Profile
              -> ProfilePermission
                  -> Permission
```

### Regla de integridad importante

`Profile` pertenece a una `Company`.

`UserCompanyProfile` debe validar que el perfil asignado pertenezca a la misma empresa del `UserCompany`.

Por eso el modelo usa claves compuestas de apoyo:

- `Profile(ProfileId, CompanyId)`
- `UserCompany(UserCompanyId, CompanyId)`

Y `UserCompanyProfile` referencia ambas para evitar asignar a un usuario un perfil de otra empresa.

### Modelo que se reemplaza

El modelo objetivo reemplaza la idea de `UserProfile` global.

`UserProfile` no debe ser la referencia principal para la nueva base porque no resuelve correctamente el escenario multiempresa.

### Permisos

Los permisos se manejan como capacidades concretas y tecnicas del sistema.

Ejemplos:

- `company.read`
- `company.create`
- `invoice.read`
- `invoice.create`
- `user.manage`

Los permisos se asignan al perfil mediante `ProfilePermission`, no directamente al usuario.

### Flujo inicial de registro

Cuando se registra una empresa con su primer usuario:

1. Se crea o identifica la persona.
2. Se crea el usuario.
3. Se crea la empresa.
4. Se crea la sucursal inicial.
5. Se crea el punto de emision inicial.
6. Se crea la relacion `UserCompany`.
7. Se crea o identifica el perfil `ADMIN` para esa empresa.
8. Se crean permisos base si no existen.
9. Se asignan permisos base al perfil `ADMIN`.
10. Se asigna el perfil `ADMIN` al usuario mediante `UserCompanyProfile`.

### Scripts relacionados

- `docs/db/entities/app-user/00-create-table-appuser.sql`
- `docs/db/entities/profile/00-create-table-profile.sql`
- `docs/db/entities/permission/00-create-table-permission.sql`
- `docs/db/entities/profile-permission/00-create-table-profile-permission.sql`
- `docs/db/entities/user-company/00-create-table-user-company.sql`
- `docs/db/entities/user-company-profile/00-create-table-user-company-profile.sql`
- `docs/db/stored-procedures/auth/P_Auth_Register.sql`
- `docs/db/integrations/INTEGRACION_API_AUTH_REGISTER.md`

### Pendientes

- Definir catalogo inicial de permisos por modulo.
- Definir perfiles base sugeridos por empresa.
- Revisar si existiran perfiles plantilla globales para crear perfiles por empresa.
- Actualizar el script consolidado si todavia contiene `UserProfile` como modelo principal.
- Definir consultas/SPs para obtener permisos efectivos del usuario por empresa.

## Backlog inicial

- Mantener `docs/db/BACKEND_DATABASE_CONTEXT.md` como indice vigente para el backend.
- Definir orden oficial de ejecucion de scripts.
- Crear matriz de modulos y permisos.
- Crear SP o vista para permisos efectivos por usuario y empresa.
- Revisar indices para login, seleccion de empresa y validacion de permisos.

## Ejemplo 001 - Roles y permisos para usuarios

### Escenario

Empresa: `Nicole Mock Store`

Usuarios:

- `nicole.admin`: administradora de la empresa.
- `caja.001`: usuario operativo de caja.
- `consulta.001`: usuario solo lectura.

Perfiles:

- `ADMIN`: puede administrar usuarios y configuracion.
- `CAJERO`: puede operar ventas, pero no administrar usuarios.
- `CONSULTA`: solo puede consultar informacion.

Permisos:

- `user.read`: consultar usuarios.
- `user.create`: crear usuarios.
- `user.update`: actualizar usuarios.
- `user.disable`: desactivar usuarios.
- `profile.read`: consultar perfiles.
- `profile.assign`: asignar perfiles a usuarios.

### Matriz de permisos

| Perfil | user.read | user.create | user.update | user.disable | profile.read | profile.assign |
| --- | --- | --- | --- | --- | --- | --- |
| ADMIN | Si | Si | Si | Si | Si | Si |
| CAJERO | No | No | No | No | No | No |
| CONSULTA | Si | No | No | No | Si | No |

### Lectura funcional

Para crear usuarios dentro de una empresa, el usuario autenticado debe tener el permiso `user.create` en esa empresa.

No basta con que el usuario exista ni con que tenga un perfil llamado `ADMIN` en otra empresa. La validacion siempre debe hacerse con:

- usuario autenticado
- empresa seleccionada
- permiso requerido

### Consulta conceptual de permisos efectivos

```sql
SELECT DISTINCT
    p.Code,
    p.Name,
    p.ModuleCode
FROM dbo.AppUser u
INNER JOIN dbo.UserCompany uc
    ON uc.UserId = u.UserId
   AND uc.Status = 'A'
INNER JOIN dbo.UserCompanyProfile ucp
    ON ucp.UserCompanyId = uc.UserCompanyId
   AND ucp.CompanyId = uc.CompanyId
   AND ucp.Status = 'A'
INNER JOIN dbo.Profile pr
    ON pr.ProfileId = ucp.ProfileId
   AND pr.CompanyId = uc.CompanyId
   AND pr.Status = 'A'
INNER JOIN dbo.ProfilePermission pp
    ON pp.ProfileId = pr.ProfileId
   AND pp.Status = 'A'
INNER JOIN dbo.Permission p
    ON p.PermissionId = pp.PermissionId
   AND p.Status = 'A'
WHERE u.UserId = @UserId
  AND uc.CompanyId = @CompanyId;
```

### Validacion para crear usuarios

```sql
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.AppUser u
    INNER JOIN dbo.UserCompany uc
        ON uc.UserId = u.UserId
       AND uc.Status = 'A'
    INNER JOIN dbo.UserCompanyProfile ucp
        ON ucp.UserCompanyId = uc.UserCompanyId
       AND ucp.CompanyId = uc.CompanyId
       AND ucp.Status = 'A'
    INNER JOIN dbo.Profile pr
        ON pr.ProfileId = ucp.ProfileId
       AND pr.CompanyId = uc.CompanyId
       AND pr.Status = 'A'
    INNER JOIN dbo.ProfilePermission pp
        ON pp.ProfileId = pr.ProfileId
       AND pp.Status = 'A'
    INNER JOIN dbo.Permission p
        ON p.PermissionId = pp.PermissionId
       AND p.Status = 'A'
    WHERE u.UserId = @CurrentUserId
      AND uc.CompanyId = @CompanyId
      AND p.Code = N'user.create'
)
BEGIN
    RAISERROR('No tiene permisos para crear usuarios en esta empresa.', 16, 1);
    RETURN;
END;
```

### Datos mock sugeridos

```sql
DECLARE @CompanyId UNIQUEIDENTIFIER = '22222222-2222-2222-2222-222222222222';
DECLARE @AdminProfileId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666666';
DECLARE @CashierProfileId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666667';
DECLARE @ReadOnlyProfileId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666668';

DECLARE @UserReadPermissionId UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777701';
DECLARE @UserCreatePermissionId UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777702';
DECLARE @UserUpdatePermissionId UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777703';
DECLARE @UserDisablePermissionId UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777704';
DECLARE @ProfileReadPermissionId UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777705';
DECLARE @ProfileAssignPermissionId UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777706';

INSERT INTO dbo.Profile (ProfileId, CompanyId, Name, Description, Status, CreatedBy)
VALUES
    (@AdminProfileId, @CompanyId, N'ADMIN', N'Administrador de la empresa', 'A', N'mock.seed'),
    (@CashierProfileId, @CompanyId, N'CAJERO', N'Operador de caja', 'A', N'mock.seed'),
    (@ReadOnlyProfileId, @CompanyId, N'CONSULTA', N'Usuario de solo consulta', 'A', N'mock.seed');

INSERT INTO dbo.Permission (PermissionId, Code, Name, Description, ModuleCode, Status, CreatedBy)
VALUES
    (@UserReadPermissionId, N'user.read', N'Consultar usuarios', N'Permite consultar usuarios de la empresa', N'user', 'A', N'mock.seed'),
    (@UserCreatePermissionId, N'user.create', N'Crear usuarios', N'Permite crear usuarios para la empresa', N'user', 'A', N'mock.seed'),
    (@UserUpdatePermissionId, N'user.update', N'Actualizar usuarios', N'Permite actualizar datos de usuarios', N'user', 'A', N'mock.seed'),
    (@UserDisablePermissionId, N'user.disable', N'Desactivar usuarios', N'Permite desactivar usuarios', N'user', 'A', N'mock.seed'),
    (@ProfileReadPermissionId, N'profile.read', N'Consultar perfiles', N'Permite consultar perfiles', N'profile', 'A', N'mock.seed'),
    (@ProfileAssignPermissionId, N'profile.assign', N'Asignar perfiles', N'Permite asignar perfiles a usuarios', N'profile', 'A', N'mock.seed');

INSERT INTO dbo.ProfilePermission (ProfileId, PermissionId, Status, CreatedBy)
VALUES
    (@AdminProfileId, @UserReadPermissionId, 'A', N'mock.seed'),
    (@AdminProfileId, @UserCreatePermissionId, 'A', N'mock.seed'),
    (@AdminProfileId, @UserUpdatePermissionId, 'A', N'mock.seed'),
    (@AdminProfileId, @UserDisablePermissionId, 'A', N'mock.seed'),
    (@AdminProfileId, @ProfileReadPermissionId, 'A', N'mock.seed'),
    (@AdminProfileId, @ProfileAssignPermissionId, 'A', N'mock.seed'),
    (@ReadOnlyProfileId, @UserReadPermissionId, 'A', N'mock.seed'),
    (@ReadOnlyProfileId, @ProfileReadPermissionId, 'A', N'mock.seed');
```

### Pendiente tecnico

Convertir la validacion de permisos en una funcion o stored procedure reutilizable, por ejemplo:

- `dbo.FN_UserHasPermission(@UserId, @CompanyId, @PermissionCode)`
- `dbo.P_Security_ValidatePermission(@UserId, @CompanyId, @PermissionCode)`
