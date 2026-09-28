# catalog-lookup-contract-standardization Specification

## Purpose

TBD

## Requirements

### Requirement: Canonical catalog lookup response for select controls
The system SHALL expose a canonical response shape for supported catalog keys so backend and frontend can consume catalog options without depending on physical table structures.

#### Scenario: Return canonical fields for any supported key
- **WHEN** the client requests `STATUS`, `IDENTIFICATION`, or `PERSON_TYPE`
- **THEN** each returned item SHALL include `value`, `label`, `status`, and optional `description`

### Requirement: Explicit source-column mapping by functional key
The system MUST define and document an explicit mapping from each functional key to physical source columns to avoid ambiguous transformations.

#### Scenario: Resolve source fields for status catalog
- **WHEN** the client requests `STATUS`
- **THEN** the lookup SHALL map `StatusCode` to `value`, `StatusName` to `label`, and `StatusDescription` to `description`

#### Scenario: Resolve source fields for identification catalog
- **WHEN** the client requests `IDENTIFICATION`
- **THEN** the lookup SHALL map `IdentificationTypeId` to `value`, `Name` to `label`, and `Description` to `description`

#### Scenario: Resolve source fields for person type catalog
- **WHEN** the client requests `PERSON_TYPE`
- **THEN** the lookup SHALL map `PersonTypeId` to `value`, `Name` to `label`, and `Description` to `description`

### Requirement: Active-only default behavior with includeInactive override
The system SHALL return only active records by default and MUST support an explicit override to include inactive records.

#### Scenario: Default query excludes inactive records
- **WHEN** the client requests a supported key without setting `includeInactive`
- **THEN** the lookup SHALL return only active records according to each source catalog active rule

#### Scenario: Explicit override includes inactive records
- **WHEN** the client requests a supported key with `includeInactive = true`
- **THEN** the lookup SHALL include inactive and active records

### Requirement: Deterministic ordering strategy across catalogs
The system SHALL return catalog items in deterministic order to ensure consistent UI behavior.

#### Scenario: Source has explicit sort column
- **WHEN** the source catalog provides `SortOrder`
- **THEN** the lookup SHALL order by `SortOrder` and then by `label`

#### Scenario: Source has no explicit sort column
- **WHEN** the source catalog does not provide `SortOrder`
- **THEN** the lookup SHALL order by `label` ascending as fallback

### Requirement: Backward-compatible contract evolution
The system MUST preserve compatibility with the current catalog lookup contract while allowing optional fields for future growth.

#### Scenario: Existing consumers continue to work
- **WHEN** consumers parse the current response fields
- **THEN** the lookup SHALL keep existing field semantics unchanged and only add optional non-breaking fields
