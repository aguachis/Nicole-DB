## Why

Los procedimientos almacenados del registro global usan el prefijo `usp_`, mientras que los procedimientos existentes y sus contratos de integracion usan `P_`. Esta inconsistencia crea una API SQL dificil de descubrir y rompe la convencion establecida del repositorio.

## What Changes

- Se establece `dbo.P_<Dominio>_<Accion>` como la nomenclatura canonica para todos los procedimientos almacenados del repositorio.
- **BREAKING** Se renombran los cinco procedimientos `dbo.usp_Registry_*` y `dbo.usp_Client_*` a sus equivalentes `dbo.P_Registry_*` y `dbo.P_Client_*`; no se mantendran aliases `usp_` en el bootstrap de una base vacia.
- Se actualizan el manifiesto SQLCMD, permisos de ejecucion y contratos/documentacion de integracion que invocan esos procedimientos.

## Capabilities

### New Capabilities

- `stored-procedure-naming`: Define y exige una nomenclatura uniforme para la API de procedimientos almacenados.

### Modified Capabilities

- Ninguna.

## Impact

- Scripts SQL bajo `database/procedures/registry-client/`, el manifiesto de bootstrap y los grants de `nicole_app`.
- Consumidores de backend/API y su documentacion de integracion para registro y clientes.
- La base vacia creada por el manifiesto expondra exclusivamente los nombres canonicos `P_`.
