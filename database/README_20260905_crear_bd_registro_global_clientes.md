# Creacion inicial de Nicole: registro global de clientes

Este recorrido es exclusivamente para una base de datos vacia. No contiene preflight, backfill, migracion ni rollback de datos.

1. Crea una base de datos vacia en SQL Server y selecciona esa base.
2. Abre una ventana de SSMS con **SQLCMD Mode** habilitado.
3. Configura como directorio de trabajo la raiz de `Nicole-DB`.
4. Ejecuta unicamente `database/20260905_001_crear_bd_registro_global_clientes.sql`.

El manifiesto crea las tablas base y del registro, claves, FK, indices, seeds, procedimientos y el rol `nicole_app` en el orden de dependencias. No ejecutes los archivos anteriores de `database/migrations/`, `database/validation/`, `database/tests/` o `database/rollback/`; corresponden al enfoque de migracion descartado.

Todos los scripts de procedimientos almacenados se mantienen centralizados en `database/procedures/`, separados por dominio (`auth`, `catalogs`, `profile` y `registry-client`).

El DBA debe revisar el resultado de SQL Server y registrar sus propias evidencias. Este repositorio solo entrega la definicion y no ha ejecutado el manifiesto.
