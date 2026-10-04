## Why

La vigencia y la validacion de los tipos de identificacion no son coherentes entre el catalogo y las rutas de escritura. `IdentificationType` mantiene a la vez `Status` e `IsActive`; el lookup consulta el primero, mientras que registro, usuarios y clientes consultan el segundo. Ademas, el registro inicial puede persistir identificaciones que no cumplen la longitud, el formato ni la aplicabilidad configurados para su tipo.

Es necesario unificar la politica antes de ampliar el uso de `PersonIdentification`: evita que una UI ofrezca opciones que los SP rechazan (o viceversa), que se registren identidades globales invalidas y que los consumidores dependan de la clave fisica de un catalogo.

## What Changes

- Establecer `IdentificationType.Status = 'A'` como la unica regla de vigencia para nuevas capturas y selecciones; retirar el estado duplicado `IsActive` del DDL base, semillas, procedimientos y documentacion.
- Definir una politica reutilizable de identificacion que normalice el valor, resuelva un `Code` estable a su clave interna y valide vigencia, longitud, restriccion numerica y compatibilidad con `PersonKind` antes de crear una identidad global.
- Aplicar la politica a `P_Auth_Register`, `P_User_Create` y `P_Client_Create`; conservar la resolucion exacta y la comprobacion de facturacion de las rutas de cliente con la misma definicion de vigencia.
- Exponer y aceptar `Code` como identificador funcional de tipos de identificacion. El lookup `IDENTIFICATION` devolverá `Code` en `value`; las rutas de registro y alta de usuario dejaran de recibir `IdentificationTypeId` como contrato publico. **BREAKING** para consumidores que envian o almacenan el `char(2)` fisico.
- Definir el tratamiento de tipos desactivados: no se pueden seleccionar ni usar para crear identificaciones nuevas; las identificaciones historicas permanecen consultables, pero no pueden elegirse como identificacion de facturacion mientras su tipo no este activo y habilitado para facturacion.
- Sincronizar los diccionarios, contratos de integracion y el snapshot de esquema con el DDL base. El cambio se incorpora al bootstrap de una base nueva; no incluye migracion de datos ni `ALTER` para instalaciones existentes.

## Capabilities

### New Capabilities

- `identity-input-policy`: politica unica para resolver y validar identificaciones recibidas por rutas de alta, con errores funcionales y reglas de vigencia consistentes.
- `registration-identity-validation`: registro inicial que crea una persona natural solo con una identificacion admitida por la politica comun.

### Modified Capabilities

- `global-tax-identity-registry`: usar una sola vigencia basada en `Status` y hacer que toda alta de identidad global cumpla su metadata.
- `user-create-with-person-autoprovision`: recibir el codigo estable de tipo y validar la identidad de persona natural con la politica comun antes de aprovisionarla.
- `catalog-lookup-contract-standardization`: mapear el catalogo `IDENTIFICATION` al `Code` funcional, sustituyendo el identificador fisico en el valor expuesto.

## Impact

- DDL y semilla: `database/tables/01-create-table-identification-type.sql` y `database/seeds/00-seed-base-catalogs.sql`; se mantiene `IdentificationTypeId` como FK interna de `PersonIdentification`.
- Procedimientos: `P_Catalog_Lookup`, `P_Auth_Register`, `P_User_Create`, `P_Person_ResolveIdentification`, `P_Client_Create` y `P_Client_Update`. Las rutas de cliente seguiran exigiendo permiso efectivo por `UserId`, `CompanyId` y perfil activo mediante `fn_HasEffectivePermission`; este cambio no altera el aislamiento multiempresa.
- Contratos backend/UI: el valor de `IDENTIFICATION` y los parametros de registro/alta de usuario pasan de ID fisico a `Code`; se requiere una actualizacion coordinada de consumidores y documentacion de integracion.
- Orden de definicion inicial: catalogo y semilla, rutina de politica, procedimientos dependientes, documentacion/contratos y, finalmente, comprobaciones del DBA en una base vacia.
- El DBA debera comprobar compilacion del bootstrap, combinaciones contradictorias ya eliminadas, validaciones de formato/persona, tipos desactivados, facturacion y compatibilidad de los contratos actualizados.
