## Context

El repositorio ya modela catálogos base como `EntityStatus`, `IdentificationType` y `PersonType`, pero cada uno se consume de forma aislada. Las pantallas de usuario y otros formularios necesitan una forma estable de pedir catálogos sin conocer tablas, IDs ni reglas internas de cada dominio.

El cambio debe convivir con el patrón actual del sistema, donde `Permission` ya se expone como catálogo funcional propio, pero no se debe ampliar ese alcance en este primer corte.

## Goals / Non-Goals

**Goals:**
- Exponer una capa unificada para consulta de catálogos de UI.
- Resolver catálogos mediante claves funcionales estables.
- Mantener como fuente de verdad las tablas existentes.
- Retornar solo registros activos por defecto.
- Mantener el contrato centrado en `STATUS`, `IDENTIFICATION` y `PERSON_TYPE`.

**Non-Goals:**
- No crear una mega-tabla genérica de catálogos.
- No incluir `Permission` en este primer corte.
- No modelar catálogos futuros como `ClientType` hasta que existan como entidad y semilla.
- No cambiar la semántica relacional de las tablas actuales.

## Decisions

1. **Endpoint unificado por clave**
- Se usará un endpoint de lectura por clave funcional, por ejemplo `/api/catalogs/{key}`.
- Alternativa considerada: mantener endpoints separados por catálogo.
- Razonamiento: una sola superficie de consumo reduce duplicidad en frontend y simplifica la evolución de nuevos selects.

2. **Registro interno de resolución**
- La implementación debe resolver cada clave contra una fuente concreta mediante un mapa interno.
- Alternativa considerada: inferir la fuente por convención o por nombre de tabla.
- Razonamiento: el mapa hace explícita la relación entre clave funcional y fuente de verdad, y evita acoplamientos frágiles.

3. **Respuesta normalizada para select**
- La API debe devolver una estructura homogénea para cualquier catálogo soportado.
- Alternativa considerada: devolver el esquema nativo de cada tabla.
- Razonamiento: un formato común evita adaptadores específicos por pantalla y mantiene la UI simple.

4. **Filtro activo por defecto**
- La consulta debe devolver únicamente registros activos a menos que el contrato futuro agregue un override explícito.
- Alternativa considerada: incluir activos e inactivos por defecto.
- Razonamiento: la mayoría de selects operativos solo necesitan valores válidos para interacción inmediata.

5. **Capacidad acotada en el primer corte**
- Solo se soportarán `STATUS`, `IDENTIFICATION` y `PERSON_TYPE` inicialmente.
- Alternativa considerada: incluir también `Permission` desde el inicio.
- Razonamiento: `Permission` ya tiene contrato propio y mezclarlo ahora agrega complejidad sin beneficio inmediato.

## Risks / Trade-offs

- [Risk] La UI podría asumir que todos los catálogos futuros entran automáticamente por la misma vía. → Mitigation: documentar el mapa de claves soportadas y exigir alta formal para nuevas claves.
- [Risk] Un mapa interno mal mantenido podría desalinearse con la fuente real. → Mitigation: centralizar la resolución y documentar cada clave con su origen único.
- [Risk] Un formato unificado puede ocultar atributos específicos de ciertos catálogos. → Mitigation: mantener la respuesta mínima para selects y extender solo cuando exista un caso real.

## Migration Plan

1. Publicar el contrato funcional y la lista de claves soportadas.
2. Implementar el lookup unificado sin cambiar la fuente de verdad de las tablas existentes.
3. Validar que los consumidores de UI puedan sustituir sus consultas directas por la nueva clave funcional.
4. Mantener `Permission` como contrato independiente durante esta fase.

Rollback:
- Si el nuevo endpoint o servicio genera regresión, la aplicación puede volver temporalmente a los consumos directos de `EntityStatus`, `IdentificationType` y `PersonType` sin alterar el modelo de datos.

## Open Questions

- ¿Se necesitará un mecanismo futuro para incluir inactivos desde la UI administrativa?
- ¿Conviene estandarizar más catálogos después de validar el primer corte?
- ¿Debe existir un alias de compatibilidad para catálogos ya expuestos por endpoints separados o se migra todo al endpoint unificado?