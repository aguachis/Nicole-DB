## 1. Catalogo y bootstrap de base nueva

- [x] 1.1 Actualizar `database/tables/01-create-table-identification-type.sql` para retirar `IsActive`, conservar `Status` con FK a `EntityStatus` y documentar que solo `Status = 'A'` habilita nuevas capturas y facturacion.
- [x] 1.2 Ajustar `database/seeds/00-seed-base-catalogs.sql` para sembrar los tipos con `Status` explicito y sin depender de una segunda bandera de vigencia.
- [x] 1.3 Revisar el manifiesto `database/20260905_001_crear_bd_registro_global_clientes.sql` y su orden de inclusiones para instalar tabla, semilla, rutina compartida y SP dependientes en una base vacia.

## 2. Politica comun de identificacion

- [x] 2.1 Crear una rutina T-SQL reutilizable que reciba `Code`, identificacion y `PersonKind`, aplique `fn_NormalizeIdentification`, resuelva el ID interno y distinga codigo inexistente, tipo inactivo e identificacion invalida.
- [x] 2.2 Aplicar la rutina a `database/procedures/auth/P_Auth_Register.sql`, usando persona natural, sin crear ningun objeto del registro cuando la politica falle.
- [x] 2.3 Aplicar la rutina a `database/procedures/auth/P_User_Create.sql`, sustituir el parametro publico basado en ID fisico por codigo estable y conservar la reutilizacion transaccional de `Person`.
- [x] 2.4 Aplicar la misma resolucion de codigo y vigencia a `database/procedures/registry-client/20260905_001_usp_person_resolve_identification.sql` y a `20260905_003_usp_client_create.sql`, sin debilitar `fn_HasEffectivePermission` ni el aislamiento por empresa y perfil activo.
- [x] 2.5 Ajustar `database/procedures/registry-client/20260905_004_usp_client_update.sql` y la validacion de identificacion de facturacion para usar `Status = 'A'` e `IsBillingAllowed = 1`, conservando las identificaciones historicas sin permitir seleccionarlas de nuevo cuando su tipo este inactivo.

## 3. Contratos de catalogo y consumidores

- [x] 3.1 Actualizar `database/procedures/catalogs/P_Catalog_Lookup.sql` para que `IDENTIFICATION.value` devuelva `IdentificationType.Code`, filtre por `Status = 'A'` por defecto y mantenga forma canonica de salida.
- [x] 3.2 Actualizar los contratos y ejemplos de `INTEGRACION_API_CATALOG_LOOKUPS.md`, `INTEGRACION_API_CATALOG_LOOKUPS_BACKEND_HANDOFF.md`, `INTEGRACION_API_AUTH_REGISTER.md`, `INTEGRACION_API_USER_SECURITY_MAINTENANCE.md` e `INTEGRACION_API_REGISTRY_CLIENTS.md` para declarar la ruptura de ID fisico a `Code` y los nuevos errores de validacion.
- [x] 3.3 Confirmar que backend y frontend sustituyan valores `IdentificationTypeId` persistidos o enviados por `Code` antes de adoptar el bootstrap actualizado.

## 4. Documentacion del modelo

- [x] 4.1 Sincronizar `database/docs/db/entities/identification-type.md` y `database/docs/db/entities/identification-type/00-current-schema.sql` con el catalogo definitivo, sus metadatos y la vigencia unica.
- [x] 4.2 Actualizar `database/docs/db/entities/global-tax-identity-registry.md`, `database/docs/db/BACKEND_DATABASE_CONTEXT.md` y los documentos de procedimientos afectados para reflejar la politica comun, el contrato por `Code` y la semantica historica de tipos inactivos.
- [x] 4.3 Revisar `database/docs/db/databse.md` y el diagrama ER solo si contienen atributos o contratos de `IdentificationType` que cambien con esta propuesta.

## 5. Revision y validacion del DBA

- [ ] 5.1 Instalar el manifiesto completo en una instancia SQL Server vacia y comprobar que no queden referencias a `IdentificationType.IsActive`, que las FK/UNIQUE de `PersonIdentification` se conserven y que no se introduzcan indices redundantes.
- [ ] 5.2 Probar por cada ruta de alta: codigo inexistente, tipo inactivo, longitud fuera de rango, caracteres no numericos, incompatibilidad de `PersonKind`, valor valido y reutilizacion de una identidad existente; confirmar rollback sin filas parciales en los rechazos.
- [ ] 5.3 Probar el lookup `IDENTIFICATION` con y sin inactivos y verificar que `value` sea `Code`, no `IdentificationTypeId`.
- [ ] 5.4 Probar que una identificacion historica de tipo inactivo se conserve para consulta, pero no pueda seleccionarse como identificacion de facturacion; comprobar tambien el rechazo por `IsBillingAllowed = 0`.
- [ ] 5.5 Verificar que las rutas de cliente continuen exigiendo permiso efectivo para el `UserId`, `CompanyId` y `ProfileId` activo, incluido un intento de operar sobre otra empresa.
