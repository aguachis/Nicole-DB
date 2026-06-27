# Integracion API - Profiles

## Objetivo

Cubrir el mantenimiento de perfiles por empresa y la sincronizacion de permisos del perfil en dos operaciones separadas.

Flujo esperado:

1. listar perfiles de la empresa activa
2. crear o actualizar el perfil
3. consultar permisos disponibles
4. guardar el set final de permisos del perfil

## Endpoints

- `GET /api/profiles?companyId={companyId}`
- `GET /api/profiles/{profileId}?companyId={companyId}`
- `POST /api/profiles`
- `PATCH /api/profiles/{profileId}`
- `DELETE /api/profiles/{profileId}?companyId={companyId}`
- `GET /api/permissions`
- `PUT /api/profiles/{profileId}/permissions`

## Stored Procedures

- `dbo.P_Profile_ListByCompany`
- `dbo.P_Profile_GetDetail`
- `dbo.P_Profile_Create`
- `dbo.P_Profile_Update`
- `dbo.P_Profile_Deactivate`
- `dbo.P_Permission_List`
- `dbo.P_ProfilePermission_ReplaceByProfile`

Scripts:

- `docs/db/stored-procedures/profile/P_Profile_ListByCompany.sql`
- `docs/db/stored-procedures/profile/P_Profile_GetDetail.sql`
- `docs/db/stored-procedures/profile/P_Profile_Create.sql`
- `docs/db/stored-procedures/profile/P_Profile_Update.sql`
- `docs/db/stored-procedures/profile/P_Profile_Deactivate.sql`
- `docs/db/stored-procedures/profile/P_Permission_List.sql`
- `docs/db/stored-procedures/profile/P_ProfilePermission_ReplaceByProfile.sql`

## Clases C# Sugeridas

### Request - Crear Perfil

```csharp
public sealed class CreateProfileRequest
{
    public Guid CompanyId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
}
```

### Request - Actualizar Perfil

```csharp
public sealed class UpdateProfileRequest
{
    public Guid CompanyId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
}
```

### Request - Reemplazar Permisos

```csharp
public sealed class ReplaceProfilePermissionsRequest
{
    public Guid CompanyId { get; set; }
    public List<string> PermissionCodes { get; set; } = new();
}
```

### Response - Profile Summary

```csharp
public sealed class ProfileSummaryResponse
{
    public Guid ProfileId { get; set; }
    public Guid CompanyId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string Status { get; set; } = string.Empty;
    public int ActivePermissionCount { get; set; }
    public DateTime CreatedAt { get; set; }
    public string CreatedBy { get; set; } = string.Empty;
    public DateTime? UpdatedAt { get; set; }
    public string? UpdatedBy { get; set; }
}
```

### Response - Profile Detail

```csharp
public sealed class ProfileDetailResponse
{
    public Guid ProfileId { get; set; }
    public Guid CompanyId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string Status { get; set; } = string.Empty;
    public int ActivePermissionCount { get; set; }
    public List<ProfilePermissionItemResponse> Permissions { get; set; } = new();
}

public sealed class ProfilePermissionItemResponse
{
    public Guid PermissionId { get; set; }
    public string Code { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string ModuleCode { get; set; } = string.Empty;
}
```

### Response - Permission Catalog

```csharp
public sealed class PermissionCatalogItemResponse
{
    public Guid PermissionId { get; set; }
    public string Code { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string ModuleCode { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
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

## Payloads Esperados

### Crear Perfil

`POST /api/profiles`

```json
{
  "companyId": "33333333-3333-3333-3333-333333333333",
  "name": "Supervisor",
  "description": "Perfil para supervisar operaciones"
}
```

### Actualizar Perfil

`PATCH /api/profiles/{profileId}`

```json
{
  "companyId": "33333333-3333-3333-3333-333333333333",
  "name": "Supervisor Comercial",
  "description": "Perfil para supervisar ventas y catalogos"
}
```

### Reemplazar Permisos del Perfil

`PUT /api/profiles/{profileId}/permissions`

```json
{
  "companyId": "33333333-3333-3333-3333-333333333333",
  "permissionCodes": [
    "profile.read",
    "profile.update",
    "permission.read"
  ]
}
```

## Ejecucion SQL

### Listar Perfiles

```sql
EXEC dbo.P_Profile_ListByCompany
    @CompanyId = @CompanyId;
```

### Consultar Detalle

```sql
EXEC dbo.P_Profile_GetDetail
    @CompanyId = @CompanyId,
    @ProfileId = @ProfileId;
```

### Crear Perfil

```sql
EXEC dbo.P_Profile_Create
    @CompanyId = @CompanyId,
    @Name = @Name,
    @Description = @Description,
    @CreatedBy = @CreatedBy;
```

### Actualizar Perfil

```sql
EXEC dbo.P_Profile_Update
    @CompanyId = @CompanyId,
    @ProfileId = @ProfileId,
    @Name = @Name,
    @Description = @Description,
    @UpdatedBy = @UpdatedBy;
```

### Inactivar Perfil

```sql
EXEC dbo.P_Profile_Deactivate
    @CompanyId = @CompanyId,
    @ProfileId = @ProfileId,
    @UpdatedBy = @UpdatedBy;
```

### Listar Permisos

```sql
EXEC dbo.P_Permission_List
    @ModuleCode = @ModuleCode;
```

### Reemplazar Permisos del Perfil

```sql
DECLARE @PermissionCodes dbo.PermissionCodeListType;

