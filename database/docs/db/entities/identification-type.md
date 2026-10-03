# Entidad: IdentificationType

`dbo.IdentificationType` define los tipos de identificación permitidos por el maestro global, como `CEDULA`, `RUC`, `PASAPORTE` e `IDENTIFICACION_EXTERIOR`.

Además de su clave física `IdentificationTypeId`, cada tipo define un `Code` estable para el backend, longitudes mínima y máxima, si admite solo números, si aplica a personas naturales o jurídicas y si puede utilizarse para facturación.

`P_Person_ResolveIdentification` y `P_Client_Create` reciben el código estable, validan esos metadatos y resuelven internamente la clave física. La aplicación no debe duplicar esas reglas ni inferir que un RUC corresponde necesariamente a una persona jurídica.
