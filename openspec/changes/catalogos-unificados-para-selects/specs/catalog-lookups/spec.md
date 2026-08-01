## ADDED Requirements

### Requirement: Unified catalog lookup by key
The system SHALL expose a unified catalog lookup that allows the UI to request catalog data by a stable functional key.

#### Scenario: Request the status catalog
- **WHEN** the client requests the catalog lookup using the key `STATUS`
- **THEN** the system returns the catalog items that represent the canonical entity status values

#### Scenario: Request the identification catalog
- **WHEN** the client requests the catalog lookup using the key `IDENTIFICATION`
- **THEN** the system returns the catalog items that represent the available identification types

#### Scenario: Request the person type catalog
- **WHEN** the client requests the catalog lookup using the key `PERSON_TYPE`
- **THEN** the system returns the catalog items that represent the available person types

### Requirement: Active items by default
The system SHALL return only active catalog records by default when serving lookup data for the supported keys.

#### Scenario: Return only active records
- **WHEN** the client requests any supported catalog key without an explicit inactive-record override
- **THEN** the system returns only active records from the source catalog

### Requirement: Normalized catalog item shape
The system SHALL return catalog lookup results using a normalized item shape suitable for select components.

#### Scenario: Receive a catalog response
- **WHEN** the client receives lookup data for any supported key
- **THEN** each item includes a stable value, a display label, and optional descriptive text

### Requirement: Unsupported catalog keys are rejected
The system SHALL reject requests for catalog keys that are not part of the supported lookup set.

#### Scenario: Request an unknown key
- **WHEN** the client requests a lookup with an unsupported key
- **THEN** the system returns a validation or business error indicating the key is not available