# Integracion API - Registro Inicial

## Endpoint

`POST /api/auth/register`

## Proposito

Crear el primer acceso de una empresa nueva dentro del sistema. El backend debe recibir los datos del usuario administrador, hashear la contrasena, ejecutar `dbo.P_Auth_Register` y devolver los identificadores creados.

Este endpoint debe usarse para alta inicial de empresa, no para crear usuarios adicionales dentro de una empresa existente.

## Stored Procedure

Script: `docs/db/stored-procedures/auth/P_Auth_Register.sql`

SP: `dbo.P_Auth_Register`

## Referencias complementarias

- `docs/db/integrations/INTEGRACION_API_CATALOG_LOOKUPS.md`

## Clases C# Sugeridas

### Request

```csharp
public sealed class RegisterCompanyRequest
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string PersonIdentificationType { get; set; } = string.Empty;
    public string PersonIdentification { get; set; } = string.Empty;
    public string PersonName { get; set; } = string.Empty;
    public string? PersonLastName { get; set; }
    public string? PersonPhone { get; set; }
    public string CompanyBusinessName { get; set; } = string.Empty;
    public string CompanyIdentification { get; set; } = string.Empty;
    public string? Username { get; set; }
    public string? EstablishmentCode { get; set; }
    public string? EmissionPointCode { get; set; }
}
```

### Stored Procedure Parameters

```csharp
public sealed class RegisterCompanySpParameters
{
    public string Email { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string PersonIdentificationType { get; set; } = string.Empty;
    public string PersonIdentification { get; set; } = string.Empty;
    public string PersonName { get; set; } = string.Empty;
    public string? PersonLastName { get; set; }
    public string? PersonPhone { get; set; }
    public string CompanyBusinessName { get; set; } = string.Empty;
    public string CompanyIdentification { get; set; } = string.Empty;
    public string? Username { get; set; }
    public string? EstablishmentCode { get; set; }
    public string? EmissionPointCode { get; set; }
}
```

### Response

```csharp
public sealed class RegisterCompanyResponse
{
    public Guid PersonId { get; set; }
    public Guid UserId { get; set; }
    public Guid CompanyId { get; set; }
    public Guid CompanyBranchId { get; set; }
    public Guid CompanyEmissionPointId { get; set; }
    public Guid UserCompanyId { get; set; }
    public Guid ProfileId { get; set; }
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
  "password": "PasswordPlanoSoloParaElBackend",
  "personIdentificationType": "05",
  "personIdentification": "0912345678",
  "personName": "Juan Carlos",
  "personLastName": "Perez",
  "personPhone": "0999999999",
  "companyBusinessName": "Empresa Demo S.A.S.",
  "companyIdentification": "1790012345001",
  "username": "admin.demo",
  "establishmentCode": "001",
  "emissionPointCode": "001"
}
```

## Validaciones del Backend

Campos obligatorios:

- `email`
- `password`
- `personIdentificationType`
- `personIdentification`
- `personName`
- `companyBusinessName`
- `companyIdentification`

Reglas:

- `email` debe tener formato de correo valido.
- `password` no debe enviarse al SP; primero debe convertirse en `passwordHash`.
- `personIdentificationType` debe existir en `dbo.IdentificationType`.
- `personIdentification` maximo 20 caracteres.
- `companyIdentification` maximo 20 caracteres.
- `personIdentificationType` debe tener 2 caracteres.
- `establishmentCode` y `emissionPointCode` pueden omitirse; el SP usa `001` si llegan nulos o vacios.
- `username` es opcional. Si se ejecuta `01-unique-username-filtered.sql`, no se deben aceptar usernames duplicados.

## Ejecucion SQL

```sql
EXEC dbo.P_Auth_Register
    @Email = @Email,
    @PasswordHash = @PasswordHash,
    @PersonIdentificationType = @PersonIdentificationType,
    @PersonIdentification = @PersonIdentification,
    @PersonName = @PersonName,
    @PersonLastName = @PersonLastName,
    @PersonPhone = @PersonPhone,
    @CompanyBusinessName = @CompanyBusinessName,
    @CompanyIdentification = @CompanyIdentification,
    @Username = @Username,
    @EstablishmentCode = @EstablishmentCode,
    @EmissionPointCode = @EmissionPointCode;
```

## Respuesta Exitosa

HTTP `201 Created`

