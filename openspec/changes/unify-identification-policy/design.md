## Context

`dbo.IdentificationType` contiene dos representaciones editables de vigencia: `Status`, relacionado con `EntityStatus`, e `IsActive`. El bootstrap siembra solamente `Status`; `IsActive` toma su valor por defecto. Sin embargo, `P_Catalog_Lookup` filtra tipos por `Status = 'A'`, mientras que `P_Auth_Register`, `P_User_Create`, `P_Person_ResolveIdentification`, `P_Client_Create` y `P_Client_Update` usan `IsActive = 1`.

La validacion de metadata tambien esta distribuida: el alta de clientes valida longitud, solo-numerico y clase de persona; el alta de usuarios hace lo mismo para personas naturales; el registro inicial solo comprueba existencia y actividad. A la vez, clientes ya acepta `IdentificationTypeCode`, pero registro, usuarios y el lookup exponen o aceptan `IdentificationTypeId`, una clave interna `char(2)`.

El proyecto define una base nueva. Por ello el cambio modifica scripts base y el manifiesto de bootstrap, sin migracion ni compatibilidad de datos desplegados. `PersonIdentification.IdentificationTypeId` sigue siendo una FK interna y su unicidad global no cambia. La autorizacion de cliente sigue usando `fn_HasEffectivePermission(UserId, CompanyId, ProfileId, ...)`; la politica de identidad no otorga ni amplifica permisos.

## Goals / Non-Goals

**Goals:**

- Tener una sola definicion persistida de vigencia: `Status = 'A'`.
- Resolver un `Code` publico a la PK interna y validar, antes de cada insercion de identidad, valor normalizado, longitud, restriccion numerica y aplicabilidad natural/juridica.
- Mantener la semantica de errores funcionales entre registro, usuarios y clientes.
- Separar la prohibicion de crear o seleccionar tipos inactivos de la conservacion de identificaciones historicas.
- Actualizar DDL, semilla, SP, contratos e inventarios documentales como una unica definicion instalable desde una base vacia.

**Non-Goals:**

- No crear migraciones de datos, `ALTER` ni estrategia de doble lectura para bases existentes.
- No implementar una validacion ecuatoriana de digito verificador; la politica cubre solo los metadatos existentes (longitud y solo-numerico). Una regla semantica por pais o tipo requerira una capacidad posterior.
- No modificar la clave interna, las FK, normalizacion ni reglas de unicidad de `PersonIdentification`.
- No permitir DML directo como mecanismo alternativo de alta de identidades ni cambiar permisos, empresas o perfiles.
- No reactivar automaticamente tipos ni identificaciones historicas.

## Decisions

### 1. `Status` es la unica fuente de vigencia del tipo

El DDL base retira `IdentificationType.IsActive`; un tipo esta disponible cuando `Status = 'A'`. La semilla declarara ese estado de forma explicita y cada SP filtrara con la misma condicion. Se preserva la FK a `EntityStatus`, que ya expresa el dominio de estado y permite futuros estados sin una segunda bandera mutable.

Alternativa descartada: conservar ambos campos con un `CHECK` de sincronizacion. Previene algunas combinaciones invalidas, pero mantiene dos contratos, dos convenciones y el riesgo de que nuevos consumidores consulten una columna distinta.

### 2. `Code` es la frontera de API y `IdentificationTypeId` queda interno

El lookup `IDENTIFICATION` devolvera `Code` como `value`. `P_Auth_Register` y `P_User_Create` recibiran un parametro de codigo funcional (con nombres acordes a su contrato); los procedimientos resolveran el ID dentro de la transaccion antes de consultar o insertar `PersonIdentification`. Las salidas que necesiten describir el tipo expondran `Code`; no se usa el ID fisico para contratos nuevos.

La ruptura es intencional porque el valor previo es una clave de implementacion. La documentacion de integracion debera señalar el cambio y el backend/UI deberan traducir los valores persistidos o enviados antes de consumir el bootstrap nuevo.

Alternativa descartada: devolver simultaneamente el ID como `value` y el codigo como un campo adicional. Conserva la dependencia del consumidor sobre la PK, no satisface el contrato estable y prolonga la incompatibilidad entre rutas.

