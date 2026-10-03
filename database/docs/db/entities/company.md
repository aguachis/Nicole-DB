# Entidad: Company

`dbo.Company` representa la empresa o tenant que opera el ERP. No representa una empresa cliente: una empresa que compra productos o servicios se modela como `Person` con `PersonKind = 'J'` y se vincula mediante `Client`.

Cada usuario de la aplicacion pertenece a exactamente una `Company`; la FK `AppUser.CompanyId` permite muchos usuarios por empresa.

| Relación | Regla |
| --- | --- |
| `Company.RepresentativeId -> Person.PersonId` | Representante legal opcional. |
| `Client.CompanyId -> Company.CompanyId` | Cada cliente pertenece a una empresa activa. |
| `Company.ParentCompanyId -> Company.CompanyId` | Jerarquía empresarial opcional. |

Una identidad global nunca se vuelve propiedad de una empresa por haber sido usada para crear un cliente. La empresa solo controla sus propios contactos, dirección de facturación y condiciones comerciales en `Client`.
