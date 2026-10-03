## MODIFIED Requirements

### Requirement: External registries are called only by backend services
The backend SHALL be the only component that invokes an external cédula or RUC service after an exact global-identity miss. SQL Server SHALL not open HTTP connections or store provider credentials. Neither SQL Server nor the backend persistence contract SHALL retain provider identity, raw response, technical result, failure, timeout, hash, correlation, query time, or expiration as part of the global-person or client-registration flow.

#### Scenario: SQL resolution has no network or persistence side effect

- **WHEN** a client-resolution request reaches the database interface
- **THEN** SQL Server SHALL return only a matching global identity or a not-found result
- **AND** it SHALL neither call an external service nor write a provider-related record

## REMOVED Requirements

### Requirement: Verification cache has explicit validity
**Reason**: La reutilización se basa en la identidad global confirmada y no en una verificación externa con proveedor, vigencia o caché técnico.

**Esquema inicial**: No definir `PersonVerification`, `RegistryProvider` ni las columnas de estado, consulta y vencimiento de `PersonIdentification`.

## MODIFIED Requirements

### Requirement: Registry records minimize retained data
The system SHALL persist only the global identity fields confirmed for `Person` and `PersonIdentification`, and the tenant-specific client fields confirmed for `Client`. It SHALL NOT persist raw provider JSON, provider UUIDs, spouse, parents, profession, education, sex, marital status, date or place of birth, tax status, economic activity, provider-derived address or phone, technical response fields, or a registry-access audit for this flow.

#### Scenario: Provider response contains excluded fields

- **WHEN** an external response contains fields outside the approved identity suggestion
- **THEN** the backend SHALL discard those fields before persistence
- **AND** the database SHALL contain no provider-response or provider-audit row for the request

### Requirement: Effective tenant permissions control global resolution and clients
The system SHALL enforce effective permission and tenant membership using both `UserId` and `CompanyId` for client procedures and global-identity resolution. It SHALL define and enforce `client.read`, `client.create`, `client.update`, and `client.deactivate`; a resolution used to start client creation SHALL require `client.create`. It SHALL deny global discovery by partial identifier, name, wildcard, or listing, and SHALL not use `client.verify`.

#### Scenario: Unauthorized identity resolution is denied without provider persistence

- **WHEN** a user lacks `client.create` or has no membership in the supplied company while resolving an identification for client creation
- **THEN** the operation SHALL be denied before a local result or external lookup is disclosed
- **AND** it SHALL not write a provider or registry-access record
