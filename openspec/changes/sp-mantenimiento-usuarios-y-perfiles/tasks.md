## 1. Preparacion y contratos

- [x] 1.1 Revisar convenciones en `docs/db/02-conventions.md` y definir plantilla unica de respuesta (`result_code`, `result_message`, dataset).
- [x] 1.2 Levantar matriz de validaciones de negocio para usuario, perfil y relacion usuario-empresa.
- [x] 1.3 Definir nomenclatura final de SP y su ubicacion en `procedures/auth/` y `procedures/profile/`.

## 2. Implementacion de SP de mantenimiento de usuarios

- [x] 2.1 Crear SP de alta de usuario con control de duplicidad de username y validaciones obligatorias.
- [x] 2.2 Crear SP de actualizacion de usuario con control de existencia y estado.
- [x] 2.3 Crear SP de activacion/inactivacion con comportamiento idempotente.
- [x] 2.4 Crear SP de consulta operativa por filtros con salida tabular estandar.

## 3. Implementacion de SP de asignacion de perfiles

- [x] 3.1 Crear SP de asignacion de perfil a usuario por empresa con validaciones de pertenencia y vigencia.
- [x] 3.2 Crear SP de revocacion de perfil por usuario/empresa con manejo idempotente.
- [x] 3.3 Incorporar trazabilidad minima (actor, fecha, operacion) en asignacion y revocacion.

## 4. Documentacion de integracion para API

- [x] 4.1 Crear/actualizar markdown de integracion en `docs/db/integrations/` para SP de usuarios y perfiles.
- [x] 4.2 Incluir contratos de entrada/salida por SP y catalogo de codigos de error funcional.
- [x] 4.3 Agregar ejemplos de consumo desde servicios API y mapeo sugerido a respuestas HTTP.

## 5. Verificacion y cierre

- [x] 5.1 Validar que todos los SP cumplan contrato de respuesta estandar y escenarios definidos en specs.
- [x] 5.2 Validar consistencia documental cruzada con `docs/db/02-conventions.md` y documentos de integracion existentes.
- [x] 5.3 Ejecutar `openspec validate --change "sp-mantenimiento-usuarios-y-perfiles"` y corregir hallazgos.
