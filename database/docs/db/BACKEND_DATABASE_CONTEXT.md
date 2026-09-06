# Contexto de Base de Datos para Backend

## Proposito

Este documento es la referencia principal para desarrollar APIs REST del proyecto S.A.S. de inventario y facturacion.

El repositorio actualmente contiene la base core multiempresa, seguridad, usuarios y configuracion inicial de empresa. Los modulos especificos de inventario y facturacion todavia no tienen DDL definitivo en este repo.

## Motor

- SQL Server
- Esquema: `dbo`
- Modelo: multiempresa
- Autenticacion: por usuario
- Autorizacion: por permisos efectivos dentro de la empresa activa

## Instalacion inicial vigente

Nicole se crea sobre una base vacia. El punto de entrada es `database/20260905_001_crear_bd_registro_global_clientes.sql` ejecutado en SQLCMD Mode desde la raiz del repositorio. Define el modelo final: `Person` no guarda identificacion, `PersonIdentification` es global y `Client` contiene solo la relacion comercial y el contacto por `Company`.

Los archivos bajo `database/migrations/`, `database/validation/`, `database/tests/` y `database/rollback/` no pertenecen a la instalacion inicial y no deben ejecutarse.

## Orden de Ejecucion Recomendado

1. `database/tables/00-create-table-entitystatus.sql`
2. `database/tables/01-create-table-identification-type.sql`
3. `database/tables/02-create-table-person-type.sql`
4. `database/seeds/00-seed-base-catalogs.sql`
5. `database/procedures/catalogs/P_Catalog_Lookup.sql`
6. `database/tables/03-create-table-person.sql`
7. `database/tables/04-create-table-company.sql`
8. `database/tables/05-create-table-company-branch.sql`
9. `database/tables/06-create-table-company-emission-point.sql`
10. `database/tables/07-create-table-app-user.sql`
11. `database/tables/08-create-table-profile.sql`
12. `database/tables/09-create-table-permission.sql`
13. `database/seeds/01-seed-base-permissions.sql`
14. `database/tables/10-create-table-profile-permission.sql`
15. `database/tables/11-create-table-user-company.sql`
16. `database/tables/12-create-table-user-company-profile.sql`
17. `database/procedures/auth/P_Auth_Register.sql`
18. `database/tables/indexes/02-recommended-indexes.sql`

## Tablas Vigentes

| Tabla | Dominio | Proposito | Script |
| --- | --- | --- | --- |
| `EntityStatus` | Core | Catalogo canonico de estados (`A`, `I`). | `database/tables/00-create-table-entitystatus.sql` |
| `IdentificationType` | Core | Catalogo de tipos de identificacion tributaria/civil. | `database/tables/01-create-table-identification-type.sql` |
| `PersonType` | Core | Catalogo de persona natural o juridica. | `database/tables/02-create-table-person-type.sql` |
| `Person` | Core | Entidad canonica para personas naturales y juridicas. | `database/tables/03-create-table-person.sql` |
| `Company` | Empresa | Empresa legal del modelo multiempresa. | `database/tables/04-create-table-company.sql` |
| `CompanyBranch` | Empresa | Sucursal o establecimiento operativo de una empresa. | `database/tables/05-create-table-company-branch.sql` |
| `CompanyEmissionPoint` | Facturacion | Punto de emision asociado a una sucursal. | `database/tables/06-create-table-company-emission-point.sql` |
| `AppUser` | Seguridad | Identidad de acceso a la aplicacion. | `database/tables/07-create-table-app-user.sql` |
| `UserCompany` | Seguridad | Relacion entre usuario y empresa. | `database/tables/11-create-table-user-company.sql` |
| `Profile` | Seguridad | Perfil o rol definido dentro de una empresa. | `database/tables/08-create-table-profile.sql` |
| `Permission` | Seguridad | Catalogo de permisos funcionales usados por la app. | `database/tables/09-create-table-permission.sql` |
| `ProfilePermission` | Seguridad | Permisos asignados a perfiles. | `database/tables/10-create-table-profile-permission.sql` |
| `UserCompanyProfile` | Seguridad | Perfil asignado a un usuario dentro de una empresa. | `database/tables/12-create-table-user-company-profile.sql` |
| `PersonIdentification` | Registro global | Identidad normalizada y verificable de una persona. | `database/migrations/20260905_002_centralizar_registro_global_clientes_forward.sql` |
| `TaxRegistration` | Registro global | Datos tributarios verificados de una identidad RUC. | `database/migrations/20260905_002_centralizar_registro_global_clientes_forward.sql` |
| `EconomicActivity` | Registro global | Catálogo global de actividades económicas. | `database/migrations/20260905_002_centralizar_registro_global_clientes_forward.sql` |
| `TaxRegistrationEconomicActivity` | Registro global | Actividades verificadas de un registro tributario. | `database/migrations/20260905_002_centralizar_registro_global_clientes_forward.sql` |
| `RegistryProvider` | Registro global | Proveedor y TTL de verificación, sin secretos. | `database/migrations/20260905_002_centralizar_registro_global_clientes_forward.sql` |
| `PersonVerification` | Registro global | Historial de resultados y vigencias sin payload crudo. | `database/migrations/20260905_002_centralizar_registro_global_clientes_forward.sql` |
| `RegistryAccessAudit` | Seguridad | Auditoría mínima de acceso al registro global. | `database/migrations/20260905_002_centralizar_registro_global_clientes_forward.sql` |

