# Nicole DB

Repositorio de definiciones y documentación de la base de datos del ERP Nicole, actualmente orientado a Microsoft SQL Server.

## Estructura

- `tables/`: definición canónica de las tablas, en orden de creación. Cada script contiene sus claves, restricciones y valores por defecto.
- `tables/indexes/`: índices adicionales que deben ejecutarse después de crear todas las tablas.
- `procedures/`: procedimientos almacenados agrupados por dominio funcional.
- `types/`: tipos definidos por el usuario requeridos por los procedimientos.
- `seeds/`: catálogos y datos iniciales. Los archivos con prefijo `99-` son únicamente para pruebas.
- `docs/`: documentación funcional, integraciones, modelos de entidades y snapshots históricos de la base de datos.
- `openspec/`: especificaciones y registro de cambios funcionales.

Los archivos `docs/db/entities/*/00-current-schema.sql` se conservan como snapshots históricos. No son la fuente canónica para desplegar el esquema.

El [diagrama entidad–relación](docs/db/ER_DIAGRAM.md) muestra gráficamente las tablas y sus claves foráneas.

## Despliegue

El archivo `deploy.sql` define el orden completo de ejecución mediante comandos `:r` de SQLCMD. Debe ejecutarse desde la raíz del repositorio con el modo SQLCMD habilitado.

Los datos mock de `seeds/99-insert-mock-data.sql` no forman parte del despliegue normal.
