# Convenciones de Trabajo

## Estado

Este documento define las convenciones objetivo. Algunas todavia no se cumplen en el modelo actual y se iran adoptando gradualmente.

## Nombres

- Elegir un idioma canonico por dominio antes de hacer cambios estructurales
- Evitar coexistencia de tablas duplicadas con nombres en ingles y espanol si representan la misma entidad
- Usar nombres de columnas autoexplicativos
- Evitar nombres ambiguos como `codigo`, `estado` o `descripcion` sin contexto cuando la tabla crezca

## Llaves

- Preferir PK surrogate estables para entidades maestras
- Mantener claves naturales como `UNIQUE` cuando representen reglas del negocio
- Declarar FK fisicas siempre que la relacion sea real y estable
- Evitar depender solo de convenciones de nombres para inferir relaciones

## Auditoria

Objetivo recomendado:

- `CreatedAt`
- `CreatedBy`
- `UpdatedAt`
- `UpdatedBy`

Si un modulo legacy usa:

- `fechaIngreso`
- `usuarioIngreso`
- `fechaActualizacion`
- `usuarioActualizacion`

entonces se documentara como legacy y se evaluara convergencia futura.

## Estados

- Definir catalogos o dominios claros para columnas de estado
- Evitar mezclar `char(1)`, `char(6)`, `varchar(6)` y `bit` para la misma semantica
- Documentar el significado de cada valor posible

## Tipos de datos

- Revisar uso de `money` caso por caso
- Evitar `image`; preferir `varbinary(max)` o almacenamiento externo con metadatos
- Revisar uso excesivo de `nvarchar(max)` o `varchar(max)` cuando no sea necesario
- Homologar fechas a `datetime2` cuando el contexto lo permita

## Indices

- Cada indice debe responder a un patron real de consulta o una regla de unicidad
- Evitar indices redundantes o duplicados
- Revisar cobertura de:
  - FK
  - filtros frecuentes
  - joins frecuentes
  - busquedas por identificacion, estado, empresa y fecha

## Stored Procedures

- Cada SP debe tener objetivo claro: consulta, mantenimiento, anulacion, reporteria
- Evitar SPs multiproposito excesivamente acoplados
- Documentar:
  - tablas afectadas
  - parametros
  - validaciones
  - transacciones
  - manejo de errores
- Antes de crear o modificar un SP, revisar constraints e indices de las tablas involucradas
