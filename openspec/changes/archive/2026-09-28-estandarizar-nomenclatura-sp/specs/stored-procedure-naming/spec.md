## Purpose

Esta capacidad establece una API SQL consistente y reconocible para todos los procedimientos almacenados de Nicole.

## ADDED Requirements

### Requirement: Canonical stored procedure names
The database-definition repository SHALL name every stored procedure `dbo.P_<Domain>_<Action>`, with the `P_` prefix and PascalCase domain and action tokens.

#### Scenario: A procedure is added to the database API
- **WHEN** a new stored procedure is defined in the repository
- **THEN** its database object name SHALL conform to `dbo.P_<Domain>_<Action>`

#### Scenario: Registry and client procedures use canonical names
- **WHEN** the global registry and client module is deployed
- **THEN** it SHALL expose `dbo.P_Registry_ResolveIdentification`, `dbo.P_Registry_PersistVerification`, `dbo.P_Client_Create`, `dbo.P_Client_Update`, and `dbo.P_Client_Deactivate`

### Requirement: Stored procedure references remain synchronized
The SQLCMD bootstrap, runtime grants, and versioned backend/API contracts SHALL reference the canonical stored procedure names.

#### Scenario: An empty database is bootstrapped
- **WHEN** the SQLCMD manifest is executed on an empty database
- **THEN** every created registry/client procedure and every `nicole_app` execute grant SHALL use its canonical `P_` name
- **AND** documented integration examples SHALL invoke the same names

### Requirement: Legacy usp aliases are not deployed
The empty-database bootstrap SHALL not create compatibility aliases or duplicate procedures with the legacy `usp_` naming pattern.

#### Scenario: A consumer attempts to use a legacy registry name
- **WHEN** a consumer invokes a former `dbo.usp_Registry_*` or `dbo.usp_Client_*` name after bootstrap
- **THEN** the consumer SHALL migrate to the corresponding canonical `dbo.P_` procedure name
