## ADDED Requirements

### Requirement: Client creation reuses or atomically creates the global person
The system SHALL allow an authorized company to create a client from a `Person` resolved globally by exact identification or from confirmed manual identity fields when no global person exists. It SHALL perform the missing-person path atomically so that `Person`, `PersonIdentification`, and `Client` are either all created or none are created.

#### Scenario: Two companies register the same new identification concurrently
- **WHEN** two authorized client-creation requests for the same normalized identification reach the system concurrently
- **THEN** the system SHALL retain one global `PersonIdentification` and one associated `Person`
- **AND** it SHALL create the permitted tenant-specific `Client` relationships without duplicating the identity

#### Scenario: Existing person becomes a client of another company
- **WHEN** an authorized company confirms an existing global person and supplies valid local client fields
- **THEN** the system SHALL create a `Client` for that company
- **AND** it SHALL not require or persist any external-service verification

## MODIFIED Requirements

### Requirement: Tenant contact data remains isolated
The system SHALL require nonblank `BillingAddress`, `Phone`, and `Email` on the client relationship. It SHALL NOT copy a value from an external cédula or RUC response, nor any contact detail of another company, into a tenant's client record automatically. A backend-provided suggestion SHALL be stored as `BillingAddress`, `Phone`, or `Email` only after explicit tenant-scoped user input.

#### Scenario: External address is only a suggestion

- **WHEN** an external lookup provides an address or phone while an actor creates a client
- **THEN** the system SHALL treat the value only as a form suggestion
- **AND** it SHALL persist it on `Client` only when the actor explicitly submits it for the active company
