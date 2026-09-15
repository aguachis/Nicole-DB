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

- `database/tables/07-create-table-app-user.sql`
- `database/tables/08-create-table-profile.sql`
- `database/tables/09-create-table-permission.sql`
- `database/tables/10-create-table-profile-permission.sql`
- `database/tables/11-create-table-user-company.sql`
- `database/tables/12-create-table-user-company-profile.sql`

## Comentario de diseno

Este modelo reemplaza la idea de un `UserProfile` global.

Con este enfoque, un mismo usuario puede tener distintos roles segun la empresa en la que trabaje.
