## ADDED Requirements

### Requirement: Company retains issuer fiscal names and has an explicit main address

The system SHALL retain `Company.Identification` as issuer RUC, `Company.BusinessName` as issuer legal name, and `Company.TradeName` as issuer trade name. It SHALL provide a nullable `Company.MainAddress` for the issuer's matrix address.

#### Scenario: No source for a matrix address exists

- **WHEN** a company has no verified or explicitly mapped source for a matrix address during migration
- **THEN** `MainAddress` SHALL remain `NULL`
- **AND** migration SHALL report the row for remediation rather than inventing an address

### Requirement: Company address backfill is evidence based

The migration SHALL only populate `MainAddress` from a source explicitly designated as the company matrix address. It SHALL not copy a client billing address or a buyer RUC tax address into `Company.MainAddress`.

#### Scenario: A client address exists but no company-matrix designation exists

- **WHEN** migration finds client or person addresses but no matrix-address mapping
- **THEN** it SHALL not use those addresses to populate the company