## Scripts Complementarios

| Script | Tipo | Uso |
| --- | --- | --- |
| `database/seeds/00-seed-base-catalogs.sql` | Seed obligatorio | Crea `EntityStatus`, `IdentificationType` y `PersonType` base. |
| `database/procedures/catalogs/P_Catalog_Lookup.sql` | Consulta catalogos | Expone `STATUS`, `IDENTIFICATION` y `PERSON_TYPE` para selects. |
| `database/seeds/01-seed-base-permissions.sql` | Seed obligatorio | Crea permisos base para administracion inicial. |
| `database/seeds/99-insert-mock-data.sql` | Seed de pruebas | Crea datos mock y asigna todos los permisos base al perfil `ADMIN`. |
| `database/tables/indexes/02-recommended-indexes.sql` | Optimizacion recomendada | Crea indices para login, selector de empresa y permisos efectivos. |
| `database/docs/db/entities/app-user/01-unique-username-filtered.sql` | Constraint opcional | Hace `Username` unico cuando no es null. Ejecutar solo si la app permitira login/busqueda por username. |

## Integraciones Backend

| Integracion | Endpoint sugerido | Documento |
| --- | --- | --- |
| Registro inicial de empresa | `POST /api/auth/register` | `database/docs/db/integrations/INTEGRACION_API_AUTH_REGISTER.md` |
| Registro tributario y clientes por tenant | `POST /api/registry/resolve`, `POST/PATCH /api/clients` | `database/docs/db/integrations/INTEGRACION_API_REGISTRY_CLIENTS.md` |

## Registro global de clientes

La identidad fiscal es global en `PersonIdentification`; el cliente comercial sigue siendo local a una empresa en `Client`. El backend debe extraer `UserId` y `CompanyId` del contexto autenticado y pasarlos a todos los procedimientos. No acepta esos valores como autoridad de un payload del usuario.

La resolución se limita a coincidencia exacta de tipo y valor. Primero llama a `dbo.usp_Registry_ResolveIdentification`; si devuelve `202`, el adaptador externo del backend consulta el proveedor, aplica sus propios timeout/reintentos y persiste solo campos estructurados mediante `dbo.usp_Registry_PersistVerification`. SQL no realiza HTTP ni conserva secretos o JSON del proveedor.

Para el alta, cambio y baja de clientes usa `dbo.usp_Client_Create`, `dbo.usp_Client_Update` y `dbo.usp_Client_Deactivate`. La dirección de facturación, teléfono y correo son entradas locales obligatorias. `TaxRegistration.TaxAddress` puede mostrarse como sugerencia, pero nunca se copia automáticamente a `Client.BillingAddress`.

## Relaciones Principales

