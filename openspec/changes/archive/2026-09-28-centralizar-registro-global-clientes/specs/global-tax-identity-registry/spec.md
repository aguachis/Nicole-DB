## ADDED Requirements

### Requirement: Person is the global fiscal-identity master

The system SHALL retain `PersonId` and existing relationships of `Person`, including its relationships to `AppUser` and `Company.RepresentativeId`. It SHALL represent each natural or legal person once as a global fiscal identity with a nonblank legal name, an optional trade name, and an explicit natural/legal classification. It SHALL NOT store tenant-specific portfolio, phone, email, or billing address in `Person`.

#### Scenario: Reuse a verified natural person across companies

- **WHEN** two authorized companies create commercial relationships for the same verified natural person
- **THEN** both relationships SHALL reference one `Person`
- **AND** each company SHALL retain only its own client-contact and commercial data

### Requirement: Identifications are globally unique and belong provably to a person

The system SHALL store fiscal identifications in `PersonIdentification` with their type, display value, persisted normalized value, verification state, verification timestamps, and audit data. It SHALL enforce uniqueness of `(IdentificationTypeId, NormalizedIdentification)`, a candidate key `(PersonIdentificationId, PersonId)`, and at most one primary identification per person.

#### Scenario: Cédula cannot identify two people

- **WHEN** an actor attempts to add a cédula whose normalized type/value already belongs to another `Person`
- **THEN** the write SHALL fail
- **AND** no second person-identification relation SHALL be created

#### Scenario: A natural person has cédula and RUC

- **WHEN** verified cédula and verified RUC identify the same natural person
- **THEN** the system SHALL associate both identifications with the same `Person`
- **AND** each identifier SHALL remain globally unique within its type

### Requirement: Identification types express validation and billing policy

The system SHALL maintain, per active identification type, minimum and maximum length, numeric-only requirement, applicability to natural/legal people, billing eligibility, and a stable unique code. Writes SHALL validate an identification against those metadata and the person classification.

#### Scenario: Non-billable identifier cannot be selected for billing

- **WHEN** an actor selects an identifier whose type is not billing-eligible as a default billing identifier
- **THEN** the system SHALL reject the operation

### Requirement: RUC data is a verified registration, not tenant contact data

The system SHALL store a one-to-one `TaxRegistration` for a RUC identification, including tax status, taxpayer class, verified tax address, accounting requirement, start date, source, provider, and verification validity. It SHALL only allow a RUC identification to own a tax registration.

#### Scenario: Sentinel start date is absent

- **WHEN** a provider response contains `0001-01-01` as a start date
- **THEN** the stored `TaxRegistration.StartedAt` SHALL be `NULL`

#### Scenario: Buyer accounting requirement is distinct from issuer accounting requirement

- **WHEN** a buyer RUC has an accounting-requirement value
- **THEN** the system SHALL store it only on that buyer's `TaxRegistration`
- **AND** it SHALL NOT update or derive `Company.IsAccountingRequired`

### Requirement: Economic activities are reusable and provider IDs are not Nicole keys

The system SHALL maintain an `EconomicActivity` catalog keyed by Nicole's activity key and reusable activity code, and a registration-to-activity relation supporting multiple activities and one optional primary activity. Provider activity IDs SHALL be stored only as opaque provider references and SHALL NOT be a primary key, foreign key, or business key of Nicole.

#### Scenario: Multiple activities can be retained for one RUC

- **WHEN** a RUC provider reports more than one economic activity
- **THEN** the system SHALL associate each distinct catalog activity with the RUC registration
- **AND** it SHALL allow at most one association to be primary
