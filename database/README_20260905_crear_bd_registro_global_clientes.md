# Creación inicial de Nicole: personas globales y clientes por empresa

Esta definición crea una base de datos nueva y vacía. El punto de entrada es:

```text
database/20260905_001_crear_bd_registro_global_clientes.sql
```

Ejecuta el manifiesto en SQLCMD Mode desde la raíz del repositorio. El orden de sus inclusiones es la única secuencia necesaria.

El esquema crea el maestro global `Person` y `PersonIdentification`, la relación comercial `Client` por `Company`, permisos, procedimientos y documentación de soporte. No define tablas ni procedimientos para conservar respuestas, trazas, proveedores, estados tributarios o actividades económicas de servicios externos.

Cada `AppUser` pertenece a una sola empresa tenant (`CompanyId`). `UserProfile` permite asignar varios perfiles de esa misma empresa y sus FKs compuestas impiden relaciones entre empresas. Tras autenticar, el usuario elige un perfil activo para la sesion; solo se aplican los permisos de ese perfil. No se modela membresia multiempresa.

## Comprobaciones previas para el DBA

- Revisar el manifiesto SQLCMD desde una base nueva y vacia y confirmar el orden de creacion de tablas, procedimientos, indices y permisos.
- Confirmar que `AppUser` no contiene `ProfileId`, y que `UserProfile` y `UserProfileAudit` se crean antes de los procedimientos que las usan.
- Validar que las FKs compuestas bloquean una asignacion cuyo usuario y perfil pertenezcan a empresas distintas.
- Probar asignacion nueva, `NOOP` duplicado, reactivacion, revocacion y rechazo de revocar el ultimo perfil activo.
- Confirmar que cada cambio efectivo de asignacion y su evento de auditoria se confirman o revierten juntos; comprobar que `UPDATE` y `DELETE` de auditoria son rechazados.
- Verificar que la inactivacion de un perfil no deja usuarios activos sin otro perfil y que sesiones simultaneas con perfiles distintos autorizan solo por el perfil de cada sesion.
- Revisar los permisos efectivos de los principales de aplicacion: ejecucion solo de procedimientos autorizados y sin DML directo sobre tablas de auditoria.
- Registrar errores de compilacion, constraints, resultados de las pruebas, permisos y version desplegada. Esta lista no constituye evidencia de ejecucion.

La consulta externa de cédula o RUC pertenece al backend: ocurre solo después de que una búsqueda local exacta no encuentre una identidad y sus datos se usan únicamente como sugerencia editable del formulario.
