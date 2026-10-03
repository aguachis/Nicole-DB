# Integracion API - Login

## Endpoint

`POST /api/auth/login`

## Proposito

Validar las credenciales de un usuario registrado. El backend recibe `email` y `password`, valida la contrasena contra el hash almacenado y, si las credenciales son validas, consulta los perfiles asignados para que el usuario elija el contexto de acceso.

El SP no recibe la clave plana. El backend no debe exponer si fallo el email, la clave, el estado inactivo o el bloqueo del usuario.

## Stored Procedure

Script: `database/procedures/auth/P_Auth_Login.sql`

SP: `dbo.P_Auth_Login`

## Clases C# Sugeridas

### Request

```csharp
public sealed class LoginRequest
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}
```

### Stored Procedure Parameters

```csharp
public sealed class LoginSpParameters
{
    public string Email { get; set; } = string.Empty;
}
```

### Stored Procedure Result

```csharp
public sealed class LoginSpResult
{
    public bool UserExists { get; set; }
    public Guid? UserId { get; set; }
    public string? PasswordHash { get; set; }
}
```

### Response

```csharp
public sealed class LoginResponse
{
    public Guid UserId { get; set; }
    public List<LoginProfileOption> AvailableProfiles { get; set; } = new();
}

public sealed class LoginProfileOption
{
    public Guid ProfileId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
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

## Payload Esperado

```json
{
  "email": "admin@empresa.com",
  "password": "PasswordPlanoSoloParaElBackend"
}
```

## Validaciones del Backend

Campos obligatorios:

- `email`
- `password`

Reglas:

- `email` debe tener formato de correo valido.
- `password` no debe enviarse al SP.
- El SP devuelve `PasswordHash` solo para uso interno del backend.
- El backend debe validar `request.Password` contra `PasswordHash` con el verificador seguro configurado.
- El backend debe normalizar o permitir que el SP normalice `email` con trim y minusculas.
- El backend no debe registrar ni devolver `password` ni `passwordHash` en logs o respuestas.
- Si el SP devuelve `UserExists = 0`, `UserId = NULL`, `PasswordHash = NULL` o la verificacion de clave falla, el endpoint debe responder `401 Unauthorized`.

## Ejecucion SQL

```sql
EXEC dbo.P_Auth_Login
    @Email = @Email;
```

`dbo.P_Auth_Login` devuelve primero el resultset de estado (`result_code`, `result_message`). Si el estado es exitoso, el siguiente resultset contiene `UserExists`, `UserId` y `PasswordHash`. La ausencia de credenciales coincidentes es un resultado de consulta exitoso con `UserExists = 0`, no un error tecnico del SP.

## Respuesta Exitosa

HTTP `200 OK`

```json
{
  "userId": "22222222-2222-2222-2222-222222222222",
  "availableProfiles": [
    {
      "profileId": "77777777-7777-7777-7777-777777777777",
      "name": "Ventas",
      "description": "Gestion comercial"
    }
  ]
}
```

Al elegir un perfil, el cliente solicita el establecimiento del contexto de sesion con `POST /api/auth/session/profile` y `profileId`. La API deriva `UserId` de las credenciales ya verificadas, invoca `P_Auth_GetSessionContext` con ambos valores y solo emite o actualiza el token despues de validar el perfil y sus permisos.

## Errores Esperados

### Campo requerido

HTTP `400 Bad Request`

```json
{
  "error": {
    "code": "VALIDATION_REQUIRED_FIELD",
    "message": "The field email is required.",
    "userMessage": "Completa los campos obligatorios.",
    "category": "validation",
    "showToUser": true,
    "retryable": false
  }
}
```

### Formato invalido

HTTP `400 Bad Request`

```json
{
  "error": {
    "code": "VALIDATION_INVALID_FORMAT",
    "message": "The field email has an invalid format.",
    "userMessage": "Revisa el formato de los datos ingresados.",
    "category": "validation",
    "showToUser": true,
    "retryable": false
  }
}
```

### Credenciales invalidas

HTTP `401 Unauthorized`

```json
{
  "error": {
    "code": "AUTH_LOGIN_INVALID_CREDENTIALS",
    "message": "Invalid credentials.",
    "userMessage": "El correo o la contrasena no son correctos.",
    "category": "authentication",
    "showToUser": true,
    "retryable": false
  }
}
```

### Error no controlado

HTTP `500 Internal Server Error`

```json
{
  "error": {
    "code": "INTERNAL_SERVER_ERROR",
    "message": "Unexpected error while validating login.",
    "userMessage": "No se pudo iniciar sesion. Intenta nuevamente.",
    "category": "internal",
    "showToUser": true,
    "retryable": true
  }
}
```

## Tabla de Estados

| HTTP | `error.code` | Caso |
| --- | --- | --- |
| `200` | N/A | Login valido. |
| `400` | `VALIDATION_REQUIRED_FIELD` | Falta un campo obligatorio. |
| `400` | `VALIDATION_INVALID_FORMAT` | Formato invalido. |
| `401` | `AUTH_LOGIN_INVALID_CREDENTIALS` | Email inexistente, clave incorrecta, usuario bloqueado o usuario inactivo. |
| `500` | `INTERNAL_SERVER_ERROR` | Error inesperado. |

## Ejemplo Controller

```csharp
[ApiController]
[Route("api/auth")]
public sealed class AuthController : ControllerBase
{
    private readonly IAuthLoginService _loginService;

