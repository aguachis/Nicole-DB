# Stored Procedure - Auth

## Estado

Definicion inicial para base nueva.

## Procedimientos principales

- `docs/db/stored-procedures/auth/P_Auth_Register.sql`
- `docs/db/stored-procedures/auth/P_Auth_Login.sql`

## Objetivos

Permitir el registro inicial de usuario y empresa en una sola transaccion.
Consultar por email el `UserId` y `PasswordHash` necesarios para que el backend valide el login.

## Flujo

- crea o reutiliza `Person`
- crea `AppUser`
- crea `Company`
- crea `CompanyBranch`
- crea `CompanyEmissionPoint`
- crea `UserCompany`
- crea perfil `ADMIN` para esa empresa si no existe
- crea permisos base si no existen
- asigna permisos base al perfil `ADMIN`
- asigna el perfil al usuario dentro de la empresa

## Regla importante

El rol depende de la empresa, por eso el procedimiento usa `UserCompanyProfile` y no un `UserProfile` global.
