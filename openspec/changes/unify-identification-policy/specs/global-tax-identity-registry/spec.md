## MODIFIED Requirements

### Requirement: Identification types express validation and billing policy

The system SHALL maintain, per identification type, a stable unique `Code`, minimum and maximum length, numeric-only requirement, applicability to natural/legal people, billing eligibility, and a `Status` governed by the canonical entity-status catalog. `Status = 'A'` SHALL be the sole rule that makes a type available for new identity capture and billing-identifier selection; the system SHALL NOT maintain a second editable active flag for the type. All writes that create a `PersonIdentification` SHALL validate the identification against those metadata and the person classification through the common identity-input policy. The internal `IdentificationTypeId` SHALL remain the foreign-key value of `PersonIdentification` and SHALL NOT be required from external capture contracts.

#### Scenario: Non-billable identifier cannot be selected for billing

- **WHEN** an actor selects an identifier whose active type is not billing-eligible as a default billing identifier
- **THEN** the system SHALL reject the operation

#### Scenario: Inactive type cannot create a new global identity

- **WHEN** an actor supplies the stable code of an identification type whose `Status` is not `A`
- **THEN** the system SHALL reject the write
- **AND** no `PersonIdentification` SHALL be created
