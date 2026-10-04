# Diccionario: maestro global de personas e identificaciones

## Alcance

`Person` y `PersonIdentification` son maestros globales: no llevan `CompanyId`. Permiten que varias empresas creen su propio `Client` para la misma persona sin duplicar su identidad.

La aplicación no modifica estas tablas con DML directo. `dbo.P_Person_ResolveIdentification` resuelve una coincidencia exacta y `dbo.P_Client_Create` reutiliza una persona existente o crea la persona, su identificación y el cliente en una sola transacción.

## PersonIdentification

| Campo | Tipo | Regla |
| --- | --- | --- |
| `PersonIdentificationId` | `bigint identity` | PK. |
| `PersonId` | `uniqueidentifier` | FK a `Person`; propietario global de la identificación. |
| `IdentificationTypeId` | `char(2)` | FK a `IdentificationType`. |
| `Identification` | `nvarchar(64)` | Valor visible y no vacío. |
| `NormalizedIdentification` | calculada persistida | Normaliza espacios, guiones, puntos y mayúsculas para la unicidad. |
| `IsPrimary` | `bit` | Una sola identificación primaria por persona. |
| auditoría | fechas y `AppUser` opcional | Creación y actualización. |

Las claves `UQ_PersonIdentification_Type_Normalized(IdentificationTypeId, NormalizedIdentification)` y `UQ_PersonIdentification_Id_Person(PersonIdentificationId, PersonId)` evitan duplicados y soportan la FK compuesta desde `Client`.

## Resolución y captura manual

1. El backend toma `IdentificationType.Code` del catálogo y busca el tipo y número exactos mediante `P_Person_ResolveIdentification`.
2. Si existe, devuelve solo `PersonId`, identificación, `PersonKind`, nombre legal, nombre comercial opcional e indicación de facturación.
3. Si no existe, el backend puede consultar un servicio externo y convertir el resultado en una sugerencia transitoria.
4. El usuario confirma o completa los campos requeridos; recién entonces `P_Client_Create` guarda los datos globales confirmados y el cliente local.

No se almacenan payloads JSON, UUID externos, resultados, errores, timeouts, proveedor, fechas de consulta, hash, vigencias, dirección, teléfono, estado tributario ni actividad económica recibidos de un servicio.

## Política de tipos de identificación

`IdentificationType.Status = 'A'` es la única señal de vigencia. La rutina `P_Identification_ValidateInput` resuelve el código funcional a la FK interna y comprueba normalización, longitud, restricción numérica y compatibilidad natural/jurídica antes de crear una identidad. Un tipo inactivo no puede utilizarse para nuevas capturas ni para seleccionar una identificación facturable; no se eliminan las relaciones históricas ya existentes.

## Propiedad de datos

- `Person` contiene clasificación natural/jurídica, nombre legal y nombre comercial opcional.
- `PersonIdentification` contiene solamente la identidad global y sus reglas de formato y facturación.
- `Client` contiene por empresa dirección de facturación, correo, teléfono y condiciones comerciales.

Una persona encontrada no se modifica al crear un cliente para otra empresa. La corrección del maestro global es una capacidad independiente.
