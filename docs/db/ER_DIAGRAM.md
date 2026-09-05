# Diagrama entidad–relación

Este diagrama se genera a partir de los scripts canónicos de `tables/`. Incluye las claves primarias, las claves foráneas y los campos funcionales más relevantes. Las columnas de auditoría se omiten para mantener la lectura clara.

```mermaid
erDiagram
    ENTITY_STATUS {
        char StatusCode PK
        nvarchar StatusName
        bit IsActive
        tinyint SortOrder
    }

    IDENTIFICATION_TYPE {
        char IdentificationTypeId PK
        nvarchar Name
        char Status FK
    }

    PERSON_TYPE {
        char PersonTypeId PK
        nvarchar Name
        char Status FK
    }

    PERSON {
        uniqueidentifier PersonId PK
        char IdentificationType FK
        nvarchar Identification
        char PersonType FK
        nvarchar FirstName
        nvarchar LastName
        nvarchar BusinessName
        nvarchar Email
        char Status FK
    }

    COMPANY {
        uniqueidentifier CompanyId PK
        nvarchar Identification
        nvarchar TradeName
        nvarchar BusinessName
        uniqueidentifier RepresentativeId FK "nullable"
        uniqueidentifier ParentCompanyId FK "nullable"
        char Status FK
    }

    COMPANY_BRANCH {
        uniqueidentifier CompanyBranchId PK
        uniqueidentifier CompanyId FK
        varchar EstablishmentCode
        nvarchar BranchName
        char Status FK
    }

    COMPANY_EMISSION_POINT {
        uniqueidentifier CompanyEmissionPointId PK
        uniqueidentifier CompanyBranchId FK
        varchar EmissionPointCode
        nvarchar Name
        char Status FK
    }

    APP_USER {
        uniqueidentifier UserId PK
        uniqueidentifier PersonId FK
        nvarchar Username
        nvarchar Email
        bit IsBlocked
        char Status FK
    }

    PROFILE {
        uniqueidentifier ProfileId PK
        uniqueidentifier CompanyId FK
        nvarchar Name
        char Status FK
    }

    PERMISSION {
        uniqueidentifier PermissionId PK
        nvarchar Code
        nvarchar Name
        nvarchar ModuleCode
        char Status FK
    }

    PROFILE_PERMISSION {
        uniqueidentifier ProfilePermissionId PK
        uniqueidentifier ProfileId FK
        uniqueidentifier PermissionId FK
        char Status FK
    }

    USER_COMPANY {
        uniqueidentifier UserCompanyId PK
        uniqueidentifier UserId FK
        uniqueidentifier CompanyId FK
        char Status FK
    }

    USER_COMPANY_PROFILE {
        uniqueidentifier UserCompanyProfileId PK
        uniqueidentifier UserCompanyId FK
        uniqueidentifier CompanyId FK
        uniqueidentifier ProfileId FK
        char Status FK
    }

    CLIENT {
        uniqueidentifier ClientId PK
        uniqueidentifier CompanyId FK
        uniqueidentifier PersonId FK
        nvarchar Identification
        nvarchar BusinessName
        char Status FK
    }

    ENTITY_STATUS ||--o{ IDENTIFICATION_TYPE : "estado"
    ENTITY_STATUS ||--o{ PERSON_TYPE : "estado"
    ENTITY_STATUS ||--o{ PERSON : "estado"
    ENTITY_STATUS ||--o{ COMPANY : "estado"
    ENTITY_STATUS ||--o{ COMPANY_BRANCH : "estado"
    ENTITY_STATUS ||--o{ COMPANY_EMISSION_POINT : "estado"
    ENTITY_STATUS ||--o{ APP_USER : "estado"
    ENTITY_STATUS ||--o{ PROFILE : "estado"
    ENTITY_STATUS ||--o{ PERMISSION : "estado"
    ENTITY_STATUS ||--o{ PROFILE_PERMISSION : "estado"
    ENTITY_STATUS ||--o{ USER_COMPANY : "estado"
    ENTITY_STATUS ||--o{ USER_COMPANY_PROFILE : "estado"
    ENTITY_STATUS ||--o{ CLIENT : "estado"

    IDENTIFICATION_TYPE ||--o{ PERSON : "clasifica"
    PERSON_TYPE ||--o{ PERSON : "clasifica"
    PERSON ||--o{ APP_USER : "posee acceso"
    PERSON o|--o{ COMPANY : "representa"
    PERSON ||--o{ CLIENT : "identifica"

    COMPANY o|--o{ COMPANY : "empresa matriz"
    COMPANY ||--o{ COMPANY_BRANCH : "posee"
    COMPANY_BRANCH ||--o{ COMPANY_EMISSION_POINT : "posee"
    COMPANY ||--o{ PROFILE : "define"
    COMPANY ||--o{ USER_COMPANY : "asocia usuarios"
    COMPANY ||--o{ CLIENT : "registra"

    APP_USER ||--o{ USER_COMPANY : "pertenece mediante"
    PROFILE ||--o{ PROFILE_PERMISSION : "recibe"
    PERMISSION ||--o{ PROFILE_PERMISSION : "se asigna mediante"
    USER_COMPANY ||--o{ USER_COMPANY_PROFILE : "recibe perfiles"
    PROFILE ||--o{ USER_COMPANY_PROFILE : "se asigna mediante"
```

## Notas del modelo

- `Company.ParentCompanyId` permite una jerarquía opcional entre empresas.
- `Company.RepresentativeId` es opcional; cuando tiene valor referencia a `Person`.
- `ProfilePermission` resuelve la relación muchos-a-muchos entre perfiles y permisos.
- `UserCompany` resuelve la relación muchos-a-muchos entre usuarios y empresas.
- `UserCompanyProfile` usa claves foráneas compuestas con `CompanyId` para impedir que se asigne a un usuario un perfil perteneciente a otra empresa.
- Todas las relaciones de estado apuntan al catálogo compartido `EntityStatus`.
