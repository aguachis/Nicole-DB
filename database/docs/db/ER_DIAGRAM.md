# Diagrama entidad-relación: personas globales y clientes

```mermaid
flowchart LR
    Status[EntityStatus]
    IdType[IdentificationType]
    PersonType[PersonType]
    Person[Person]
    PersonId[PersonIdentification]
    Company[Company]
    Branch[CompanyBranch]
    Emission[CompanyEmissionPoint]
    User[AppUser]
    Profile[Profile]
    Permission[Permission]
    ProfilePermission[ProfilePermission]
    UserCompany[UserCompany]
    UserCompanyProfile[UserCompanyProfile]
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
    Person --> PersonId
    IdType --> PersonId
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
    Company --> Client
    Person --> Client
    PersonId --> Client
```

| Entidad | Clave y relación |
| --- | --- |
| `Person` | Maestro global; `PersonKind` referencia `PersonType`. |
| `PersonIdentification` | Única por `(IdentificationTypeId, NormalizedIdentification)`; pertenece a `Person`. |
| `Client` | Única por `(CompanyId, PersonId)`; es local a la empresa. |
| `Client`–`PersonIdentification` | FK compuesta `(DefaultBillingIdentificationId, PersonId)` que garantiza propiedad de la identificación facturable. |
