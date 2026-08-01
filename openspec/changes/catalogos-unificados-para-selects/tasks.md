## 1. Contract and lookup scope

- [x] 1.1 Confirm the supported keys for the first release: `STATUS`, `IDENTIFICATION`, `PERSON_TYPE`.
- [x] 1.2 Define the normalized response shape for select components.
- [x] 1.3 Document that only active records are returned by default.

## 2. Unified lookup implementation

- [x] 2.1 Implement the catalog lookup entry point using the unified key-based contract.
- [x] 2.2 Map each supported key to its source of truth: `EntityStatus`, `IdentificationType`, `PersonType`.
- [x] 2.3 Reject unsupported keys with a clear validation or business error.

## 3. API and documentation updates

- [x] 3.1 Document the new endpoint pattern `/api/catalogs/{key}`.
- [x] 3.2 Update the integration notes for screens that consume catalog selects.
- [x] 3.3 Keep `Permission` out of the first release and document that it remains a separate contract.

## 4. Validation

- [x] 4.1 Verify that existing catalog consumers can migrate without changing the data source semantics.
- [x] 4.2 Validate that each key maps to a single source of truth.
- [x] 4.3 Confirm that future catalogs such as `ClientType` require their own approved entity and seed before exposure.