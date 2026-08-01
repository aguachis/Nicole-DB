## Context

Ya existen SP para mantenimiento de usuarios en el dominio auth, pero el listado no entrega todos los campos personales requeridos para consumo directo. Tambien existe `P_User_Create`, que hoy exige `PersonId` previamente resuelto; esto obliga a la API a implementar una orquestacion adicional para crear o buscar persona antes de crear usuario.

## Goals / Non-Goals

**Goals:**
- Incluir en la consulta de usuarios: `lastName`, `middleName`, `firstName`, `identification`, `phone`.
- Permitir que el alta de usuario reciba datos de persona y cree la persona automaticamente cuando no exista por identificacion.
- Mantener salida estandar por SP (`result_code`, `result_message`, dataset).
- Preservar consistencia transaccional entre creacion de persona y usuario.

**Non-Goals:**
- No redisenar modelo relacional de `Person` o `AppUser`.
- No cambiar flujos de autenticacion/login.
- No introducir nuevos modulos fuera del dominio auth.

## Decisions

1. Expandir `P_User_List` con join y proyeccion de campos personales:
- Se exponen `LastName`, `MiddleName`, `FirstName`, `Identification` y `Phone` desde `dbo.Person`.
- Se mantiene compatibilidad hacia atras de columnas existentes para no romper consumidores actuales.

2. Evolucionar `P_User_Create` para modo de aprovisionamiento de persona:
- Opcion A (preferida): recibir `@PersonId` opcional y, cuando no se envia, crear/buscar persona por (`IdentificationType`, `Identification`).
- Opcion B: mantener `@PersonId` obligatorio y crear un nuevo SP wrapper.
- Decision: aplicar opcion A para minimizar endpoints/SP adicionales y consolidar logica.

3. Resolver existencia de persona antes de insercion:
- Si existe persona activa por identificacion, reutilizar `PersonId`.
- Si no existe, insertar nueva persona con auditoria y estado `A`.
- Validar colisiones por email cuando aplique para evitar inconsistencias de contacto.

4. Mantener transaccion unica para creacion:
- Persona y usuario se confirman/retroceden como una sola unidad.
- Errores funcionales usan codigos positivos; errores tecnicos usan `-5000`.

## Risks / Trade-offs

- [Riesgo] Duplicidad de persona por identificacion en datos legacy -> Mitigacion: validar unicidad efectiva y retornar error funcional cuando exista ambiguedad.
- [Riesgo] Ruptura de clientes que mapean columnas por posicion en `P_User_List` -> Mitigacion: agregar nuevas columnas sin remover ni reordenar las existentes criticas.
- [Trade-off] Mas parametros en `P_User_Create` incrementan complejidad de entrada -> Mitigacion: documentar contrato y validaciones minimas en integracion API.
- [Riesgo] Reutilizar persona existente podria sobrescribir expectativas de datos de nombre/telefono -> Mitigacion: no actualizar persona automaticamente en este cambio, solo reutilizar o crear.