INSERT INTO @PermissionCodes (Code)
VALUES
    (N'profile.read'),
    (N'profile.update'),
    (N'permission.read');

EXEC dbo.P_ProfilePermission_ReplaceByProfile
    @CompanyId = @CompanyId,
    @ProfileId = @ProfileId,
    @PermissionCodes = @PermissionCodes,
    @UpdatedBy = @UpdatedBy;
```

## Respuestas Exitosas

### Listado

HTTP `200 OK`

```json
[
  {
    "profileId": "77777777-7777-7777-7777-777777777777",
    "companyId": "33333333-3333-3333-3333-333333333333",
    "name": "Supervisor",
    "description": "Perfil para supervisar operaciones",
    "status": "A",
    "activePermissionCount": 3,
    "createdAt": "2026-06-27T15:40:00Z",
    "createdBy": "admin@empresa.com",
    "updatedAt": null,
    "updatedBy": null
  }
]
```

### Detalle

HTTP `200 OK`

```json
{
  "profileId": "77777777-7777-7777-7777-777777777777",
  "companyId": "33333333-3333-3333-3333-333333333333",
  "name": "Supervisor",
  "description": "Perfil para supervisar operaciones",
  "status": "A",
  "activePermissionCount": 3,
  "permissions": [
    {
      "permissionId": "88888888-8888-8888-8888-888888888888",
      "code": "profile.read",
      "name": "Consultar perfiles",
      "description": "Permite consultar perfiles",
      "moduleCode": "profile"
    }
  ]
}
```

### Creacion

HTTP `201 Created`

```json
{
  "profileId": "77777777-7777-7777-7777-777777777777",
  "companyId": "33333333-3333-3333-3333-333333333333",
  "name": "Supervisor",
  "description": "Perfil para supervisar operaciones",
  "status": "A",
  "activePermissionCount": 0,
  "createdAt": "2026-06-27T15:40:00Z",
  "createdBy": "admin@empresa.com",
  "updatedAt": null,
  "updatedBy": null
}
```

## Validaciones del Backend

Reglas de negocio:

- `companyId` es obligatorio en todas las operaciones.
- `name` es obligatorio para crear y actualizar.
- `name` no puede repetirse dentro de la misma empresa.
- `permissionCodes` puede venir vacio para dejar el perfil sin permisos activos.
- `permissionCodes` no puede contener codigos vacios.
- todos los `permissionCodes` deben existir en `dbo.Permission` y estar activos.
- el backend debe mapear los dos resultsets de `P_Profile_GetDetail` y `P_ProfilePermission_ReplaceByProfile` al contrato HTTP final.

## Errores Esperados

### Campo requerido

HTTP `400 Bad Request`

```json
{
  "error": {
    "code": "VALIDATION_REQUIRED_FIELD",
    "message": "The field name is required.",
    "userMessage": "Completa los campos obligatorios.",
    "category": "validation",
    "showToUser": true,
    "retryable": false
  }
}
```

### Perfil duplicado

HTTP `409 Conflict`

```json
{
  "error": {
    "code": "PROFILE_ALREADY_EXISTS",
    "message": "Profile name already exists for the company.",
    "userMessage": "Ya existe un perfil con ese nombre en la empresa.",
    "category": "business",
    "showToUser": true,
    "retryable": false
  }
}
```

### Perfil no encontrado

HTTP `404 Not Found`

```json
{
  "error": {
    "code": "PROFILE_NOT_FOUND",
    "message": "Profile not found for the company.",
    "userMessage": "No se encontro el perfil solicitado.",
    "category": "business",
    "showToUser": true,
    "retryable": false
  }
}
```

### Permisos invalidos

HTTP `400 Bad Request`

```json
{
  "error": {
    "code": "PROFILE_PERMISSION_INVALID_SET",
    "message": "One or more permission codes are invalid or inactive.",
    "userMessage": "La lista de permisos contiene valores invalidos o inactivos.",
    "category": "validation",
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
    "message": "Unexpected error while maintaining profiles.",
    "userMessage": "No se pudo completar la operacion sobre perfiles.",
    "category": "internal",
    "showToUser": true,
    "retryable": true
  }
}
```

## Ejemplo TypeScript

```ts
export interface ProfileSummaryResponse {
  profileId: string;
  companyId: string;
  name: string;
  description?: string | null;
  status: string;
  activePermissionCount: number;
  createdAt: string;
  createdBy: string;
  updatedAt?: string | null;
  updatedBy?: string | null;
}

export interface ProfileDetailResponse {
  profileId: string;
  companyId: string;
  name: string;
  description?: string | null;
  status: string;
  activePermissionCount: number;
  permissions: PermissionCatalogItemResponse[];
}

export interface PermissionCatalogItemResponse {
  permissionId: string;
  code: string;
  name: string;
  description?: string | null;
  moduleCode: string;
  status?: string;
}

export interface CreateProfileRequest {
  companyId: string;
  name: string;
  description?: string | null;
}

export interface ReplaceProfilePermissionsRequest {
  companyId: string;
  permissionCodes: string[];
}
```

## Responsabilidades del Service

- validar payload y tenant activo
- construir parametros de SP incluyendo auditoria `CreatedBy` o `UpdatedBy`
- mapear `P_Profile_GetDetail` y `P_ProfilePermission_ReplaceByProfile` desde multiples resultsets
- traducir errores conocidos del SP a codigos HTTP y `error.code` estables
- exponer al front un detalle enriquecido del perfil con su lista de permisos activos