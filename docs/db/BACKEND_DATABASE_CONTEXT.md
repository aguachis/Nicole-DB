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

## Orden de Ejecucion Recomendado

1. `tables/00-create-table-entitystatus.sql`
2. `tables/01-create-table-identification-type.sql`
3. `tables/02-create-table-person-type.sql`
4. `seeds/00-seed-base-catalogs.sql`
5. `procedures/catalogs/P_Catalog_Lookup.sql`
6. `tables/03-create-table-person.sql`
7. `tables/04-create-table-company.sql`
8. `tables/05-create-table-company-branch.sql`
9. `tables/06-create-table-company-emission-point.sql`
10. `tables/07-create-table-app-user.sql`
11. `tables/08-create-table-profile.sql`
12. `tables/09-create-table-permission.sql`
13. `seeds/01-seed-base-permissions.sql`
14. `tables/10-create-table-profile-permission.sql`
15. `tables/11-create-table-user-company.sql`
16. `tables/12-create-table-user-company-profile.sql`
17. `procedures/auth/P_Auth_Register.sql`
18. `tables/indexes/02-recommended-indexes.sql`

## Tablas Vigentes

| Tabla | Dominio | Proposito | Script |
| --- | --- | --- | --- |
| `EntityStatus` | Core | Catalogo canonico de estados (`A`, `I`). | `tables/00-create-table-entitystatus.sql` |
| `IdentificationType` | Core | Catalogo de tipos de identificacion tributaria/civil. | `tables/01-create-table-identification-type.sql` |
| `PersonType` | Core | Catalogo de persona natural o juridica. | `tables/02-create-table-person-type.sql` |
| `Person` | Core | Entidad canonica para personas naturales y juridicas. | `tables/03-create-table-person.sql` |
| `Company` | Empresa | Empresa legal del modelo multiempresa. | `tables/04-create-table-company.sql` |
| `CompanyBranch` | Empresa | Sucursal o establecimiento operativo de una empresa. | `tables/05-create-table-company-branch.sql` |
| `CompanyEmissionPoint` | Facturacion | Punto de emision asociado a una sucursal. | `tables/06-create-table-company-emission-point.sql` |
| `AppUser` | Seguridad | Identidad de acceso a la aplicacion. | `tables/07-create-table-app-user.sql` |
| `UserCompany` | Seguridad | Relacion entre usuario y empresa. | `tables/11-create-table-user-company.sql` |
| `Profile` | Seguridad | Perfil o rol definido dentro de una empresa. | `tables/08-create-table-profile.sql` |
| `Permission` | Seguridad | Catalogo de permisos funcionales usados por la app. | `tables/09-create-table-permission.sql` |
| `ProfilePermission` | Seguridad | Permisos asignados a perfiles. | `tables/10-create-table-profile-permission.sql` |
| `UserCompanyProfile` | Seguridad | Perfil asignado a un usuario dentro de una empresa. | `tables/12-create-table-user-company-profile.sql` |

## Scripts Complementarios

| Script | Tipo | Uso |
| --- | --- | --- |
| `seeds/00-seed-base-catalogs.sql` | Seed obligatorio | Crea `EntityStatus`, `IdentificationType` y `PersonType` base. |
| `procedures/catalogs/P_Catalog_Lookup.sql` | Consulta catalogos | Expone `STATUS`, `IDENTIFICATION` y `PERSON_TYPE` para selects. |
| `seeds/01-seed-base-permissions.sql` | Seed obligatorio | Crea permisos base para administracion inicial. |
| `seeds/99-insert-mock-data.sql` | Seed de pruebas | Crea datos mock y asigna todos los permisos base al perfil `ADMIN`. |
| `tables/indexes/02-recommended-indexes.sql` | Optimizacion recomendada | Crea indices para login, selector de empresa y permisos efectivos. |
| `docs/db/entities/app-user/01-unique-username-filtered.sql` | Constraint opcional | Hace `Username` unico cuando no es null. Ejecutar solo si la app permitira login/busqueda por username. |

## Integraciones Backend

| Integracion | Endpoint sugerido | Documento |
| --- | --- | --- |
| Registro inicial de empresa | `POST /api/auth/register` | `docs/db/integrations/INTEGRACION_API_AUTH_REGISTER.md` |

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
| `dbo.P_Auth_Register` | Registra persona, usuario, empresa, sucursal, punto de emision, relacion usuario-empresa, perfil `ADMIN` y permisos base en una transaccion. | `procedures/auth/P_Auth_Register.sql` |
| `dbo.P_Catalog_Lookup` | Consulta catalogos comunes para selects de UI con clave funcional estable. | `procedures/catalogs/P_Catalog_Lookup.sql` |

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
| Facturacion | `Customer`, `Invoice`, `InvoiceDetail`, `Payment`, `Tax`, `ElectronicDocumentStatus` |

Antes de generar APIs REST de inventario o facturacion, primero se debe crear y aprobar el DDL de estas tablas y sus stored procedures.

## Archivos Conservados

- `docs/db/02-conventions.md`: convenciones generales de diseno.
- `docs/db/03-new-database-working-document.md`: bitacora de decisiones.
- `docs/db/04-erp-app-generation-context.md`: contexto amplio para generar la app.
- `docs/db/entities/**`: documentos y scripts vigentes por entidad.
- `docs/db/stored-procedures/**`: procedimientos almacenados separados de las entidades.
- `docs/db/integrations/**`: contratos de integracion para backend/frontend.
