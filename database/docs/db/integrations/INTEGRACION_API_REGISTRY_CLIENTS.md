# Integración API: personas globales y clientes por empresa

## Autoridad

`UserId` y `CompanyId` proceden exclusivamente de la sesión autenticada y de la empresa activa. No se permiten búsquedas por nombre, fragmentos, comodines ni listados globales de personas.

## Resolución de identidad

`POST /api/registry/resolve` recibe `identificationTypeCode` e `identification` exactos. El backend llama primero:

```sql
EXEC dbo.P_Person_ResolveIdentification
  @UserId, @CompanyId, @IdentificationTypeCode, @Identification, @CorrelationId;
```

- `0`: existe una persona global; se devuelve la identidad mínima para que el usuario confirme el alta de cliente.
- `404`: no existe una identidad global. El backend puede consultar el servicio de cédula o RUC y devolver solo una sugerencia editable de nombre/razón social.
- `400` y `403`: se trasladan sin revelar datos globales ni iniciar una consulta externa.

La consulta externa se ejecuta únicamente en el backend. No se guarda en SQL su JSON, UUID, resultado, error, timeout, proveedor, fecha, vigencia ni datos tributarios. Si el servicio no responde, no encuentra información o no devuelve nombre útil, el formulario manual permanece disponible.

## Alta y mantenimiento de cliente

| Ruta | Procedimiento | Entrada |
| --- | --- | --- |
| `POST /api/clients` | `P_Client_Create` | Persona existente **o** identidad manual confirmada, más `billingAddress`, `phone` y `email`. |
| `PATCH /api/clients/{clientId}` | `P_Client_Update` | Identificación facturable de la misma persona y datos comerciales locales. |
| `POST /api/clients/{clientId}/deactivate` | `P_Client_Deactivate` | Ninguna entrada adicional. |

Para una persona existente, el backend envía `PersonId` y `DefaultBillingIdentificationId`. Para una identidad inexistente, envía `PersonId = NULL`, `identificationTypeCode`, `identification`, `personKind`, `legalName` y `tradeName` opcional. El procedimiento crea la persona, su identificación y el cliente en una transacción; si otra empresa creó la misma identificación en paralelo, reutiliza la identidad global sin sobrescribirla.

Dirección, correo y teléfono siempre se confirman como valores de `Client` de la empresa activa. Una sugerencia externa nunca se persiste automáticamente.
