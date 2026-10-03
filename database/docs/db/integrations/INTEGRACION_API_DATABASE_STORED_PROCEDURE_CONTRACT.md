# Contrato global de respuesta de Stored Procedures

## Alcance

Este contrato aplica a todos los procedimientos almacenados de `database/procedures`. Las funciones escalares y tabulares quedan excluidas porque no devuelven resultsets de estado.

## Resultsets

Todo SP devuelve primero un resultset de exactamente una fila con:

| Columna | Tipo | Regla |
| --- | --- | --- |
| `result_code` | `int` | `0` indica exito; otro valor indica rechazo funcional. |
| `result_message` | `nvarchar` | Mensaje descriptivo para diagnostico; no es una clave de control. |
| `operation` | `nvarchar` | Obligatoria para comandos; identifica la operacion realizada o `NOOP`. No aplica a consultas. |

Los SP que manejan correlacion pueden incluir `correlation_id` en el resultset de estado. El estado siempre precede los datos. Si el SP devuelve recursos, cada conjunto se entrega en resultsets posteriores, en el orden y con las columnas descritos por su contrato de integracion. Un rechazo funcional devuelve solo el resultset de estado. Una consulta exitosa sin coincidencias devuelve el estado exitoso seguido del resultset de datos con cero filas y el esquema normal.

Las operaciones definidas como comandos idempotentes de estado deseado, cuando ya alcanzaron ese estado, son exitosas e identifican `operation = 'NOOP'`. Una creacion duplicada que no represente una repeticion identificada por clave de idempotencia es un conflicto funcional, no un NOOP.

## Catalogo de codigos funcionales

Los codigos son internos a la base de datos y no son codigos HTTP. Cada codigo representa una condicion estable; los consumidores no deben interpretar `result_message`.

| Codigo | Condicion |
| --- | --- |
| `0` | Operacion o consulta exitosa. |
| `1001` | Entrada requerida ausente o entrada con formato/valor invalido. |
| `1002` | Clave o valor funcional no soportado. |
| `2001` | Recurso no encontrado. |
| `2002` | Recurso encontrado pero inactivo/no disponible para la operacion. |
| `3001` | Autorizacion denegada o acceso fuera del tenant. |
| `4001` | Recurso duplicado o conflicto de unicidad. |
| `4002` | Regla de negocio impide la operacion. |
| `4003` | Referencia relacionada invalida o inconsistente. |

Al agregar una condicion no cubierta, se debe asignar un nuevo codigo en este catalogo; no reutilizar codigos HTTP ni un codigo existente con semantica diferente.

## Errores tecnicos

Errores SQL inesperados no son resultados funcionales. Los SP deben revertir las transacciones que iniciaron y propagar el error con `THROW`. No devolver `ERROR_MESSAGE()` en `result_message`. La API registra el detalle interno de forma segura y responde con su error tecnico sanitizado.

## Consumo desde la API

1. Leer el primer resultset y exigir exactamente una fila.
2. Evaluar `result_code`; no analizar el texto de `result_message`.
3. En comandos, leer `operation` y tratar `NOOP` como exito idempotente.
4. Si `result_code` no es cero, no esperar resultsets de datos.
5. Si `result_code` es cero y el contrato del SP define datos, leer los resultsets restantes en el orden documentado.
6. Tratar excepciones SQL propagadas como errores tecnicos; no exponer mensajes internos de SQL Server.

## Mapeo HTTP

La API traduce los codigos funcionales a su contrato HTTP. No se debe reutilizar directamente un codigo SQL como status HTTP ni inferir el caso por el mensaje libre.

## Resultsets de datos por procedimiento

En todos los casos, RS1 es el estado descrito arriba. Los resultsets de datos siguientes aparecen solo cuando el estado es exitoso; las consultas sin coincidencias conservan su esquema con cero filas. Los nombres de columna se indican tal como los devuelve SQL Server.

### Autenticacion y usuarios

