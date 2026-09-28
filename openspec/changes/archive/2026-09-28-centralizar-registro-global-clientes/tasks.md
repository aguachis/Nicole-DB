# Tareas: creacion inicial de BD

Las tareas entregan definiciones para una base vacia. Codex no ejecuta SQL Server ni pruebas.

- [x] 1. Definir las tablas finales `IdentificationType`, `Person` y `Company`, sin identidad legacy y con `MainAddress`.
- [x] 2. Definir tablas globales de identificacion, registro tributario, actividades, proveedor, verificacion y auditoria con PK, FK, checks e indices.
- [x] 3. Definir `Client` por tenant con datos comerciales locales, unicidad y FK compuesta a la identidad de su persona.
- [x] 4. Definir seeds iniciales de estados, tipos, proveedores y permisos sin secretos.
- [x] 5. Definir SP de resolucion, persistencia y comandos de cliente con autorizacion por usuario y empresa.
- [x] 6. Adaptar el SP de registro inicial al maestro `Person` y `PersonIdentification`.
- [x] 7. Definir el manifiesto SQLCMD unico de bootstrap y la guia de ejecucion en base vacia.
- [x] 8. Actualizar diccionario, contratos backend/API y diagrama ER con las relaciones y el contrato de factura futura.
