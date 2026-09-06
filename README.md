# Nicole DB

Repositorio de diseño y definición de la base de datos del ERP Nicole para Microsoft SQL Server (`dbo`). Su finalidad es entregar al responsable de base de datos scripts revisables de creación y la documentación que los acompaña.

## Alcance

El repositorio contiene, entre otros, los siguientes artefactos:

- tablas, claves primarias y foráneas, restricciones y valores por defecto;
- índices y reglas de unicidad;
- tipos definidos por el usuario y procedimientos almacenados;
- semillas y permisos iniciales;
- manifiestos SQLCMD y documentación del modelo, relaciones e integraciones.

No contiene una instancia de SQL Server ni administra su despliegue. Por tanto, los scripts no se ejecutan, validan ni certifican desde este repositorio. La ejecución, revisión de resultados, respaldo, control de acceso y evidencias son responsabilidad de la persona encargada de la base de datos.

La guía completa de alcance, responsabilidades y criterio de entrega está en [docs/db/01-project-scope-and-delivery.md](docs/db/01-project-scope-and-delivery.md).

## Estructura

- `tables/`: definición canónica de tablas, en orden de creación; incluye claves, restricciones y valores por defecto.
- `tables/indexes/`: índices adicionales que se crean después de las tablas de las que dependen.
- `procedures/`: procedimientos almacenados agrupados por dominio funcional.
- `types/`: tipos definidos por el usuario requeridos por procedimientos.
- `seeds/`: catálogos y datos iniciales. Los archivos con prefijo `99-` son solo datos mock y no pertenecen al despliegue normal.
- `database/`: manifiestos SQLCMD, procedimientos, semillas y seguridad asociados a entregas específicas.
- `docs/`: documentación técnica, integraciones, modelo de entidades y snapshots históricos.
- `openspec/`: especificaciones y registro de cambios funcionales.

Los archivos `docs/db/entities/*/00-current-schema.sql` son snapshots históricos; no son la fuente canónica para desplegar el esquema.

El [diagrama entidad-relación](docs/db/ER_DIAGRAM.md) muestra gráficamente las tablas y claves foráneas documentadas.

## Entrega para ejecución

La instalación inicial vigente para una base vacía usa [database/20260905_001_crear_bd_registro_global_clientes.sql](database/20260905_001_crear_bd_registro_global_clientes.sql). El DBA debe ejecutarlo desde la raíz del repositorio, en SQLCMD Mode, y revisar el resultado directamente en SQL Server.

Antes de ejecutar, el DBA debe confirmar el entorno destino, permisos, respaldo y compatibilidad de SQL Server. Después de ejecutar, debe registrar sus propias evidencias de creación de objetos, restricciones, índices, procedimientos, semillas y permisos. Este repositorio entrega los scripts; no sustituye esas actividades operativas.
