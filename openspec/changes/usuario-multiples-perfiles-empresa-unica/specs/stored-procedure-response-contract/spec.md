## ADDED Requirements

### Requirement: Resultset inicial de estado uniforme
Todos los procedimientos almacenados de `database/procedures` MUST devolver primero un resultset de exactamente una fila con `result_code` entero y `result_message` no nulo. Los SP de comando MUST incluir `operation`; los SP de consulta no requieren ese campo. Las funciones escalares y tabulares quedan fuera de este contrato.

#### Scenario: Procedimiento ejecutado correctamente
- **WHEN** un SP termina exitosamente, ya sea de consulta o comando
- **THEN** el primer resultset SHALL contener `result_code = 0` y un mensaje de resultado, antes de cualquier dato de negocio

#### Scenario: Resultado idempotente de comando de estado deseado
- **WHEN** se repite un comando definido como operacion idempotente de estado deseado y el recurso ya tiene el estado solicitado
- **THEN** el SP SHALL devolver `result_code = 0` y `operation = 'NOOP'` sin duplicar cambios ni eventos de auditoria

#### Scenario: Reintento de comando de creacion
- **WHEN** se repite una creacion cuyo recurso ya existe y no hay una clave de idempotencia que identifique el mismo intento
- **THEN** el SP SHALL devolver un codigo funcional de conflicto, no `NOOP`, y no crear un duplicado

#### Scenario: Rechazo funcional
- **WHEN** una entrada valida sintacticamente no satisface una regla de negocio o autorizacion
- **THEN** el SP SHALL devolver un codigo funcional documentado distinto de cero y solo el resultset de estado, sin datos de negocio

### Requirement: Resultsets de datos documentados
Los datos de negocio MUST devolverse en resultsets posteriores al resultset de estado, y cada SP MUST documentar numero, orden y columnas de todos sus resultsets.

#### Scenario: Consulta sin filas
- **WHEN** una consulta valida no encuentra registros
- **THEN** el SP SHALL devolver primero el estado exitoso y despues el resultset de datos con su esquema documentado y cero filas

#### Scenario: Contexto con varios conjuntos de negocio
- **WHEN** un SP devuelve varias entidades o conjuntos logicos de datos
- **THEN** el SP SHALL devolver cada conjunto en el orden documentado, siempre despues del estado y sin mezclar columnas de entidades independientes

### Requirement: Codigos funcionales estables y no ambiguos
Los codigos funcionales MUST estar registrados en un catalogo central documentado, ser estables y unicos por condicion dentro de la base. Los consumidores MUST tomar decisiones usando el codigo y no analizar `result_message`; los codigos internos SHALL ser independientes de los codigos HTTP.

#### Scenario: Mapeo de codigo funcional
- **WHEN** una API recibe una condicion funcional desde cualquier SP
- **THEN** SHALL poder mapear el codigo estable a su comportamiento sin depender del texto o idioma de `result_message`

#### Scenario: Condiciones distintas
- **WHEN** dos SP reportan condiciones funcionales diferentes
- **THEN** cada condicion SHALL usar un codigo distinto del catalogo central

### Requirement: Errores tecnicos propagados
Los SP MUST manejar las transacciones para revertir los cambios parciales y MUST propagar errores tecnicos con `THROW`, sin convertirlos en codigos funcionales ni incluir detalles internos de SQL Server en un resultset normal.

#### Scenario: Error tecnico durante una transaccion
- **WHEN** ocurre un error tecnico despues de iniciar cambios transaccionales
- **THEN** el SP SHALL revertir la transaccion y propagar el error tecnico; no SHALL devolver un resultset funcional de exito ni `ERROR_MESSAGE()` como `result_message`

#### Scenario: Error tecnico en consulta
- **WHEN** ocurre una excepcion inesperada durante un SP de consulta
- **THEN** el SP SHALL propagar la excepcion y no representarla como una respuesta funcional exitosa

### Requirement: Compatibilidad de consumidores del contrato
Los contratos de integracion documentados MUST describir el nuevo resultset inicial, los resultsets de datos y el mapeo de errores para los SP que consumen.

#### Scenario: Consumidor de varios resultsets
- **WHEN** un consumidor invoca un SP con resultsets de negocio
- **THEN** SHALL leer primero el estado, validar `result_code` y mapear los resultsets posteriores en el orden y esquema documentados
