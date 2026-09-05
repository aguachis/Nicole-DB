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

- `tables/07-create-table-app-user.sql`
- `tables/08-create-table-profile.sql`
- `tables/09-create-table-permission.sql`
- `tables/10-create-table-profile-permission.sql`
- `tables/11-create-table-user-company.sql`
- `tables/12-create-table-user-company-profile.sql`

## Comentario de diseno

Este modelo reemplaza la idea de un `UserProfile` global.

Con este enfoque, un mismo usuario puede tener distintos roles segun la empresa en la que trabaje.
