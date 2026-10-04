## Context

El modelo de seguridad del repositorio ya establece tres reglas clave: `AppUser` pertenece a una sola empresa, `UserProfile` debe mantener `CompanyId` consistente con el usuario y el perfil, y la autorizacion de sesion se basa en el perfil activo elegido para esa sesion. Esto se documenta en `database/docs/db/BACKEND_DATABASE_CONTEXT.md` y se refuerza en `database/procedures/auth/P_Auth_GetSessionContext.sql`.

Sin embargo, la administracion de usuarios y perfiles sigue teniendo un hueco de diseño: varios SP aceptan `@CompanyId` y otros identificadores, pero no validan la identidad del actor autenticado ni su permiso efectivo. El caso visible es `P_User_List`, y la misma ausencia de frontera aparece en los SP de perfiles. El patron ya implementado para clientes en `database/procedures/registry-client/20260905_006_registry_client_authorization_helpers.sql` demuestra la solucion esperada: evaluar permisos efectivos por `UserId + CompanyId + ProfileId`.

## Goals / Non-Goals

**Goals:**
- Cerrar la brecha de cross-tenant en SPs administrativos.
- Reutilizar el mismo criterio de autorizacion de la sesion: perfil activo, empresa del usuario y permisos efectivos.
- Asegurar que las consultas y mutaciones de usuarios/perfiles solo operen sobre el tenant correcto.
- Mantener la auditoria funcional y la trazabilidad de la accion.

**Non-Goals:**
- No se cambiaran modelos de negocio distintos al de seguridad y autorizacion.
- No se introduciran nuevas tablas para permisos; se reutiliza `Permission`, `ProfilePermission`, `UserProfile` y `AppUser`.
- No se dejaran scripts de migracion para bases ya desplegadas; este cambio se incorpora como regla de contrato de procedimiento y validacion de negocio.

## Decisions

### 1. El actor autenticado debe ser parte del contrato del SP
Los SP sensibles no deben depender solo de `@CompanyId`; deben recibir la identidad del actor autenticado y el perfil activo de la sesion. Esto evita que el mismo procedimiento pueda ser invocado con un tenant arbitrario por un usuario que no tiene permiso para ese tenant.

**Rationale:** el punto de fallo actual es exactamente la firma del procedimiento: la empresa del objetivo se valida, pero la identidad del ejecutante no. La sesion ya resuelve este dato correctamente en `P_Auth_GetSessionContext`.

### 2. La autorizacion debe evaluarse con permisos efectivos
La validacion no sera por nombre de perfil ni por presencia de la relacion en otra tabla; se evaluara mediante la funcion centralizada `fn_HasEffectivePermission` o equivalentes sobre `UserId`, `CompanyId` y `ProfileId` activo.

**Rationale:** este patron ya existe para clientes y hace el control uniforme para toda operacion sensible.

### 3. El permiso se calcula desde el perfil activo de la sesion, no desde la suma de perfiles
La regla single-tenant no se rompe si un usuario tiene varios perfiles. El sistema debe permitir multiples perfiles para la misma empresa, pero la autorizacion de cada accion debe derivarse del perfil activo que eligio para la sesion.

**Alternatives considered:**
- Combinar permisos de todos los perfiles del usuario.
- Autorizar por `CompanyId` solamente.
- Validar solo la pertenencia del usuario a la empresa.

**Why rejected:** cada alternativa permitiria dependencia innecesaria de conexiones cruzadas o autorizacion por agregacion, rompendo la regla de empresa unica por sesion.

### 4. Cada SP administracion debe aplicar la misma frontera de validacion
Los SP de consulta, alta, baja, activacion/inactivacion y asignacion de perfiles deben tener la misma secuencia de validacion:
1. `@CompanyId` no nulo.
2. `@ActorUserId` no nulo y vigente.
3. `@ActorProfileId` no nulo y activo.
4. Actor pertenece a `@CompanyId`.
5. Actor tiene permiso efectivo requerido.
6. Operacion solo sobre entidades de `@CompanyId`.
7. Resultado funcional si falla alguna validacion.

**Rationale:** minimiza riesgo de bypass y homogeneiza la seguridad para toda la administracion.

### 5. La evaluacion de permisos efectivos se encapsula en un helper reutilizable para todos los SP administrativos
La validacion de permiso efectivo no se implementara en un conjunto de vistas ni se duplicara en cada SP con pequenas variaciones. Se normaliza un helper centralizado de autorizacion, por ejemplo `dbo.fn_HasEffectivePermission`, que todos los SP administrativos invocan con `UserId`, `CompanyId` y `ProfileId` activo.

**Rationale:** la seguridad efectiva es una regla de negocio central y transversal; mantenerla en un unico helper evita drift de permisos, inconsistencia entre procedimientos y validaciones cruzadas por tenant. La capa SP conserva la validacion de contexto de entrada, pero la decision final de autorizacion debe salir del helper compartido.

**Alternatives considered:**
- Duplicar la validacion dentro de cada SP.
- Encapsular la decision en una vista.
- Autorizar por `CompanyId` sin controlar al actor.

**Why rejected:** las alternativas anteriores permiten divergencia funcional, no mantienen la regla de single-tenant ni ofrecen un unico punto de control para auditoria y mantenimiento.

## Risks / Trade-offs

- [Risk] Cambiar la firma de SPs puede romper clientes legados que invocan los procedimientos sin actor. → Mitigation: actualizar la capa de consumo y documentar el contrato nuevo en el protocolo de seguridad del backend.
- [Risk] Los permisos efectivos pueden quedar desalineados con los perfiles activos reales. → Mitigation: validar `UserProfile` y `Profile` activos antes de cada ejecucion y mantener auditoria de la operacion.
- [Risk] La aplicacion de la regla a todos los SP puede requerir cambios en procedures no documentados. → Mitigation: revisar el conjunto de SPs sensibles y centralizar la validacion en un helper reutilizable.

## Migration Plan

1. Identificar todos los SPs administrativos que leen o manipulan usuarios, perfiles y permisos.
2. Ajustar la firma y validacion de cada uno con los parametros del actor autentico y del perfil activo.
3. Aplicar la comprobacion de permisos efectivos por `UserId`, `CompanyId` y `ProfileId`.
4. Probar con casos de negocio y confirmacion DBA:
   - actor valido en la empresa correcta;
   - actor valido en otra empresa;
   - actor sin permiso efectivo;
   - perfil inactivo o no asignado;
   - listas cruzadas con `CompanyId` distinto;
   - operaciones de asignacion/revocacion con datos del tenant correcto.
5. Ejecutar despliegue en entorno controlado con validacion SQL Server por el DBA.

## Open Questions

- El equipo requiere bloquear completamente algunos SP para usuarios no administrativos, o conviene exponer solo lectura restringida para ciertos perfiles?
