# Alcance y entrega del proyecto de base de datos

## Propósito

Nicole DB define el diseño, la estructura y los scripts de creación de la base de datos del ERP Nicole en Microsoft SQL Server, bajo el esquema `dbo`.

El repositorio es una fuente de definición técnica. Cada cambio debe producir scripts claros, ordenados por dependencias y documentados para que el responsable de base de datos pueda revisarlos y ejecutarlos en el entorno autorizado.

## Artefactos incluidos

- DDL de tablas, columnas, claves primarias, claves foráneas, `CHECK`, `DEFAULT` y reglas `UNIQUE`.
- Índices relacionados con reglas de unicidad, claves foráneas o patrones de consulta documentados.
- Tipos definidos por el usuario y procedimientos almacenados T-SQL.
- Datos semilla, permisos iniciales y scripts de seguridad que correspondan al modelo.
- Manifiestos SQLCMD, documentación de entidades, relaciones, decisiones de diseño y contratos de integración.

## Límites del repositorio

Este repositorio no incluye acceso a una instancia de SQL Server ni un entorno de pruebas. En consecuencia, desde aquí no se ejecutan scripts, no se prueban procedimientos almacenados y no se certifica el resultado de un despliegue.

No se deben presentar revisiones de scripts como evidencia de que el DDL, los procedimientos, los índices o los permisos se ejecutaron correctamente. Cualquier validación que requiera una base de datos —incluidas la compilación T-SQL, la creación de objetos, la integridad referencial, el rendimiento, las transacciones y los permisos efectivos— debe ser realizada y registrada por el DBA en el entorno correspondiente.

## Responsabilidades

| Responsable | Responsabilidad |
| --- | --- |
| Equipo del repositorio | Mantener scripts de creación, orden de dependencias, documentación y justificación técnica de tablas, relaciones, índices y procedimientos. |
| Responsable de base de datos (DBA) | Revisar los scripts, preparar el entorno, ejecutar el manifiesto autorizado, gestionar respaldos y permisos, y conservar las evidencias de ejecución y validación. |
| Equipo de aplicación | Consumir únicamente los contratos y objetos que hayan sido desplegados y confirmados por el DBA. |

## Criterio de entrega

Una entrega de base de datos debe identificar, como mínimo:

1. El objetivo funcional y las entidades afectadas.
2. Los scripts a ejecutar y su orden de dependencias.
3. Las tablas, relaciones, restricciones, índices, tipos, procedimientos, semillas y permisos impactados.
4. Las precondiciones operativas que el DBA debe revisar antes de ejecutarla.
5. Los puntos que el DBA debe validar en SQL Server y documentar como evidencia.

Para instalaciones iniciales, el manifiesto vigente y sus indicaciones están en `database/`. Para cambios posteriores, el responsable de base de datos debe recibir y aprobar el conjunto de scripts correspondiente antes de su ejecución.

## Fuentes de verdad

- `database/tables/`, `database/tables/indexes/`, `database/types/`, `database/seeds/`, `database/procedures/` y los demás manifiestos de `database/`: scripts de definición y creación.
- `database/docs/db/BACKEND_DATABASE_CONTEXT.md`: índice técnico del modelo vigente para integraciones.
- `database/docs/db/02-conventions.md`: convenciones de diseño.
- `database/docs/db/03-new-database-working-document.md`: decisiones y bitácora técnica.
- `database/docs/db/entities/`, `database/docs/db/stored-procedures/` y `database/docs/db/integrations/`: documentación por objeto e integración.