| Procedimiento | Resultsets posteriores a RS1 |
| --- | --- |
| `P_Auth_Login` | RS2: `UserExists`, `UserId`, `PasswordHash` (si no hay coincidencia, devuelve una fila con `UserExists = 0`). |
| `P_Auth_Register` | RS2: `PersonId`, `UserId`, `CompanyId`, `CompanyBranchId`, `CompanyEmissionPointId`, `ProfileId`. |
| `P_Auth_GetSessionContext` | RS2 usuario: `UserId`, `PersonId`, `Email`, `Username`, `IsBlocked`, `RequiresNewPassword`, `MustUpdate`, `Status`, `PersonType`, `IdentificationType`, `Identification`, `FirstName`, `MiddleName`, `LastName`, `BusinessName`, `Phone`, `PersonEmail`, `LegalName`, `TradeName`, `IdentificationTypeCode`; RS3 empresa: `CompanyId`, `Identification`, `BusinessName`, `TradeName`, `Email`, `Currency`, `Timezone`, `LanguageCode`, `Environment`, `Status`; RS4 perfil: `ProfileId`, `CompanyId`, `Name`, `Description`, `Status`; RS5 permisos: `PermissionId`, `Code`, `Name`, `Description`, `ModuleCode`. |
| `P_User_Create` | RS2: `UserId`, `PersonId`, `CompanyId`, `ProfileId`, `Username`, `Email`, `IsBlocked`, `RequiresNewPassword`, `MustUpdate`, `Status`, `CreatedBy`, `CreatedAt`, `UpdatedBy`, `UpdatedAt`. |
| `P_User_Update`, `P_User_SetStatus` | RS2: `UserId`, `PersonId`, `Username`, `Email`, `IsBlocked`, `RequiresNewPassword`, `MustUpdate`, `Status`, `CreatedBy`, `CreatedAt`, `UpdatedBy`, `UpdatedAt`. |
| `P_User_List` | RS2: `UserId`, `PersonId`, `CompanyId`, `Username`, `Email`, `IsBlocked`, `RequiresNewPassword`, `MustUpdate`, `Status`, `CreatedAt`, `UpdatedAt`, `IdentificationType`, `Identification`, `FirstName`, `LastName`, `MiddleName`, `Phone`, `lastName`, `middleName`, `firstName`, `identification`, `phone`, `PersonKind`, `LegalName`, `TradeName`, `IdentificationTypeCode`. Las asignaciones activas se consultan por `P_UserProfile_ListByUser`; no hay perfil escalar en el usuario. Las variantes de mayusculas/minusculas se mantienen como aliases independientes del resultado actual. |

### Perfiles y catalogos

| Procedimiento | Resultsets posteriores a RS1 |
| --- | --- |
| `P_Catalog_Lookup` | RS2: `CatalogKey`, `Value`, `Label`, `Description`, `Status`. |
| `P_Permission_List` | RS2: `PermissionId`, `Code`, `Name`, `Description`, `ModuleCode`, `Status`. |
| `P_Profile_ListByCompany` | RS2: `ProfileId`, `CompanyId`, `Name`, `Description`, `Status`, `CreatedBy`, `CreatedAt`, `UpdatedBy`, `UpdatedAt`, `ActivePermissionCount`. |
| `P_Profile_GetDetail` | RS2 perfil: las columnas de perfil de `P_Profile_ListByCompany`; RS3 permisos: `PermissionId`, `Code`, `Name`, `Description`, `ModuleCode`. |
| `P_Profile_Create`, `P_Profile_Update` | RS2: `ProfileId`, `CompanyId`, `Name`, `Description`, `Status`, `CreatedBy`, `CreatedAt`, `UpdatedBy`, `UpdatedAt`, `ActivePermissionCount`. |
| `P_Profile_Deactivate` | RS2: `ProfileId`, `CompanyId`, `Name`, `Description`, `Status`, `CreatedBy`, `CreatedAt`, `UpdatedBy`, `UpdatedAt`. |
| `P_ProfilePermission_ReplaceByProfile` | RS2 perfil: `ProfileId`, `CompanyId`, `Name`, `Description`, `Status`, `ActivePermissionCount`; RS3 permisos: `PermissionId`, `Code`, `Name`, `Description`, `ModuleCode`. |
| `P_UserProfile_Assign` | RS2: `UserId`, `CompanyId`, `ProfileId`, `Status`, `CreatedBy`, `CreatedAt`, `UpdatedBy`, `UpdatedAt`. |
| `P_UserProfile_Revoke` | RS2: las mismas columnas que `P_UserProfile_Assign`; si no existe asignacion, RS2 conserva el esquema y devuelve cero filas. |
| `P_UserProfile_ListByUser` | RS2: `UserId`, `CompanyId`, `ProfileId`, `Name`, `Description`, `Status`, `AssignedAt`. |

### Clientes y personas

| Procedimiento | Resultsets posteriores a RS1 |
| --- | --- |
| `P_Person_ResolveIdentification` | RS2: `PersonId`, `PersonKind`, `LegalName`, `TradeName`, `PersonIdentificationId`, `IdentificationTypeCode`, `Identification`, `IsBillingAllowed`. |
| `P_Client_Create` | RS2: `client_id`, `person_id`, `default_billing_identification_id`. |
| `P_Client_Update`, `P_Client_Deactivate` | RS2: `client_id`. |

Los SP de comandos incluyen `operation` en RS1 tanto para exitos como para rechazos funcionales (`NULL` en estos ultimos). Los SP de consulta no incluyen esa columna. El `correlation_id` se conserva en los resultsets de estado de los SP de registro de clientes/personas que lo reciben o generan.
