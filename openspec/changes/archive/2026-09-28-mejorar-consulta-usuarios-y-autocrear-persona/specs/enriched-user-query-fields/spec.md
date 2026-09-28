## ADDED Requirements

### Requirement: Consulta de usuarios con datos personales extendidos
El sistema MUST devolver en el SP de consulta de usuarios los campos personales `lastName`, `middleName`, `firstName`, `identification` y `phone` para cada usuario, manteniendo el contrato estandar de respuesta.

#### Scenario: Consulta exitosa con campos extendidos
- **WHEN** se ejecuta la consulta de usuarios con filtros validos
- **THEN** el sistema SHALL retornar `result_code`, `result_message` y columnas de usuario incluyendo los cinco campos personales requeridos

### Requirement: Compatibilidad de salida para consumidores actuales
El sistema SHALL mantener las columnas existentes del listado de usuarios para no romper integraciones actuales que dependen del SP.

#### Scenario: Consumidor existente sigue funcionando
- **WHEN** un consumidor actual procesa la salida previa del SP de usuarios
- **THEN** el sistema SHALL conservar las columnas existentes y agregar los nuevos campos sin eliminar datos previos

### Requirement: Validacion de filtros en consulta
El sistema MUST validar que los filtros opcionales de estado sigan las reglas definidas para el SP de listado.

#### Scenario: Estado invalido en filtro
- **WHEN** se envía un valor de estado distinto de `A` o `I`
- **THEN** el sistema SHALL retornar un `result_code` de validacion y no ejecutar la consulta de datos
