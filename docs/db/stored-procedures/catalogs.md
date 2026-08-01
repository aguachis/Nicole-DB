# Stored Procedures - Catalogs

## Estado

Definicion inicial para catalogos compartidos por selects de UI.

## Objetivo

Exponer una consulta unificada por clave funcional para catalogos comunes del sistema sin acoplar la API a tablas o IDs fisicos.

## Alcance de esta etapa

- consultar `STATUS`
- consultar `IDENTIFICATION`
- consultar `PERSON_TYPE`

## Procedimientos principales

- `docs/db/stored-procedures/catalogs/P_Catalog_Lookup.sql`

## Regla importante

La consulta unificada debe devolver solo registros activos por defecto y mantener como fuente de verdad las tablas originales de cada catalogo.

## Nomenclatura y ubicacion de SP

- Dominio catalogs (`docs/db/stored-procedures/catalogs/`): prefijo `P_Catalog_` para lectura de catalogos compartidos.

## Matriz minima de validaciones

- `P_Catalog_Lookup`: valida `CatalogKey`, soporta `STATUS`, `IDENTIFICATION` y `PERSON_TYPE`, y rechaza claves no soportadas con codigo funcional de validacion.