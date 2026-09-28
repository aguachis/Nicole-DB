## 1. Contrato canonico y compatibilidad

- [x] 1.1 Definir y documentar el contrato canonico de catalogos para selects (`value`, `label`, `status`, `description` opcional, `sortOrder` opcional).
- [x] 1.2 Documentar reglas de compatibilidad para no romper el contrato actual de `docs/db/integrations/INTEGRACION_API_CATALOG_LOOKUPS.md`.
- [x] 1.3 Definir tabla de compatibilidad con cambios y no-cambios esperados para consumidores backend/frontend.

## 2. Mapeo funcional por catalogo

- [x] 2.1 Documentar mapeo de `STATUS`: `StatusCode -> value`, `StatusName -> label`, `StatusDescription -> description`.
- [x] 2.2 Documentar mapeo de `IDENTIFICATION`: `IdentificationTypeId -> value`, `Name -> label`, `Description -> description`.
- [x] 2.3 Documentar mapeo de `PERSON_TYPE`: `PersonTypeId -> value`, `Name -> label`, `Description -> description`.

## 3. Reglas operativas del lookup

- [x] 3.1 Definir regla de activos por defecto por clave y comportamiento de `includeInactive`.
- [x] 3.2 Definir estrategia de orden deterministico: `SortOrder` cuando exista, fallback por `label` ascendente cuando no exista.
- [x] 3.3 Verificar que el set soportado se mantenga en `STATUS`, `IDENTIFICATION`, `PERSON_TYPE` y que `Permission` permanezca fuera de alcance.

## 4. Handoff backend en Markdown

- [x] 4.1 Crear `docs/db/integrations/INTEGRACION_API_CATALOG_LOOKUPS_BACKEND_HANDOFF.md`.
- [x] 4.2 Incluir en el handoff el contrato canonico, mapeo por clave, reglas de activos/includeInactive y estrategia de orden.
- [x] 4.3 Incluir tabla de compatibilidad, recomendaciones para nuevos catalogos (plantilla DDL minima + checklist) y ejemplos de request/response backend.

## 5. Cierre y validacion

- [x] 5.1 Revisar consistencia cruzada entre proposal, design, specs y handoff backend.
- [x] 5.2 Ejecutar `openspec status --change "estandar-catalogos-escalable"` y confirmar artefactos completos.
- [x] 5.3 Ejecutar `openspec validate --changes "estandar-catalogos-escalable"` y corregir hallazgos si aplica.
