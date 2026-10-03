# Integracion API - Mantenimiento de Usuarios y Asignacion de Perfiles

## Objetivo

Definir el contrato de integracion entre API y base de datos para mantenimiento de usuarios y asignacion de multiples perfiles en la empresa tenant unica.

Este documento complementa la integracion de auth y perfiles existente, y estandariza respuestas de SP con `result_code` y `result_message`.

## Correcciones funcionales solicitadas

1. La consulta de usuarios debe incluir datos personales adicionales en el dataset:
- `lastName`
- `middleName`
- `firstName`
- `identification`
- `phone`

2. La creacion de usuario debe permitir aprovisionar persona en el mismo flujo:
- Si la persona ya existe por identificacion, reutilizar `PersonId`.
- Si no existe, crear la persona automaticamente antes de crear el usuario.

## Referencias

- `database/docs/db/02-conventions.md`
- `database/docs/db/stored-procedures/auth.md`
- `database/docs/db/stored-procedures/profile.md`
- `database/docs/db/integrations/INTEGRACION_API_AUTH_REGISTER.md`
- `database/docs/db/integrations/INTEGRACION_API_PROFILES.md`
- `database/docs/db/integrations/INTEGRACION_API_CATALOG_LOOKUPS.md`

## Stored Procedures

### Dominio Usuario

- `dbo.P_User_Create`
- `dbo.P_User_Update`
- `dbo.P_User_SetStatus`
- `dbo.P_User_List`

Scripts:

- `database/procedures/auth/P_User_Create.sql`
- `database/procedures/auth/P_User_Update.sql`
- `database/procedures/auth/P_User_SetStatus.sql`
- `database/procedures/auth/P_User_List.sql`

### Dominio Asignacion de Perfiles

- `dbo.P_UserProfile_Assign`

Scripts:

- `database/procedures/profile/P_UserProfile_Assign.sql`

## Contrato estandar de respuesta

Todos los SP devuelven primero una fila de estado. Los datos de negocio se leen en resultsets posteriores. Para la estructura completa, errores tecnicos y catalogo global de codigos, consultar `INTEGRACION_API_DATABASE_STORED_PROCEDURE_CONTRACT.md`.

### Catalogo de codigos funcionales

Los codigos funcionales anteriores de este documento quedan reemplazados por el catalogo global. Los errores tecnicos se propagan como excepciones SQL con `THROW`, no como `result_code`.

### Lectura de resultsets SQL

El backend debe leer RS1 y validar `result_code` antes de intentar mapear datos. Si el comando falla funcionalmente, solo existe RS1; si tiene exito, los datos estan en los resultsets posteriores. Los esquemas completos se documentan en `INTEGRACION_API_DATABASE_STORED_PROCEDURE_CONTRACT.md`.

| Procedimiento | Respuesta exitosa |
| --- | --- |
| `P_User_Create` | RS1 con `operation = 'CREATE'`; RS2 con el usuario creado. |
| `P_User_Update` | RS1 con `operation = 'UPDATE'` o `NOOP`; RS2 con el usuario actualizado. |
| `P_User_SetStatus` | RS1 con `operation = 'SET_STATUS'` o `NOOP`; RS2 con el usuario actualizado. |
| `P_User_List` | RS1 de consulta; RS2 con usuarios filtrados, incluso vacio si no hay coincidencias. |
| `P_UserProfile_Assign` | RS1 con estado y operacion; RS2 con la asignacion/usuario resultante. |

## Endpoints sugeridos

- `POST /api/users`
- `PATCH /api/users/{userId}`
- `PATCH /api/users/{userId}/status`
- `GET /api/users?companyId={companyId}&status={status}&search={search}`
- `GET /api/users/{userId}/profiles`
- `POST /api/users/{userId}/profiles`
- `DELETE /api/users/{userId}/profiles/{profileId}`

## Mapeo API -> Stored Procedure

### Crear usuario

`POST /api/users`

