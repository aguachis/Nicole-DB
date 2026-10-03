# Diagrama detallado de base de datos

Este diagrama es un reflejo del DDL base de `database/tables/`. Debe actualizarse junto con ese DDL: cada tabla y cada columna física, incluida una columna calculada, debe aparecer aquí.

```mermaid
erDiagram
    EntityStatus {
        char StatusCode PK
        nvarchar StatusName UK
        nvarchar StatusDescription
        bit IsActive
        tinyint SortOrder
        datetime2 CreatedAt
        datetime2 UpdatedAt
    }
    IdentificationType {
        char IdentificationTypeId PK
        varchar Code UK
        nvarchar Name UK
        nvarchar Description
        tinyint MinLength
        tinyint MaxLength
        bit IsNumericOnly
        bit AllowsNaturalPerson
        bit AllowsLegalEntity
        bit IsBillingAllowed
        bit IsActive
        char Status FK
        datetime2 CreatedAt
        datetime2 UpdatedAt
    }
    PersonType {
        char PersonTypeId PK
        nvarchar Name UK
        nvarchar Description
        char Status FK
        datetime2 CreatedAt
        datetime2 UpdatedAt
    }
    Person {
        uniqueidentifier PersonId PK
        char PersonKind FK
        nvarchar LegalName
        nvarchar TradeName
        char Status FK
        nvarchar CreatedBy
        datetime2 CreatedAt
        nvarchar UpdatedBy
        datetime2 UpdatedAt
    }
    PersonIdentification {
        bigint PersonIdentificationId PK
        uniqueidentifier PersonId FK
        char IdentificationTypeId FK
        nvarchar Identification
        nvarchar NormalizedIdentification "computed persisted"
        bit IsPrimary
        datetime2 CreatedAt
        uniqueidentifier CreatedByUserId FK
        datetime2 UpdatedAt
        uniqueidentifier UpdatedByUserId FK
    }
    Company {
        uniqueidentifier CompanyId PK
        nvarchar Identification UK
        nvarchar TradeName
        nvarchar BusinessName
        nvarchar MainAddress
        nvarchar Email
        bit IsAccountingRequired
        nvarchar SpecialTaxpayer
        char Status FK
        uniqueidentifier RepresentativeId FK
        uniqueidentifier ParentCompanyId FK
        nvarchar TaxpayerType
        nvarchar ArtisanQualification
        varchar Environment
        varchar Currency
        varchar Timezone
        varchar LanguageCode
        nvarchar CreatedBy
        datetime2 CreatedAt
        nvarchar UpdatedBy
        datetime2 UpdatedAt
    }
    CompanyBranch {
        uniqueidentifier CompanyBranchId PK
        uniqueidentifier CompanyId FK
        varchar EstablishmentCode
        nvarchar BranchName
        nvarchar Address
        nvarchar Phone
        nvarchar Email
        int City
        char Province
        char Status FK
        nvarchar CreatedBy
        datetime2 CreatedAt
        nvarchar UpdatedBy
        datetime2 UpdatedAt
    }
    CompanyEmissionPoint {
        uniqueidentifier CompanyEmissionPointId PK
        uniqueidentifier CompanyBranchId FK
        varchar EmissionPointCode
        nvarchar Name
        char Status FK
        nvarchar CreatedBy
        datetime2 CreatedAt
        nvarchar UpdatedBy
        datetime2 UpdatedAt
    }
    AppUser {
        uniqueidentifier UserId PK
        uniqueidentifier PersonId FK
        uniqueidentifier CompanyId FK
        nvarchar Username
        nvarchar PasswordHash
        nvarchar Email UK
        bit IsBlocked
        bit RequiresNewPassword
        bit MustUpdate
        char Status FK
        nvarchar CreatedBy
        datetime2 CreatedAt
        nvarchar UpdatedBy
        datetime2 UpdatedAt
    }
    UserProfile {
        uniqueidentifier UserProfileId PK
        uniqueidentifier UserId FK
        uniqueidentifier CompanyId FK
        uniqueidentifier ProfileId FK
        char Status FK
        nvarchar CreatedBy
        datetime2 CreatedAt
        nvarchar UpdatedBy
        datetime2 UpdatedAt
    }
    UserProfileAudit {
        bigint UserProfileAuditId PK
        uniqueidentifier UserId FK
        uniqueidentifier CompanyId FK
        uniqueidentifier ProfileId FK
        varchar OperationCode
        nvarchar Actor
        datetime2 OccurredAt
    }
    Profile {
        uniqueidentifier ProfileId PK
        uniqueidentifier CompanyId FK
        nvarchar Name
        nvarchar Description
        char Status FK
        nvarchar CreatedBy
        datetime2 CreatedAt
        nvarchar UpdatedBy
        datetime2 UpdatedAt
    }
    Permission {
        uniqueidentifier PermissionId PK
        nvarchar Code UK
        nvarchar Name
        nvarchar Description
        nvarchar ModuleCode
        char Status FK
        nvarchar CreatedBy
        datetime2 CreatedAt
        nvarchar UpdatedBy
        datetime2 UpdatedAt
    }
    ProfilePermission {
        uniqueidentifier ProfilePermissionId PK
        uniqueidentifier ProfileId FK
        uniqueidentifier PermissionId FK
        char Status FK
        nvarchar CreatedBy
        datetime2 CreatedAt
        nvarchar UpdatedBy
        datetime2 UpdatedAt
    }
    Client {
        uniqueidentifier ClientId PK
        uniqueidentifier CompanyId FK
        uniqueidentifier PersonId FK
        bigint DefaultBillingIdentificationId FK
        nvarchar BillingAddress
        nvarchar Phone
        nvarchar Email
        decimal CreditLimit
        smallint PaymentTermDays
        nvarchar AccountsReceivable
        char Status FK
        nvarchar Remarks
        nvarchar CreatedBy
        datetime2 CreatedAt
        nvarchar UpdatedBy
        datetime2 UpdatedAt
    }

    EntityStatus ||--o{ IdentificationType : Status
    EntityStatus ||--o{ PersonType : Status
    EntityStatus ||--o{ Person : Status
    EntityStatus ||--o{ Company : Status
    EntityStatus ||--o{ CompanyBranch : Status
    EntityStatus ||--o{ CompanyEmissionPoint : Status
    EntityStatus ||--o{ AppUser : Status
    EntityStatus ||--o{ UserProfile : Status
    EntityStatus ||--o{ Profile : Status
    EntityStatus ||--o{ Permission : Status
    EntityStatus ||--o{ ProfilePermission : Status
    EntityStatus ||--o{ Client : Status
    PersonType ||--o{ Person : PersonKind
    Person ||--o{ PersonIdentification : PersonId
    IdentificationType ||--o{ PersonIdentification : IdentificationTypeId
    AppUser o|--o{ PersonIdentification : CreatedByUserId
    AppUser o|--o{ PersonIdentification : UpdatedByUserId
    Person ||--o{ AppUser : PersonId
    Person ||--o{ Company : RepresentativeId
    Company o|--o{ Company : ParentCompanyId
    Company ||--o{ CompanyBranch : CompanyId
    CompanyBranch ||--o{ CompanyEmissionPoint : CompanyBranchId
    Company ||--o{ Profile : CompanyId
    Company ||--o{ AppUser : CompanyId
    AppUser ||--o{ UserProfile : UserId_and_CompanyId
    Profile ||--o{ UserProfile : ProfileId_and_CompanyId
    UserProfile ||--o{ UserProfileAudit : UserId_and_ProfileId
    Profile ||--o{ ProfilePermission : ProfileId
    Permission ||--o{ ProfilePermission : PermissionId
    Company ||--o{ Client : CompanyId
    Person ||--o{ Client : PersonId
    PersonIdentification ||--o{ Client : DefaultBillingIdentificationId_and_PersonId
```

