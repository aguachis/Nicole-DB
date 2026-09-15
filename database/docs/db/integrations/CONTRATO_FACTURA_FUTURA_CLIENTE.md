# Contrato futuro: factura y cliente centralizado

## Alcance

Esta definición no crea `Invoice`, no modifica comprobantes existentes ni habilita facturación. Define la integración obligatoria para cuando se apruebe su DDL.

## Relación multiempresa

La futura tabla de factura deberá guardar `ClientId uniqueidentifier NOT NULL` y `CompanyId uniqueidentifier NOT NULL`, con FK compuesta:

```sql
FOREIGN KEY (ClientId, CompanyId)
    REFERENCES dbo.Client (ClientId, CompanyId)
```

No se acepta una FK aislada por `ClientId`, porque permitiría asociar un cliente de otra empresa. La clave candidata `UQ_Client_Client_Company` queda definida por la segunda fase de esta migración.

## Snapshot inmutable del comprador

Al emitir la factura se copian como columnas propias e inmutables: `BuyerIdentificationType`, `BuyerIdentification`, `BuyerLegalName`, `BuyerAddress` y `BuyerEmail`. Estos valores acreditan lo emitido en ese momento y no se recalculan si cambian `Person`, `PersonIdentification`, `TaxRegistration` o `Client`.

La dirección usada es `Client.BillingAddress` confirmada localmente. `TaxRegistration.TaxAddress` no se usa como sustituto automático. Cualquier reemisión, nota de crédito o rectificación deberá respetar la política tributaria que se defina junto con el DDL de factura.

## Precondiciones

- La migración de registro global está aplicada hasta su fase 2 y `Client` tiene identidad facturable, contacto local y clave `(ClientId, CompanyId)`.
- El comando de emisión autoriza la empresa activa y utiliza los datos de `Client` dentro de esa empresa.
- El contrato de factura se convierte en DDL, procedimientos y actualización del diagrama ER mediante un cambio OpenSpec posterior.
