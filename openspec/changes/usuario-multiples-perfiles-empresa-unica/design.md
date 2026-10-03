## Context

`dbo.AppUser` currently contiene un `CompanyId` y un `ProfileId` obligatorios. La FK compuesta `(ProfileId, CompanyId)` protege la pertenencia del perfil a la empresa, pero la estructura solo permite un perfil por usuario. `dbo.P_UserProfile_Assign` reemplaza ese perfil y `dbo.P_Auth_GetSessionContext` obtiene permisos desde el `ProfileId` almacenado directamente en `AppUser`.

La configuracion OpenSpec anterior describia tablas `UserCompany` y `UserCompanyProfile`, pero no corresponden al modelo acordado ni al DDL vigente: cada usuario pertenece a una sola empresa. La configuracion se corrigio para documentar una empresa por usuario y perfiles multiples dentro de ella.

## Goals / Non-Goals

**Goals:**
- Mantener `AppUser.CompanyId` como empresa unica del usuario.
- Permitir multiples asignaciones usuario-perfil en esa empresa con integridad referencial verificable por SQL Server.
- Validar el perfil seleccionado al consultar el contexto de sesion y devolver permisos solo para ese perfil.
- Crear y revocar asignaciones de forma transaccional, idempotente y auditable.
- Definir el esquema directamente para la creacion de una base nueva, sin migracion de datos ni scripts `ALTER` para convertir una base existente.

**Non-Goals:**
- Permitir que un usuario pertenezca a mas de una empresa.
- Combinar permisos de varios perfiles para una misma sesion.
- Persistir el perfil activo en `AppUser`; el perfil activo pertenece a una sesion concreta y pueden coexistir sesiones diferentes.
- Implementar endpoints, tokens, interfaz de seleccion o codigo de API en este repositorio.
- Ejecutar DDL o certificar el despliegue en SQL Server; eso corresponde al DBA.

## Decisions

1. **Conservar la empresa en `AppUser` y eliminar de ahi el perfil unico.**
   `AppUser.CompanyId` continua siendo requerido. `AppUser.ProfileId` y su FK compuesta dejan de representar asignaciones, pues esa columna impide asignar mas de un perfil.

2. **Crear `dbo.UserProfile` como relacion de asignacion.**
   La tabla tendra una PK surrogate, `UserId`, `CompanyId`, `ProfileId`, estado y auditoria estandar. Una restriccion UNIQUE sobre usuario y perfil impedira duplicados. Para garantizar que el perfil y el usuario pertenecen a la misma empresa, la tabla tendra FKs compuestas `(UserId, CompanyId)` hacia una clave UNIQUE equivalente en `AppUser`, y `(ProfileId, CompanyId)` hacia `Profile`.

   La asignacion revocada se conservara con estado inactivo para permitir reactivacion idempotente. La FK de estado apuntara a `EntityStatus`.

3. **Aplicar la regla de al menos un perfil activo mediante operaciones transaccionales.**
   La creacion de usuario insertara el usuario y su perfil inicial en una misma transaccion. La revocacion de perfil y la inactivacion de un perfil deberan impedir que un usuario activo quede sin perfiles asignados activos. Esta regla no puede garantizarse con una FK o CHECK convencional, por lo que se valida en los SPs bajo una transaccion con bloqueo apropiado.

4. **Tratar el perfil activo como contexto de sesion, no como atributo global del usuario.**
   Despues de validar credenciales, la API consultara los perfiles activos permitidos para el usuario. Al construir el contexto de sesion, enviara `UserId` y el `ProfileId` elegido a `P_Auth_GetSessionContext` (o al contrato que lo sustituya). El SP verificara que la asignacion y el perfil sigan activos y que ambos correspondan a `AppUser.CompanyId`; solo entonces devolvera la empresa y permisos de ese perfil.

   No se guardara el perfil activo en `AppUser`: asi dos sesiones simultaneas del mismo usuario pueden operar con perfiles diferentes sin cambiarse mutuamente el contexto. La API es responsable de incluir el perfil validado en el contexto/token y de volver a validar al renovar o cambiar la sesion.

5. **Adaptar asignacion y alta sin introducir tablas de membresia empresarial.**
   `P_UserProfile_Assign` asignara sin reemplazar los otros perfiles. Se agregaran operaciones de revocacion y listado segun las convenciones existentes. Los SPs de alta de usuario conservaran un perfil inicial requerido en su contrato, pero insertaran la relacion en `UserProfile` junto con `AppUser`.

6. **Definir el modelo en los scripts de creacion inicial.**
   La base objetivo es nueva, por lo que `AppUser` se define desde el inicio sin `ProfileId` y `UserProfile` forma parte del esquema creado inicialmente. No se copiaran datos desde el modelo anterior ni se prepararan scripts `ALTER` para transformar una base existente. Los scripts y sus dependencias deben quedar ordenados para crear primero las tablas referenciadas y despues sus relaciones y procedimientos.

7. **Registrar cada cambio exitoso en una auditoria append-only.**
   Crear `dbo.UserProfileAudit` como historial separado de `UserProfile`. Cada asignacion, revocacion o reactivacion exitosa insertara un evento con el usuario, empresa y perfil afectados, tipo de operacion, actor y fecha/hora. La insercion del evento y el cambio de `UserProfile` ocurriran en la misma transaccion para que no haya cambios sin auditar ni eventos de operaciones revertidas.

   Los eventos no se actualizan ni eliminan por los procedimientos de negocio. La tabla no usara borrado en cascada desde `UserProfile`; los permisos de base de datos deben proteger el historial contra modificaciones. `UserProfile` puede conservar los datos de estado actual y ultima modificacion para consultas operativas, mientras `UserProfileAudit` es la fuente del historial de transiciones.

