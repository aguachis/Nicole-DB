## Context

El esquema vigente centraliza personas, pero el flujo `P_Registry_*` trata al proveedor como una fuente persistida: registra proveedor, resultado, vencimiento, hash, auditoría y datos tributarios/económicos. La consulta acordada tiene otra finalidad: reutilizar una identidad global ya confirmada; si no existe, el backend consulta cédula o RUC solo para sugerir datos en un formulario. El usuario confirma o completa los campos y el guardado crea la identidad y el cliente sin conservar metadatos ni payload del servicio.

La base mantiene un modelo multiempresa: `Person` y `PersonIdentification` son globales; `Client` relaciona una sola `Person` con una `Company` y contiene los contactos y condiciones comerciales locales. La base de datos es nueva y está en definición, por lo que el cambio se aplica directamente sobre sus scripts base y no existe información previa que conservar o transformar.

## Goals / Non-Goals

**Goals:**

- Resolver una identificación exacta en el maestro global antes de solicitar cualquier dato externo.
- Reutilizar la misma `Person` por varias empresas, sin compartir dirección de facturación, correo, teléfono, crédito ni plazo.
- Permitir un alta manual completa cuando no haya coincidencia local, el servicio falle, no encuentre datos o devuelva un nombre insuficiente.
- Persistir únicamente los campos globales confirmados: tipo y valor de identificación, clase natural/jurídica, nombre legal y nombre comercial opcional.
- Mantener la creación de una nueva persona, su identificación y su `Client` en una sola transacción.
- Retirar toda persistencia de proveedor y reflejar el modelo final en tablas, FK, permisos, contratos, diccionarios y diagramas Mermaid.

**Non-Goals:**

- No implementar llamadas HTTP, credenciales, reintentos ni límites de tiempo dentro de SQL Server.
- No conservar payload JSON, UUID externo, resultado, error, timeout, proveedor, fecha de consulta, hash, vigencia ni historial del servicio.
- No almacenar por ahora estado tributario, actividad económica, obligación contable, fechas fiscales ni dirección/teléfono provenientes del RUC.
- No copiar automáticamente dirección, teléfono o correo de una empresa a otra ni desde la respuesta externa a `Client`.
- No fusionar personas por nombre, por coincidencias parciales o por heurísticas entre cédula y RUC.

## Decisions

### 1. El maestro global es la única caché persistente

`Person` y `PersonIdentification` conservarán solamente los datos de negocio confirmados. La unicidad de `(IdentificationTypeId, NormalizedIdentification)` será la garantía de que una cédula o RUC representa una sola persona global. La consulta local será exacta, sin búsqueda por nombre, fragmentos ni listados globales.

Se elimina `VerificationStatus`, `LastVerifiedAt` y `ExpiresAt` de `PersonIdentification`: su significado depende de una verificación externa que ya no se retiene. Permanecen las reglas de formato, aplicabilidad natural/jurídica y elegibilidad de facturación de `IdentificationType`.

Alternativa descartada: mantener los campos con valores como `Manual` o `Unverified`. Conserva semántica de verificación inexistente y vuelve ambiguo qué significa un dato confirmado por el usuario.

### 2. El servicio externo es un prellenado transitorio del backend

El frontend solicitará al backend la resolución de una identificación. El backend consulta primero el procedimiento local de resolución. Solo si este devuelve que no existe, el backend usa su adaptador externo; el navegador no invoca el proveedor directamente ni persiste su respuesta.

El adaptador reduce la respuesta a una sugerencia de formulario: identificación y nombre cuando estén disponibles. Para un RUC, `businessName` puede sugerir el nombre legal; para una cédula, un nombre vacío obliga a ingreso manual. El UUID externo y todos los otros campos se descartan. El usuario confirma o corrige los campos antes de guardar.

Alternativa descartada: persistir una respuesta parcial con estado de timeout, proveedor o vencimiento. No aporta valor al alta manual y contradice la retención acordada.

### 3. Separar resolución global de creación comercial, y hacer la creación atómica

