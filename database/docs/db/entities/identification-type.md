# Entidad: IdentificationType

`dbo.IdentificationType` define los tipos de identificación permitidos por el maestro global, como `CEDULA`, `RUC`, `PASAPORTE` e `IDENTIFICACION_EXTERIOR`.

Además de su clave física `IdentificationTypeId`, cada tipo define un `Code` único y estable para contratos de backend/UI, longitudes mínima y máxima, si admite solo números, si aplica a personas naturales o jurídicas y si puede utilizarse para facturación.

`Status = 'A'` es la única regla de vigencia: habilita la selección en catálogo, la resolución y las capturas nuevas. No existe una bandera `IsActive` paralela. Las identificaciones ya almacenadas de un tipo inactivo se conservan como histórico, pero no pueden seleccionarse de nuevo para facturación.

`P_Identification_ValidateInput` concentra la normalización, resolución de `Code` a `IdentificationTypeId`, longitud, restricción numérica y compatibilidad con `PersonKind`. `P_Auth_Register`, `P_User_Create`, `P_Person_ResolveIdentification` y `P_Client_Create` la invocan; los contratos externos reciben o devuelven `Code`, nunca la clave física. La aplicación no debe duplicar estas reglas ni inferir que un RUC corresponde necesariamente a una persona jurídica.
