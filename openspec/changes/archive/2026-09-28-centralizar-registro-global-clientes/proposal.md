# Cambio: Centralizar registro global de clientes

## Por que

Nicole comienza con una base de datos vacia. La identidad fiscal debe quedar normalizada desde la primera instalacion, separada de la relacion comercial que cada `Company` mantiene con una `Person`.

## Que cambia

- Se define el DDL final de `Person`, `IdentificationType`, `Company` y `Client`, sin columnas legacy de identidad o snapshot comercial duplicado.
- Se crean `PersonIdentification`, `TaxRegistration`, actividad economica, proveedores, historial de verificacion y auditoria de acceso.
- Se crean las claves, FKs compuestas, checks, indices y triggers del modelo final.
- Se crean los SP de registro, verificacion y cliente, junto con permisos de aplicacion.
- Se entrega un manifiesto SQLCMD de creacion inicial y semillas minimas de catalogos y permisos.
- Se actualizan diccionario, contratos backend/API, catalogo de SP y diagrama ER.

## Impacto

- **SQL Server / dbo:** creacion inicial de tablas, restricciones, funciones, triggers, seeds, permisos y procedimientos.
- **Operacion:** el DBA ejecuta un unico manifiesto de bootstrap sobre una base vacia. No hay preflight, backfill, remediacion, rollback de datos ni fases de migracion.
- **Backend/API:** este repositorio define el contrato SQL; HTTP, secretos, UI e Invoice siguen fuera de alcance.

## Fuera de alcance

- Ejecutar los scripts o pruebas contra una instancia SQL Server desde este repositorio.
- Migrar, conservar o deprecar datos y columnas de una instalacion anterior.
- Crear el modulo o las tablas de `Invoice`.