    public AuthController(IAuthLoginService loginService)
    {
        _loginService = loginService;
    }

    [HttpPost("login")]
    [ProducesResponseType(typeof(LoginResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiErrorResponse), StatusCodes.Status400BadRequest)]
    [ProducesResponseType(typeof(ApiErrorResponse), StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(typeof(ApiErrorResponse), StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> Login(LoginRequest request, CancellationToken cancellationToken)
    {
        LoginResponse response = await _loginService.LoginAsync(request, cancellationToken);
        return Ok(response);
    }
}
```

## Ejemplo Service

```csharp
public interface IAuthLoginService
{
    Task<LoginResponse> LoginAsync(
        LoginRequest request,
        CancellationToken cancellationToken);
}
```

Responsabilidades del service:

- Validar payload.
- Construir parametros del SP solo con `Email`.
- Ejecutar `dbo.P_Auth_Login`.
- Mapear RS1 a `StoredProcedureStatus` y detener el procesamiento si `result_code` no es cero.
- Mapear RS2 a `LoginSpResult`.
- Si `UserExists` es `false`, `UserId` es `null` o `PasswordHash` es `null`, devolver `401` con `AUTH_LOGIN_INVALID_CREDENTIALS`.
- Validar `request.Password` contra `PasswordHash` usando el verificador seguro del backend.
- Si la verificacion falla, devolver `401` con `AUTH_LOGIN_INVALID_CREDENTIALS`.
- Si la verificacion pasa, devolver `UserId` en `LoginResponse`.
- Despues de verificar las credenciales, ejecutar `dbo.P_UserProfile_ListByUser` con el `UserId` encontrado y devolver sus perfiles activos. No consultar perfiles antes de autenticar la contrasena.
- Si no hay perfiles activos, rechazar la creacion de sesion con error de negocio/controlado; no inferir ni combinar permisos.
- No crear el contexto final ni emitir un token con permisos hasta que el usuario elija un `ProfileId` de la lista.
- No exponer si fallo el email, la clave, el bloqueo o el estado del usuario.

## Ejemplo TypeScript

```ts
export interface LoginRequest {
  email: string;
  password: string;
}

export interface LoginResponse {
  userId: string;
}
```

## Consumo Frontend

```ts
const response = await fetch("/api/auth/login", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify(payload)
});

if (!response.ok) {
  const body = await response.json();

  if (body.error?.showToUser) {
    throw new Error(body.error.userMessage);
  }

  throw new Error("No se pudo iniciar sesion.");
}

const data = await response.json() as LoginResponse;
```

## Nota para Frontend

El frontend debe decidir por HTTP status y `error.code`. No debe depender del texto libre de `message` ni de mensajes internos de SQL Server.
