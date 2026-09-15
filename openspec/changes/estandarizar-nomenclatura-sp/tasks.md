## 1. Canonical SQL Objects

- [x] 1.1 Rename the five registry/client procedure objects to `dbo.P_Registry_*` and `dbo.P_Client_*`, preserving signatures and result sets; verify no `CREATE OR ALTER PROCEDURE dbo.usp_` remains.

## 2. Runtime and Contract References

- [x] 2.1 Update the SQLCMD bootstrap and `nicole_app` object checks/grants to canonical names; verify every referenced registry/client procedure resolves to its `P_` name.
- [x] 2.2 Update the registry/client integration contract and backend database context; verify a repository search finds no legacy registry/client `usp_` invocation.

## 3. Verification

- [x] 3.1 Validate OpenSpec in strict mode and run static SQL/reference checks plus `git diff --check`; record that no SQL Server instance is executed by this repository.

> Verification note: the repository does not configure a SQL Server instance; validation for this change is static.
