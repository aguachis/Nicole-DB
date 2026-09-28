## ADDED Requirements

### Requirement: Alta de usuario con aprovisionamiento de persona
El sistema MUST permitir crear usuarios enviando los datos necesarios de persona y crear la persona automaticamente cuando no exista una coincidencia valida por identificacion.

#### Scenario: Persona no existe y se crea junto al usuario
- **WHEN** se ejecuta el alta de usuario con identificacion valida de persona no existente
- **THEN** el sistema SHALL crear primero la persona y luego el usuario en una misma transaccion con `result_code = 0`

#### Scenario: Persona existente se reutiliza
- **WHEN** se ejecuta el alta y ya existe una persona activa con la misma identificacion
- **THEN** el sistema SHALL reutilizar el `PersonId` existente y crear solo el usuario

### Requirement: Validaciones de duplicidad para usuario
El sistema SHALL impedir la creacion de usuario cuando el email o username ya existan de acuerdo con las reglas vigentes de unicidad.

#### Scenario: Email duplicado
- **WHEN** se intenta crear un usuario con email ya registrado
- **THEN** el sistema SHALL retornar codigo funcional de duplicidad y no crear persona/usuario adicional

#### Scenario: Username duplicado
- **WHEN** se intenta crear un usuario con username ya registrado
- **THEN** el sistema SHALL retornar codigo funcional de duplicidad y no crear usuario

### Requirement: Contrato estandar y consistencia transaccional
El sistema MUST devolver `result_code` y `result_message` junto a dataset de salida y garantizar rollback completo si ocurre error tecnico durante el flujo de creacion.

#### Scenario: Error tecnico durante insercion
- **WHEN** ocurre un error tecnico luego de crear persona pero antes de confirmar usuario
- **THEN** el sistema SHALL revertir la transaccion completa y devolver `result_code` tecnico
