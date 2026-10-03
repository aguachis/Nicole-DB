## MODIFIED Requirements

### Requirement: Person is the global fiscal-identity master
The system SHALL retain `PersonId` and existing relationships of `Person`, including its relationships to `AppUser` and `Company.RepresentativeId`. It SHALL represent each natural or legal person once as a global identity with a nonblank legal name, an optional trade name, and an explicit natural/legal classification confirmed during registration. It SHALL NOT store tenant-specific portfolio, phone, email, or billing address in `Person`.

#### Scenario: Reuse a confirmed natural person across companies

- **WHEN** two authorized companies create commercial relationships for the same globally registered natural person
- **THEN** both relationships SHALL reference one `Person`
- **AND** each company SHALL retain only its own client-contact and commercial data

### Requirement: Identifications are globally unique and belong provably to a person
The system SHALL store global identifications in `PersonIdentification` with their type, display value, persisted normalized value, primary flag, and creation/update audit data. It SHALL enforce uniqueness of `(IdentificationTypeId, NormalizedIdentification)`, a candidate key `(PersonIdentificationId, PersonId)`, and at most one primary identification per person. It SHALL NOT store external-verification status, verification timestamps, or expiration timestamps on the identification.

#### Scenario: Cédula cannot identify two people

- **WHEN** an actor attempts to add a cédula whose normalized type/value already belongs to another `Person`
- **THEN** the write SHALL fail or reuse the already-resolved person within the atomic client-creation flow
- **AND** no second person-identification relation SHALL be created

#### Scenario: A natural person has cédula and RUC

- **WHEN** an authorized actor confirms that a cédula and RUC belong to the same natural person
- **THEN** the system SHALL associate both identifications with the same `Person`
- **AND** each identifier SHALL remain globally unique within its type

## REMOVED Requirements

### Requirement: RUC data is a verified registration, not tenant contact data
**Reason**: Los campos tributarios y su procedencia de proveedor no son necesarios para el registro manual de clientes y no deben retenerse en esta fase.

**Esquema inicial**: No definir `TaxRegistration`, su trigger ni dependencias de proveedor; los contactos y la dirección de facturación se definen exclusivamente en `Client`.

### Requirement: Economic activities are reusable and provider IDs are not Nicole keys
**Reason**: Las actividades económicas y sus identificadores externos no forman parte de la información requerida en la fase actual.

**Esquema inicial**: No definir `EconomicActivity`, `TaxRegistrationEconomicActivity` ni el tipo de tabla usado por la persistencia del proveedor.
