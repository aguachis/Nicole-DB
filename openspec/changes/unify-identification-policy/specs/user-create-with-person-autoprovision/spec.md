## MODIFIED Requirements

### Requirement: Alta de usuario con aprovisionamiento de persona
El sistema MUST permitir crear usuarios enviando los datos necesarios de persona y crear la persona automaticamente cuando no exista una coincidencia valida por identificacion. Cuando `PersonId` no sea recibido, el alta SHALL recibir el `Code` estable de tipo de identificacion y aplicar la politica comun para persona natural antes de buscar o crear la persona; no SHALL exigir ni exponer `IdentificationTypeId` como contrato de entrada.

#### Scenario: Persona no existe y se crea junto al usuario
- **WHEN** se ejecuta el alta de usuario con codigo de tipo e identificacion valida de persona natural no existente
- **THEN** el sistema SHALL crear primero la persona y luego el usuario en una misma transaccion con `result_code = 0`

#### Scenario: Persona existente se reutiliza
- **WHEN** se ejecuta el alta y ya existe una persona activa con la misma identificacion resuelta por su codigo de tipo
- **THEN** el sistema SHALL reutilizar el `PersonId` existente y crear solo el usuario

#### Scenario: Tipo de identificacion no disponible
- **WHEN** el alta recibe un codigo inexistente o cuyo tipo no tiene `Status = 'A'`
- **THEN** el sistema SHALL devolver un error funcional
- **AND** no SHALL crear persona ni usuario
