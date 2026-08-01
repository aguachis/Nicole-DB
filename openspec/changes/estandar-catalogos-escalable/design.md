## Context

El repositorio ya dispone de un lookup unificado de catalogos para `STATUS`, `IDENTIFICATION` y `PERSON_TYPE`, pero su escalabilidad futura depende de estandarizar contrato y reglas de evolucion. Las tablas fuente tienen columnas heterogeneas por diseno de dominio (`StatusCode`, `IdentificationTypeId`, `PersonTypeId`), y el backend necesita un contrato uniforme para no acoplar frontend/API a detalles fisicos.

Adicionalmente, se requiere un entregable de traspaso tecnico para el proyecto backend en un archivo Markdown independiente, manteniendo compatibilidad con el contrato actual.

## Goals / Non-Goals

**Goals:**
- Definir contrato canonico de respuesta para catalogos de select sin romper consumidores actuales.
- Documentar mapeo explicito por clave funcional a columnas fisicas por tabla.
- Definir reglas de activos por defecto, uso de `includeInactive` y orden consistente.
- Establecer lineamientos para crecimiento de nuevos catalogos (plantilla DDL minima y checklist).
- Entregar documento de handoff backend en `docs/db/integrations/INTEGRACION_API_CATALOG_LOOKUPS_BACKEND_HANDOFF.md`.

**Non-Goals:**
- No migrar fisicamente todas las tablas existentes a un modelo unico.
- No incorporar `Permission` al lookup de este alcance.
- No romper endpoint ni payload vigente ya publicado.

## Decisions

1. Normalizacion por contrato, no por estructura fisica
- Decision: aceptar heterogeneidad de PK en tablas origen y normalizar solo en la capa de lookup.
- Alternativa: forzar remodelado fisico de tablas para unificar llaves.
- Razon: menor riesgo, menor costo y misma consistencia para consumidores.

2. Evolucion compatible del contrato
- Decision: mantener campos actuales y permitir campos adicionales opcionales (`sortOrder`) sin ruptura.
- Alternativa: version mayor con ruptura inmediata.
- Razon: protege integraciones existentes del backend/frontend.

3. Estrategia de orden canonica
- Decision: usar `SortOrder` cuando exista en fuente; en su ausencia aplicar fallback por `label` ascendente.
- Alternativa: ordenar siempre alfabeticamente.
- Razon: soporta prioridad funcional donde exista orden de negocio.

4. Entregable de handoff dedicado
- Decision: generar md independiente para backend con detalle de correcciones y adopcion.
- Alternativa: mezclar todo en documento de integracion original.
- Razon: facilita traspaso operativo y trazabilidad de cambios.

## Risks / Trade-offs

- [Risk] Ambiguedad en la semantica de activo entre `IsActive` y `Status`. -> Mitigation: documentar regla unica de filtrado por clave y pruebas por catalogo.
- [Risk] Crecimiento futuro del lookup con demasiadas ramas hardcoded. -> Mitigation: documentar ruta de evolucion a estrategia normalizada reusable.
- [Risk] Consumidores dependientes de orden previo. -> Mitigation: explicitar orden canonico y publicar tabla de compatibilidad en handoff.

## Migration Plan

1. Crear artefactos OpenSpec del cambio con criterios de compatibilidad.
2. Publicar en integraciones el documento de handoff backend con contrato canonico y mapeos.
3. Aplicar correcciones de documentacion sin cambiar contrato obligatorio existente.
4. Validar con OpenSpec y checklist de compatibilidad.

Rollback:
- Si alguna correccion documental genera conflicto de consumo, conservar el contrato vigente como fuente principal y tratar cambios nuevos como opcionales.

## Open Questions

- Conviene introducir un endpoint versionado para cuando se agreguen metadatos adicionales no opcionales?
- Se desea incluir `categoryCode` como campo opcional desde esta fase o reservarlo para una fase posterior?
