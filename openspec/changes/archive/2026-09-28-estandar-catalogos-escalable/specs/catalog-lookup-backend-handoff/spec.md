## ADDED Requirements

### Requirement: Backend handoff markdown document for catalog corrections
The system MUST generate an independent backend handoff document describing the approved catalog lookup corrections and adoption guidance.

#### Scenario: Handoff file is created in integrations folder
- **WHEN** the change is implemented
- **THEN** the repository SHALL contain `docs/db/integrations/INTEGRACION_API_CATALOG_LOOKUPS_BACKEND_HANDOFF.md`

### Requirement: Handoff includes canonical contract and mapping details
The system SHALL include canonical response rules and explicit source mappings in the backend handoff document.

#### Scenario: Handoff describes mandatory and optional fields
- **WHEN** backend engineers read the handoff
- **THEN** the document SHALL define `value`, `label`, `description` optional, `status`, and `sortOrder` optional

#### Scenario: Handoff describes supported key mappings
- **WHEN** backend engineers implement lookup handling
- **THEN** the document SHALL include mapping rules for `STATUS`, `IDENTIFICATION`, and `PERSON_TYPE` with source columns

### Requirement: Handoff includes compatibility and expansion guidance
The system SHALL include compatibility boundaries and future expansion standards for new catalogs.

#### Scenario: Handoff lists compatibility changes
- **WHEN** backend engineers assess migration impact
- **THEN** the document SHALL include a compatibility table describing what changes and what remains unchanged

#### Scenario: Handoff provides standards for future catalogs
- **WHEN** a new catalog is proposed
- **THEN** the document SHALL provide a minimum DDL template recommendation and a checklist to onboard the new catalog into lookup

### Requirement: Handoff includes backend request-response examples
The system SHALL include practical backend examples for request and response to accelerate implementation.

#### Scenario: Backend uses examples to implement endpoint behavior
- **WHEN** engineers consume the handoff document
- **THEN** they SHALL find at least one request example and one response example aligned with the canonical contract
