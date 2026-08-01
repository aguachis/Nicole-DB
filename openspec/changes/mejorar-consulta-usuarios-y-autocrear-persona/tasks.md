## 1. Ajuste de consulta de usuarios

- [x] 1.1 Actualizar `P_User_List` para incluir `lastName`, `middleName`, `firstName`, `identification` y `phone` desde `dbo.Person`.
- [x] 1.2 Verificar que la salida mantenga compatibilidad con columnas existentes del SP actual.
- [x] 1.3 Validar que reglas de filtro de estado (`A`/`I`) se mantengan sin regresion.

## 2. Ajuste de creacion de usuario con persona

- [x] 2.1 Redefinir parametros de `P_User_Create` para aceptar datos de persona necesarios cuando `PersonId` no se envie.
- [x] 2.2 Implementar busqueda de persona por identificacion y reutilizacion de `PersonId` cuando exista activa.
- [x] 2.3 Implementar creacion de persona cuando no exista, con auditoria y estado activo.
- [x] 2.4 Mantener validaciones de duplicidad para email y username antes del commit.
- [x] 2.5 Garantizar transaccion unica con rollback completo ante error tecnico.

## 3. Contrato y codigos funcionales

- [x] 3.1 Confirmar que `P_User_List` y `P_User_Create` devuelvan `result_code` y `result_message` en todos los caminos.
- [x] 3.2 Alinear codigos funcionales para validaciones de parametros, duplicados y no encontrados.

## 4. Documentacion de integracion

- [x] 4.1 Actualizar documento de integracion API de seguridad/usuarios con nuevos parametros de alta.
- [x] 4.2 Documentar nuevos campos de salida del listado de usuarios y ejemplos de mapeo en API.
- [x] 4.3 Incluir tabla de errores esperados para flujo de autocreacion de persona.

## 5. Verificacion final

- [x] 5.1 Revisar consistencia con `docs/db/02-conventions.md` y convenciones de SP del repositorio.
- [x] 5.2 Ejecutar `openspec validate --changes "mejorar-consulta-usuarios-y-autocrear-persona"`.
