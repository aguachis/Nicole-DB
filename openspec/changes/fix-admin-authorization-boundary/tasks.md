## 1. Definir el contrato de autorizacion para SP sensibles

- [x] 1.1 Identificar todos los SP de usuarios, perfiles y seguridad que aceptan `@CompanyId` sin actor autenticado
- [x] 1.2 Definir la firma nueva con `@ActorUserId`, `@ActorProfileId` y validaciones necesarias
- [x] 1.3 Documentar el flujo de autorizacion: actor activo, mismo tenant, perfil activo y permiso efectivo

## 2. Corregir SP de mantenimiento de usuarios

- [x] 2.1 Actualizar `database/procedures/auth/P_User_List.sql` para validar actor, perfil y permiso efectivo antes de consultar
- [x] 2.2 Revisar `database/procedures/auth/P_User_Create.sql` para exigir actor autentico y permisos de creacion por empresa
- [x] 2.3 Confirmar que no existan rutas de lectura o escritura de usuario sin control de tenant y perfil activo

## 3. Corregir SP de perfiles y asignaciones

- [x] 3.1 Ajustar `database/procedures/profile/P_UserProfile_Assign.sql` para validar actor, perfil activo y permiso de asignacion
- [x] 3.2 Ajustar `database/procedures/profile/P_UserProfile_Revoke.sql` para rechazar operaciones cruzadas y sin permiso efectivo
- [x] 3.3 Ajustar `database/procedures/profile/P_UserProfile_ListByUser.sql` para consultar solo perfiles del mismo tenant y actor autorizado

## 4. Reforzar la capa de autorizacion efectiva

- [x] 4.1 Reutilizar o ampliar `database/procedures/registry-client/20260905_006_registry_client_authorization_helpers.sql` para cualquier SP administrativo susceptible de cross-tenant
- [x] 4.2 Garantizar que la autorizacion derive del perfil activo de la sesion y no de la suma de perfiles del usuario
- [x] 4.3 Mantener la regla de single-tenant en toda operacion con `UserId`, `CompanyId` y `ProfileId`

## 5. Auditoria y validacion final para DBA

- [x] 5.1 Confirmar que los SP de usuarios/perfiles devuelven `result_code` funcional para actor no valido, sin permiso y tenant cruzado
- [x] 5.2 Revisar trazabilidad de auditoria para asignacion, revocacion y listados sensibles
- [x] 5.3 Documentar checklist de validacion SQL Server para el DBA antes del despliegue
- [x] 5.4 Verificar que la base nueva sigue respetando el modelo multiempresa y la frontera single-tenant
