# Integración API: registro global y clientes por empresa

## Límites de autoridad

`UserId` y `CompanyId` proceden exclusivamente de la sesión autenticada y de la empresa activa autorizada. El API no expone búsquedas globales por nombre, fragmento de identificación ni datos tributarios de otras empresas. Cada petición genera o propaga un UUID `correlationId`.

## Resolución de identidad

`POST /api/registry/resolve`

Entrada permitida: `identificationTypeCode`, `identification` y `correlationId` opcional. La solicitud debe contener coincidencia exacta; no admite comodines. El backend llama primero:

```sql
EXEC dbo.usp_Registry_ResolveIdentification
  @UserId, @CompanyId, @IdentificationTypeCode, @Identification, @CorrelationId;
```

- `0`: devuelve datos estructurados de identidad obtenidos desde una verificación vigente.
- `202`: el backend usa su `RegistryProviderAdapter` para HTTP, timeout, reintentos y transformación. Después llama `usp_Registry_PersistVerification`.
- `400`, `403`, `404` y errores controlados se traducen sin revelar si otra empresa tiene relación comercial con la persona.

El adaptador guarda secretos en el gestor de secretos, no en SQL. El procedimiento de persistencia recibe resultados normalizados, vigencia, hash y referencias opacas; no recibe ni guarda payload JSON. Los logs de aplicación conservan solo código de resultado y `correlationId`.

## Comandos de cliente

| Ruta | Procedimiento | Entrada local obligatoria |
| --- | --- | --- |
| `POST /api/clients` | `usp_Client_Create` | persona, identificación facturable, `billingAddress`, `phone`, `email`. |
| `PATCH /api/clients/{clientId}` | `usp_Client_Update` | identificación facturable, `billingAddress`, `phone`, `email`; crédito/plazo opcionales. |
| `POST /api/clients/{clientId}/deactivate` | `usp_Client_Deactivate` | ninguna adicional. |

El backend pasa el `CompanyId` de contexto y nunca permite sustituirlo con el cuerpo de la petición. Una dirección recuperada de `TaxRegistration.TaxAddress` se muestra solo como sugerencia: para grabar un cliente la UI exige confirmación y envía `billingAddress` explícito. La baja es lógica y solo afecta al cliente de la empresa activa.

## Respuesta y errores

Todas las rutas trasladan `result_code`, `result_message` y `correlation_id` del procedimiento. En éxito de alta/cambio/baja incluyen `client_id`. El API no devuelve valores de auditoría ni de conflictos de backfill a usuarios finales. La trazabilidad operativa consulta `RegistryAccessAudit` bajo controles administrativos.

## Dependencias SQL

Los contratos se habilitan con los manifiestos `database/20260905_001_centralizar_registro_global_clientes_phase1.sql` y `database/20260905_002_centralizar_registro_global_clientes_phase2_guards.sql`; el orden manual obligatorio está en `database/README_20260905_centralizar_registro_global_clientes.md`.