```sql
EXEC dbo.P_User_Create
  @CompanyId = @CompanyId,
  @ProfileId = @ProfileId,
  @PersonId = @PersonId, -- opcional cuando se envia bloque de persona
  @PersonIdentificationType = @PersonIdentificationType,
  @PersonIdentification = @PersonIdentification,
  @PersonFirstName = @PersonFirstName,
  @PersonMiddleName = @PersonMiddleName,
  @PersonLastName = @PersonLastName,
  @PersonPhone = @PersonPhone,
    @Email = @Email,
    @PasswordHash = @PasswordHash,
    @Username = @Username,
    @CreatedBy = @CreatedBy;
```

Notas para backend:
- `@CompanyId` y `@ProfileId` son obligatorios; el perfil debe pertenecer a esa empresa.
- Obtener `@CompanyId` del contexto autenticado del actor, no confiar en un valor de tenant enviado por el cliente.
- `@PersonId` puede ser `NULL` si se envia identificacion de persona.
- `@PersonIdentificationType` y `@PersonIdentification` son requeridos cuando `@PersonId` no se envia.
- Si no existe persona por identificacion, `@PersonFirstName` y `@PersonLastName` pasan a ser requeridos para crearla.
- `@PersonMiddleName` y `@PersonPhone` son opcionales.

### Actualizar usuario

`PATCH /api/users/{userId}`

```sql
EXEC dbo.P_User_Update
    @UserId = @UserId,
    @Email = @Email,
    @Username = @Username,
    @IsBlocked = @IsBlocked,
    @RequiresNewPassword = @RequiresNewPassword,
    @MustUpdate = @MustUpdate,
    @UpdatedBy = @UpdatedBy;
```

### Cambiar estado del usuario

`PATCH /api/users/{userId}/status`

```sql
EXEC dbo.P_User_SetStatus
    @UserId = @UserId,
    @Status = @Status,
    @UpdatedBy = @UpdatedBy;
```

### Consultar usuarios

`GET /api/users`

```sql
EXEC dbo.P_User_List
    @CompanyId = @CompanyId,
    @Status = @Status,
    @Search = @Search;
```

`companyId` debe derivarse del tenant del usuario autenticado; no permitir consultas globales.

Campos esperados adicionales en respuesta de listado:
- `LastName`
- `MiddleName`
- `FirstName`
- `Identification`
- `Phone`

### Asignar perfil a usuario

`PATCH /api/users/{userId}/profile`

```sql
EXEC dbo.P_UserProfile_Assign
    @CompanyId = @CompanyId,
    @UserId = @UserId,
    @ProfileId = @ProfileId,
    @Actor = @Actor;
```

La asignacion agrega un perfil sin reemplazar las asignaciones activas existentes. Repetir la asignacion de un perfil activo devuelve `NOOP`; una asignacion revocada se reactiva sin duplicar la relacion. Cada alta, reactivacion o revocacion efectiva registra un evento atomico en `UserProfileAudit`.

### Consultar perfiles asignados al usuario

`GET /api/users/{userId}/profiles`

```sql
EXEC dbo.P_UserProfile_ListByUser
    @UserId = @UserId;
```

Invocar despues de validar las credenciales en el backend. El SP deriva la unica empresa desde el usuario. RS1 es el estado de consulta; RS2 contiene solo asignaciones activas de perfiles activos de esa empresa: `UserId`, `CompanyId`, `ProfileId`, `Name`, `Description`, `Status`, `AssignedAt`.

### Revocar perfil de usuario

`DELETE /api/users/{userId}/profiles/{profileId}`

```sql
EXEC dbo.P_UserProfile_Revoke
    @CompanyId = @CompanyId,
    @UserId = @UserId,
    @ProfileId = @ProfileId,
    @Actor = @Actor;
```

La operacion es idempotente (`NOOP` si la asignacion ya no existe o esta inactiva). El SP rechaza la revocacion del ultimo perfil activo de un usuario activo con el codigo de regla de negocio `4002`.

## Ejemplo C# (service)

```csharp
public sealed class UserSecurityService
{
    public async Task<UserCreateResponse> CreateUserAsync(CreateUserRequest request, CancellationToken ct)
    {
        // 1) Validar payload y reglas de formato.
        // 2) Hashear password en backend.
        // 3) Validar RS1 y mapear los resultsets de datos posteriores.
        // 4) Traducir result_code a contrato HTTP.
        throw new NotImplementedException();
    }
}
```

