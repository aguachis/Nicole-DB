## MODIFIED Requirements

### Requirement: Explicit source-column mapping by functional key
The system MUST define and document an explicit mapping from each functional key to physical source columns to avoid ambiguous transformations.

#### Scenario: Resolve source fields for status catalog
- **WHEN** the client requests `STATUS`
- **THEN** the lookup SHALL map `StatusCode` to `value`, `StatusName` to `label`, and `StatusDescription` to `description`

#### Scenario: Resolve source fields for identification catalog
- **WHEN** the client requests `IDENTIFICATION`
- **THEN** the lookup SHALL map the stable `Code` to `value`, `Name` to `label`, and `Description` to `description`
- **AND** it SHALL NOT expose `IdentificationTypeId` as the selectable value

#### Scenario: Resolve source fields for person type catalog
- **WHEN** the client requests `PERSON_TYPE`
- **THEN** the lookup SHALL map `PersonTypeId` to `value`, `Name` to `label`, and `Description` to `description`

### Requirement: Backward-compatible contract evolution
The system MUST preserve the canonical response shape while allowing optional fields for future growth. A deliberate value-semantic change SHALL be documented as breaking and coordinated with every backend and frontend consumer.

#### Scenario: Identification value moves from physical ID to stable code
- **WHEN** the client requests `IDENTIFICATION` after this change is installed
- **THEN** `value` SHALL contain `Code` rather than `IdentificationTypeId`
- **AND** the integration documentation SHALL identify the change as breaking for consumers of the prior value
