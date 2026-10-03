# Revision de Entidad - UserProfileAudit

## Tabla

`dbo.UserProfileAudit`

## Objetivo

Conservar append-only el historial de asignaciones, reactivaciones y revocaciones de perfiles, identificando la empresa, usuario, perfil, actor y momento de cada transicion. Es independiente del estado actual almacenado en `UserProfile`.

## Campos y restricciones

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `UserProfileAuditId` | `bigint identity` | No | PK creciente del evento. |
| `UserId` | `uniqueidentifier` | No | Usuario afectado. |
| `CompanyId` | `uniqueidentifier` | No | Empresa unica del usuario y perfil. |
| `ProfileId` | `uniqueidentifier` | No | Perfil afectado. |
| `OperationCode` | `varchar(20)` | No | `ASSIGN`, `REACTIVATE` o `REVOKE`. |
| `Actor` | `nvarchar(80)` | No | Actor que realizo el cambio; no vacio. |
| `OccurredAt` | `datetime2(3)` | No | Fecha UTC; default `sysutcdatetime()`. |

Las claves foraneas a `UserProfile`, `AppUser` y `Profile` no tienen `ON DELETE CASCADE`. `TR_UserProfileAudit_AppendOnly` rechaza `UPDATE` y `DELETE`; el rol de ejecucion no recibe permisos DML directos sobre la tabla.

## Escritura atomica

La insercion del evento se realiza en la misma transaccion que la creacion, reactivacion o revocacion de la fila de `UserProfile`. Si falla el evento, se revierte tambien la asignacion. Las repeticiones `NOOP` no generan eventos.

## Archivo relacionado

- DDL: `database/tables/12-create-table-user-profile-audit.sql`