```json
{
  "personId": "11111111-1111-1111-1111-111111111111",
  "userId": "22222222-2222-2222-2222-222222222222",
  "companyId": "33333333-3333-3333-3333-333333333333",
  "companyBranchId": "44444444-4444-4444-4444-444444444444",
  "companyEmissionPointId": "55555555-5555-5555-5555-555555555555",
  "userCompanyId": "66666666-6666-6666-6666-666666666666",
  "profileId": "77777777-7777-7777-7777-777777777777"
}
```

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

### Email duplicado

HTTP `409 Conflict`

```json
{
  "error": {
    "code": "AUTH_REGISTER_EMAIL_ALREADY_EXISTS",
    "message": "Email already exists.",
    "userMessage": "Ya existe una cuenta registrada con ese correo.",
    "category": "business",
    "showToUser": true,
    "retryable": false
  }
}
```

### Empresa duplicada

HTTP `409 Conflict`

```json
{
  "error": {
    "code": "AUTH_REGISTER_COMPANY_ALREADY_EXISTS",
    "message": "CompanyIdentification already exists.",
    "userMessage": "Ya existe una empresa registrada con esa identificacion.",
    "category": "business",
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
    "message": "Unexpected error while registering company.",
    "userMessage": "No se pudo completar el registro. Intenta nuevamente.",
    "category": "internal",
    "showToUser": true,
    "retryable": true
  }
}
```

## Tabla de Estados

| HTTP | `error.code` | Caso |
| --- | --- | --- |
| `201` | N/A | Registro creado correctamente. |
| `400` | `VALIDATION_REQUIRED_FIELD` | Falta un campo obligatorio. |
| `400` | `VALIDATION_INVALID_FORMAT` | Formato o longitud invalida. |
| `409` | `AUTH_REGISTER_EMAIL_ALREADY_EXISTS` | El email ya existe en `dbo.AppUser`. |
| `409` | `AUTH_REGISTER_COMPANY_ALREADY_EXISTS` | La identificacion de empresa ya existe en `dbo.Company`. |
| `500` | `INTERNAL_SERVER_ERROR` | Error inesperado. |

## Ejemplo Controller

```csharp
[ApiController]
[Route("api/auth")]
public sealed class AuthController : ControllerBase
{
    private readonly IAuthRegistrationService _registrationService;

    public AuthController(IAuthRegistrationService registrationService)
    {
        _registrationService = registrationService;
    }

    [HttpPost("register")]
    [ProducesResponseType(typeof(RegisterCompanyResponse), StatusCodes.Status201Created)]
    [ProducesResponseType(typeof(ApiErrorResponse), StatusCodes.Status400BadRequest)]
    [ProducesResponseType(typeof(ApiErrorResponse), StatusCodes.Status409Conflict)]
    [ProducesResponseType(typeof(ApiErrorResponse), StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> Register(RegisterCompanyRequest request, CancellationToken cancellationToken)
    {
        RegisterCompanyResponse response = await _registrationService.RegisterCompanyAsync(request, cancellationToken);
        return StatusCode(StatusCodes.Status201Created, response);
    }
}
```

## Ejemplo Service

```csharp
public interface IAuthRegistrationService
{
    Task<RegisterCompanyResponse> RegisterCompanyAsync(
        RegisterCompanyRequest request,
        CancellationToken cancellationToken);
}
```

Responsabilidades del service:

- Validar payload.
- Hashear `request.Password`.
- Construir parametros del SP con `PasswordHash`.
- Ejecutar `dbo.P_Auth_Register`.
- Mapear el primer resultset a `RegisterCompanyResponse`.
- Traducir errores conocidos del SP a `error.code` estable.

## Ejemplo TypeScript

```ts
export interface RegisterCompanyRequest {
  email: string;
  password: string;
  personIdentificationType: string;
  personIdentification: string;
  personName: string;
  personLastName?: string | null;
  personPhone?: string | null;
  companyBusinessName: string;
  companyIdentification: string;
  username?: string | null;
  establishmentCode?: string | null;
  emissionPointCode?: string | null;
}

export interface RegisterCompanyResponse {
  personId: string;
  userId: string;
  companyId: string;
  companyBranchId: string;
  companyEmissionPointId: string;
  userCompanyId: string;
  profileId: string;
}
```

## Consumo Frontend

```ts
const response = await fetch("/api/auth/register", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify(payload)
});

if (!response.ok) {
  const body = await response.json();

  if (body.error?.showToUser) {
    throw new Error(body.error.userMessage);
  }

  throw new Error("No se pudo completar el registro.");
}

const data = await response.json() as RegisterCompanyResponse;
```

## Nota para Frontend

El frontend debe decidir por HTTP status y `error.code`. No debe depender del texto libre de `message` ni de mensajes internos de SQL Server.
