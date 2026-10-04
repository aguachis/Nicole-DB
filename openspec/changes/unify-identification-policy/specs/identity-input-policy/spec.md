## ADDED Requirements

### Requirement: Politica comun de captura de identificaciones
El sistema SHALL resolver un `Code` unico de `IdentificationType` a su `IdentificationTypeId` interno y, antes de crear una `PersonIdentification`, validar que el tipo tenga `Status = 'A'`, que el valor normalizado cumpla `MinLength` y `MaxLength`, que cumpla `IsNumericOnly` cuando aplique y que sea admisible para el `PersonKind` solicitado. La politica SHALL reutilizar `dbo.fn_NormalizeIdentification` para la comparacion y las claves internas no SHALL formar parte del contrato publico de captura.

#### Scenario: Captura valida para persona juridica
- **WHEN** una ruta autorizada recibe el `Code` de un tipo activo que permite personas juridicas y una identificacion normalizada que satisface su metadata
- **THEN** el sistema SHALL resolver el `IdentificationTypeId` interno y permitir que la ruta cree o reutilice la identidad global

#### Scenario: Captura con caracteres no admitidos
- **WHEN** una ruta autorizada recibe un tipo activo con `IsNumericOnly = 1` y la identificacion normalizada contiene caracteres no numericos
- **THEN** el sistema SHALL devolver un error funcional de identificacion invalida
- **AND** no SHALL crear ni modificar `Person` o `PersonIdentification`

#### Scenario: Tipo incompatible con la clase de persona
- **WHEN** una ruta intenta crear una persona natural con un tipo que no permite personas naturales
- **THEN** el sistema SHALL rechazar la captura como identificacion invalida
- **AND** no SHALL crear una identidad global

### Requirement: Vigencia unica para tipos de identificacion
El sistema SHALL determinar la vigencia de `IdentificationType` exclusivamente mediante `Status`; `Status = 'A'` SHALL significar que el tipo puede seleccionarse, resolverse para captura y usarse para una nueva identificacion de facturacion. El DDL base SHALL NOT definir una segunda bandera editable de vigencia para ese catalogo.

#### Scenario: Tipo inactivo no aparece ni se admite
- **WHEN** un tipo tiene un `Status` distinto de `A`
- **THEN** el lookup por defecto SHALL excluirlo
- **AND** la politica comun SHALL rechazarlo para crear una identificacion o seleccionarlo para facturacion

#### Scenario: Identificacion historica de tipo inactivo
- **WHEN** una `PersonIdentification` existente pertenece a un tipo que despues queda inactivo
- **THEN** el sistema SHALL conservar la relacion historica y su clave interna
- **AND** SHALL rechazar la seleccion de esa identificacion como nueva identificacion predeterminada de facturacion mientras el tipo siga inactivo
