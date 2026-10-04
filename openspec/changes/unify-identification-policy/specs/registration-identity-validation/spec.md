## ADDED Requirements

### Requirement: Registro inicial valida la identidad de persona natural por codigo funcional
El registro inicial SHALL recibir el `Code` funcional del tipo de identificacion y aplicar la politica comun con `PersonKind = 'N'` antes de buscar o crear la persona representante. El registro SHALL usar internamente el tipo resuelto para la unicidad global y la insercion de `PersonIdentification`.

#### Scenario: Registro con identificacion natural valida
- **WHEN** una solicitud de registro incluye un codigo activo admisible para persona natural y una identificacion que cumple su metadata
- **THEN** el sistema SHALL reutilizar la persona global coincidente o crearla junto con su identificacion y la empresa inicial dentro de la misma transaccion

#### Scenario: Registro con identificacion invalida
- **WHEN** una solicitud de registro incluye un codigo inexistente, inactivo, incompatible, una longitud fuera de rango o caracteres no admitidos
- **THEN** el sistema SHALL devolver un error funcional correspondiente
- **AND** no SHALL crear `Person`, `PersonIdentification`, `Company`, `AppUser` ni relaciones de perfil
