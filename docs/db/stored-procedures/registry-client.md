# Catálogo de procedimientos: registro global y cliente

## Reglas comunes

Todos los procedimientos son `dbo`, usan `@UserId`, `@CompanyId` y admiten `@CorrelationId` opcional. La autorización se resuelve dentro de SQL con `dbo.fn_HasEffectivePermission`; el tenant se comprueba también en los `UPDATE` y `DELETE` lógicos. El contrato de resultado empieza por `result_code`, `result_message` y `correlation_id`.

| Procedimiento | Permiso efectivo | Operación y resultado |
| --- | --- | --- |
| `usp_Registry_ResolveIdentification` | `client.read` o `client.verify` | Busca únicamente tipo+cédula/RUC exactos y devuelve `0` para cache vigente, `202` si el backend debe refrescar, `400`, `403` o `404` en error. Inserta auditoría mínima. |
| `usp_Registry_PersistVerification` | `client.verify` | Persiste campos estructurados de una respuesta que el backend ya obtuvo; actualiza identidad, verificación, datos RUC y actividades. Nunca recibe URL, secreto o JSON crudo. |
| `usp_Client_Create` | `client.create` | Crea el vínculo comercial de la empresa con una persona y devuelve `client_id`. Valida identidad facturable y contacto local. |
| `usp_Client_Update` | `client.update` | Actualiza solo el `ClientId` dentro de `CompanyId`; devuelve `404` si pertenece a otro tenant. |
| `usp_Client_Deactivate` | `client.deactivate` | Baja lógica dentro del tenant; no borra historial ni identidad global. |

## Firmas de cliente

```sql
dbo.usp_Client_Create
  @UserId, @CompanyId, @PersonId, @DefaultBillingIdentificationId,
  @BillingAddress, @Phone, @Email,
  @CreditLimit = NULL, @PaymentTermDays = NULL, @CorrelationId = NULL;

dbo.usp_Client_Update
  @UserId, @CompanyId, @ClientId, @DefaultBillingIdentificationId,
  @BillingAddress, @Phone, @Email,
  @CreditLimit = NULL, @PaymentTermDays = NULL, @CorrelationId = NULL;

dbo.usp_Client_Deactivate
  @UserId, @CompanyId, @ClientId, @CorrelationId = NULL;
```

`DefaultBillingIdentificationId` debe corresponder a la misma `PersonId`, a un tipo activo permitido para facturación y a una identidad que no esté `Invalid`. Las validaciones SQL no sustituyen la autorización que el backend debe realizar antes de exponer cada ruta.

## Flujo de verificación

1. El backend llama `usp_Registry_ResolveIdentification` con el usuario y tenant autenticados.
2. Si recibe `0`, responde únicamente los campos permitidos de cache. Si recibe `202`, consulta al proveedor mediante un adaptador fuera de SQL.
3. El adaptador normaliza la respuesta, define expiración y llama `usp_Registry_PersistVerification` con los campos permitidos y la misma correlación.
4. El backend no registra valores de identidad, nombres, dirección ni payload en sus logs operativos; conserva el `correlation_id` para diagnóstico.

## Scripts

- Ayudantes de permiso y auditoría: `database/procedures/20260905_006_registry_client_authorization_helpers.sql`.
- Resolución y persistencia: `database/procedures/20260905_001_usp_registry_resolve_identification.sql`, `database/procedures/20260905_002_usp_registry_persist_verification.sql`.
- Cliente y endurecimiento: `database/procedures/20260905_003_usp_client_create.sql` a `20260905_005_usp_client_deactivate.sql`, y `20260905_007_usp_client_authorization_audit_hardening.sql`.
- Permisos y rol sin DML directo: `database/security/20260905_001_centralizar_registro_global_clientes_grants.sql`.
