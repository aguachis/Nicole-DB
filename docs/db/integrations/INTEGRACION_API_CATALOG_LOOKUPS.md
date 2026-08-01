# Integracion API - Catalog Lookups

## Objetivo

Definir el contrato de integracion entre la API de backend y la base de datos para consultar catalogos comunes usados por selects de la UI sin depender de IDs fijos ni de la tabla fisica de origen.

Este documento estandariza la consulta unificada para el proyecto backend y permite reutilizar el mismo contrato en pantallas de usuarios, clientes y mantenimiento administrativo.

## Alcance inicial

La primera version soporta estas claves funcionales:

- `STATUS`
- `IDENTIFICATION`
- `PERSON_TYPE`

Fuente de verdad por clave:

- `STATUS` -> `dbo.EntityStatus`
- `IDENTIFICATION` -> `dbo.IdentificationType`
- `PERSON_TYPE` -> `dbo.PersonType`

Reglas iniciales:

- La respuesta devuelve solo registros activos por defecto.
- La clave solicitada debe existir en el set soportado.
- `Permission` queda fuera de este primer corte.
- Catalogos no modelados todavia, como `ClientType`, quedan fuera hasta que exista su entidad y su semilla.

## Endpoint sugerido

`GET /api/catalogs/{key}`

Ejemplos:

- `GET /api/catalogs/STATUS`
- `GET /api/catalogs/IDENTIFICATION`
- `GET /api/catalogs/PERSON_TYPE`

## Stored Procedure

Script: `docs/db/stored-procedures/catalogs/P_Catalog_Lookup.sql`

SP: `dbo.P_Catalog_Lookup`

## Clases C# sugeridas

### Query

```csharp
public sealed class CatalogLookupQuery
{
    public string Key { get; set; } = string.Empty;
    public bool IncludeInactive { get; set; }
}
```

### Stored Procedure Parameters

```csharp
public sealed class CatalogLookupSpParameters
{
  public string CatalogKey { get; set; } = string.Empty;
  public bool IncludeInactive { get; set; }
}
```

### Result Item

```csharp
public sealed class CatalogLookupItemResponse
{
    public string Value { get; set; } = string.Empty;
    public string Label { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string Status { get; set; } = string.Empty;
}
```

### Response

```csharp
public sealed class CatalogLookupResponse
{
    public string Key { get; set; } = string.Empty;
    public List<CatalogLookupItemResponse> Items { get; set; } = new();
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

## Payload esperado

Este endpoint es de lectura, por lo que solo recibe la clave del catalogo en la ruta.

## Ejecucion SQL

```sql
EXEC dbo.P_Catalog_Lookup
  @CatalogKey = @CatalogKey,
  @IncludeInactive = @IncludeInactive;
```

## Respuesta esperada

```json
{
  "key": "IDENTIFICATION",
  "items": [
    {
      "value": "04",
      "label": "RUC",
      "description": "Ruc",
      "status": "A"
    },
    {
      "value": "05",
      "label": "CEDULA",
      "description": "Cedula",
      "status": "A"
    }
  ]
}
```

## Validaciones del backend

- `key` es obligatoria.
- `key` debe pertenecer al set soportado por el backend.
- Si la clave no existe, el backend debe responder con error controlado.
- Por defecto no se incluyen registros inactivos.

## Mapeo sugerido de result_code a HTTP

| result_code | HTTP | error.code sugerido | Caso |
| --- | --- | --- | --- |
| `0` | `200` | N/A | Consulta exitosa. |
| `1001` | `400` | `VALIDATION_REQUIRED_FIELD` | Falta `CatalogKey` o la clave no es soportada. |
| `-5000` | `500` | `INTERNAL_SERVER_ERROR` | Error inesperado de base de datos. |

## Notas de integracion

- El frontend no debe hardcodear tablas ni identificadores fisicos.
- El backend debe centralizar el mapeo de clave funcional a fuente de verdad.
- Esta capa es compatible con pantallas que consumen catalogos en formularios de alta o edicion.
- Si un catalogo nuevo necesita ser expuesto, primero debe existir su entidad y su semilla en base de datos.

## Relacion con otros contratos

- `docs/db/integrations/INTEGRACION_API_AUTH_REGISTER.md` usa `IdentificationType` como parte del alta de empresa.
- `docs/db/integrations/INTEGRACION_API_USER_SECURITY_MAINTENANCE.md` usa `Status` para filtros y mantenimiento.
- `docs/db/integrations/INTEGRACION_API_PROFILES.md` mantiene `Permission` como catalogo funcional separado.