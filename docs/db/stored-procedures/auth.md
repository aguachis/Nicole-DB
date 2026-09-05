# Stored Procedure - Auth

## Estado

Definicion inicial para base nueva.

## Procedimientos principales

- `procedures/auth/P_Auth_Register.sql`
- `procedures/auth/P_Auth_Login.sql`
- `procedures/auth/P_Auth_GetSessionContext.sql`
- `procedures/auth/P_User_Create.sql`
- `procedures/auth/P_User_Update.sql`
- `procedures/auth/P_User_SetStatus.sql`
- `procedures/auth/P_User_List.sql`

## Objetivos

Permitir el registro inicial de usuario y empresa en una sola transaccion.
Consultar por email el `UserId` y `PasswordHash` necesarios para que el backend valide el login.
Consultar por `UserId` el contexto completo de sesion: usuario, empresa, perfil y permisos.

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

## Plantilla de respuesta estandar

Los SP de mantenimiento de usuario usan una salida uniforme:

- `result_code`: entero funcional (0 = exito, negativo = error tecnico, positivo = validacion/negocio)
- `result_message`: mensaje funcional legible
- `dataset`: columnas de negocio devueltas en el mismo resultset

Codigos funcionales reservados en esta etapa:

- `0`: operacion exitosa o idempotente sin cambios
- `1001`: validacion de parametro obligatorio o valor invalido
- `2001`: usuario no encontrado
- `2002`: usuario inactivo para la operacion solicitada
- `2003`: username duplicado
- `2004`: persona no encontrada o inactiva
- `2005`: email duplicado
- `-5000`: error no controlado

## Matriz minima de validaciones

- `P_User_Create`: valida `Email`, `PasswordHash`, `CreatedBy`, duplicidad de `Email` y `Username`; admite `PersonId` opcional y aprovisiona/reutiliza persona por identificacion
- `P_User_Update`: valida `UserId`, `Email`, `UpdatedBy`, estado activo y duplicidad de `Email`/`Username`
- `P_User_SetStatus`: valida `UserId`, `Status` (`A` o `I`) y `UpdatedBy`; aplica idempotencia
- `P_User_List`: valida `Status` opcional (`A` o `I`) y aplica filtros por empresa y texto
