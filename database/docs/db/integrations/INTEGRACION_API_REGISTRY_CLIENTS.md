# Integración API: personas globales y clientes por empresa

## Autoridad

`UserId` y `CompanyId` proceden exclusivamente de la sesión autenticada; `CompanyId` es la unica empresa asignada al usuario. No se permiten búsquedas por nombre, fragmentos, comodines ni listados globales de personas.

## Resolución de identidad

`POST /api/registry/resolve` recibe `identificationTypeCode` e `identification` exactos. El backend llama primero:

```sql
EXEC dbo.P_Person_ResolveIdentification
  @UserId, @CompanyId, @ProfileId, @IdentificationTypeCode, @Identification, @CorrelationId;
```

`UserId`, `CompanyId` y `ProfileId` proceden de la sesion autenticada; el `ProfileId` activo fue validado al construir el contexto de sesion. El procedimiento vuelve a comprobar el permiso `client.create` exclusivamente a traves de ese perfil. `P_Client_Create`, `P_Client_Update` y `P_Client_Deactivate` reciben igualmente `@ProfileId` para autorizar cada comando sin mezclar permisos de otros perfiles.

El procedimiento devuelve RS1 con `result_code`, `result_message` y `correlation_id`. Cuando la resolución es exitosa devuelve RS2 con la identidad global mínima (`PersonId`, tipo y número de identificación, nombres y permiso de facturación).

- `0`: existe una persona global; RS2 permite al usuario confirmar el alta de cliente.
- `2001`: no existe una identidad global. El backend puede consultar el servicio de cédula o RUC y devolver solo una sugerencia editable de nombre/razón social.
- `1001`/`1002`/`2002`/`3001`: entrada inválida, tipo de identificación no soportado, tipo inactivo o autorización denegada; se manejan según el contrato global y nunca inician una consulta externa.

La consulta externa se ejecuta únicamente en el backend. No se guarda en SQL su JSON, UUID, resultado, error, timeout, proveedor, fecha, vigencia ni datos tributarios. Si el servicio no responde, no encuentra información o no devuelve nombre útil, el formulario manual permanece disponible.

## Alta y mantenimiento de cliente

| Ruta | Procedimiento | Entrada |
| --- | --- | --- |
| `POST /api/clients` | `P_Client_Create` | Persona existente **o** identidad manual confirmada, más `billingAddress`, `phone` y `email`. |
| `PATCH /api/clients/{clientId}` | `P_Client_Update` | Identificación facturable de la misma persona y datos comerciales locales. |
| `POST /api/clients/{clientId}/deactivate` | `P_Client_Deactivate` | Ninguna entrada adicional. |

Para una persona existente, el backend envía `PersonId` y `DefaultBillingIdentificationId`. Para una identidad inexistente, envía `PersonId = NULL`, `identificationTypeCode`, `identification`, `personKind`, `legalName` y `tradeName` opcional. El procedimiento crea la persona, su identificación y el cliente en una transacción; si otra empresa creó la misma identificación en paralelo, reutiliza la identidad global sin sobrescribirla.

Dirección, correo y teléfono siempre se confirman como valores de `Client` del tenant del usuario autenticado. Una sugerencia externa nunca se persiste automáticamente.

Los procedimientos de alta, actualización y desactivación de cliente devuelven el estado en RS1 y, solo si es exitoso, los datos del cliente en RS2. Las excepciones técnicas se propagan como errores SQL y deben traducirse a errores HTTP sanitizados. Los códigos SQL no son códigos HTTP; véase `INTEGRACION_API_DATABASE_STORED_PROCEDURE_CONTRACT.md`.
