## Why

La consulta actual de usuarios no devuelve todos los datos personales necesarios para pantallas administrativas y reportes, lo que obliga a consultas adicionales y aumenta complejidad en API. Adicionalmente, el alta de usuario exige que la persona exista previamente, y eso rompe el flujo de registro operativo cuando se requiere crear ambos elementos en una sola operacion transaccional.

## What Changes

- Ajustar el SP de consulta de usuarios para incluir `lastName`, `middleName`, `firstName`, `identification` y `phone`.
- Ajustar el SP de creacion de usuario para recibir los datos de persona necesarios y crear la persona automaticamente cuando no exista.
- Definir validaciones para resolver colisiones de persona por tipo/numero de identificacion y mantener consistencia de email/username.
- Mantener contrato de salida estandar de SP (`result_code`, `result_message`, dataset) en ambos flujos.
- Actualizar documentacion tecnica e integracion API con los nuevos parametros y respuestas.

## Capabilities

### New Capabilities
- `enriched-user-query-fields`: La consulta de usuarios entrega datos personales clave para consumo directo en API sin joins adicionales en capa de aplicacion.
- `user-create-with-person-autoprovision`: La creacion de usuario permite aprovisionamiento automatico de persona cuando no existe, con validaciones transaccionales.

### Modified Capabilities
- None.

## Impact

- Afecta SP `procedures/auth/P_User_List.sql`.
- Afecta SP `procedures/auth/P_User_Create.sql`.
- Puede afectar documentos de integracion de auth/usuarios en `docs/db/integrations/`.
- Impacta validaciones sobre `dbo.Person` y `dbo.AppUser`, incluyendo reglas de identificacion y duplicados.
