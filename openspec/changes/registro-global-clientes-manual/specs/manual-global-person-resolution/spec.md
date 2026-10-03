## ADDED Requirements

### Requirement: Backend resolves an exact identity from the global master before external lookup
The backend SHALL resolve a requested identification by its active type code and exact normalized value in `PersonIdentification` before it invokes an external service. The database resolution SHALL return only the global fields required to confirm a client registration: `PersonId`, identification type and value, `PersonKind`, legal name, and optional trade name. It SHALL have no network side effect and SHALL not support name, fragment, wildcard, or global-list searches.

#### Scenario: Existing identification is reused without an external call
- **WHEN** an authorized user requests an exact cédula or RUC already present in `PersonIdentification`
- **THEN** the backend SHALL receive the associated global `Person` data
- **AND** it SHALL not invoke the external service

#### Scenario: Exact identification is not yet global
- **WHEN** an authorized user requests an active type and exact normalized identification that is absent from `PersonIdentification`
- **THEN** the database resolution SHALL report that no global identity exists
- **AND** the backend SHALL be able to invoke its external adapter as the next step

### Requirement: External lookup is transient and reduced to a form suggestion
When the global resolution finds no identity, the backend SHALL be the only component that invokes the cédula or RUC service. It SHALL reduce a successful response to the identification and available name/razón social fields needed by the form, and SHALL discard the external UUID, raw payload, technical result, error, timeout, provider metadata, tax status, economic activity, dates, address, phone, and all other fields outside the manual registration scope.

#### Scenario: RUC lookup provides a business-name suggestion
- **WHEN** a missing RUC lookup returns a nonblank `businessName`
- **THEN** the backend SHALL present it only as an editable legal-name suggestion
- **AND** it SHALL not persist any service-response field before user confirmation

#### Scenario: Lookup fails or lacks a usable name
- **WHEN** the external service times out, returns no match, returns an error, or does not provide a nonblank required legal name
- **THEN** the backend SHALL keep the manual registration path available
- **AND** it SHALL not create a `Person` or persist technical lookup data

### Requirement: Confirmed manual data creates a reusable global identity with the client
The system SHALL create a missing global `Person`, its `PersonIdentification`, and the tenant-scoped `Client` only after the user confirms required manual data. The operation SHALL validate identification metadata and person kind, run atomically, and return the resulting person and client identifiers.

#### Scenario: User completes a client after a provider timeout
- **WHEN** a lookup for a missing identification fails externally and the user enters valid identity and client fields
- **THEN** the system SHALL create the global person and identification together with the client of the active company
- **AND** it SHALL retain no timeout or provider record

### Requirement: Existing global person data is not overwritten during client confirmation
The system SHALL create a `Client` relationship from a confirmed existing `Person` without automatically changing that person's global name, trade name, classification, or identifications. A correction of global master data SHALL require a separate future capability.

#### Scenario: Second company confirms an existing person
- **WHEN** a user of a second authorized company confirms a global person found by exact identification
- **THEN** the system SHALL create only that company's `Client` row and local commercial fields
- **AND** it SHALL leave the global person data unchanged
