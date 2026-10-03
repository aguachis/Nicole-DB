## 1. Definición inicial del modelo global mínimo

- [x] 1.1 Revisar en scripts y documentación todas las referencias de proveedor, verificación, auditoría de registro y datos tributarios que deben quedar fuera de la definición inicial.
- [x] 1.2 Actualizar el DDL base para que no defina `RegistryProvider`, `PersonVerification`, `RegistryAccessAudit`, `TaxRegistration`, `EconomicActivity`, `TaxRegistrationEconomicActivity`, `RegistryEconomicActivityListType`, sus FK, índices, trigger ni semillas asociadas.
- [x] 1.3 Simplificar `PersonIdentification` eliminando `VerificationStatus`, `LastVerifiedAt` y `ExpiresAt`, conservando normalización, unicidad global, identificación primaria, auditoría y FK necesarias para `Client`.
- [x] 1.4 Actualizar el DDL base de `PersonIdentification` y de las tablas relacionadas para que la definición inicial no incluya objetos ni columnas de verificación externa.
- [x] 1.5 Preservar y comprobar en el diseño las claves `UQ_PersonIdentification_Type_Normalized`, `UQ_PersonIdentification_Id_Person`, `UX_PersonIdentification_OnePrimaryPerPerson`, `UQ_Client_Company_Person`, `UQ_Client_Client_Company` y la FK compuesta de identificación de facturación.

## 2. Procedimientos y autorización backend

- [x] 2.1 Reemplazar `P_Registry_ResolveIdentification` por un procedimiento de resolución local exacta que requiera contexto `UserId`/`CompanyId`, `client.create`, tipo activo e identificación normalizada, sin llamada de red ni escritura de auditoría/proveedor.
- [x] 2.2 Eliminar de los scripts base `P_Registry_PersistVerification` y cualquier tipo, parámetro o contrato de persistencia de respuesta externa.
- [x] 2.3 Ampliar `P_Client_Create`, o crear su reemplazo documentado, para admitir una persona global existente o crear atómicamente `Person`, `PersonIdentification` y `Client` desde datos manuales confirmados.
- [x] 2.4 Implementar la protección de concurrencia en el alta manual: volver a buscar bajo bloqueo la identificación normalizada, reutilizar la persona creada concurrentemente y no sobrescribir datos globales existentes.
- [x] 2.5 Ajustar `P_Client_Update` y `P_Client_Deactivate` para que no dependan de estado de verificación ni escriban en `RegistryAccessAudit`.
- [x] 2.6 Definir permisos, semillas y grants sin `client.verify`, `P_Registry_*` ni privilegios de objetos excluidos; otorgar ejecución solamente de los procedimientos de resolución y cliente definidos.
- [x] 2.7 Revisar todos los procedimientos de autenticación y cliente que lean columnas excluidas de `PersonIdentification` y adaptar sus contratos sin introducir DML directo desde `nicole_app`.

## 3. Contrato de integración backend

- [x] 3.1 Actualizar el contrato de resolución para que el backend consulte primero la identidad global exacta y llame al adaptador externo solo cuando el resultado local sea inexistente.
- [x] 3.2 Documentar el DTO transitorio permitido: identificación y nombre/razón social sugeridos; descartar UUID externo, JSON, resultados, errores, timeouts, proveedor, datos tributarios, dirección, teléfono y demás campos no aprobados.
- [x] 3.3 Documentar que una respuesta externa vacía, no encontrada o fallida mantiene el formulario manual y nunca crea una persona antes de la confirmación del usuario.
- [x] 3.4 Documentar el contrato de alta para separar la confirmación de una persona existente de la creación manual, y exigir dirección, correo y teléfono locales de la empresa activa.

## 4. Documentación de tablas, relaciones y Mermaid

- [x] 4.1 Actualizar `database/docs/db/entities/global-tax-identity-registry.md`, `person.md`, `company.md` y `database/docs/db/databse.md` para describir el maestro global mínimo y eliminar conceptos de verificación/proveedor/datos tributarios fuera de alcance.
- [x] 4.2 Actualizar `database/docs/db/BACKEND_DATABASE_CONTEXT.md`, `database/docs/db/changes/20260905_centralizar_registro_global_clientes.md` y la documentación de integración para reflejar el flujo local, sugerencia transitoria y alta manual.
- [x] 4.3 Actualizar el gráfico Mermaid y su tabla de relaciones en `database/docs/db/ER_DIAGRAM.md`, retirando nodos y aristas de proveedor, verificación, auditoría y tributación, y preservando `Company`–`Client`–`Person`–`PersonIdentification`.
- [x] 4.4 Actualizar el diagrama Mermaid de detalle en `database/docs/db/databse-diagrama.md` para incluir todas las columnas físicas definidas por el DDL, eliminar tablas, atributos y relaciones retiradas, y mostrar las claves compuestas que mantienen el aislamiento por tenant.
- [x] 4.5 Revisar referencias cruzadas y README de definición para eliminar rutas obsoletas de proveedor/procedimientos y mantener coherente el orden de creación inicial.

## 5. Verificación de la definición inicial

- [x] 5.1 Ejecutar validaciones estáticas de referencias para confirmar que ningún script, seed, grant, procedimiento o diagrama activo conserva dependencias hacia los objetos retirados.
- [x] 5.2 Revisar el contrato de resultados de resolución: coincidencia global exacta, ausencia local, sugerencia externa transitoria, fallo externo y nombre externo insuficiente.
- [x] 5.3 Revisar los casos de seguridad y aislamiento: permiso `client.create`, membresía en la empresa activa, bloqueo de búsqueda parcial/listado global y ausencia de registros técnicos de proveedor.
- [x] 5.4 Verificar la lista de FK, claves únicas, alta concurrente de la misma identificación y coherencia entre los scripts base y la documentación.