Se reemplazarán los procedimientos `P_Registry_ResolveIdentification` y `P_Registry_PersistVerification` por una resolución local sin efectos secundarios y por un `P_Client_Create` ampliado, o procedimiento equivalente con contrato explícito, que soporte dos casos:

1. recibe una `PersonId` ya resuelta y crea solo la relación `Client` de la empresa activa;
2. recibe los campos manuales de una identidad inexistente y crea `Person`, `PersonIdentification` y `Client` dentro de una transacción.

El segundo caso realizará una nueva búsqueda protegida por bloqueo y la clave única antes de insertar. Si otra solicitud creó la identidad entre la consulta y el guardado, reutilizará la persona encontrada y creará solo el cliente. La confirmación de un registro existente nunca actualizará automáticamente `Person`.

La autorización efectiva se validará con `UserId` y `CompanyId`. La resolución necesaria para crear un cliente requerirá `client.create`; `client.read` seguirá limitado a clientes de la empresa activa. Se retira `client.verify`, ya que no existe persistencia de verificaciones.

### 4. Excluir el submodelo que solo representa respuestas de servicio

Los scripts base, permisos y documentación no definirán `RegistryProvider`, `PersonVerification`, `RegistryAccessAudit`, `TaxRegistration`, `EconomicActivity`, `TaxRegistrationEconomicActivity` ni `RegistryEconomicActivityListType`, ni sus FK, índices, trigger, semillas, grants o referencias. Estos objetos no son necesarios para el alta manual de clientes.

Si en el futuro se requiere auditoría de seguridad, se diseñará una capacidad general independiente, con finalidad, retención y acceso explícitos; no se reutilizará `RegistryAccessAudit` para registrar consultas al servicio.

### 5. Los contactos y condiciones siguen siendo propiedad del tenant

La dirección de facturación, correo, teléfono, límite de crédito y plazo se mantendrán únicamente en `Client`. Una respuesta de RUC puede mostrarlos temporalmente como sugerencia, pero el backend solo enviará al procedimiento el valor local que el usuario confirme. Se preservan las FK compuestas que prueban que la identificación facturable pertenece a la persona del cliente y la unicidad `(CompanyId, PersonId)`.

## Risks / Trade-offs

- [Datos globales desactualizados tras la primera captura] → La información confirmada queda como maestro hasta una futura capacidad explícita de corrección; no habrá actualización silenciosa desde el servicio.
- [Una cédula/RUC conocida revela una coincidencia entre tenants] → La resolución será exacta, requerirá permiso efectivo y devolverá solo los campos globales mínimos necesarios para confirmar el alta.
- [Carrera entre dos empresas que crean la misma identificación] → La transacción, bloqueo de lectura y clave única resolverán la segunda solicitud reutilizando la identidad creada.
- [El servicio devuelve éxito sin nombre utilizable] → No se inserta una `Person` incompleta; el formulario exige el nombre legal manual antes de guardar.
- [RUC de persona natural clasificado erróneamente como jurídica] → `PersonKind` se confirma en el formulario o proviene de una fuente confiable; no se infiere únicamente por el tipo RUC.

## Orden de definición inicial

1. Ajustar el DDL base para definir únicamente el maestro global mínimo, sus claves y `Client`, sin submodelo de proveedor o tributación.
2. Crear los procedimientos de resolución local y alta atómica de cliente sin estados de verificación ni auditoría/proveedor.
3. Definir permisos, semillas y grants para los procedimientos que permanecen, sin `client.verify` ni `P_Registry_*`.
4. Actualizar contratos backend, diccionarios, documentos de entidades y diagramas Mermaid/ER en la misma entrega de definición.
5. Comprobar estáticamente FK, claves únicas, rutas autorizadas, alta concurrente de la misma identificación, resolución existente, respuesta externa fallida y alta manual.

## Open Questions

- No hay una decisión pendiente para esta fase. Una futura capacidad de corrección global, auditoría general o refresco voluntario desde un servicio externo requerirá una propuesta separada.