8. **Estandarizar la respuesta de todos los procedimientos almacenados del repositorio.**
   Todo SP bajo `database/procedures` devolvera primero un resultset de una fila con `result_code` entero y `result_message`. Los SP de comando incluiran `operation` para identificar la accion realizada y `NOOP` para una repeticion idempotente. Los SP de consulta no necesitan `operation`. Si el SP devuelve datos de negocio, estos iran en uno o mas resultsets posteriores, con orden y columnas documentados por SP; ante un resultado funcional no exitoso no se devolveran resultsets de datos.

   `result_code = 0` significa operacion exitosa. Las repeticiones idempotentes tambien seran exitosas y usaran `operation = 'NOOP'`, evitando que la API trate una repeticion segura como error. Cada condicion funcional tendra un codigo numerico estable y no compartido con otra condicion en un catalogo central documentado; los codigos y mensajes se documentaran, pero la API tomara decisiones por codigo, nunca parseando `result_message`. Se evitaran codigos HTTP como codigos internos SQL y se asignaran codigos funcionales por condicion, corrigiendo reutilizaciones ambiguas existentes.

   Los errores tecnicos no se convertiran en codigos funcionales ni expondran `ERROR_MESSAGE()` como respuesta normal. El SP revertira la transaccion y relanzara el error con `THROW`; la API registrara el detalle interno y devolvera un error tecnico sanitizado. Este contrato aplica a los 20 SP existentes y a los nuevos que se agreguen a la carpeta; no aplica a funciones escalares o tabulares.

## Risks / Trade-offs

- [Riesgo] Los artefactos del repositorio aun contienen consumidores documentales o scripts que presuponen `AppUser.ProfileId` -> Mitigacion: alinear las definiciones iniciales, SPs y documentacion antes de crear la base; verificar el orden de ejecucion con el DBA.
- [Riesgo] Una carrera entre revocacion y cambios de estado puede dejar un usuario sin perfil activo -> Mitigacion: serializar las operaciones relevantes por usuario/empresa dentro de transacciones y verificar la condicion antes del commit.
- [Riesgo] Un `ProfileId` manipulado por el cliente podria ampliar permisos -> Mitigacion: el contexto de sesion valida la asignacion usuario-perfil activa en base de datos y resuelve permisos solo para ese perfil.
- [Riesgo] Los eventos append-only pueden modificarse por principals con permisos de escritura directa sobre la tabla -> Mitigacion: limitar permisos, escribir mediante SPs controlados y revisar que no existan UPDATE/DELETE ni borrado en cascada en el diseno.
- [Riesgo] Consumidores que esperan un solo resultset pueden mapear incorrectamente SPs con estado y datos separados -> Mitigacion: documentar el orden y esquema de cada resultset y validar los mapeos de integracion antes del despliegue.
- [Riesgo] Estandarizar todos los SP modifica contratos de autenticacion, catalogos y clientes, no solo seguridad de usuarios -> Mitigacion: inventariar cada firma/salida, documentar los resultsets y sus consumidores conocidos, y actualizar los documentos de integracion disponibles antes de certificar la base inicial.
- [Trade-off] El historial append-only agrega almacenamiento y escrituras a cada cambio de asignacion -> Motivo: permite reconstruir quien asigno, revoco o reactivo cada perfil y cuando ocurrio.
- [Trade-off] La integridad compuesta requiere una clave UNIQUE redundante sobre `AppUser(UserId, CompanyId)` aunque `UserId` ya sea PK -> Motivo: SQL Server exige una clave candidata con la misma lista de columnas para la FK que valida la empresa coincidente.

## Initial Database Creation Plan

1. Definir `AppUser` desde el inicio con `CompanyId` y sin `ProfileId`.
2. Crear `Profile`, `UserProfile` y `UserProfileAudit` con sus claves, restricciones e indices en los scripts iniciales, preservando la integridad entre usuario, perfil y empresa.
3. Inventariar los 20 SP, sus codigos actuales, formas de salida y consumidores documentados; definir el catalogo central de codigos funcionales.
4. Aplicar a todos los SP el resultset inicial de estado, mover los datos de negocio a resultsets posteriores, asignar `operation` solo a comandos y propagar errores tecnicos con `THROW`.
5. Crear o actualizar los SPs para que el alta de usuarios inserte su perfil inicial y las operaciones de asignacion modifiquen `UserProfile` y agreguen sus eventos de auditoria dentro de una transaccion.
6. Actualizar `P_Auth_GetSessionContext` para exigir un perfil elegido, validar su asignacion y retornar permisos efectivos de ese perfil; publicar el SP de consulta de perfiles asignados.
7. Actualizar documentacion de integracion afectada, entidades y diagrama para coincidir con los contratos y el esquema inicial.
8. Revisar el orden de ejecucion y las restricciones de los scripts iniciales. No generar migracion de datos ni scripts `ALTER` cuyo objetivo sea transformar la estructura anterior; el DBA valida y despliega la creacion desde cero.

## Open Questions

Ninguna para esta propuesta. El catalogo de codigos funcionales especificos y los resultsets de datos de cada SP se concretaran al inventariar e implementar el contrato global.
