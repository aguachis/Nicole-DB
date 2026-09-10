## Context

The registry/client scripts define five `usp_` database objects, while every existing auth, catalog, and profile procedure already uses the `P_` prefix. The registry object names are also repeated in runtime grants and integration contracts.

## Goals / Non-Goals

**Goals:**
- Apply one canonical name format to every stored procedure object.
- Rename the five nonconforming registry/client objects and every in-repository reference.
- Keep the bootstrap for an empty database internally consistent.

**Non-Goals:**
- Do not rename SQL script filenames, scalar functions, tables, or permissions.
- Do not change procedure signatures, result sets, or business behavior.

## Decisions

1. Use `dbo.P_<Domain>_<Action>` as the sole database-object naming convention.
   - The existing `P_Auth_*`, `P_Profile_*`, and `P_Permission_List` procedures establish this repository convention; the registry procedures will follow it.

2. Keep the date-prefixed registry script filenames and rename only the procedure objects inside them.
   - Filenames convey deployment ordering and change history, while the object name is the API invoked by SQL and backend consumers.

3. Update references atomically within the repository.
   - The manifest, grants, backend context, and registry-client integration contract must use `P_` names in the same release.

4. Do not deploy compatibility wrappers for `usp_` names.
   - The supported deployment target is an empty database, so duplicate public names add ambiguity without a migration benefit.

## Risks / Trade-offs

- [Risk] Existing consumers can still invoke `usp_` names -> Mitigation: mark the change breaking and update every versioned integration contract.
- [Risk] A reference is missed outside the procedure definition -> Mitigation: static-search the repository for `usp_Registry` and `usp_Client`, and validate the manifest and grants together.

## Migration Plan

1. Change the five procedure-object names and their references in the database-definition repository.
2. Bootstrap a new empty database with only the canonical `P_` objects and grants.
3. For an already deployed database, coordinate an explicit DBA migration or a consumer release before removing legacy objects; this repository does not define in-place data migrations.
