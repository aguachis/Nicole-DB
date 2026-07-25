# Integracion API - Me

## Endpoint

`GET /api/auth/me?userId={userId}`

## Proposito

Obtener el contexto de sesion del usuario autenticado usando su `userId`:

- datos de usuario
- empresa a la que pertenece
- perfil asignado
- permisos efectivos

La consulta se resuelve con `dbo.P_Auth_GetSessionContext`.

## Stored Procedure

Script: `docs/db/stored-procedures/auth/P_Auth_GetSessionContext.sql`

SP: `dbo.P_Auth_GetSessionContext`

## Regla de negocio aplicada

- un usuario debe tener una sola empresa activa
- un usuario debe tener un solo perfil activo para su empresa activa

Si la data no cumple esa cardinalidad, el SP devuelve error controlado.

## Clases C# Sugeridas

### Query

```csharp
public sealed class AuthMeQuery
{
    public Guid UserId { get; set; }
}
```

### Result Set 1 - Usuario

```csharp
public sealed class AuthMeUserSpResult
{
    public Guid UserId { get; set; }
    public Guid PersonId { get; set; }
    public string Email { get; set; } = string.Empty;
    public string? Username { get; set; }
    public bool IsBlocked { get; set; }
    public bool RequiresNewPassword { get; set; }
    public bool MustUpdate { get; set; }
    public string Status { get; set; } = string.Empty;
    public string PersonType { get; set; } = string.Empty;
    public string IdentificationType { get; set; } = string.Empty;
    public string Identification { get; set; } = string.Empty;
    public string? FirstName { get; set; }
    public string? MiddleName { get; set; }
    public string? LastName { get; set; }
    public string? BusinessName { get; set; }
    public string? Phone { get; set; }
    public string? PersonEmail { get; set; }
}
```

### Result Set 2 - Empresa

```csharp
public sealed class AuthMeCompanySpResult
{
    public Guid CompanyId { get; set; }
    public string Identification { get; set; } = string.Empty;
    public string BusinessName { get; set; } = string.Empty;
    public string? TradeName { get; set; }
    public string? Email { get; set; }
    public string? Currency { get; set; }
    public string? Timezone { get; set; }
    public string? LanguageCode { get; set; }
    public string? Environment { get; set; }
    public string Status { get; set; } = string.Empty;
}
```

### Result Set 3 - Perfil

```csharp
public sealed class AuthMeProfileSpResult
{
    public Guid ProfileId { get; set; }
    public Guid CompanyId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string Status { get; set; } = string.Empty;
}
```

### Result Set 4 - Permisos

```csharp
public sealed class AuthMePermissionSpResult
{
    public Guid PermissionId { get; set; }
    public string Code { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string ModuleCode { get; set; } = string.Empty;
}
```

### Response

```csharp
public sealed class AuthMeResponse
{
    public AuthMeUser User { get; set; } = new();
    public AuthMeCompany Company { get; set; } = new();
    public AuthMeProfile Profile { get; set; } = new();
    public List<AuthMePermission> Permissions { get; set; } = new();
}

public sealed class AuthMeUser
{
    public Guid UserId { get; set; }
    public Guid PersonId { get; set; }
    public string Email { get; set; } = string.Empty;
    public string? Username { get; set; }
    public string? FullName { get; set; }
    public string? Identification { get; set; }
}

public sealed class AuthMeCompany
{
    public Guid CompanyId { get; set; }
    public string BusinessName { get; set; } = string.Empty;
    public string? Identification { get; set; }
}

public sealed class AuthMeProfile
{
    public Guid ProfileId { get; set; }
    public string Name { get; set; } = string.Empty;
}

public sealed class AuthMePermission
{
    public string Code { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string ModuleCode { get; set; } = string.Empty;
}
```

### Error Response

```csharp
public sealed class ApiErrorResponse
{
    public ApiError Error { get; set; } = new();
}

public sealed class ApiError
{
    public string Code { get; set; } = string.Empty;
    public string Message { get; set; } = string.Empty;
    public string UserMessage { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public bool ShowToUser { get; set; }
    public bool Retryable { get; set; }
}
```

## Ejecucion SQL

```sql
EXEC dbo.P_Auth_GetSessionContext
    @UserId = @UserId;
```

## Mapeo de Result Sets

- RS1 -> `AuthMeUserSpResult`
- RS2 -> `AuthMeCompanySpResult`
- RS3 -> `AuthMeProfileSpResult`
- RS4 -> `List<AuthMePermissionSpResult>`

## Respuesta Exitosa

HTTP `200 OK`

```json
{
  "user": {
    "userId": "22222222-2222-2222-2222-222222222222",
    "personId": "11111111-1111-1111-1111-111111111111",
    "email": "admin@empresa.com",
    "username": "admin",
    "fullName": "Nicole Admin",
    "identification": "0123456789"
  },
  "company": {
    "companyId": "33333333-3333-3333-3333-333333333333",
    "businessName": "Empresa Demo S.A.",
    "identification": "1790012345001"
  },
  "profile": {
    "profileId": "77777777-7777-7777-7777-777777777777",
    "name": "ADMIN"
  },
  "permissions": [
    {
      "code": "profile.read",
      "name": "Consultar perfiles",
      "moduleCode": "profile"
    },
    {
      "code": "profile.update",
      "name": "Actualizar perfiles",
      "moduleCode": "profile"
    }
  ]
}
```

## Errores Esperados

### Parametro requerido

HTTP `400 Bad Request`

```json
{
  "error": {
    "code": "VALIDATION_REQUIRED_FIELD",
    "message": "UserId is required.",
    "userMessage": "No se encontro el identificador del usuario.",
    "category": "validation",
    "showToUser": true,
    "retryable": false
  }
}
```

### Usuario no valido

HTTP `404 Not Found`

```json
{
  "error": {
    "code": "AUTH_USER_NOT_FOUND",
    "message": "User not found or inactive.",
    "userMessage": "No se pudo obtener la sesion del usuario.",
    "category": "authentication",
    "showToUser": true,
    "retryable": false
  }
}
```

### Contexto inconsistente

HTTP `409 Conflict`

```json
{
  "error": {
    "code": "AUTH_SESSION_CONTEXT_CONFLICT",
    "message": "User has more than one active company.",
    "userMessage": "La sesion del usuario tiene datos inconsistentes.",
    "category": "business",
    "showToUser": true,
    "retryable": false
  }
}
```

## Tabla de Estados

| HTTP | `error.code` | Caso |
| --- | --- | --- |
| `200` | N/A | Contexto de sesion obtenido correctamente. |
| `400` | `VALIDATION_REQUIRED_FIELD` | `userId` no informado o invalido. |
| `404` | `AUTH_USER_NOT_FOUND` | Usuario no existe o esta inactivo. |
| `409` | `AUTH_SESSION_CONTEXT_CONFLICT` | Usuario con 0 o multiples empresas/perfiles activos. |
| `500` | `INTERNAL_SERVER_ERROR` | Error inesperado. |