| Origen | Destino | Regla |
| --- | --- | --- |
| `Person.IdentificationType` | `IdentificationType.IdentificationTypeId` | Cada persona tiene un tipo de identificacion valido. |
| `Person.PersonType` | `PersonType.PersonTypeId` | Cada persona es natural o juridica. |
| `Company.RepresentativeId` | `Person.PersonId` | Representante legal opcional. |
| `Company.ParentCompanyId` | `Company.CompanyId` | Jerarquia empresarial opcional. |
| `CompanyBranch.CompanyId` | `Company.CompanyId` | Una empresa puede tener varias sucursales. |
| `CompanyEmissionPoint.CompanyBranchId` | `CompanyBranch.CompanyBranchId` | Una sucursal puede tener varios puntos de emision. |
| `AppUser.PersonId` | `Person.PersonId` | Un usuario pertenece a una persona. |
| `UserCompany.UserId` | `AppUser.UserId` | Un usuario puede acceder a varias empresas. |
| `UserCompany.CompanyId` | `Company.CompanyId` | Una empresa puede tener varios usuarios. |
| `Profile.CompanyId` | `Company.CompanyId` | Los perfiles pertenecen a una empresa. |
| `ProfilePermission.ProfileId` | `Profile.ProfileId` | Un perfil puede tener muchos permisos. |
| `ProfilePermission.PermissionId` | `Permission.PermissionId` | Un permiso puede estar en muchos perfiles. |
| `UserCompanyProfile(UserCompanyId, CompanyId)` | `UserCompany(UserCompanyId, CompanyId)` | Valida la empresa del usuario. |
| `UserCompanyProfile(ProfileId, CompanyId)` | `Profile(ProfileId, CompanyId)` | Evita asignar perfiles de otra empresa. |

## Stored Procedures Vigentes

| Stored Procedure | Proposito | Script |
| --- | --- | --- |
| `dbo.P_Auth_Register` | Registra persona, usuario, empresa, sucursal, punto de emision, relacion usuario-empresa, perfil `ADMIN` y permisos base en una transaccion. | `database/procedures/auth/P_Auth_Register.sql` |
| `dbo.P_Catalog_Lookup` | Consulta catalogos comunes para selects de UI con clave funcional estable. | `database/procedures/catalogs/P_Catalog_Lookup.sql` |

## Regla de Autorizacion

La aplicacion no debe autorizar acciones por nombre de perfil fijo, por ejemplo `ADMIN`.

Cada endpoint debe validar el permiso efectivo del usuario en la empresa activa:

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

## Permisos Iniciales Sugeridos

| Codigo | Modulo | Uso esperado |
| --- | --- | --- |
| `company.read` | `company` | Consultar empresa activa. |
| `company.update` | `company` | Actualizar datos de empresa. |
| `user.read` | `user` | Consultar usuarios de la empresa. |
| `user.create` | `user` | Crear usuarios en la empresa. |
| `user.update` | `user` | Actualizar usuarios. |
| `user.disable` | `user` | Desactivar usuarios. |
| `profile.read` | `profile` | Consultar perfiles. |
| `profile.create` | `profile` | Crear perfiles. |
| `profile.update` | `profile` | Actualizar perfiles. |
| `profile.assign` | `profile` | Asignar perfiles a usuarios. |
| `permission.read` | `permission` | Consultar permisos. |
| `permission.assign` | `permission` | Asignar permisos a perfiles. |

## Pendientes para Inventario y Facturacion

Estas entidades son necesarias para el objetivo del producto, pero aun no existen como DDL vigente en el repo:

| Modulo | Entidades pendientes |
| --- | --- |
| Inventario | `Product`, `ProductCategory`, `Brand`, `UnitOfMeasure`, `Warehouse`, `WarehouseProduct`, `StockMovement` |
| Facturacion | `Invoice`, `InvoiceDetail`, `Payment`, `Tax`, `ElectronicDocumentStatus`; el cliente comercial queda definido por esta migracion y la factura conserva un contrato futuro de snapshot. |

Antes de generar APIs REST de inventario o facturacion, primero se debe crear y aprobar el DDL de estas tablas y sus stored procedures.

## Archivos Conservados

- `database/docs/db/02-conventions.md`: convenciones generales de diseno.
- `database/docs/db/03-new-database-working-document.md`: bitacora de decisiones.
- `database/docs/db/04-erp-app-generation-context.md`: contexto amplio para generar la app.
- `database/docs/db/entities/**`: documentos y scripts vigentes por entidad.
- `database/docs/db/stored-procedures/**`: procedimientos almacenados separados de las entidades.
- `database/docs/db/integrations/**`: contratos de integracion para backend/frontend.
