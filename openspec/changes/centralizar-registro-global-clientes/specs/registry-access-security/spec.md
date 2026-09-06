## ADDED Requirements

### Requirement: External registries are called only by backend services

The database SHALL not open HTTP connections or store provider credentials. It SHALL persist only a response already obtained by an authorized backend service through a controlled stored procedure.

#### Scenario: SQL resolution has no network side effect

- **WHEN** a client resolves an identification through the database interface
- **THEN** SQL Server SHALL return eligible cached data or a cache-miss/expired result
- **AND** it SHALL NOT call an external service

### Requirement: Verification cache has explicit validity

The system SHALL record provider, result, queried time, expiration time, correlation ID, and SHA-256 payload hash for every persisted verification. It SHALL treat only a successful verification with a future expiration as a valid cache hit; expired verification requires a backend refresh before it is treated as verified.

#### Scenario: Valid cache is reused

- **WHEN** exact identification resolution finds a verified result whose expiration is in the future
- **THEN** the system SHALL return the cached result without requesting a new provider call
- **AND** it SHALL audit `CacheHit`

#### Scenario: Expired cache is not used as current verification

- **WHEN** the latest verified result has expired
- **THEN** the system SHALL identify it as expired or require refresh
- **AND** backend SHALL be responsible for any new provider request

### Requirement: Registry records minimize retained data

The system SHALL NOT persist spouse, parents, profession, education, sex, marital status, date or place of birth, or raw provider JSON by default. Registry access audit SHALL contain company, user, outcome, occurrence time and minimal technical correlation; it SHALL not duplicate identifier, name, address, payload, or free-text PII.

#### Scenario: Provider payload contains excluded personal fields

- **WHEN** a provider response contains excluded personal fields or raw JSON
- **THEN** the persistence procedure SHALL discard them
- **AND** the audit and verification history SHALL retain only allowed structured data and payload hash

### Requirement: Effective tenant permissions control registry and clients

The system SHALL enforce effective permission and tenant membership using both `UserId` and `CompanyId` for all client/registry procedures. It SHALL define `client.read`, `client.create`, `client.update`, `client.deactivate`, and `client.verify` permissions, and deny global discovery by partial identifier or listing.

#### Scenario: Unauthorized cross-tenant access is denied and audited

- **WHEN** a user lacks the required permission or has no membership in the supplied company
- **THEN** the operation SHALL be denied
- **AND** the system SHALL write a minimal access-audit outcome without PII in clear text
