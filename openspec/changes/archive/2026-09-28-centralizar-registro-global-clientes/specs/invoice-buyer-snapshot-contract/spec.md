## ADDED Requirements

### Requirement: Future invoices reference clients within the same tenant

When the invoice module is introduced, an invoice SHALL reference its client through the composite pair `(CompanyId, ClientId)` backed by `Client(ClientId, CompanyId)`. It SHALL not allow a client belonging to another company.

#### Scenario: Cross-tenant invoice client is rejected

- **WHEN** an invoice for Company A is assigned a client that belongs to Company B
- **THEN** the database SHALL reject the reference

### Requirement: Future invoices retain immutable buyer fiscal snapshots

When issued, an invoice SHALL persist `BuyerIdentificationType`, `BuyerIdentification`, `BuyerLegalName`, `BuyerAddress`, and `BuyerEmail` as buyer snapshots. Those values SHALL NOT be derived at read time from editable `Person`, `PersonIdentification`, `TaxRegistration`, or `Client` records, and SHALL be immutable after issuance.

#### Scenario: Buyer data changes after invoice issuance

- **WHEN** a tenant changes a client's address/email or the global identity legal name after an invoice is issued
- **THEN** the invoice buyer snapshot SHALL remain unchanged
