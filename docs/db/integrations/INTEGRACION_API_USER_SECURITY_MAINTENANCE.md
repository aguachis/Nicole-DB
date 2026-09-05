# Integracion API - Mantenimiento de Usuarios y Asignacion de Perfiles

## Objetivo

Definir el contrato de integracion entre API y base de datos para mantenimiento de usuarios y asignacion/revocacion de perfiles por empresa.

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

- `docs/db/02-conventions.md`
- `docs/db/stored-procedures/auth.md`
- `docs/db/stored-procedures/profile.md`
- `docs/db/integrations/INTEGRACION_API_AUTH_REGISTER.md`
- `docs/db/integrations/INTEGRACION_API_PROFILES.md`
- `docs/db/integrations/INTEGRACION_API_CATALOG_LOOKUPS.md`

## Stored Procedures

### Dominio Usuario

- `dbo.P_User_Create`
- `dbo.P_User_Update`
- `dbo.P_User_SetStatus`
- `dbo.P_User_List`

Scripts:

- `procedures/auth/P_User_Create.sql`
- `procedures/auth/P_User_Update.sql`
- `procedures/auth/P_User_SetStatus.sql`
- `procedures/auth/P_User_List.sql`

### Dominio Asignacion de Perfiles

- `dbo.P_UserCompanyProfile_Assign`
- `dbo.P_UserCompanyProfile_Revoke`

Scripts:

- `procedures/profile/P_UserCompanyProfile_Assign.sql`
- `procedures/profile/P_UserCompanyProfile_Revoke.sql`

## Contrato estandar de respuesta

Todos los SP de este alcance devuelven al menos:

- `result_code` (`int`)
- `result_message` (`nvarchar`)

Cuando aplica, en el mismo resultset se incluyen columnas del recurso impactado (`UserId`, `ProfileId`, `Status`, `CreatedAt`, `UpdatedAt`, etc.).

### Catalogo de codigos funcionales

- `0`: exito (incluye no-op idempotente)
- `1001`: validacion de parametros (requeridos o formato)
- `2001`: usuario no encontrado
- `2002`: usuario inactivo para la operacion
- `2003`: username duplicado
- `2004`: persona no encontrada o inactiva
- `2005`: email duplicado
- `2101`: usuario sin pertenencia activa a la empresa
- `2102`: perfil no encontrado o inactivo para la empresa
- `-5000`: error tecnico no controlado

## Endpoints sugeridos

- `POST /api/users`
- `PATCH /api/users/{userId}`
- `PATCH /api/users/{userId}/status`
- `GET /api/users?companyId={companyId}&status={status}&search={search}`
- `POST /api/users/{userId}/profiles`
- `DELETE /api/users/{userId}/profiles/{profileId}?companyId={companyId}`

## Mapeo API -> Stored Procedure

### Crear usuario

`POST /api/users`

```sql
EXEC dbo.P_User_Create
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

Campos esperados adicionales en respuesta de listado:
- `LastName`
- `MiddleName`
- `FirstName`
- `Identification`
- `Phone`

### Asignar perfil a usuario

`POST /api/users/{userId}/profiles`

```sql
EXEC dbo.P_UserCompanyProfile_Assign
    @CompanyId = @CompanyId,
    @UserId = @UserId,
    @ProfileId = @ProfileId,
    @Actor = @Actor;
```

### Revocar perfil a usuario

`DELETE /api/users/{userId}/profiles/{profileId}`

```sql
EXEC dbo.P_UserCompanyProfile_Revoke
    @CompanyId = @CompanyId,
    @UserId = @UserId,
    @ProfileId = @ProfileId,
    @Actor = @Actor;
```

## Ejemplo C# (service)

```csharp
public sealed class UserSecurityService
{
    public async Task<UserCreateResponse> CreateUserAsync(CreateUserRequest request, CancellationToken ct)
    {
        // 1) Validar payload y reglas de formato.
        // 2) Hashear password en backend.
        // 3) Ejecutar SP y mapear resultset.
        // 4) Traducir result_code a contrato HTTP.
        throw new NotImplementedException();
    }
}
```

## DTO sugerido - Crear usuario con autocreacion de persona

```csharp
public sealed class CreateUserRequest
{
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

export async function assignProfileToUser(payload: {
  companyId: string;
  userId: string;
  profileId: string;
}) {
  const response = await fetch(`/api/users/${payload.userId}/profiles`, {
    method: "POST",
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
| `0` | `200/201` | N/A | Operacion exitosa o idempotente sin error. |
| `1001` | `400` | `VALIDATION_REQUIRED_FIELD` | Faltan parametros o valores invalidos. |
| `2001` | `404` | `USER_NOT_FOUND` | Usuario no existe. |
| `2002` | `409` | `USER_INACTIVE` | Usuario en estado incompatible. |
| `2003` | `409` | `USER_USERNAME_ALREADY_EXISTS` | Username duplicado. |
| `2004` | `404/409` | `PERSON_NOT_FOUND_OR_INACTIVE` | Persona no existe o esta inactiva segun el contexto de validacion. |
| `2005` | `409` | `USER_EMAIL_ALREADY_EXISTS` | Email duplicado. |
| `2101` | `409` | `USER_NOT_IN_COMPANY` | Usuario sin relacion activa con empresa. |
| `2102` | `404` | `PROFILE_NOT_FOUND` | Perfil invalido o inactivo para empresa. |
| `-5000` | `500` | `INTERNAL_SERVER_ERROR` | Error inesperado de base de datos. |

## Validaciones backend recomendadas

- No exponer mensajes internos de SQL en errores al frontend.
- Trazar logs con `result_code` y `result_message` para auditoria tecnica.
- Tratar `result_code = 0` con mensaje de no-op como operacion exitosa idempotente.
- Sanitizar y normalizar entradas (`trim`, lower para email, longitudes maximas).
- Nunca enviar ni loggear contrasena en texto plano.

## Checklist rapido de implementacion API

- Crear DTOs de request/response por endpoint.
- Agregar capa de acceso SQL para cada SP.
- Implementar traductor `result_code -> error.code/http`.
- Cubrir pruebas de integracion para casos: exito, duplicidad, no encontrado, conflicto y error tecnico.
