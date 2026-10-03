# Contexto de base de datos para backend

## Instalación inicial

La base se define desde `database/20260905_001_crear_bd_registro_global_clientes.sql` en SQLCMD Mode. El manifiesto crea catálogos, seguridad, personas globales, clientes por empresa y procedimientos públicos.

## Modelo de identidad y clientes

Cada `AppUser` pertenece a una sola empresa tenant (`CompanyId`). Sus perfiles se asignan mediante `UserProfile`, cuyas FKs compuestas garantizan que todos pertenecen a esa misma empresa. Despues de validar las credenciales, el usuario elige un perfil activo para la sesion; las autorizaciones usan solo ese perfil y no combinan permisos. La empresa se obtiene de la identidad autenticada y nunca se acepta como tenant arbitrario desde el cliente.

| Tabla | Propiedad | Función |
| --- | --- | --- |
| `Person` | Global | Persona natural o jurídica, nombre legal y nombre comercial opcional. |
| `PersonIdentification` | Global | Identidad única por tipo y valor normalizado. |
| `Client` | Tenant | Relación comercial y datos de contacto de una `Company` con una `Person`. |

El backend siempre usa `UserId` y `CompanyId` de la sesión. La resolución exige `client.create`, el alta exige `client.create`, el cambio exige `client.update` y la baja exige `client.deactivate`.

`P_Person_ResolveIdentification` busca primero el maestro global por tipo y valor exactos. Si devuelve ausencia, el backend puede consultar un servicio externo y mostrar una sugerencia editable; SQL no realiza HTTP y no conserva datos técnicos ni tributarios de esa consulta.

`P_Client_Create` recibe una persona existente o datos manuales confirmados. En el segundo caso crea `Person`, `PersonIdentification` y `Client` atómicamente. `P_Client_Update` y `P_Client_Deactivate` solo modifican la relación comercial de la empresa activa.

## Relaciones críticas

- `PersonIdentification` es global y única por tipo más identificación normalizada.
- `Client.CompanyId` delimita los contactos y condiciones comerciales.
- `Client(DefaultBillingIdentificationId, PersonId)` prueba que la identificación facturable pertenece a la persona del cliente.
- `Client(ClientId, CompanyId)` queda disponible para una futura FK compuesta de factura.
