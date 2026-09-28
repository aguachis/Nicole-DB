## Why

Los catalogos de UI ya existen y funcionan, pero hoy dependen de estructuras fisicas heterogeneas entre tablas (`StatusCode`, `IdentificationTypeId`, etc.), lo que dificulta escalar nuevos catalogos sin duplicar logica en backend/frontend. Este cambio es necesario ahora para fijar un contrato canonico estable, mantener compatibilidad y habilitar crecimiento ordenado.

## What Changes

- Estandarizar el contrato de lookup de catalogos para selects con una forma de respuesta unica y estable.
- Documentar el mapeo explicito por clave funcional (`STATUS`, `IDENTIFICATION`, `PERSON_TYPE`) hacia columnas fisicas de cada tabla fuente.
- Definir reglas de comportamiento para activos por defecto, `includeInactive` y estrategia de orden consistente entre catalogos.
- Definir lineamientos escalables para nuevos catalogos (plantilla DDL minima y checklist de alta).
- Generar un entregable de handoff para backend en `docs/db/integrations/INTEGRACION_API_CATALOG_LOOKUPS_BACKEND_HANDOFF.md`.
- Mantener compatibilidad con el contrato actual documentado en `docs/db/integrations/INTEGRACION_API_CATALOG_LOOKUPS.md`.

## Capabilities

### New Capabilities
- `catalog-lookup-contract-standardization`: Estandariza el contrato canonico de lookup de catalogos y su evolucion compatible para backend/frontend.
- `catalog-lookup-backend-handoff`: Define y entrega un documento tecnico en Markdown para traspaso de correcciones al proyecto backend.

### Modified Capabilities
- None.

## Impact

- Afecta documentacion tecnica de integracion en `docs/db/integrations/`.
- Afecta artefactos OpenSpec del cambio para guiar implementacion y validacion.
- Puede afectar implementacion futura del lookup SQL/API al formalizar reglas de mapeo y orden.
- No introduce ruptura del contrato vigente de consumo para clientes actuales.
