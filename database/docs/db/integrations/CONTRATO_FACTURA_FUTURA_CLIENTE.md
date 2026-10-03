# Contrato futuro: factura y cliente centralizado

Cuando exista DDL de factura, esta deberá guardar `ClientId` y `CompanyId` con una FK compuesta hacia `Client(ClientId, CompanyId)`. No se acepta una FK aislada por `ClientId`.

Al emitir, la factura copiará como snapshot inmutable `BuyerIdentificationType`, `BuyerIdentification`, `BuyerLegalName`, `BuyerAddress` y `BuyerEmail`. Esos valores no se recalculan si después cambian `Person`, `PersonIdentification` o `Client`.

La dirección de factura procede de `Client.BillingAddress`, confirmada en la empresa emisora.