### 3. Una rutina de politica resuelve y valida toda captura nueva

Se definira una rutina reutilizable compatible con T-SQL que reciba `Code`, identificacion y `PersonKind` y entregue el `IdentificationTypeId` resuelto y el valor normalizado solo si el tipo esta activo y la metadata se cumple. La implementacion elegida debe permitir a cada SP distinguir: codigo no soportado, tipo inactivo y valor no valido, para conservar `result_code` y mensajes funcionales.

`P_Auth_Register` invocara la rutina con clase `N`; `P_User_Create`, tambien con `N`; `P_Client_Create`, con la clase recibida. La busqueda de persona existente usara el tipo resuelto y el valor normalizado. `P_Person_ResolveIdentification` aplicara la misma resolucion de codigo y vigencia para que una identificacion no pueda resolverse con una regla diferente a la de captura.

Alternativa descartada: replicar el predicado de metadata en cada SP. Es la causa actual de la divergencia y hace probable que futuras propiedades de `IdentificationType` se apliquen solo parcialmente.

### 4. Tipos inactivos preservan historia, pero no habilitan nuevas acciones

Una identificacion ya almacenada conserva su FK y puede aparecer en consultas historicas. Un tipo inactivo no aparece en el lookup por defecto, no se admite para crear una persona o identificacion y no se puede elegir como identificacion predeterminada de facturacion. `P_Client_Update` verificara `Status = 'A'` e `IsBillingAllowed = 1` al asignar el identificador de facturacion.

Alternativa descartada: bloquear toda lectura o actualizacion de una persona con una identificacion historica. Convertiria un cambio de catalogo en una indisponibilidad innecesaria de datos globales y de relaciones comerciales existentes.

### 5. La integridad de la politica se protege por rutas autorizadas y pruebas de bootstrap

El repositorio mantendra el modelo en que la aplicacion usa SP y no DML directo sobre `PersonIdentification`. Los SP de cliente preservan su comprobacion de permiso efectivo del perfil activo; la rutina de identidad se ejecuta despues de esa autorizacion. La validacion del DBA se define sobre una base vacia, incluidos catalogo, entradas validas/invalidas, tipo inactivo, facturacion y concurrencia de la clave unica existente.

## Risks / Trade-offs

- [Consumidores que envian `IdentificationTypeId`] → Documentar la ruptura, actualizar contratos backend/UI en la misma entrega y probar el lookup con `Code`.
- [Formato valido segun longitud pero invalido segun reglas nacionales] → Explicitar el limite actual; proponer una capacidad separada antes de implementar checksum o reglas regulatorias.
- [Una implementacion de rutina no preserva mensajes funcionales] → Definir resultados diferenciados y cubrirlos con escenarios de SP antes de retirar validaciones locales.
- [Desactivar un tipo afecta facturacion al cambiar una identificacion predeterminada] → Mantener las relaciones existentes legibles y rechazar solo una nueva seleccion; confirmar este comportamiento con negocio/DBA durante la revision.
- [DML directo omite metadata] → Mantener los grants del rol de ejecucion limitados a SP y revisar los permisos del bootstrap con el DBA.

## Migration Plan

1. Modificar el DDL y las semillas de la base nueva para retirar `IsActive` y definir `Status` como regla unica.
2. Crear la rutina de resolucion/validacion antes de los SP que la consumen.
3. Actualizar lookup, registro, usuarios, resolucion y SP de cliente; luego actualizar permisos/grants solo si la nueva rutina o los SP lo requieren.
4. Actualizar manifiesto de bootstrap, contratos de integracion, diccionarios y snapshots de esquema.
5. El DBA debe instalar desde una base vacia y verificar los escenarios de las especificaciones. No hay rollback de datos: durante la definicion, el rollback consiste en restaurar los scripts base y contratos anteriores antes de un despliegue.

## Open Questions

- No hay decisiones bloqueantes. La validacion de digito verificador y cualquier norma fiscal especifica quedan deliberadamente fuera de este cambio.
