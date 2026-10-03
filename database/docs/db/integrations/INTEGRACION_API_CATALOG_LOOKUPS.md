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

Script: `database/procedures/catalogs/P_Catalog_Lookup.sql`

SP: `dbo.P_Catalog_Lookup`

## Contrato canonico de respuesta

Campos por item:

- `value` (obligatorio): identificador funcional del item para seleccion.
- `label` (obligatorio): texto principal visible.
- `status` (obligatorio): estado funcional (`A` o `I`).
- `description` (opcional): descripcion ampliada del item.
- `sortOrder` (opcional): prioridad de orden cuando el catalogo lo soporte.

Regla de compatibilidad:

- Los campos actuales (`value`, `label`, `description`, `status`) se mantienen sin cambios semanticos.
- `sortOrder` se incorpora como campo opcional y no rompe consumidores existentes.

## Mapeo funcional por clave

| key | Fuente | value | label | description | status |
| --- | --- | --- | --- | --- | --- |
| `STATUS` | `dbo.EntityStatus` | `StatusCode` | `StatusName` | `StatusDescription` | `StatusCode` |
| `IDENTIFICATION` | `dbo.IdentificationType` | `IdentificationTypeId` | `Name` | `Description` | `Status` |
| `PERSON_TYPE` | `dbo.PersonType` | `PersonTypeId` | `Name` | `Description` | `Status` |

## Reglas operativas del lookup

- Filtro por defecto: solo activos.
- Override explicito: `includeInactive=true` permite incluir activos e inactivos.
- Determinismo de orden:
  - Si la fuente tiene `SortOrder`, ordenar por `SortOrder` y luego `label`.
  - Si la fuente no tiene `SortOrder`, usar fallback por `label` ascendente.

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
    public int? SortOrder { get; set; }
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
      "status": "A",
      "sortOrder": null
    },
    {
      "value": "05",
      "label": "CEDULA",
      "description": "Cedula",
      "status": "A",
      "sortOrder": null
    }
  ]
}
```

## Validaciones del backend

- `key` es obligatoria.
- `key` debe pertenecer al set soportado por el backend.
- Si la clave no existe, el backend debe responder con error controlado.
- Por defecto no se incluyen registros inactivos.
- Cualquier campo opcional agregado debe preservarse como no obligatorio para consumidores existentes.

## Mapeo sugerido de result_code a HTTP

| result_code | HTTP | error.code sugerido | Caso |
| --- | --- | --- | --- |
| `0` | `200` | N/A | Consulta exitosa. |
| `1001` | `400` | `VALIDATION_REQUIRED_FIELD` | Falta `CatalogKey`. |
| `1002` | `400` | `CATALOG_KEY_UNSUPPORTED` | La clave funcional no esta soportada. |
| Excepcion SQL | `500` | `INTERNAL_SERVER_ERROR` | Error tecnico inesperado propagado por el SP. |

`dbo.P_Catalog_Lookup` devuelve primero el resultset de estado y luego el conjunto de items. El estado exitoso no se repite en cada item.

RS1 contiene `result_code` y `result_message`. Si la consulta es exitosa, RS2 contiene `CatalogKey`, `Value`, `Label`, `Description` y `Status`; si no hay items, RS2 conserva esas columnas y devuelve cero filas. No se incluye `operation` porque es una consulta.

## Notas de integracion

- El frontend no debe hardcodear tablas ni identificadores fisicos.
- El backend debe centralizar el mapeo de clave funcional a fuente de verdad.
- Esta capa es compatible con pantallas que consumen catalogos en formularios de alta o edicion.
- Si un catalogo nuevo necesita ser expuesto, primero debe existir su entidad y su semilla en base de datos.
- El detalle operativo de adopcion backend se documenta en `docs/db/integrations/INTEGRACION_API_CATALOG_LOOKUPS_BACKEND_HANDOFF.md`.

## Relacion con otros contratos

- `database/docs/db/integrations/INTEGRACION_API_AUTH_REGISTER.md` usa `IdentificationType` como parte del alta de empresa.
- `database/docs/db/integrations/INTEGRACION_API_USER_SECURITY_MAINTENANCE.md` usa `Status` para filtros y mantenimiento.
- `database/docs/db/integrations/INTEGRACION_API_PROFILES.md` mantiene `Permission` como catalogo funcional separado.
