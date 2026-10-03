# Creación inicial de Nicole: personas globales y clientes por empresa

Esta definición crea una base de datos nueva y vacía. El punto de entrada es:

```text
database/20260905_001_crear_bd_registro_global_clientes.sql
```

Ejecuta el manifiesto en SQLCMD Mode desde la raíz del repositorio. El orden de sus inclusiones es la única secuencia necesaria.

El esquema crea el maestro global `Person` y `PersonIdentification`, la relación comercial `Client` por `Company`, permisos, procedimientos y documentación de soporte. No define tablas ni procedimientos para conservar respuestas, trazas, proveedores, estados tributarios o actividades económicas de servicios externos.

La consulta externa de cédula o RUC pertenece al backend: ocurre solo después de que una búsqueda local exacta no encuentre una identidad y sus datos se usan únicamente como sugerencia editable del formulario.
