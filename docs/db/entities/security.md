# Revision de Seguridad - Roles y Permisos

## Estado

Definicion inicial para base nueva.

## Regla principal

El rol depende de la empresa.

Por eso el modelo recomendado es:

- `AppUser`: identidad de acceso
- `Company`: empresa a la que accede
- `Profile`: rol definido por empresa
- `Permission`: permiso funcional
- `ProfilePermission`: permisos asignados a cada rol
- `UserCompany`: acceso del usuario a una empresa
- `UserCompanyProfile`: rol del usuario dentro de una empresa

## Scripts base

- `docs/db/entities/app-user/00-create-table-appuser.sql`
- `docs/db/entities/profile/00-create-table-profile.sql`
- `docs/db/entities/permission/00-create-table-permission.sql`
- `docs/db/entities/profile-permission/00-create-table-profile-permission.sql`
- `docs/db/entities/user-company/00-create-table-user-company.sql`
- `docs/db/entities/user-company-profile/00-create-table-user-company-profile.sql`

## Comentario de diseno

Este modelo reemplaza la idea de un `UserProfile` global.

Con este enfoque, un mismo usuario puede tener distintos roles segun la empresa en la que trabaje.
