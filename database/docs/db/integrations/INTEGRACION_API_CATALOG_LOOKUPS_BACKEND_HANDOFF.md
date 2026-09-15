# Handoff Backend - Catalog Lookups

## Objetivo

Entregar al proyecto backend un resumen ejecutable de correcciones y reglas de adopcion para estandarizar el lookup de catalogos sin romper compatibilidad con consumidores actuales.

## Contrato canonico de respuesta

Cada item del catalogo debe usar la misma forma:

- `value` (obligatorio): identificador funcional para seleccionar.
- `label` (obligatorio): texto principal mostrado al usuario.
- `status` (obligatorio): estado funcional del item (`A` o `I`).
- `description` (opcional): texto descriptivo secundario.
- `sortOrder` (opcional): prioridad de orden cuando exista en la fuente.

### Ejemplo de payload de salida

```json
{
  "key": "STATUS",
  "items": [
    {
      "value": "A",
      "label": "ACTIVO",
      "description": "Estado activo",
      "status": "A",
      "sortOrder": 1
    },
    {
      "value": "I",
      "label": "INACTIVO",
      "description": "Estado inactivo",
      "status": "I",
      "sortOrder": 2
    }
  ]
}
```

## Mapeo por clave funcional

| key | Tabla fuente | value | label | description | status |
| --- | --- | --- | --- | --- | --- |
| `STATUS` | `dbo.EntityStatus` | `StatusCode` | `StatusName` | `StatusDescription` | `StatusCode` |
| `IDENTIFICATION` | `dbo.IdentificationType` | `IdentificationTypeId` | `Name` | `Description` | `Status` |
| `PERSON_TYPE` | `dbo.PersonType` | `PersonTypeId` | `Name` | `Description` | `Status` |

## Reglas de activos e includeInactive

Regla por defecto:

- El lookup retorna solo registros activos.

Override:

- Si `includeInactive=true`, retornar activos e inactivos.

Semantica por fuente:

- `STATUS`: activo por `EntityStatus.IsActive = 1`.
- `IDENTIFICATION`: activo por `IdentificationType.Status = 'A'`.
- `PERSON_TYPE`: activo por `PersonType.Status = 'A'`.

## Estrategia de orden

Regla canonica:

1. Si la fuente expone `SortOrder`, ordenar por `SortOrder` y luego `label`.
2. Si la fuente no expone `SortOrder`, ordenar por `label` ascendente.

## Tabla de compatibilidad

| Componente | Estado previo | Estado con correccion | Impacto |
| --- | --- | --- | --- |
| Endpoint `GET /api/catalogs/{key}` | Existente | Se mantiene | Sin ruptura |
| Campos `value`, `label`, `description`, `status` | Existentes | Se mantienen | Sin ruptura |
| Campo `sortOrder` | No estandarizado | Opcional | No rompe consumidores |
| Soporte de claves `STATUS`, `IDENTIFICATION`, `PERSON_TYPE` | Existente | Se mantiene | Sin ruptura |
| `Permission` dentro de lookup comun | Fuera de alcance | Se mantiene fuera | Sin ruptura |

## Recomendaciones para nuevos catalogos

### Plantilla DDL minima

```sql
CREATE TABLE dbo.<NewCatalog>
(
    <NewCatalogId> UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_<NewCatalog> PRIMARY KEY
        DEFAULT NEWSEQUENTIALID(),
    Code NVARCHAR(50) NOT NULL
        CONSTRAINT UQ_<NewCatalog>_Code UNIQUE,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(250) NULL,
    Status CHAR(1) NOT NULL
        CONSTRAINT DF_<NewCatalog>_Status DEFAULT ('A'),
    SortOrder SMALLINT NOT NULL
        CONSTRAINT DF_<NewCatalog>_SortOrder DEFAULT (0),
    CreatedBy NVARCHAR(80) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL
        CONSTRAINT DF_<NewCatalog>_CreatedAt DEFAULT (SYSDATETIME()),
    UpdatedBy NVARCHAR(80) NULL,
    UpdatedAt DATETIME2(0) NULL,
    CONSTRAINT CK_<NewCatalog>_Status CHECK (Status IN ('A', 'I')),
    CONSTRAINT CK_<NewCatalog>_SortOrder CHECK (SortOrder >= 0)
);
```

### Checklist de alta de nuevo catalogo

1. Crear entidad y constraints basicos (PK, Code unico, Name, Status, SortOrder).
2. Crear semilla inicial con valores minimos operativos.
3. Registrar clave funcional en documentacion de catalog lookup.
4. Definir mapeo `value/label/description/status` para la nueva clave.
5. Confirmar regla de activo e includeInactive para esa fuente.
6. Validar orden canonico (`SortOrder` o fallback por `label`).
7. Agregar ejemplo request/response en documentacion de integracion.

## Ejemplos de request/response para backend

### Request HTTP

```http
GET /api/catalogs/IDENTIFICATION?includeInactive=false
```

### Parametros sugeridos a SP

```sql
EXEC dbo.P_Catalog_Lookup
  @CatalogKey = N'IDENTIFICATION',
  @IncludeInactive = 0;
```

### Response HTTP

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

## Notas de implementacion

- Mantener el contrato actual como base y tratar `sortOrder` como campo opcional.
- Evitar dependencias de nombre fisico de tabla o PK en frontend.
- Mantener `Permission` en su contrato separado hasta una decision formal de convergencia.