## Restricciones compuestas y filtradas

Las siguientes claves no pueden expresarse como una marca en una sola columna del diagrama y se conservan aquí para completar la lectura del modelo:

| Tabla | Restricción |
|---|---|
| `CompanyBranch` | `UQ_CompanyBranch_Company_EstablishmentCode (CompanyId, EstablishmentCode)` |
| `CompanyEmissionPoint` | `UQ_CompanyEmissionPoint_Branch_EmissionPointCode (CompanyBranchId, EmissionPointCode)` |
| `Profile` | `UQ_Profile_Company_Name (CompanyId, Name)` y `UQ_Profile_ProfileId_CompanyId (ProfileId, CompanyId)` |
| `ProfilePermission` | `UQ_ProfilePermission_Profile_Permission (ProfileId, PermissionId)` |
| `AppUser` | Clave `UQ_AppUser_UserId_CompanyId` para la FK compuesta de asignaciones; no almacena `ProfileId`. |
| `UserProfile` | `UQ_UserProfile_User_Profile (UserId, ProfileId)` evita duplicados; FKs compuestas a `AppUser (UserId, CompanyId)` y `Profile (ProfileId, CompanyId)`. |
| `UserProfileAudit` | FKs sin cascada a `UserProfile`, `AppUser` y `Profile`; eventos append-only identificados por `OperationCode`, `Actor` y `OccurredAt`. |
| `PersonIdentification` | `UQ_PersonIdentification_Type_Normalized (IdentificationTypeId, NormalizedIdentification)`, `UQ_PersonIdentification_Id_Person (PersonIdentificationId, PersonId)` y el índice filtrado `UX_PersonIdentification_OnePrimaryPerPerson (PersonId) WHERE IsPrimary = 1` |
| `Client` | `UQ_Client_Company_Person (CompanyId, PersonId)`, `UQ_Client_Client_Company (ClientId, CompanyId)` y FK de facturación `(DefaultBillingIdentificationId, PersonId)` a `PersonIdentification (PersonIdentificationId, PersonId)` |
