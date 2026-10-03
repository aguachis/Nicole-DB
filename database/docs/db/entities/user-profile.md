# Revision de Entidad - UserProfile

## Estado

Definicion objetivo para la base nueva. El usuario conserva una sola empresa y puede tener varias asignaciones de perfil dentro de ella.

## Tabla

`dbo.UserProfile`

## Objetivo

Representar las asignaciones actuales de perfiles a usuarios. Las asignaciones revocadas se conservan inactivas para permitir reactivarlas sin duplicar la relacion. El perfil activo se elige por sesion y no se guarda en `AppUser`.

## Campos y restricciones

| Campo | Tipo SQL | Nulo | Regla |
| --- | --- | --- | --- |
| `UserProfileId` | `uniqueidentifier` | No | PK surrogate; default `newsequentialid()`. |
| `UserId` | `uniqueidentifier` | No | Usuario al que se asigna el perfil. |
| `CompanyId` | `uniqueidentifier` | No | Empresa unica del usuario. |
| `ProfileId` | `uniqueidentifier` | No | Perfil perteneciente a `CompanyId`. |
| `Status` | `char(1)` | No | Estado de la asignacion; default `A`. |
| `CreatedBy` | `nvarchar(80)` | No | Actor de la primera asignacion. |
| `CreatedAt` | `datetime2(0)` | No | Fecha de creacion; default `sysdatetime()`. |
| `UpdatedBy` | `nvarchar(80)` | Si | Actor de la ultima reactivacion o revocacion. |
| `UpdatedAt` | `datetime2(0)` | Si | Fecha de la ultima reactivacion o revocacion. |

| Restriccion/indice | Columnas | Regla |
| --- | --- | --- |
| `PK_UserProfile` | `UserProfileId` | Identidad de la fila de asignacion. |
| `UQ_UserProfile_User_Profile` | `UserId`, `ProfileId` | Una sola fila historica por usuario y perfil. |
| `FK_UserProfile_AppUser_Company` | `UserId`, `CompanyId` | Impide que la relacion cambie la empresa del usuario. |
| `FK_UserProfile_Profile_Company` | `ProfileId`, `CompanyId` | Impide asignar un perfil de otra empresa. |
| `FK_UserProfile_Status` | `Status` | Referencia `EntityStatus`. |
| `IX_UserProfile_User_Company_Status` | `UserId`, `CompanyId`, `Status` | Lista perfiles activos por usuario. |
| `IX_UserProfile_Profile_Company_Status` | `ProfileId`, `CompanyId`, `Status` | Encuentra usuarios afectados por un perfil. |

## Ciclo de vida y auditoria

- `P_UserProfile_Assign` crea una nueva asignacion (`ASSIGN`) o reactiva la fila inactiva (`REACTIVATE`); si ya esta activa devuelve `NOOP`.
- `P_UserProfile_Revoke` cambia solo la asignacion objetivo a inactiva (`REVOKE`) y no permite quitar el ultimo perfil activo a un usuario activo.
- Cada transicion efectiva y su fila de `UserProfileAudit` se confirman en la misma transaccion.
- La inactivacion de un perfil se rechaza si dejaria a un usuario activo sin otro perfil activo.
- `P_UserProfile_ListByUser` devuelve solo asignaciones y perfiles activos de la empresa derivada de `AppUser`.

## Archivos relacionados

- DDL: `database/tables/11-create-table-user-profile.sql`
- Auditoria: `database/docs/db/entities/user-profile-audit.md`
- C#: `database/docs/db/entities/user-profile/UserProfile.cs`
- TypeScript: `database/docs/db/entities/user-profile/user-profile.ts`
- Integracion: `database/docs/db/integrations/INTEGRACION_API_USER_SECURITY_MAINTENANCE.md`
