## ADDED Requirements

### Requirement: Client is a tenant-scoped commercial relationship

The system SHALL model `Client` as the commercial relationship between exactly one `Company` and one global `Person`. It SHALL preserve `ClientId`, `CompanyId`, `PersonId`, `Status`, and audit data; enforce unique `(CompanyId, PersonId)` and unique `(ClientId, CompanyId)`; and keep billing address, phone, email, credit limit, and payment term on this tenant-scoped record.

#### Scenario: Same person can be a client of two tenants

- **WHEN** two companies create a client relationship for one `Person`
- **THEN** both rows SHALL be permitted
- **AND** a duplicate relationship for the same company and person SHALL be rejected

### Requirement: Billing identification must belong to the client person

The system SHALL require a billing-eligible default billing identification for each active client and enforce, with a composite foreign key, that it belongs to the client's `PersonId`.

#### Scenario: Cross-person billing identifier is rejected

- **WHEN** a client is assigned an identification that belongs to a different person
- **THEN** the database SHALL reject the write through referential integrity

### Requirement: Tenant contact data remains isolated

The system SHALL require nonblank `BillingAddress`, `Phone`, and `Email` on the client relationship. It SHALL NOT copy a RUC tax address, phone, email, or any contact detail into another company's client record automatically.

#### Scenario: RUC tax address is only a suggestion

- **WHEN** a verified RUC contains a tax address and an actor creates a client
- **THEN** the system MAY show the address as a suggestion
- **BUT** it SHALL store it as `BillingAddress` only after an explicit tenant-scoped input

### Requirement: Commercial values are extensible and local

The system SHALL support nullable nonnegative `CreditLimit` and nullable `PaymentTermDays` on `Client`. These values SHALL be visible and editable only within the authorized company relationship.

#### Scenario: Tenant cannot update another tenant client

- **WHEN** an authorized user for Company A attempts to update a `ClientId` owned by Company B
- **THEN** the client update SHALL be denied
- **AND** no commercial or contact data SHALL change

### Requirement: Relationship documentation remains synchronized

The database-definition repository SHALL update the entity dictionary, stored-procedure contract, backend/API context, and ER diagram whenever the `Client`–`Company`–`Person` relationship, its keys, or its tenant-isolation rules change. The ER diagram SHALL show the composite contract `Client(ClientId, CompanyId)` and the billing-identification ownership relationship.

#### Scenario: A relationship constraint changes

- **WHEN** a change adds or modifies a key, foreign key, or cardinality involving `Client`, `Company`, `Person`, or `PersonIdentification`
- **THEN** the versioned database definition SHALL include the corresponding documentation and ER-diagram update
- **AND** the change SHALL identify the manual migration artifact that applies the constraint
