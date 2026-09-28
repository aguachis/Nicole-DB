## Context

El proyecto documenta entidades de seguridad (`app-user`, `profile`, `user-company`, `user-company-profile`) y ya posee convenciones de base de datos, pero no tiene un paquete consolidado de SP para mantenimiento operativo de usuarios ni para asignacion de perfiles. La API necesita contratos estables para invocar operaciones de seguridad sin duplicar logica en capa de aplicacion.

## Goals / Non-Goals

**Goals:**
- Definir SP de mantenimiento de usuarios con operaciones de alta, actualizacion, cambio de estado y consulta operativa.
- Definir SP de asignacion/revocacion de perfiles por usuario y empresa con comportamiento idempotente.
- Estandarizar respuestas de SP para facilitar mapeo uniforme en API.
- Definir la documentacion de integracion en Markdown para traspaso al proyecto API.

**Non-Goals:**
- No se implementa autenticacion OAuth/JWT ni cambios de arquitectura en API.
- No se reemplazan tablas existentes ni se redefine el modelo relacional de seguridad.
- No se implementa interfaz de usuario ni endpoints finales en esta fase de propuesta.

## Decisions

1. Agrupar los SP en dominios funcionales:
- Dominio de usuario en `database/procedures/auth/`.
- Dominio de perfiles/relaciones en `database/procedures/profile/`.
Razon: mantiene coherencia con la organizacion documental existente.

2. Estandarizar firma de respuesta en todos los SP:
- Codigo de resultado numerico (`result_code`).
- Mensaje funcional (`result_message`).
- Dataset tabular para salida de negocio cuando aplique.
Razon: simplifica manejo de errores y telemetria en API.

3. Aplicar validaciones previas de integridad y negocio dentro del SP:
- Existencia y estado de usuario.
- Existencia y estado de perfil.
- Pertenencia del usuario al contexto de empresa.
- Prevencion de asignaciones duplicadas.
Razon: evita inconsistencias cuando distintos consumidores invocan la base.

4. Publicar un documento de integracion API dedicado:
- Ubicado en `database/docs/db/integrations/`.
- Incluye contratos de entrada/salida, ejemplos de ejecucion y matriz de errores.
Razon: reducir ambiguedad en implementacion de capa de servicios.

## Risks / Trade-offs

- [Riesgo] Sobrevalidacion en SP puede aumentar latencia en operaciones masivas -> Mitigacion: separar operaciones unitarias de operaciones batch y definir indices recomendados.
- [Riesgo] Contratos de respuesta inconsistentes entre SP -> Mitigacion: checklist comun en tasks y ejemplos de salida en documento de integracion.
- [Riesgo] Ambiguedad en reglas de empresa-usuario-perfil -> Mitigacion: fijar escenarios obligatorios en specs para alta/revocacion y estados invalidos.
- [Trade-off] Mover reglas al SP reduce flexibilidad en API -> Mitigacion: mantener reglas de autorizacion de actor en API y reglas de integridad en DB.
