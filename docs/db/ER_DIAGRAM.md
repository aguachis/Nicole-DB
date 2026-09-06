# Diagrama entidad-relacion: Nicole

Este diagrama representa el esquema final de instalacion inicial definido en `tables/` y ejecutado por `database/20260905_001_crear_bd_registro_global_clientes.sql`. Se omiten columnas de auditoria para facilitar la lectura.

```mermaid
flowchart LR
    Status[EntityStatus]
    IdType[IdentificationType]
    PersonType[PersonType]
    Person[Person]
    Company[Company]
    Branch[CompanyBranch]
    Emission[CompanyEmissionPoint]
    User[AppUser]
    Profile[Profile]
    Permission[Permission]
    ProfilePermission[ProfilePermission]
    UserCompany[UserCompany]
    UserCompanyProfile[UserCompanyProfile]
    Provider[RegistryProvider]
    PersonId[PersonIdentification]
    Tax[TaxRegistration]
    Activity[EconomicActivity]
    TaxActivity[TaxRegistrationEconomicActivity]
    Verification[PersonVerification]
    Audit[RegistryAccessAudit]
    Client[Client]

    Status --> IdType
    Status --> PersonType
    Status --> Person
    Status --> Company
    Status --> Branch
    Status --> Emission
    Status --> User
    Status --> Profile
    Status --> Permission
    Status --> ProfilePermission
    Status --> UserCompany
    Status --> UserCompanyProfile
    Status --> Client

    PersonType --> Person
    Person --> User
    Person --> Company
    Company --> Company
    Company --> Branch --> Emission
    Company --> Profile
    User --> UserCompany
    Company --> UserCompany
    UserCompany --> UserCompanyProfile
    Profile --> UserCompanyProfile
    Profile --> ProfilePermission
    Permission --> ProfilePermission

    Person --> PersonId
    IdType --> PersonId
    Provider --> Tax
    PersonId --> Tax
    Tax --> TaxActivity
    Activity --> TaxActivity
    PersonId --> Verification
    Provider --> Verification

    Company --> Client
    Person --> Client
    PersonId --> Client
    Company --> Audit
    User --> Audit
    PersonId --> Audit
    Provider --> Audit
```

## Claves y relaciones relevantes

| Entidad | PK / clave candidata | Relaciones |
| --- | --- | --- |
| `Person` | `PersonId` | Maestro global. `PersonKind` referencia `PersonType`. |
| `PersonIdentification` | `PersonIdentificationId`; única `(IdentificationTypeId, NormalizedIdentification)`; candidata `(PersonIdentificationId, PersonId)` | Pertenece a una `Person` y tiene un `IdentificationType`. |
| `TaxRegistration` | `TaxRegistrationId`; única `PersonIdentificationId` | Solo una por identidad RUC; referencia proveedor. |
| `TaxRegistrationEconomicActivity` | `TaxRegistrationEconomicActivityId`; única `(TaxRegistrationId, EconomicActivityId)` | Relación N:M entre RUC y actividad. |
| `Client` | `ClientId`; única `(CompanyId, PersonId)` y `(ClientId, CompanyId)` | Relación comercial local entre empresa y persona. |
| `RegistryAccessAudit` | `RegistryAccessAuditId` | Registra consulta por empresa, usuario, identidad y proveedor opcionales. |

La FK `Client(DefaultBillingIdentificationId, PersonId)` hacia `PersonIdentification(PersonIdentificationId, PersonId)` garantiza que la identificacion de cobro pertenece a la persona del cliente. La clave `(ClientId, CompanyId)` se reserva para la FK compuesta de una futura `Invoice`.