## DTO sugerido - Crear usuario con autocreacion de persona

```csharp
public sealed class CreateUserRequest
{
  public Guid CompanyId { get; set; }
  public Guid ProfileId { get; set; }
  public Guid? PersonId { get; set; }
  public string? PersonIdentificationType { get; set; }
  public string? PersonIdentification { get; set; }
  public string? PersonFirstName { get; set; }
  public string? PersonMiddleName { get; set; }
  public string? PersonLastName { get; set; }
  public string? PersonPhone { get; set; }
  public string Email { get; set; } = string.Empty;
  public string Password { get; set; } = string.Empty;
  public string? Username { get; set; }
}
```

Regla de validacion sugerida:
- Si `PersonId` es `null`, exigir datos minimos de persona para aprovisionamiento.

## DTO sugerido - Resumen de usuario en listado

```csharp
public sealed class UserListItemResponse
{
  public Guid UserId { get; set; }
  public Guid PersonId { get; set; }
  public Guid CompanyId { get; set; }
  public string? Username { get; set; }
  public string Email { get; set; } = string.Empty;
  public string Status { get; set; } = string.Empty;
  public string? LastName { get; set; }
  public string? MiddleName { get; set; }
  public string? FirstName { get; set; }
  public string? Identification { get; set; }
  public string? Phone { get; set; }
}
```

## Ejemplo TypeScript (cliente interno)

```ts
export interface SpResultBase {
  result_code: number;
  result_message: string;
}

export async function setUserProfile(payload: {
  companyId: string;
  userId: string;
  profileId: string;
}) {
  const response = await fetch(`/api/users/${payload.userId}/profile`, {
    method: "PATCH",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload)
  });

  if (!response.ok) {
    const errorBody = await response.json();
    throw new Error(errorBody.error?.userMessage ?? "No se pudo asignar perfil");
  }

  return await response.json();
}
```

## Mapeo sugerido de result_code a HTTP

| result_code | HTTP | error.code sugerido | Caso |
| --- | --- | --- | --- |
| `0` | `200/201` | N/A | Operacion exitosa; `operation = 'NOOP'` representa exito idempotente cuando aplica. |
| `1001` | `400` | `VALIDATION_INVALID_INPUT` | Entrada requerida ausente o invalida. |
| `2001` | `404` | `RESOURCE_NOT_FOUND` | Recurso no encontrado. |
| `2002` | `404/409` | `RESOURCE_UNAVAILABLE` | Recurso inactivo o no disponible para la operacion. |
| `3001` | `403` | `AUTHORIZATION_DENIED` | Autorizacion denegada o acceso fuera del tenant. |
| `4001` | `409` | `RESOURCE_CONFLICT` | Recurso duplicado o conflicto de unicidad. |
| `4002` | `409` | `BUSINESS_RULE_VIOLATION` | Regla de negocio impide la operacion. |
| `4003` | `400/409` | `INVALID_REFERENCE` | Referencia relacionada invalida o inconsistente. |
| Excepcion SQL | `500` | `INTERNAL_SERVER_ERROR` | Error tecnico inesperado propagado por el SP. |

## Validaciones backend recomendadas

- No exponer mensajes internos de SQL en errores al frontend.
- Leer y validar primero el estado; despues mapear cada resultset de datos en el orden documentado.
- Trazar el codigo y el identificador de correlacion cuando exista; `result_message` es diagnostico, no una clave de control.
- Tratar `result_code = 0` y `operation = 'NOOP'` como operacion exitosa idempotente.
- Sanitizar y normalizar entradas (`trim`, lower para email, longitudes maximas).
- Nunca enviar ni loggear contrasena en texto plano.

## Checklist rapido de implementacion API

- Crear DTOs de request/response por endpoint.
- Agregar capa de acceso SQL para cada SP.
- Implementar traductor `result_code -> error.code/http`.
- Cubrir pruebas de integracion para casos: exito, duplicidad, no encontrado, conflicto y error tecnico.
