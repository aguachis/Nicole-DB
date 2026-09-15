# Ficha Técnica de Comprobantes Electrónicos Offline - SRI

> **Fuente:** Servicio de Rentas Internas (SRI), Ecuador\
> **Documento:** Ficha Técnica de Comprobantes Electrónicos Offline -
> Emisión de comprobantes electrónicos, método de automatización
> off-line\
> **Versión:** 2.34\
> **Actualización:** julio de 2026\
> **Uso sugerido:** contexto técnico para implementación, validación,
> firma electrónica y autorización de comprobantes electrónicos ante el
> SRI.\
> **Nota:** El contenido que sigue fue extraído del PDF fuente. En
> tablas o diagramas complejos puede conservar espaciado de texto para
> no perder estructura.

------------------------------------------------------------------------

Guía para contribuyentes Ficha técnica: FICHA TÉCNICA DE COMPROBANTES
ELECTRÓNICOS OFFLINE. "Emisión de comprobantes electrónicos" Método de
automatización off-line. ACTUALIZADO JULIO 2026 Versión 2.34

                                        1

------------------------------------------------------------------------

Índice 1. Introducción
......................................................................................................................................
7

2.  Consideraciones generales
    ................................................................................................................
    7

3.  Base
    legal...........................................................................................................................................
    7

4.  Proceso de solicitud de certificación de emisión de documentos
    electrónicos ............................... 9

5.  Proceso de generación, firma electrónica y solicitud de autorización
    en línea de comprobantes electrónicos
    .........................................................................................................................................
    11

6.  Proceso de firmas electrónicas y lineamientos de parametrización en
    los aplicativos .................. 14

7.  Servicios expuestos en internet para la autorización de comprobantes
    electrónicos ................... 16

8.  Servicios expuestos en internet para consultas de comprobantes
    electrónicos ............................ 21

9.  Facturador gratuito de generación de comprobantes electrónicos
    ............................................... 26

10. Caso específico de retenciones en los comercializadores /
    Distribuidores de derivados del petróleo y retención presuntiva de
    IVA a los editores, distribuidores y voceadores que participan en la
    comercialización de periódicos y/o
    revistas....................................................................................
    35

11. Códigos de errores y advertencias de validación
    ..........................................................................
    36

12. Códigos de error para aplicación de la devolución automática del IVA
    ....................................... 39

13. Servicios web para la devolución automática del IVA a personas
    adultas mayores - DIG............ 41

14. Anexos
    ...........................................................................................................................................
    48

ANEXO 1 - FORMATOS XML VERSIÓN 1.0.0
........................................................................................
48

ANEXO 2 - FORMATO DE REPRESENTACIONES IMPRESAS DE DOCUMENTOS
ELECTRÓNICOS (RIDE)
.............................................................................................................................................................
60

ANEXO 3 - FORMATOS XML VERSIÓN 1.1.0
........................................................................................
66

ANEXO 4 - FORMATOS XML FACTURA EXPORTACIÓN APLICADOS A LAS VERSIONES
1.0.0 y 1.1.0 ... 74

ANEXO 5 - FORMATOS XML FACTURA REEMBOLSO APLICADO EN LAS VERSIONES 1.0.0
y 1.1.0 ...... 82

ANEXO 6 - FORMATOS XML FACTURA CON SUBSIDIOS APLICADO EN LAS VERSIONES
1.0.0 y 1.1.0 89

ANEXO 7 -- FORMATOS DE REPRESENTACIÓN IMPRESA DE DOCUMENTO ELECTRÓNICO
CON SUBSIDIO (RIDE)
..................................................................................................................................
93

ANEXO 8 - FORMATOS XML FACTURA CON RUBROS DE TERCEROS APLICADO EN LAS
VERSIONES 2.0.0 y 2.1.0
.........................................................................................................................................
94

                                                                                                                                                              2

------------------------------------------------------------------------

ANEXO 9 - FORMATOS XML FACTURA SUSTITUTIVA DE GUÍA DE REMISIÓN APLICADO
EN LAS VERSIONES 2.0.0 y 2.1.0
......................................................................................................................
98

ANEXO 10 - FORMATO XML DE COMPROBANTE DE RETENCIÓN ATS VERSIÓN 2.0.0
...................... 104

ANEXO 11 -- REQUISITOS OBLIGATORIOS PARA EL XML DE FACTURA COMERCIAL
NEGOCIABLE.... 109

ANEXO 12 -- REQUISITO OBLIGATORIO PARA EL XML DE FACTURA EN VENTA DE
COMBUSTIBLES LÍQUIDOS DERIVADOS DE HIDROCARBUROS Y BIOCOMBUSTIBLES.
................................................ 110

ANEXO 13 -- REQUISITO OBLIGATORIO PARA XML DE COMPROBANTES EMITIDOS
DESDE UNA MÁQUINA FISCAL
..............................................................................................................................
111

ANEXO 14 -- EJEMPLO FIRMA ELECTRÓNICA BAJO ESTÁNDAR XADES_BES
..................................... 111

ANEXO 15 -- COMPATIBILIDAD DISPOSITIVOS PROVISTOS
............................................................... 113

ANEXO 16 -- REQUISITO OBLIGATORIO DE LLENADO PARA EL XML DE FACTURA EN
LA VENTA DE COMBUSTIBLES LÍQUIDOS DERIVADOS DE HIDROCARBUROS Y
BIOCOMBUSTIBLES. ...................... 114

ANEXO 17 -- FORMATOS XML LIQUIDACIÓN DE COMPRA DE BIENES Y PRESTACIÓN DE
SERVICIOS EN LAS VERSIONES 1.0.0 Y 1.1.0
.............................................................................................................
115

ANEXO 18 -- REQUISITOS OBLIGATORIOS DE LLENADO EN LA FACTURA ELECTRÓNICA
POR LA ENTREGA DE FUNDAS
PLÁSTICAS......................................................................................................
123

ANEXO 19 -- APLICACIÓN DE LAS AUTORRETENCIONES
................................................................... 124

ANEXO 20 -- REQUISITO PARA LA APLICACIÓN DE LA DEVOLUCIÓN AUTOMÁTICA DEL
IVA EN EL XML DE FACTURAS, NOTAS DE CRÉDITO Y NOTAS DE DÉBITO.
................................................................ 126

ANEXO 21 -- REQUISITO OBLIGATORIO PARA COMPROBANTES ELECTRÓNICOS
EMITIDOS POR CONTRIBUYENTES DESIGNADOS COMO AGENTES DE RETENCIÓN.
................................................. 127

ANEXO 22 -- REQUISITO OBLIGATORIO PARA COMPROBANTES ELECTRÓNICOS
EMITIDOS POR CONTRIBUYENTES RIMPE.
.................................................................................................................
129

ANEXO 23 -- REQUISITO OBLIGATORIO EL LLENADO PARA EL XML DE COMPROBANTES
DE VENTA EN LA TRANSFERENCIA LOCAL DE MATERIALES DE
CONSTRUCCIÓN..................................................... 131

ANEXO 24 -- REQUISITO OBLIGATORIO PARA COMPROBANTES ELECTRÓNICOS
EMITIDOS POR GRANDES CONTRIBUYENTES.
............................................................................................................
132

ANEXO 25 -- REQUISITOS OBLIGATORIOS DE LLENADO PARA EL XML DE FACTURAS
EMITIDAS POR LAS OPERADORAS Y SUS SOCIOS O ACCIONISTAS, DE TRANSPORTE
COMERCIAL, EXCEPTO TAXIS. 133

ANEXO 26 -- REQUISITO OBLIGATORIO DE INFORMACIÓN DE RUC DE PROVEEDOR DE
SISTEMAS INFORMÁTICOS O SERVICIOS DE FACTURACIÓN ELECTRÓNICA
....................................................... 135

15. Glosario de términos
    ...................................................................................................................
    136

                                                                                                                                               3

------------------------------------------------------------------------

16. Preguntas técnicas frecuentes
    ....................................................................................................
    139

                                                                                                                                        4

------------------------------------------------------------------------

           Fecha de

Versión Descripción de los cambios modificación Nuevos WS para ambiente
de pruebas. 2.0 05/08/2015 Se elimina las claves de uso complementario
(contingencia). 2.01 10/11/2015 Nuevos WS para ambiente de producción.
2.02 29/01/2016 Nuevos campos para factura con subsidios. Nuevos campos
para factura con rubros de terceros y factura sustitutiva de guía de
2.03 21/03/2016 remisión. Tabla 18: nuevos códigos de ICE. 2.04
01/05/2016 Tabla 24: nuevas formas de pago. Tabla 17: nueva tarifa de
IVA vigente a partir del 01 de junio de 2016. 2.05 01/06/2016 Se incluye
en el numeral 11.8 (ANEXO 7) los requisitos obligatorios para el XML de
Factura Comercial Negociable. Tabla 27: nuevo código descuento solidario
2% IVA. Tabla 28: nuevos códigos para las devoluciones de IVA por uso de
medios electrónicos 2.06 22/06/2016 exclusivamente para notas de
crédito. Se incluye ANEXO 8 nuevos campos para la inclusión del
descuento solidario 2% de IVA, devoluciones de IVA por uso de medios
electrónicos y formas de pago. Actualización tabla 24: formas de Pago.
2.07 28/06/2016 Actualización tabla 20: retenciones de IVA.
Actualización tabla 24: formas de pago. 2.08 15/09/2016 Actualización
tabla 28: código para las devoluciones de IVA por descuento solidario 2%
IVA exclusivamente para notas de crédito. Eliminación de la tabla 27:
nuevo código descuento solidario 2% IVA Eliminación de la tabla 28:
nuevos códigos para las devoluciones de IVA por uso de medios 2.09
18/09/2017 electrónicos exclusivamente para notas de crédito.
Eliminación del anexo 8: nuevos campos para la inclusión del descuento
solidario 2% de IVA. 2.10 01/12/2017 Anexo 10: comprobante de retención
ATS versión 2.0.0. Inclusión de campo placa para los XML de factura en
la venta de combustibles líquidos 2.11 07/08/2018 derivados de
hidrocarburos (CLDH) y biocombustibles para las versiones 1.0.0, 1.1.0,
2.0.0, 2.1.0. Inclusión de los campos marca, tipo y serie en todas sus
versiones para los XML de 2.12 07/01/2019 Factura, Nota de Crédito, Nota
de Débito, Guía de Remisión y Comprobantes de Retención emitidos desde
una máquina fiscal. Tabla 29: formatos de llenado del campo placa
establecido por la Agencia de Regulación y Control de Energía y Recursos
Naturales no Renovables. 2.13 15/05/2019 Tabla 30: códigos y descripción
de llenado en la factura electrónica por la venta de combustibles, según
formatos establecido por la Agencia de Regulación y Control de Energía y
Recursos Naturales no Renovables. Anexo 17 -- Formatos XML liquidación
de compra de bienes y prestación de servicios en 2.14 19/07/2019 las
versiones 1.0.0 y 1.1.0. Actualización tabla 29: formatos de llenado del
campo placa establecido por la Agencia de 2.15 03/01/2020 Regulación y
Control de Energía y Recursos Naturales no Renovables. Actualización
tabla 18: tarifa del ICE. Actualización tabla 29: formatos de llenado
del campo placa establecido por la Agencia de Regulación y Control de
Energía y Recursos Naturales no Renovables. 2.16 03/02/2020
Actualización tabla 30: códigos y descripción de llenado en la factura
electrónica por la venta de combustibles, según formatos establecido por
la Agencia de Regulación y Control de Energía y Recursos Naturales no
Renovables. Anexo 18 -- Requisitos obligatorios de llenado en la factura
electrónica por la entrega de 2.17 21/08/2020 fundas plásticas. 2.18
29/09/2020 Anexo 19 -- Aplicación de las autorretenciones. Servicios web
para la devolución automática del IVA a personas adultas mayores - DIG
2.19 19/11/2020 Anexo 20 -- Inclusión de campo para la devolución
automática del IVA a personas adultas mayores en facturas, notas de
crédito y notas de débito. Anexo 21 -- Requisito obligatorio para
comprobantes electrónicos emitidos por 2.20 11/12/2020 contribuyentes
designados Microempresas y/o Agentes de Retención.

                                                                                                                 5

------------------------------------------------------------------------

           Fecha de

Versión Descripción de los cambios modificación Anexo 22 -- Requisito
obligatorio para comprobantes electrónicos emitidos por contribuyentes
RIMPE. 2.21 06/01/2022 Actualización de porcentajes de retención de ISD.
Actualización de porcentajes de retención de IVA. Actualización de
tarifas de IVA. Actualización del Anexo 10 -- Formato XML de comprobante
de retención ATS versión 2.0.0. 2.22 01/09/2022 Actualización del Anexo
22 -- Requisito obligatorio para comprobantes electrónicos emitidos por
contribuyentes RIMPE Emprendedor y RIMPE Negocio Popular. Actualización
del monto máximo para emitir una factura a consumidor final. 2.23
01/02/2023 Actualización de porcentajes de retención de ISD. 2.24
07/02/2023 Actualización tabla 18: tarifa del ICE. Actualización de
porcentajes de retención de ISD. 2.25 30/01/2024 Actualización Anexo 19
-- Aplicación de las autorretenciones. Actualización Tabla 17: Tarifas
de IVA 2.26 05/03/2024 Actualización de porcentajes de retención del
impuesto a la renta Actualización de porcentajes de retención de ISD.
2.27 28/03/2024 Anexo 2: Formato de representaciones impresas de
documentos electrónicos (RIDE) Anexo 23 -- Requisito obligatorio de
llenado para los XML de comprobantes de venta y documentos
complementarios en la venta de materiales de construcción Anexo 24 --
Requisito obligatorio para comprobantes electrónicos emitidos por
Grandes 2.28 25/06/2024 Contribuyentes. Actualización de servicios web
para la devolución automática del IVA a personas adultas 2.29 25/10/2024
mayores -- DIG 2.30 06/03/2025 Actualización de porcentajes de retención
de ISD. 8. Nuevos servicios expuestos en internet para consultas de
comprobantes electrónicos: 2.31 27/03/2025 WS -- Consulta de validez de
comprobantes electrónicos WS -- Consulta de factura comercial negociable
Anexo 25 -- Requisito obligatorio de llenado para el XML de facturas
emitidas por 2.32 08/10/2025 operadoras de transporte comercial (no
aplica para taxis y socios o accionistas de taxis). Anexo 25 --
Inclusión del requisito obligatorio campo placa en el XML de facturas
emitidas 2.33 13/07/2026 por operadoras de transporte comercial (no
aplica para taxis y socios o accionistas de taxis. Tabla 33: Formato del
llenado campo placa. Anexo 26 -- Requisito obligatorio de información de
proveedores de sistemas informáticos o 2.34 27/07/2026 servicios de
facturación electrónica.

                                                                                                                  6

------------------------------------------------------------------------

FICHA TÉCNICA: MANUAL DE USUARIO, CATÁLOGO Y ESPECIFICACIONES TÉCNICAS
SOBRE EL PROCESO DE AUTORIZACIÓN Y EMISIÓN DE DOCUMENTOS ELECTRÓNICOS
(Aplica para la ciudadanía que emite facturas, comprobantes de
retención, guías de remisión, notas de crédito, notas de débito y
liquidaciones de compra de bienes y prestación de servicios firmadas
electrónicamente)

1.  Introducción El presente documento tiene la finalidad de brindar la
    información, el servicio y la asistencia a la ciudadanía, a los
    contribuyentes que opten por certificarse en el Sistema de
    Comprobantes Electrónicos brindado por el Servicio de Rentas
    Internas a través del portal web institucional www.sri.gob.ec.

Las directrices y actualizaciones de una implementación efectiva para
los contribuyentes se las realizará sobre este documento, el mismo que
será socializado a través de los medios de comunicación que dispone la
Administración Tributaria y principales medios de información a escala
nacional.

2.  Consideraciones generales Las especificaciones operativas y técnicas
    se enmarcan en las siguientes descripciones:

➢ Solicitud de certificación de emisión de comprobantes electrónicos
para los ambientes de pruebas y producción; ➢ Lineamientos en la
parametrización de aplicativos del contribuyente (estándar en firmas
electrónicas); ➢ Servicios expuestos a través de WEB Service, conexiones
con internet para la autorización de comprobantes electrónicos; ➢ Uso
del facturador electrónico gratuito para generar, firmar y solicitar
autorización de los comprobantes electrónicos; ➢ Esquemas XSD, formatos
XML (generación individual y generación agrupados por lotes de
comprobantes electrónicos para solicitar la autorización).

Los emisores de comprobantes firmados electrónicamente operarán con
certificados digitales de firma electrónica adquiridos en cualquiera de
las entidades de certificación autorizadas en el país.

3.  Base legal • Ley de Régimen Tributario Interno.

                                                                                    7

------------------------------------------------------------------------

• Ley de Comercio Electrónico, Firmas y Mensajes de Datos publicado en
el Suplemento del Registro Oficial No. 557 de 17 de abril de 2002. • Ley
Orgánica de Solidaridad y de Corresponsabilidad Ciudadana para la
Reconstrucción y Reactivación de las zonas Afectadas por el Terremoto de
16 de abril de 2016. • Ley Orgánica de Simplificación y Progresividad
Tributaria, Suplemento Registro Oficial Nro. 111 de 31 de diciembre de
2019. • Decreto No. 181 publicado en el Registro Oficial No. 553 de 11
de octubre del 2011, en el cual norma la numeración de identificadores
de campo y campos mínimos de los tipos de certificados. • Reglamento
para la Aplicación de la Ley de Régimen Tributario Interno. • Reglamento
de Comprobantes de Venta, Retención y Documentos Complementarios. •
Reglamento a la Ley de Comercio Electrónico, Firmas y Mensajes de Datos,
publicado en el Registro Oficial No. 735 de 31 de diciembre de 2002. •
Reglamento para la Aplicación de la Ley Orgánica de Simplificación y
Progresividad Tributaria, Segundo Suplemento al Registro Oficial Nro.
260 de 04 de agosto de 2020. • Resolución No. NAC-DGERCGC12-00105 de 09
de marzo de 2012, publicada en Registro Oficial No. 666 de 21 de marzo
de 2012. • Resolución NAC-DGERCGC14-00788, publicada en el Registro
Oficial 351 del 9 de octubre de 2014. • Resolución
NAC-DGERCGC15-00000284, publicada en el Registro Oficial 473 de 6 de
abril de 2015. • Resolución NAC-DGERCGC15-00003184, publicada en el
Registro Oficial 661 de 4 de enero de 2016. • Resolución
NAC-DGERCGC16-00000247, publicada en el Registro Oficial 781 de 22 de
junio de 2016. • Resolución NAC-DGERCGC16-00000385, publicada en el
Registro Oficial 838 de 12 de septiembre de 2016. • Resolución
NAC-DGERCGC17-00000309, publicada en el Segundo Suplemento del Registro
Oficial 8 de 6 de junio de 2017. • Resolución NAC-DGERCGC17-00000460,
publicada en el Registro Oficial 72 de 5 de septiembre de 2017. •
Resolución NAC-DGERCGC18-00000214, publicada en el Registro Oficial 255
de 5 de junio de 2018. • Resolución NAC-DGERCGC18-00000233, publicada en
el Registro Oficial 255 de 5 de junio de 2018. • Resolución
NAC-DGERCGC19-00000023 publicada en el Suplemento del Registro Oficial
No. 501 de 04 de junio de 2019. • Resolución NAC-DGERCGC20-00000059
publicada en la Edición Especial del Registro Oficial No. 1100 de 30 de
septiembre de 2020.

Los contribuyentes que ingresen una solicitud de certificación y emisión
de documentos electrónicos deberán emitir los comprobantes de venta,
retención y documentos complementarios firmados electrónicamente bajo
las condiciones señaladas en esta ficha técnica.

                                                                                8

------------------------------------------------------------------------

4.  Proceso de solicitud de certificación de emisión de documentos
    electrónicos 4.1 El contribuyente, previo a la solicitud de
    certificación debe tener conocimiento general del proceso de emisión
    de documentos electrónicos propuesto por la Administración
    Tributaria (puede solicitar asistencia llamando al Centro de
    Atención Telefónica 1700 774 774 o solicitar información y
    asistencia a los funcionarios del SRI a escala nacional a través de
    nuestro canal de atención presencial).

4.2 El contribuyente que se incorpore a la modalidad de emisión
electrónica de documentos deberá obtener un certificado digital de firma
electrónica que puede ser adquirido en cualquier entidad de
certificación autorizada por el organismo competente. En el enlace
https://www.sri.gob.ec/nl/facturacion- electronica encontrará las
direcciones electrónicas de las entidades en donde obtendrá detalles
específicos de los certificados digitales de firma electrónica.

      Hay que considerar que con la publicación del Decreto 181 de 11 de octubre de
      2011, las entidades de certificación deberán actualizar los certificados digitales
      de firma electrónica conforme a lo detallado en dicho decreto.

4.3 La solicitud de certificación para los ambientes de pruebas y
producción deberá realizarla directamente a través del portal web del
SRI (Servicios en línea), recuerde que debe encontrarse en estado
activo, al día en sus obligaciones tributarias y haber registrado un
convenio de débito para pago de declaraciones1 para obtener exitosamente
la autorización, esta solicitud se realizará una sola vez para cada
ambiente.

      La solicitud de certificación en el ambiente de pruebas es obligatoria para todos
      los solicitantes, puesto que en este ambiente los emisores podrán realizar
      todas sus acciones en desarrollo, ejecutando y verificando que los
      comprobantes electrónicos cumplan con los esquemas XSD, así como con el
      tipo de firma electrónica incorporada en los comprobantes; adicionalmente se
      verificará la conexión con los enlaces a través de WEB Service que se
      utilizarán para solicitar la autorización de los comprobantes electrónicos
      generados y recibir la respuesta por parte de la Administración Tributaria
      conforme al acuerdo de nivel de servicio; cabe mencionar que los
      comprobantes emitidos en ambiente de pruebas no tendrán ninguna validez
      tributaria, ni legal.

      Cabe recalcar que el ambiente de pruebas fue diseñado únicamente para
      verificar que el comprobante electrónico generado cumpla con las validaciones
      indicadas en el presente documento, por tal motivo no se deben hacer pruebas

1 Mediante Resolución No. NAC-DGERCGC18-00000108 publicada en Primer
Suplemento del Registro Oficial No. 202 de 16 de marzo de

2018, se dispuso que los contribuyentes que se encuentran obligados a
emitir comprobantes de venta, retención y documentos complementarios a
través de mensajes de datos y firmados electrónicamente, así como los
que soliciten autorización para la emisión de dichos comprobantes bajo
esta modalidad de facturación están obligados al pago de impuestos
mediante débito automático.

                                                                                                                                          9

------------------------------------------------------------------------

    de stress o de masividad en este ambiente. Adicionalmente se recomienda
    que, en este ambiente los contribuyentes consideren los diferentes escenarios
    que podrían darse de acuerdo con su giro de negocio.

    Los solicitantes, una vez que hayan verificado en el ambiente de desarrollo que
    el proceso de generación de comprobantes electrónicos, así como su envío y
    autorización, están estructurados correctamente y que sus pruebas realizadas
    sean de calidad, podrán ingresar la solicitud de emisión en el ambiente de
    producción; todas las acciones que se realicen en este ambiente, así como los
    comprobantes electrónicos autorizados tendrán validez tributaria. Es
    responsabilidad del emisor garantizar que el sistema utilizado para la
    generación del comprobante electrónico cumpla con las validaciones y
    requisitos establecidos en el Reglamento de Comprobantes de Venta,
    Retención y Documentos Complementarios y Resoluciones relacionadas, a fin
    de garantizar que los comprobantes generados en este ambiente sean
    autorizados.

4.4 En la misma solicitud de certificación realizada para el ambiente de
pruebas o producción, el contribuyente deberá escoger el tipo de
comprobante que va a emitir de manera electrónica.

4.5 Todas las transacciones realizadas por los contribuyentes son
sustentadas en los comprobantes firmados electrónicamente, los mismos
que deberán ser enviados al SRI a través del canal WEB Service para la
recepción y validación, el sistema de comprobantes electrónicos
realizará las validaciones correspondientes, generando una contestación
conforme al acuerdo de nivel de servicio.

4.6 Todos los comprobantes que no son autorizados tendrán su descripción
del motivo por el cual no fueron autorizados.

4.7 Una vez generados los comprobantes electrónicos, el emisor tiene la
obligación de enviar dichos comprobantes al receptor mediante correo
electrónico; adicionalmente podrá utilizar otros medios de notificación
(publicación en portal web, mensaje de texto, entre otros).

4.8 En el caso de comprobantes no autorizados, el emisor deberá corregir
el error detectado y enviar nuevamente al SRI para su respectiva
validación. Una vez que el comprobante se encuentre validado y en estado
autorizado, deberá entregar y notificar al receptor.

4.9 Los contribuyentes podrán solicitar adicionalmente la inclusión de
nuevos comprobantes, según su giro de negocio.

                                                                                  10

------------------------------------------------------------------------

5.  Proceso de generación, firma electrónica y solicitud de autorización
    en línea de comprobantes electrónicos 5.1 Los contribuyentes
    generarán sus comprobantes electrónicos en formato .xml conforme a
    los esquemas .xsd que están disponibles en el portal web del SRI, a
    través de sus propios aplicativos informáticos o mediante el
    facturador electrónico que el SRI dispone gratuitamente para los
    contribuyentes.

5.2 Cada comprobante generado contendrá una clave de acceso única que
estará compuesta por 49 dígitos numéricos, el aplicativo a utilizar por
el contribuyente deberá generar de manera automática esta clave, la cual
constituye un requisito obligatorio que le dará el CARACTER de único a
cada comprobante y a la vez se constituirá en el número de autorización
del mismo; en base a esta clave el SRI generará la respuesta de
autorizado o no; a continuación, se describe su conformación:

TABLA 1

                                       Tipo de                                              Etiqueta o tag

No. Descripción de campo Formato Longitud Requisito campo en archivo XML
1 Fecha de emisión ddmmaaaa 8 2 Tipo de comprobante Tabla 3 2 3 Número
de RUC 1234567890001 13 4 Tipo de ambiente Tabla 4 1 5 Serie Numérico
001001 6 Obligatorio `<claveAcceso>`{=html} Número del comprobante 6
000000001 9 (secuencial) 7 Código numérico Numérico 8 8 Tipo de emisión
Tabla 2 1 9 Dígito verificador (módulo 11) Numérico 1

Nota: todos los campos deben completarse conforme a la longitud
indicada, es decir si en el número secuencial no completa los 9 dígitos,
la clave de acceso estará mal conformada y será motivo de rechazo para
su autorización.

El dígito verificador será aplicado sobre toda la clave de acceso (48
dígitos) y deberá ser incorporado por el contribuyente a través del
método denominado "Módulo 11", con un factor de chequeo ponderado (2),
este mecanismo de detección de errores será verificado al momento de la
recepción del comprobante. Cuando el resultado del dígito verificador
obtenido sea igual a once (11), el dígito verificador será el cero (0) y
cuando el resultado del dígito verificador obtenido sea igual a diez 10,
el dígito verificador será el uno (1).

El código numérico constituye un mecanismo para brindar seguridad al
emisor en cada comprobante emitido, el algoritmo numérico para conformar
este código es potestad absoluta del contribuyente emisor.

                                                                                                     11

------------------------------------------------------------------------

Ejemplo de verificación utilizando algoritmo de módulo 11:

                     Cadena de verificación: 41261533

                                    +---+---+---+---+---+---+---+---+ +---+
                                     |4 |1 |2| 6| 1| 5| 3| 3|-|?|
    Pasos 1 y 2                     +---+---+---+---+---+---+---+---+ +---+
                                      | |      |    | | | | |
                                     x3 x2 x7 x6 x5 x4 x3 x2
                                      | |      |    | |     | | |
                                    =12 =2 =14 =36 =5 =20 =9 =6

    Paso 3                            12 +2 +14 +36 +5 +20 +9 +6 = 104

    Paso 4                           104 mod 11 = 5 (ya que 104 = 11 x 9 + 5)

    Paso 5                           11 - 5 = 6                                      Resultado = 6

5.3 El código que conformará el tipo de emisión según la clave de acceso
generada se detalla a continuación:

TABLA 2

                       No.                     Tipo de emisión                          Código       Requisito
                         1                     Emisión normal2                             1        Obligatorio

5.4 Los tipos de comprobantes que pueden generar los contribuyentes de
manera electrónica se detalla conforme al siguiente cuadro:

TABLA 3

                                                                                                     Etiqueta o tag en
             No.             Nombre comprobante                        Código         Requisito
                                                                                                       archivo XML
              1      FACTURA                                               01
                     LIQUIDACIÓN DE COMPRA DE
              2      BIENES Y PRESTACIÓN DE                                03
                     SERVICIOS
              3      NOTA DE CRÉDITO                                       04         Obligatorio       <codDoc>
              4      NOTA DE DÉBITO                                        05
              5      GUÍA DE REMISIÓN                                      06
              6      COMPROBANTE DE RETENCIÓN                              07

5.5 El código que conformará el tipo de ambiente según la clave de
acceso se cita a continuación:

2 Para el método de autorización offline, solo existe el tipo de emisión
normal.

                                                                                                                         12

------------------------------------------------------------------------

TABLA 4

                     No.              Tipo de ambiente           Código         Requisito

                      1      Pruebas                               1
                                                                               Obligatorio
                      2      Producción                            2

5.6 Los contribuyentes que generen sus comprobantes de venta, retención
y documentos complementarios firmados electrónicamente en el ambiente de
pruebas, pueden utilizar en el campo de la razón social del receptor,
destinatario y agente retenido la denominación PRUEBAS SERVICIO DE
RENTAS INTERNAS.

TABLA 5

                             Identificación
                No.                                 Número                  Razón Social
                               Receptor
                 1        RUC                    xxxxxxxxxx001
                                                                   PRUEBAS SERVICIO DE
                 2        Cédula de identidad      xxxxxxxxxx
                                                                     RENTAS INTERNAS
                 3        Pasaporte              xxxxxxxxxxxxx

5.7 Conforme al tipo de transacción efectuada deberá señalar el tipo de
cliente, sujeto retenido o destinatario, según el detalle:

TABLA 6

           No.                  Tipo de identificación            Código            Requisito
            1        RUC                                               04           Obligatorio
            2        CÉDULA                                            05           Obligatorio
            3        PASAPORTE                                         06           Obligatorio
            4        VENTA A CONSUMIDOR FINAL*                         07           Obligatorio
            5        IDENTIFICACIÓN DEL EXTERIOR*                      08           Obligatorio

          *Venta a consumidor final: se consignará 13 dígitos de nueve en la identificación del cliente
          (9999999999999).
          *Identificación del exterior: corresponderá al número de Identificación otorgado por la
          Administración Tributaria (AT) del país que es residente fiscal.
          * En el caso de emisión de liquidaciones de compra de bienes y prestación de servicios no se
          encuentra habilitado el uso del tipo de identificación venta a consumidor final
          * En el caso de emisión de notas de crédito, notas de débito y comprobantes de retención, se
          debe obligatoriamente identificar al receptor o sujeto retenido con el tipo de identificación
          correspondiente (RUC, cédula, pasaporte o identificación del exterior).

5.8 Si los comprobantes electrónicos cumplen con los esquemas y firmas
electrónicas, el Servicio de Rentas Internas autorizará los comprobantes
de manera automática, en caso de no autorizarlos se indicará el motivo
del rechazo.

5.9 En el método de autorización offline la clave de acceso generada por
el emisor se constituye en el número de autorización del mismo.

                                                                                                          13

------------------------------------------------------------------------

Como parte de la respuesta que el SRI genera por cada comprobante
emitido correctamente, se insertará un listado de advertencias; como por
ejemplo para el caso en que los comprobantes hayan sido emitidos en el
ambiente de pruebas y por alguna indicación que se quiera comunicar.

                                             Aparecerá texto informativo, por ejemplo, si es
             Listado de advertencias         una autorización para un ambiente de pruebas
                                                o algún comunicado por parte del SRI.

5.10 En caso de que un comprobante haya sido rechazado debido a
problemas de inconsistencia en su información (ver tabla de códigos de
errores y advertencias de validación), el emisor deberá utilizar la
misma clave de acceso y secuencial para que una vez corregida la
inconsistencia, pueda ser enviado nuevamente al SRI para su
autorización.

5.11 En el caso de que un comprobante se encuentre autorizado, el WEB
Service de autorización devuelve el XML autorizado, pero si el
comprobante fue no autorizado varias veces, el WEB Service retornará
únicamente el último estado.

5.12 Constituye obligación del contribuyente el envío del comprobante
electrónico al SRI de manera individual o en lote; y la verificación de
que el comprobante conste en estado autorizado. A continuación, se
describen los estados del comprobante electrónico:

TABLA 6

                         Estado del comprobante
              No.                                                SIGLAS
                               electrónico
              1     En procesamiento                               PPR
              2     Autorizado                                     AUT
              3     No autorizado                                  NAT

Cuando el comprobante electrónico se encuentre en estado No Autorizado
(NAT), el emisor estará en la obligación de corregir y enviar nuevamente
el comprobante electrónico a través del WEB Service y posteriormente
notificar y entregar al receptor: destinatario o sujeto retenido el
nuevo comprobante electrónico, mediante correo electrónico. Cabe aclarar
que el tiempo máximo que le tomará al SRI en procesar un comprobante
electrónico será de 24 horas.

Es obligación de los ciudadanos que reciben comprobantes electrónicos
validar sus comprobantes mediante el portal web del Servicio de Rentas
Internas.

6.  Proceso de firmas electrónicas y lineamientos de parametrización en
    los aplicativos

                                                                                                14

------------------------------------------------------------------------

6.1 Para la generación y emisión de los documentos electrónicos deberán
obligatoriamente firmar cada archivo xml bajo el estándar de firma
digital de documentos XML: XadES_BES, esto quiere decir que cada archivo
.xml tendrá dentro de su estructura la firma electrónica y constituirá
un documento electrónico válido una vez que el SRI proceda con la
autorización.

6.2 A continuación, se detallan las especificaciones técnicas
relacionadas al estándar:

TABLA 7

      Descripción      Especificación               Documentación técnica relacionada

Estándar de firma XadES_BES
http://uri.etsi.org/01903/v1.3.2/ts_101903v010302p.pdf Versión del
esquema 1.3.2 http://uri.etsi.org/01903/v1.3.2# Codificación UTF-8 Tipo
de firma ENVELOPED http://www.w3.org/2000/09/xmldsig#enveloped-signature

6.3 La estructura del formato básico de firma electrónica avanzada
acorde con la presente política se adecua a las especificaciones
definidas en XADES_BES que incluyen los campos que se describen en el
esquema 1.3.2 del cuadro anterior.

6.4 La firma electrónica se considera un nodo más a añadir en el
documento .xml.

      El nivel de seguridad en la firma electrónica está ejecutado sobre tres partes
      de la trama de datos:

      • Todos los elementos o nodos que conforman el comprobante electrónico.
      • Los elementos de firma ubicados en el contenedor “SignedProperties”.
      • El certificado digital con el que se ha firmado incluido en el elemento
        “KeyInfo”.

6.5 Es necesario utilizar el elemento ds: KeyInfo, conteniendo al menos
el certificado firmante codificado en base64. Además, dicha información
precisa ser firmada con objeto de evitar la posibilidad de sustitución
del certificado.

6.6 En el anexo 4 se muestra un ejemplo de una factura firmada bajo el
estándar XadES_BES.

      Cada comprobante deberá incorporar la firma electrónica en formato XADES-
      Bes, misma que se puede realizar con librerías destinadas para el efecto. El
      SRI utilizó el siguiente set de librerías para incorporar y validar la firma de
      cada comprobante:

      MITyCLibXADES
      MITyCLibTSA
      MITyCLibAPI
      MITyCLibOCSP
      MITyCLibTrust


                                                                                                 15

------------------------------------------------------------------------

      Para más información del estándar se puede explorar el siguiente enlace:

      http://webapp.etsi.org/workprogram/Report_WorkItem.asp?WKI_ID=21353

6.7 Sobre aspectos técnicos del estándar de encriptación, se puede
revisar la siguiente dirección: http://www.ietf.org/rfc/rfc2313.txt (RSA
Encryption).

6.8 A continuación, se detallan las especificaciones técnicas
relacionadas al algoritmo de encriptación:

      • Algoritmo de firmado: RSA-SHA1

      • Longitud de clave: 2048 bits. Recomendación técnica basada en documento:
      http://csrc.nist.gov/publications/nistpubs/800-57/sp800-57-Part1-revised2_Mar08-2007.pdf

      • Archivo de Intercambio de Información: PKCS12 (extensión. p12). Este
      archivo deberá ser proporcionado ya sea de manera directa (a través de API´s
      de acceso al token USB), o de manera indirecta a través de la extracción del
      mismo y posterior instalación en una carpeta específica de la cual el software
      proporcionado por el SRI lo utilizará para firmar los comprobantes.

7.  Servicios expuestos en internet para la autorización de comprobantes
    electrónicos Los servicios expuestos en el internet por la
    Administración Tributaria están estandarizados a través de canales
    seguros con protocolos de seguridad y certificados SSL.

7.1 Procesos que ejecutan los servicios expuestos en internet:

7.1.1 Los procesos tienen la función de aceptar o rechazar comprobantes
de manera individual o por lotes.

7.1.2 Para el intercambio de información entre el contribuyente y la
Administración Tributaria, es requisito indispensable que el
contribuyente cuente con acceso a la red de internet banda ancha (por
definición y recomendación del MINTEL la conexión debe ser mayor a
256Kbps).

7.1.3 Para poder acceder al servicio de autorización de comprobantes
electrónicos, el contribuyente deberá crear el software cliente para
poder invocar a los WEB Service que el SRI pone a disposición.

7.1.4 Para garantizar que la conexión es segura se empleará Certificados
Digitales SSL, es decir, el SRI emitirá un certificado válido cuando se
realice la petición de los WEB Service.

       Sin embargo, considerando que los certificados pueden ser cambiados
       durante el periodo de su vigencia por causas técnicas o institucionales, se
       recomienda a los contribuyentes que, en la programación de sus sistemas,

                                                                                            16

------------------------------------------------------------------------

              se considere los mecanismos necesarios para que no se queme en su
              código la información, ni los certificados digitales de comprobantes
              electrónicos del SRI, puesto que estos podrían cambiar sin previo aviso por
              la urgencia según sea el caso.

     7.2      Existen dos ambientes disponibles para la invocación de los WS publicados
              por la Administración Tributaria:

         7.2.1 Uno es para el ambiente de pruebas, donde cada contribuyente certificará
               que su aplicación funcione correctamente con cada tipo de comprobante
               electrónico, las direcciones de los WS son las siguientes:

https://celcer.sri.gob.ec/comprobantes-electronicos-ws/RecepcionComprobantesOffline?wsdl
https://celcer.sri.gob.ec/comprobantes-electronicos-ws/AutorizacionComprobantesOffline?wsdl

         7.2.2 El segundo es para el ambiente de producción, al cual cada contribuyente
               deberá acceder una vez que ha realizado las pruebas y esté seguro de que
               su aplicación funciona correctamente, las direcciones de los WS son las
               siguientes:

https://cel.sri.gob.ec/comprobantes-electronicos-ws/RecepcionComprobantesOffline?wsdl
https://cel.sri.gob.ec/comprobantes-electronicos-ws/AutorizacionComprobantesOffline?wsdl

         7.2.3 Los WS expuestos por la Administración Tributaria son los siguientes:

              Recepción de comprobantes electrónicos

              @WebMethod
              @WebResult(name="RespuestaRecepcionComprobante")
              public RespuestaSolicitud validarComprobante(@WebParam(name = "xml")
              byte[] xml);
              Parámetros:

     I/O     Nombre        Tipo                                            Descripción
    IN      Xml            byte[]   Equivale al archivo xml del comprobante, el cual debe estar firmado por el contribuyente.
                                    Retorna un objeto XML el cual indica la aceptación o rechazo del comprobante.
                                    En caso de rechazo se envía el arreglo con los motivos.
                                    La estructura que cumplirá la respuesta a la invocación del servicio es la siguiente:

                                    Recepción exitosa

                                    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                                      <soap:Body>
                                        <ns2:validarComprobanteResponse xmlns:ns2="http://ec.gob.sri.ws.recepcion">
                                          <RespuestaRecepcionComprobante>
            RespuestaC                      <estado>RECIBIDA</estado>
    OUT     omprobante     Objeto           <comprobantes/>
            Autorizacion                  </RespuestaRecepcionComprobante>
                                        </ns2:validarComprobanteResponse>
                                      </soap:Body>
                                    </soap:Envelope>

                                    Recepción fallida

                                    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                                    <soap:Body>
                                    <ns2:validarComprobanteResponse xmlns:ns2="http://ec.gob.sri.ws.recepcion">


                                                                                                                                17

------------------------------------------------------------------------

                             <RespuestaRecepcionComprobante>
                             <estado>DEVUELTA</estado>
                             <comprobantes>
                             <comprobante>
                             <claveAcceso>1702201205176001321000110010030001000011234567816</claveAcceso>
                             <mensajes>
                             <mensaje>
                             <identificador>35</identificador>
                             <mensaje>DOCUMENTO INVÁLIDO</mensaje>
                             <informacionAdicional>Se encontró el siguiente error en la estructura del comprobante: cvc-
                             complex-type.2.4.a: Invalid content was found starting with element 'totalSinImpuestos'. One
                             of '{fechaEmisionDocSustento}' is expected.</informacionAdicional>
                             <tipo>ERROR</tipo>
                             </mensaje>
                             </mensajes>
                             </comprobante>
                             </comprobantes>
                             </RespuestaRecepcionComprobante>
                             </ns2:validarComprobanteResponse>
                             </soap:Body>
                             </soap:Envelope>

Consulta de respuesta de autorización:

        @WebMethod
        @WebResult(name = "RespuestaAutorizacionComprobante")
        public RespuestaComprobante autorizacionComprobante(
        @WebParam(name            =       "claveAccesoComprobante")  String
        claveAccesoComprobante) ;
        Consulta de respuesta de lote
        @WebMethod
        @WebResult(name = "RespuestaAutorizacionLote")
        public RespuestaLote autorizacionComprobanteLote(@WebParam(name =
        "claveAccesoLote") String claveAccesoLote) ;

Parámetros:

I/O Nombre Tipo Descripción IN ClaveAcces String Equivale a la clave de
acceso del comprobante a ser consultado. o OUT RespuestaL Objeto Retorna
un objeto XML el cual indica la aceptación o rechazo de cada uno de los
oteCompAu comprobantes ingresado en el lote. torizacion En caso de
rechazo se envía el arreglo con los motivos por cada comprobante del
lote.

                             Comprobante Autorizado

                             <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                               <soap:Body>
                                 <ns2:autorizacionComprobanteResponse
                             xmlns:ns2="http://ec.gob.sri.ws.autorizacion">
                                  <RespuestaAutorizacionComprobante>
                                    <claveAccesoConsultada>
                                       0503201201176001321000110010030009900641234567814
                                    </claveAccesoConsultada>
                                    <numeroComprobantes>1</numeroComprobantes>
                                    <autorizaciones>
                                      <autorizacion>
                                        <estado>AUTORIZADO</estado>
                                        <numeroAutorizacion>
                                          0503201201176001321000110010030009900641234567814
                                        </numeroAutorizacion>
                                        <fechaAutorizacion>2012-03-05T16:57:34.997-05:00</fechaAutorizacion>
                                        <ambiente>PRUEBAS</ambiente>
                                        <comprobante><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
                                              <factura id="comprobante" version="1.0.0">


                                                                                                                     18

------------------------------------------------------------------------

I/O Nombre Tipo Descripción
`<!-- FACTURA FIRMADA DIGITALMENTE, VER ANEXO 3 -->`{=html}
`</factura>`{=html}\]\]\> `</comprobante>`{=html} `<mensajes>`{=html}
`<mensaje>`{=html} `<identificador>`{=html}60`</identificador>`{=html}
`<mensaje>`{=html}ESTE PROCESO FUE REALIZADO EN EL AMBIENTE DE PRUEBAS
`</mensaje>`{=html} `<tipo>`{=html}ADVERTENCIA`</tipo>`{=html}
`</mensaje>`{=html} `</mensajes>`{=html} `</autorizacion>`{=html}
`</autorizaciones>`{=html} `</RespuestaAutorizacionComprobante>`{=html}
`</ns2:autorizacionComprobanteResponse>`{=html} `</soap:Body>`{=html}
`</soap:Envelope>`{=html}

                       Comprobante No Autorizado

                       <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                         <soap:Body>
                           <ns2:autorizacionComprobanteResponse
                       xmlns:ns2="http://ec.gob.sri.ws.autorizacion">
                             <RespuestaAutorizacionComprobante>
                              <claveAccesoConsultada>
                                 1302201201176001321000120010030000050431234567814
                              </claveAccesoConsultada>
                               <numeroComprobantes>1</numeroComprobantes>
                               <autorizaciones>
                                 <autorizacion>
                                   <estado>RECHAZADO</estado>
                                   <fechaAutorizacion>2012-02-13T16:34:48.997-05:00</fechaAutorizacion>
                                   <ambiente>PRUEBAS</ambiente>
                                  <comprobante><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
                                         <factura id="comprobante" version="1.0.0">
                                             <!-- FACTURA FIRMADA DIGITALMENTE, VER ANEXO 4 -->
                                         </factura>]]>
                                   </comprobante>
                                   <mensajes>
                                     <mensaje>
                                       <identificador>46</identificador>
                                       <mensaje> RUC no existe </mensaje>
                                       <tipo>ERROR</tipo>
                                     </mensaje>
                                   </mensajes>
                                 </autorizacion>
                               </autorizaciones>
                             </RespuestaAutorizacionComprobante>
                           </ns2:autorizacionComprobanteResponse>
                         </soap:Body>
                       </soap:Envelope>

7.3 El Sistema de Autorización de Documentos Electrónicos soporta un
proceso a través de un ambiente computacional seguro, que brinda alta
disponibilidad y rendimiento, opta por utilizar la infraestructura
necesaria para brindar el servicio a la ciudadanía que realizan
transferencias de bienes o prestación de servicios.

7.4 La manera correcta de consumir las direcciones URL de los WS, es de
manera asíncrona; es decir una vez que el contribuyente envíe el
comprobante al WS de recepción y obtenga la respuesta "RECIBIDA", se
debe esperar un determinado tiempo (se recomienda que este tiempo sea
parametrizable) antes de proceder a consumir la segunda dirección URL de
autorización mediante la

                                                                                                          19

------------------------------------------------------------------------

       clave de acceso del comprobante, para obtener el resultado: procesamiento
       (PPR), autorizado (AUT), no autorizado (NAT).

7.5 Procesos que ejecuta el Sistema de Autorización de Documentos
Electrónicos:

• Exposición de componentes tecnológicos para el servicio de
autorización de comprobantes electrónicos.

• Receptar los documentos firmados electrónicamente (primera validación
general).

• Validación de los documentos firmados electrónicamente (segunda
validación a detalle con certificados de firma electrónica).

• Autorizar de manera automática cada comprobante electrónico. El tiempo
estimado de entrega de la autorización o motivos de errores de un
comprobante, será de un tiempo máximo de 24 horas a partir de la
respuesta de RECIBIDA, generada por el WS de recepción.

• El límite máximo en tamaño y número de comprobantes electrónicos a ser
validados y autorizados por lote es de 500 kb o 50 comprobantes
aproximadamente (considerando cada comprobante con un solo ítem);
mientras que, para el envío individual, el tamaño máximo por comprobante
será de 320 Kb.

TABLA 8: FORMATO XML PARA ENVÍO POR LOTE

                                                                                                LONGITUD /
                        ETIQUETAS O TAGS                          CARACTER      TIPO DE CAMPO
                                                                                                 FORMATO

```{=html}
<?xml version="1.0" encoding="UTF-8"?>
```
Obligatorio - - - `<lote version="1.0.0">`{=html} Obligatorio - -

`<claveAcceso>`{=html}2808201400179210439400110010010000000091234567812\<
Obligatorio Numérico 49 /claveAcceso\>
-`<ruc>`{=html}1792104394001`</ruc>`{=html} Obligatorio Numérico 13
-`<comprobantes>`{=html} Obligatorio - - -`<comprobante>`{=html}
Obligatorio - - \<\![CDATA\[COMPROBANTE\]\]\> Obligatorio - -
-`</comprobante>`{=html} Obligatorio - - -`<comprobante>`{=html}
Obligatorio - - \<\![CDATA\[COMPROBANTE\]\]\> Obligatorio - -
-`</comprobante>`{=html} Obligatorio - - -`</comprobantes>`{=html}
Obligatorio - - `</lote>`{=html} Obligatorio - -

Las claves de acceso para el envío de lote de máximo 50 comprobantes
(512 kb) estarán compuestas de 49 caracteres numéricos, la herramienta o
aplicativo a utilizar por el contribuyente deberá generar de manera
automática la clave de acceso, que constituirá un requisito que dará el
CARACTER de único a cada lote, y la misma servirá para que el SRI
indique si fue recibido; se describe a continuación su conformación:

                                                                                                         20

------------------------------------------------------------------------

TABLA 9:

                                         Tipo de                                                            Etiqueta o tag

No. Descripción de campo Formato Longitud Requisito campo en archivo XML
1 Fecha de emisión ddmmaaaa 8 2 Tipo de comprobante Tabla 3 2 3 Número
de RUC 1234567890001 13 4 Tipo de ambiente Tabla 4 1 5 Serie\* Numérico
001001 6 Obligatorio `<claveAcceso>`{=html} 6 Número secuencial\*
000000001 9 7 Código numérico Numérico 8 8 Tipo de emisión Tabla 2 1 9
Dígito verificador (módulo 11) Numérico 1 \*El emisor deberá asignar la
serie y secuencial que corresponderá únicamente al envío en lote.

8.  Servicios expuestos en internet para consultas de comprobantes
    electrónicos Los servicios expuestos en el internet por la
    Administración Tributaria están estandarizados a través de canales
    seguros con protocolos de seguridad y certificados SSL.

8.1 Procesos que ejecutan los servicios expuestos en internet:

    8.1.1 Los procesos tienen la función de consulta comprobantes de manera
        individual.

    8.1.2 Para el intercambio de información entre el contribuyente y la Administración
        Tributaria, es requisito indispensable que el contribuyente cuente con acceso
        a la red de internet banda ancha (por definición y recomendación del MINTEL
        la conexión debe ser mayor a 256Kbps).

    8.1.3 Para poder acceder al servicio de consulta de comprobantes electrónicos, el
          contribuyente deberá crear el software cliente para poder invocar a los WEB
          Service que el SRI pone a disposición.

    8.1.4 Para garantizar que la conexión es segura se empleará Certificados Digitales
          SSL, es decir, el SRI emitirá un certificado válido cuando se realice la
          petición de los WEB Service.

         Sin embargo, considerando que los certificados pueden ser cambiados
         durante el periodo de su vigencia por causas técnicas o institucionales, se
         recomienda a los contribuyentes que, en la programación de sus sistemas,
         se considere los mecanismos necesarios para que no se queme en su
         código la información, ni los certificados digitales de comprobantes
         electrónicos del SRI, puesto que estos podrían cambiar sin previo aviso por
         la urgencia según sea el caso.

8.2 Existen dos ambientes disponibles para la invocación de los WS
publicados por la Administración Tributaria:

                                                                                                                      21

------------------------------------------------------------------------

         8.2.1 Uno es para el ambiente de pruebas, donde cada contribuyente certificará
               que su aplicación funcione correctamente con cada tipo de comprobante
               electrónico, las direcciones de los WS son las siguientes:

https://celcer.sri.gob.ec/comprobantes-electronicos-ws/ConsultaComprobante?wsdl

https://celcer.sri.gob.ec/comprobantes-electronicos-ws/ConsultaFactura?wsdl

         8.2.2 El segundo es para el ambiente de producción, al cual cada contribuyente
               deberá acceder una vez que ha realizado las pruebas y esté seguro de que
               su aplicación funciona correctamente, las direcciones de los WS son las
               siguientes:

https://cel.sri.gob.ec/comprobantes-electronicos-ws/ConsultaComprobante?wsdl

https://cel.sri.gob.ec/comprobantes-electronicos-ws/ConsultaFactura?wsdl

         8.2.3 Los WS expuestos por la Administración Tributaria son los siguientes:

              Consulta de validez de comprobantes electrónicos

     @WebMethod
     @WebResult(name = " EstadoAutorizacionComprobante")
     public RespuestaConsultaComprobante consultarEstadoAutorizacionComprobante
     (@WebParam(name = "claveAcceso") String claveAcceso)

     Parámetros:

     I/O     Nombre       Tipo                                          Descripción
    IN     claveAcceso    String   Clave de acceso del comprobante electrónico
                                   <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                                   xmlns:ec="http://ec.gob.sri.ws.consultas">
                                    <soapenv:Header/>
                                    <soapenv:Body>
                                      <ec:consultarEstadoAutorizacionComprobante>

                                   <claveAcceso>0211202401050306179800120010020000000677300995216</claveAcceso>
                                      </ec:consultarEstadoAutorizacionComprobante>
                                    </soapenv:Body>
                                   </soapenv:Envelope>


    OUT    EstadoAutori   Objeto   Retorna un objeto XML con la información del estado del comprobante electrónico.
           zacionCompr
                                   Dependiendo del estado de autorización del comprobante electrónicos, el servicio web,
           obante
                                   devolverá en la etiqueta estadoAutorizacion el valor:
                                   “AUTORIZADO”
                                    “NO AUTORIZADO”
                                   “PENDIENTE DE ANULAR” y
                                   “ANULADO”

                                   <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                                    <soap:Body>
                                      <ns2:consultarEstadoAutorizacionComprobanteResponse
                                   xmlns:ns2="http://ec.gob.sri.ws.consultas">
                                       <EstadoAutorizacionComprobante>


                                                                                                                     22

------------------------------------------------------------------------

`<claveAcceso>`{=html}2111202405176001321000110010010000001241234567810`</claveAcceso>`{=html}
`<mensajes/>`{=html}
`<estadoAutorizacion>`{=html}AUTORIZADO`</estadoAutorizacion>`{=html}
`<tipoComprobante>`{=html}Nota de Débito`</tipoComprobante>`{=html}
`<rucEmisor>`{=html}1760013210001`</rucEmisor>`{=html}
`<fechaAutorizacion>`{=html}2024-12-12T10:49:37-05:00`</fechaAutorizacion>`{=html}
`</EstadoAutorizacionComprobante>`{=html}
`</ns2:consultarEstadoAutorizacionComprobanteResponse>`{=html}
`</soap:Body>`{=html} `</soap:Envelope>`{=html}

Si el comprobante consultado se encuentra fuera del rango de fechas
permitido por el SRI, devolverá en la etiqueta estadoAutorizacion el
valor "RECHAZADA", con el identificador 99 correspondiente a "ERROR AL
CONSULTAR DATOS DEL SERVICIO WEB" y con el mensaje de
informacionAdicional "No es posible validar la clave de acceso ya que la
fecha de emisión está fuera del rango permitido."

`<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">`{=html}
`<soap:Body>`{=html}
`<ns2:consultarEstadoAutorizacionComprobanteResponse
xmlns:ns2="http://ec.gob.sri.ws.consultas">`{=html}
`<EstadoAutorizacionComprobante>`{=html}
`<estadoConsulta>`{=html}RECHAZADA`</estadoConsulta>`{=html}

`<claveAcceso>`{=html}1510202407099313057500110010010000103591234567816`</claveAcceso>`{=html}
`<mensajes>`{=html} `<mensaje>`{=html}
`<identificador>`{=html}99`</identificador>`{=html}
`<mensaje>`{=html}ERROR AL CONSULTAR DATOS DEL SERVICIO
WEB`</mensaje>`{=html} `<informacionAdicional>`{=html}No es posible
validar la clave de acceso ya que la fecha de emisión está fuera del
rango permitido.`</informacionAdicional>`{=html}
`<tipo>`{=html}ERROR`</tipo>`{=html} `</mensaje>`{=html}
`</mensajes>`{=html} `</EstadoAutorizacionComprobante>`{=html}
`</ns2:consultarEstadoAutorizacionComprobanteResponse>`{=html}
`</soap:Body>`{=html} `</soap:Envelope>`{=html}

Si el comprobante no se encuentra en las bases de datos del SRI,
devolverá en la etiqueta estadoAutorizacion el valor "RECHAZADA", con el
identificador 99 correspondiente a "ERROR AL CONSULTAR DATOS DEL
SERVICIO WEB"

`<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">`{=html}
`<soap:Body>`{=html}
`<ns2:consultarEstadoAutorizacionComprobanteResponse
xmlns:ns2="http://ec.gob.sri.ws.consultas">`{=html}
`<EstadoAutorizacionComprobante>`{=html}
`<estadoConsulta>`{=html}RECHAZADA`</estadoConsulta>`{=html}

`<claveAcceso>`{=html}2111202401176001321000110010010000011171234567810`</claveAcceso>`{=html}
`<mensajes>`{=html} `<mensaje>`{=html}
`<identificador>`{=html}99`</identificador>`{=html}
`<mensaje>`{=html}ERROR AL CONSULTAR DATOS DEL SERVICIO
WEB`</mensaje>`{=html} `<informacionAdicional>`{=html}No existen datos
para los parámetros ingresados`</informacionAdicional>`{=html}
`<tipo>`{=html}ERROR`</tipo>`{=html} `</mensaje>`{=html}
`</mensajes>`{=html} `</EstadoAutorizacionComprobante>`{=html}

                                                                                      23

------------------------------------------------------------------------

                                 </ns2:consultarEstadoAutorizacionComprobanteResponse>
                               </soap:Body>
                              </soap:Envelope>

Consulta de factura comercial negociable:

@WebMethod @WebResult(name =
"EstadoConfirmacionFacturaComercialNegociable") public
RespuestaConsultaFacturaComercialNegociable
consultarEstadoConfirmacionFacturaComercialNegociable (@WebParam(name =
"claveAcceso") String claveAcceso)

Parámetros:

I/O Nombre Tipo Descripción IN ClaveAcceso String Clave de acceso del
comprobante electrónico

                              <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                              xmlns:ec="http://ec.gob.sri.ws.consultas">
                               <soapenv:Header/>
                               <soapenv:Body>
                                 <ec:consultarEstadoConfirmacionFacturaComercialNegociable>
                              <claveAcceso>1211202401092554321700110021000000000790925543211</claveAcceso>
                                 </ec:consultarEstadoConfirmacionFacturaComercialNegociable>
                               </soapenv:Body>
                              </soapenv:Envelope>

OUT EstadoConfir Objeto Retorna un objeto XML con la información de la
factura electrónica indicando si ha sido macionFactu aceptada como
factura comercial negociable raComercial Dependiendo si la factura
electrónica tiene estado de confirmación, aceptado como Negociable
factura comercial negociable, el servicio web devolverá en la etiqueta
estadoConfirmacion el valor: "SI"

                              <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                               <soap:Body>
                                 <ns2:consultarEstadoConfirmacionFacturaComercialNegociableResponse
                              xmlns:ns2="http://ec.gob.sri.ws.consultas">
                                  <EstadoConfirmacionFacturaComercialNegociable>

                              <claveAcceso>1111202401099338176200110020010000003961234567815</claveAcceso>
                                    <mensajes/>
                                                         <estadoConfirmacion>SI</estadoConfirmacion>
                                   </EstadoConfirmacionFacturaComercialNegociable>
                                 </ns2:consultarEstadoConfirmacionFacturaComercialNegociableResponse>
                               </soap:Body>
                              </soap:Envelope>


                              Si la factura consultada se encuentra fuera del rango de fechas permitido por el SRI,
                              devolverá en la etiqueta estadoConsulta el valor “RECHAZADA”, con el identificador 99
                              correspondiente a “ERROR AL CONSULTAR DATOS DEL SERVICIO WEB” y con el mensaje
                              de informacionAdicional “No es posible validar la clave de acceso ya que la fecha de
                              emisión está fuera del rango permitido.”

                              <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                               <soap:Body>
                                 <ns2:consultarEstadoConfirmacionFacturaComercialNegociableResponse


                                                                                                                   24

------------------------------------------------------------------------

I/O Nombre Tipo Descripción xmlns:ns2="http://ec.gob.sri.ws.consultas"\>
`<EstadoConfirmacionFacturaComercialNegociable>`{=html}
`<estadoConsulta>`{=html}RECHAZADA`</estadoConsulta>`{=html}

                       <claveAcceso>1111202401099338176200110020010000003961234567815</claveAcceso>
                             <mensajes>
                               <mensaje>
                                 <identificador>99</identificador>
                                 <mensaje>ERROR AL CONSULTAR DATOS DEL SERVICIO WEB</mensaje>
                                 <informacionAdicional>No es posible validar la clave de acceso ya que la fecha de
                       emisión está fuera del rango permitido.</informacionAdicional>
                                 <tipo>ERROR</tipo>
                               </mensaje>
                             </mensajes>
                            </EstadoConfirmacionFacturaComercialNegociable>
                          </ns2:consultarEstadoConfirmacionFacturaComercialNegociableResponse>
                        </soap:Body>
                       </soap:Envelope>


                       Si la factura consultada no se encuentra en las bases de datos del SRI o no fue aceptada
                       como factura comercial negociable, devolverá en la etiqueta estadoConsulta el valor
                       “RECHAZADA”, con el identificador 99 correspondiente a “ERROR AL CONSULTAR DATOS
                       DEL SERVICIO WEB”

                       <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                        <soap:Body>
                          <ns2:consultarEstadoConfirmacionFacturaComercialNegociableResponse
                       xmlns:ns2="http://ec.gob.sri.ws.consultas">
                           <EstadoConfirmacionFacturaComercialNegociable>
                             <estadoConsulta>RECHAZADA</estadoConsulta>

                       <claveAcceso>1211202401092554321700110021000000000790925543211</claveAcceso>
                              <mensajes>
                               <mensaje>
                                 <identificador>99</identificador>
                                 <mensaje>ERROR AL CONSULTAR DATOS DEL SERVICIO WEB</mensaje>
                                 <informacionAdicional>No existen datos para los parámetros
                       ingresados</informacionAdicional>
                                 <tipo>ERROR</tipo>
                               </mensaje>
                              </mensajes>
                            </EstadoConfirmacionFacturaComercialNegociable>
                          </ns2:consultarEstadoConfirmacionFacturaComercialNegociableResponse>
                         </soap:Body>
                       </soap:Envelope>

8.3 El Sistema de Autorización de Documentos Electrónicos soporta un
proceso a través de un ambiente computacional seguro, que brinda alta
disponibilidad y rendimiento, opta por utilizar la infraestructura
necesaria para brindar el servicio a la ciudadanía que realizan
transferencias de bienes o prestación de servicios.

8.4 Una vez que el contribuyente realice la consulta con la clave de
acceso del comprobante electrónico en el WS de consulta de validez
obtendrá en respuesta los estados del comprobante "AUTORIZADO", "NO
AUTORIZADO", "PENDIENTE DE ANULAR" o "ANULADO".

                                                                                                             25

------------------------------------------------------------------------

8.5 En el caso de la consulta de si es una factura comercial negociable,
cuando el contribuyente realice la consulta con la clave de acceso del
comprobante electrónico en el WS obtendrá en respuesta "SI", caso
contrario obtendrá el valor "RECHAZADA".

8.6 Es fundamental señalar que solo la factura comercial negociable
generará la respuesta "SI" una vez que haya sido notificada y aceptada a
través del portal web, en la opción de Comprobantes Electrónicos /
Ambientes de Pruebas o Producción / Factura Comercial Negociable

9.  Facturador gratuito de generación de comprobantes electrónicos 9.1
    El Servicio de Rentas Internas pone a disposición de la ciudadanía
    de manera gratuita, un facturador electrónico, el cual permitirá
    generar comprobantes, firmarlos electrónicamente y visualizarlos de
    manera amigable.

9.2 El facturador electrónico tiene la particularidad de asignar y
modificar directorios para los archivos de los comprobantes
electrónicos, validar el esquema y firma electrónica de comprobantes,
también se puede visualizar los documentos electrónicos.

9.3 Para instalar el facturador, los contribuyentes deberán descargar el
instalador desde el portal web del Servicio de Rentas Internas,
ingresando a Inicio / Guía Básica Tributaria / Facturación / Facturación
Electrónica / Facturador electrónico gratuito.

     Para una correcta instalación, se recomienda descargar el Manual de Usuario
     que le servirá como guía y pasos a seguir.

9.4 Una vez instalado el facturador electrónico, se deberá parametrizar
los directorios disponibles:

TABLA 10

No. Ruta o Directorios Observación 1 Comprobantes generados Directorio
donde se encuentren los documentos para ser firmados. Comprobantes
firmados Directorio donde se guardarán los documentos firmados 2
electrónicamente electrónicamente de manera satisfactoria. Directorio
donde almacenarán los comprobantes firmados Comprobantes transmitidos y
2.1 electrónicamente remitidos a la Administración Tributaria y no se ha
sin respuesta de autorización* recibido una respuesta. Directorio donde
se almacenarán los comprobantes autorizados por el 3 Comprobantes
autorizados SRI y automáticamente deberán eliminarse de los directorios
1 y/o 2 únicamente si son autorizados. Directorio donde se almacenarán
los archivos con los motivos de por 4 Comprobantes no autorizados qué no
se autorizó los comprobantes. Directorio donde se almacenarán los
comprobantes en estado en 5 Comprobantes enviados procesamiento. 5.1
Comprobantes rechazados* Directorio donde no cumple esquemas o sin
autorización de emisión. \* Estos directorios se configuran
automáticamente dentro de la carpeta de documentos firmados.

                                                                                                         26

------------------------------------------------------------------------

9.5 De manera obligatoria deberá parametrizarse la información del
emisor, con la finalidad de que cuando se genera un comprobante
electrónico, esta información aparezca por defecto sin la necesidad de
digitar en cada transacción la misma información, generando posibles
errores de forma y digitación.

TABLA 11

No. Descripción (emisor o agente de retención) Tipo de campo Longitud
Requisito

1 Número de RUC Numérico 13 Obligatorio 2 Razón social / nombres o
apellidos Alfanumérico Max. 300 Obligatorio 3 Nombre comercial
Alfanumérico Max. 300 Opcional 4 Dirección del establecimiento matriz
Alfanumérico Max. 300 Obligatorio 5 Dirección del establecimiento emisor
Alfanumérico Max. 300 Opcional 6 Código del establecimiento emisor
Numérico 3 Obligatorio 7 Código del punto de emisión Numérico 3
Obligatorio 8 Contribuyente especial (Número de resolución) Numérico
Min. 3 y Max. 5 Opcional Obligado a llevar contabilidad (Opciones SI o 9
De selección 2 Opcional NO) 10 Logo del emisor Imagen - Opcional 11 Tipo
de ambiente Numérico 1 Obligatorio 12 Tipo de emisión Numérico 1
Obligatorio

9.6 Para una óptima utilización del facturador, también se deberá
parametrizar los productos o servicios que ofrece el vendedor,
ingresando el detalle y un código de producto y/o servicio, en conjunto
con su tarifa de impuesto de IVA, ICE, IRBPNR o ISD de ser el caso. Se
podrá importar o exportar los productos o servicios a parametrizar en
formato txt.

TABLA 12

No. Descripción Requisito

1 Impuestos y tarifas parametrizables Obligatorio 2 Código identificador
del producto o servicio asignado por el contribuyente. Obligatorio 2
Código identificador auxiliar del producto o servicio Opcional 3 Nombre
del producto o servicio Obligatorio 4 Valor unitario Obligatorio 5
Descuento Obligatorio 6 Impuesto Obligatorio 7 Tarifa del impuesto
Obligatorio 8 Campos adicionales (máximo tres campos de hasta 300
caracteres) Opcional

9.7 De igual manera se podrá parametrizar a los clientes ya
identificados, a quienes van a transferir los bienes o realizar la
prestación de servicios, así también la información de los
transportistas para el caso de guías de remisión y

                                                                                                                27

------------------------------------------------------------------------

         los agentes retenidos para los comprobantes de retención. Se podrá importar
         los clientes a parametrizar en formato txt.

     TABLA 13

       No.                                  Descripción                                    Requisito

        1    Identificación (Número de RUC, cédula o pasaporte)                            Obligatorio
        2    Nombres y apellidos o razón social                                            Obligatorio
        3    Dirección de correo electrónico                                               Obligatorio
        4    Placa (para el caso de guías de remisión)                                     Obligatorio
        5    Teléfono                                                                       Opcional
        6    Dirección / ubicación                                                          Opcional


     9.8 Por defecto aparecerá la denominación de la moneda de curso actual en el
         país “DÓLAR”.

     9.9 Se detalla en el cuadro adjunto los campos a ser llenados que corresponden a
         facturas, comprobantes de retención, notas de crédito y notas de débito:

     TABLA 14: FACTURAS, COMPROBANTES DE RETENCIÓN, NOTAS DE
     CRÉDITO Y NOTAS DE DÉBITO:

          Descripción de llenado           Tipo de

No. Longitud Requisito Comprobante (comprador o agente retenido) campo
Número secuencial del 1 Numérico 9 Obligatorio TODOS comprobante Razón
social / Nombres o 2 Alfanumérico Max. 300 Obligatorio TODOS apellidos
Identificación (RUC, Cédula, 3 pasaporte, identificación del
Alfanumérico Max 20 Obligatorio TODOS exterior o placa) 4 Fecha de
emisión Numérico 8 Obligatorio TODOS 5 Número de la guía de remisión
Numérico 15 Opcional CAMPO SOLO PARA FACTURA Denominación del
comprobante CAMPO SOLO PARA NOTAS DE 6 Numérico 2 Obligatorio de venta
que se modifica CRÉDITO Y NOTAS DE DÉBITO Número del comprobante de
CAMPO SOLO PARA NOTAS DE 7 Numérico 15 Obligatorio venta que se modifica
CRÉDITO Y NOTAS DE DÉBITO CAMPO SOLO PARA Denominación del comprobante 8
Numérico 2 Obligatorio COMPROBANTES DE de venta que motiva la retención
RETENCIÓN CAMPO SOLO PARA Número del comprobante de 9 Numérico 15
Obligatorio COMPROBANTE DE venta que motiva la retención RETENCIÓN CAMPO
SOLO PARA 10 Ejercicio fiscal (mmaaaa) Numérico 6 Obligatorio
COMPROBANTE DE RETENCIÓN 11 Código numérico Numérico 8 / 23 Obligatorio
TODOS 12 Dígito verificador (Módulo 11) Numérico 1 Obligatorio TODOS

                                                                                                         28

------------------------------------------------------------------------

TABLA 15: GUÍAS DE REMISIÓN:

No. Descripción de Llenado Tipo de campo Longitud Requisito 1 Número
secuencial del comprobante Numérico 9 Obligatorio 2 Razón social /
nombres o apellidos (Destinatario) Alfanumérico Max. 300 Obligatorio
Identificación destinatario (RUC, cédula, pasaporte, 3 Alfanumérico 10 a
20 Obligatorio identificación del exterior) 4 Dirección del punto de
partida Alfanumérico Max. 300 Obligatorio 5 Dirección del destinatario o
destinos Alfanumérico Max. 300 Obligatorio Razón social / Nombres o
apellidos (transportista o 6 Alfanumérico Max. 300 Obligatorio
remitente) Identificación transportista o remitente (ruc, cédula, 7
Alfanumérico 10 a 13 Obligatorio pasaporte) 8 Número de placa
Alfanumérico Max. 20 Obligatorio 9 Descripción de la mercadería
transportada Alfanumérico Max. 300 Obligatorio 10 Cantidad de la
mercadería transportada Alfanumérico Libre Obligatorio 11 Motivo del
traslado Alfanumérico Max. 300 Obligatorio 12 Denominación del
comprobante de venta Numérico 2 Opcional 13 Número de autorización del
comprobante de venta Numérico 10 ó 37 Opcional 14 Fecha de emisión del
comprobante de venta Numérico 8 Opcional 15 Numeración del comprobante
de venta Numérico 15 Opcional 16 Número de la declaración aduanera
Numérico 20 Opcional 17 Fecha de Inicio de transporte Numérico 8
Obligatorio 18 Fecha de terminación del transporte Numérico 8
Obligatorio 19 Ruta Alfanumérico Max. 300 Opcional Código del
establecimiento del destinatario del 20 Numérico 3 Opcional producto 21
Código numérico Numérico 8 / 23 Obligatorio 22 Dígito verificador
Numérico 1 Obligatorio

9.10 Entre la lista de clientes se encuentra el "Consumidor final", para
que por defecto se identifique en ventas a consumidores finales. Si el
valor de la factura es mayor a 50 USD se deberá especificar
obligatoriamente los datos del adquirente. 9.11 Se podrá ingresar
información adicional por cada comprobante, como máximo quince campos de
hasta 300 caracteres alfanuméricos.

9.12 Se detalla a continuación los códigos de los impuestos.

TABLA 16

                                          Impuesto              Código
                                            IVA                   2
                                             ICE                   3
                                           IRBPNR                  5

9.13 Se enlista a continuación los códigos de las tarifas de los
impuestos:

                                                                                                     29

------------------------------------------------------------------------

TABLA 17: TARIFA DEL IVA

                                                 Porcentaje de IVA                  Código
                                                            0%                          0
                                                            12%                         2
                                                            14%                         3
                                                            15%                         4
                                                            5%                          5
                                             No Objeto de Impuesto                      6
                                                   Exento de IVA                        7
                                                 IVA diferenciado3                      8
                                                            13%                        10

TABLA 18: TARIFA DEL ICE:

A continuación, se detalla el listado de códigos del Impuesto a los
Consumos Especiales, las tarifas deberán calcularse en base a la
normativa vigente.

                                                                                                           Tarifa Ad            Tarifa
                                                                     Tarifa Ad          Tarifa              Valorem         específica de

Código Descripción Valorem específica de febrero a febrero a enero 2023
enero 2023 diciembre diciembre 2023 2023 3011 ICE Cigarrillos Rubios -
0,17 - 0,16 3021 ICE Cigarrillos Negros - 0,17 - 0,16 ICE Productos del
Tabaco y Sucedáneos 3023 150% - 150% - del Tabaco excepto Cigarrillos
3031 ICE Bebidas Alcohólicas 75% 10,36 75% 10,00 3041 ICE Cerveza
Industrial Gran Escala 75% - 75% - 3041 ICE Cerveza Industrial Mediana
Escala 75% - 75% - 3041 ICE Cerveza Industrial Pequeña Escala 75% -
75% - ICE Vehículos Motorizados cuyo PVP sea 3073 5% - 5% - hasta de
20000 USD ICE Vehículos Motorizados PVP entre 3075 15% - 15% - 30000 y
40000 ICE Vehículos Motorizados cuyo PVP 3077 20% - 20% - superior USD
40.000 hasta 50.000 ICE Vehículos Motorizados cuyo PVP 3078 25% - 25% -
superior USD 50.000 hasta 60.000 ICE Vehículos Motorizados cuyo PVP 3079
30% - 30% - superior USD 60.000 hasta 70.000 ICE Vehículos Motorizados
cuyo PVP 3080 35% - 35% - superior USD 70.000 ICE Aviones, Tricars,
yates, Barcos de 3081 15% - 10% - Recreo 3092 ICE Servicios de
Televisión Prepagada 0% - 0% - 3610 ICE Perfumes y Aguas de Tocador
20% - 20% - 3620 ICE Videojuegos 0% - 0% - ICE Armas de Fuego, Armas
deportivas y 3630 300% - 30% - Municiones 3640 ICE Focos Incandescentes
100% - 100% - ICE Cuotas Membresías Afiliaciones 3660 35% - 35% -
Acciones

3 Mediante decreto ejecutivo el presidente de la República podrá aplicar
una tafia de IVA diferenciada del 8% para el sector turístico hasta 12

días al año según se establezca en el respectivo decreto.

                                                                                                                                           30

------------------------------------------------------------------------

                                                                                    Tarifa Ad       Tarifa
                                                        Tarifa Ad      Tarifa        Valorem    específica de

Código Descripción Valorem específica de febrero a febrero a enero 2023
enero 2023 diciembre diciembre 2023 2023 3093 ICE Servicios Telefonía
Sociedades 15% - 15% - 3101 ICE Bebidas Energizantes 10% - 10% - 0,19
por 100 0,18 por 100 ICE Bebidas Gaseosas con Alto Contenido 3053 -
gramos de - gramos de de Azúcar azúcar azúcar ICE Bebidas Gaseosas con
Bajo Contenido 3054 10% - 10% - de Azúcar 0,19 por 100 0,18 por 100 3111
ICE Bebidas No Alcohólicas - gramos de - gramos de azúcar azúcar 3043
ICE Cerveza Artesanal - 1,55 - 1,50 3033 ICE Alcohol 75% 10,36 75% 10,00
ICE calefones y sistemas de calentamiento 3671 100% - 100% - de agua a
gas SRI ICE vehículos motorizados camionetas y de 3684 rescate cuyo PVP
sea hasta DE 30.000 5% - 5% - USD ICE vehículos motorizados excepto 3686
camionetas y de rescate cuyo PVP sea 10% - 10% - superior USD 20.000
hasta DE 30.000 ICE vehículos híbridos cuyo PVP sea de 3688 0% 0% hasta
USD. 35.000 ICE vehículos híbridos cuyo PVP superior 3691 8% 8% USD.
35.000 hasta 40.000 ICE vehículos híbridos cuyo PVP superior 3692 14%
14% USD. 40.000 hasta 50.000 ICE vehículos híbridos cuyo PVP superior
3695 20% 20% USD. 50.000 hasta 60.000 ICE vehículos híbridos cuyo PVP
superior 3696 26% 26% USD. 60.000 hasta 70.000 ICE vehículos híbridos
cuyo PVP superior a 3698 32% - 32% - USD 70.000 ICE consumibles tabaco
calentado y 3682 150% - 150% - líquidos con nicotina SRI ICE servicios
de telefonía móvil personas 3681 0% - 0% - naturales 3680 ICE fundas
plásticas - 0,10 - 0,08 3533 ICE Import. Bebidas Alcohólicas 75% - 75% -
3541 ICE Cerveza Gran Escala CAE 75% - 75% - ICE Cerveza Industrial de
Mediana Escala 3541 75% - 75% - CAE ICE Cerveza Industrial de Pequeña
Escala 3541 75% - 75% - CAE 3542 ICE Cigarrillos Rubios CAE - - - - 3543
ICE Cigarrillos Negros CAE - - - - ICE Productos del Tabaco y Sucedáneos
3544 150% - 150% - del Tabaco Excepto Cigarrillos CAE 3581 ICE Aeronaves
CAE 15% - 10% - ICE Aviones, Avionetas y Helicópteros Exct. 3582 15% -
10% - Aquellos destinados Al Trans. CAE 3710 ICE Perfumes Aguas de
Tocador Cae 20% - 20% - 3720 ICE Video Juegos CAE 35% - 35% - ICE
Importaciones Armas de Fuego, Armas 3730 300% - 30% - deportivas y
Municiones CAE 3740 ICE Focos Incandescentes CAE 100% - 100% -
ICE-vehículos motorizados cuyo PVP SEA 3871 5% - 5% - hasta de 20000 USD
SENAE ICE-vehículos motorizados PVP entre 3873 15% - 15% - 30000 Y 40000
SENAE ICE-vehículos motorizados cuyo PVP 3874 20% - 20% - superior USD
40.000 hasta 50.000 SENAE

                                                                                                           31

------------------------------------------------------------------------

                                                                                     Tarifa Ad       Tarifa
                                                         Tarifa Ad      Tarifa        Valorem    específica de

Código Descripción Valorem específica de febrero a febrero a enero 2023
enero 2023 diciembre diciembre 2023 2023 ICE-vehículos motorizados cuyo
PVP 3875 25% - 25% - superior USD 50.000 hasta 60.000 SENAE
ICE-vehículos motorizados cuyo PVP 3876 30% - 30% - superior USD 60.000
hasta 70.000 SENAE ICE-vehículos motorizados cuyo PVP 3877 35% - 35% -
superior USD 70.000 SENAE ICE-Aviones, Tricars, Yates, Barcos de Rec
3878 15% - 10% - SENAE 3601 ICE Bebidas Energizantes SENAE 10% - 10% -
0,19 por 100 0,18 por 100 ICE bebidas gaseosas con alto contenido 3552 -
gramos de - gramos de de azúcar SENAE azúcar azúcar ICE bebidas gaseosas
con bajo contenido 3553 10% - 10% - de azúcar SENAE 0,19 por 100 0,18
por 100 3602 ICE bebidas no alcohólicas SENAE - gramos de - gramos de
azúcar azúcar 3545 ICE cerveza artesanal SENAE 75% 1,55 75% 1,5 3532 ICE
Import. alcohol SENAE 75% 10,36 75% 10 ICE calefones y sistemas de
calentamiento 3671 100% - 100% - de agua a gas SRI ICE calefones y
sistemas de calentamiento 3771 100% - 100% - de agua a gas SENAE ICE
vehículos motorizados camionetas y de 3685 rescate PVP sea hasta DE
30.000 USD 5% - 5% - SENAE ICE vehículos motorizados excepto camionetas
y de rescate cuyo PVP sea 3687 10% - 10% - superior USD 20.000 hasta de
30.000 SENAE ICE vehículos híbridos cuyo PVP sea de 3689 0% - 0% - hasta
USD. 35.000 SENAE ICE vehículos híbridos cuyo PVP superior 3690 8% -
8% - USD. 35.000 hasta 40.000 SENAE ICE vehículos híbridos cuyo PVP
superior 3693 14% - 14% - USD. 40.000 hasta 50.000 SENAE ICE vehículos
híbridos cuyo PVP superior 3694 20% - 20% - USD. 50.000 hasta 60.000
SENAE ICE vehículos híbridos cuyo PVP superior 3697 26% - 26% - USD.
60.000 hasta 70.000 SENAE ICE vehículos híbridos cuyo PVP superior a
3699 32% - 32% - USD 70.000 SENAE ICE consumibles tabaco calentado y
3683 150% 50% líquidos con nicotina SENAE

9.14 Lista de códigos por impuestos asignados para la retención.

TABLA 19 Impuesto a retener Código RENTA 1 IVA 2 ISD 6

9.15 Se describe los códigos por impuesto de acuerdo con el porcentaje
de retención.

                                                                                                            32

------------------------------------------------------------------------

TABLA 20: TABLAS DE RETENCIONES

RETENCIÓN DEL IVA

                                                 Porcentaje IVA                      Código
                                                         10%                             9
                                                         20%                            10
                                                         30%                             1
                                                         50%                            11
                                                         70%                             2
                                                        100%                             3

• Retención en cero:

                                                 Porcentaje IVA                      Código
                                                       0.00%                             7
     *Aplica de conformidad con la Disposición Transitoria Única de la Resolución NAC-DGERCGC15-00000284.

• No procede retención:

                                                 Porcentaje IVA                      Código
                                                       0.00%                             8

RETENCIÓN DEL ISD

          Porcentaje                                                             Vigencia
                             Código
             ISD                                            Desde                                         Hasta
               5%              4580                             -                       Hasta el 31 de diciembre de 2021
             4.75%             4580                 1 de enero de 2022                          31 de marzo de 20224
             4.50%             4580                  1 de abril de 2022                          30 de junio de 2022
             4.25%             4580                  1 de julio de 2022                      30 de septiembre de 2022
             4.00%             4580                1 de octubre de 2022                       31 de diciembre de 2022
             3.75%             4580                1 de febrero de 2023                          30 de junio de 20235
             3.50%             4580                  1 de julio de 20236                        31 de marzo de 2024
               5%              4580                 1 de abril del 20247

4 Los porcentajes para el año 2022 se establecieron en el Decreto
Ejecutivo No. 298 publicado en el Segundo Suplemento del Registro
Oficial No. 604 del 23 de diciembre de 2021.

5 Los porcentajes para el año 2023 se establecieron en el Decreto
Ejecutivo No. 643 publicado en el Segundo Suplemento del Registro
Oficial No. 235 del 23 de enero de 2023.

6 El porcentaje para el año 2024 se establecieron en el Decreto
Ejecutivo No. 98 publicado en el Segundo Suplemento del Registro Oficial
No. 467 del 29 de diciembre de 2023

7 Ley Orgánica para Enfrentar el Conflicto Armado Interno, la Crisis
Social y Económica publicada en el Registro Oficial No. 516 del 12 de
marzo de 2024 que reforma el artículo 162 de la Ley. Reformatoria para
la Equidad Tributaria en el Ecuador.

                                                                                                                                        33

------------------------------------------------------------------------

          Porcentaje                                                              Vigencia
                             Código
             ISD                                             Desde                                        Hasta
              2.5%             4586                 1 de mayo de 20258

RETENCIÓN DE RENTA:

Los porcentajes de retención del Impuesto a la Renta se aplicarán
conforme lo establecido en la normativa legal vigente, para lo cual se
deberán considerar los porcentajes establecidos en las tablas del
Catálogo de Anexo Transaccional Simplificado, publicado en la página web
www.sri.gob.ec: Información sobre impuestos/Cómo declaro mis
impuestos?/Anexos y guías o directamente a través del siguiente link:
http://www.sri.gob.ec/web/guest/formularios-e-instructivos1.

9.16 A continuación, se detallan los valores subtotales y totales con
impuestos que deben constar en los comprobantes de venta, según el caso.

TABLA 21

No. Campos de valores Tipo de campo Requisito Sumarán todos los precios
totales de los 1 Subtotal IVA \_%: productos gravados con la tarifa de
IVA Obligatorio vigente. Sumarán todos los precios totales de los 2
Subtotal 0%: Obligatorio productos gravados con tarifa de IVA 0%.
Subtotal no objeto Sumarán todos los precios totales de los 3
Obligatorio IVA: productos No Objeto de IVA. Subtotal exento de Sumarán
todos los precios totales de los 3 Obligatorio IVA: productos Exento de
IVA. Sumará las tres bases (Tarifa de IVA vigente, 4 Subtotal:
Obligatorio 0%, no objeto de IVA o Exento de IVA).

5 Total descuento: Sumará los valores de los descuentos. Obligatorio
Calculará del campo Subtotal según el Obligatorio cuando corresponda / 6
Valor ICE: porcentaje ingresado, este campo será editable editable por
la naturaleza del cálculo del impuesto. Este campo será editable por la
naturaleza del Obligatorio cuando corresponda / 7 Valor IRBPNR: cálculo
del impuesto. editable Sumará el campo Subtotal IVA *% y el valor 8
Valor IVA *%: del campo Valor ICE, el resultado aplicará la Obligatorio
tarifa de IVA vigente. Este campo aparecerá vacío, si ingresa un 9
Propina: valor el sistema validará que el valor ingresado Obligatorio no
supere el 10% del campo Subtotal Sumará los campos Subtotal, ICE,
IRBPNR, 10 VALOR TOTAL Obligatorio Valor IVA \_% y Propina.

9.17 El formato para todo campo correspondiente a valores será 123456.98
utilizando el punto como separador de decimales; se utilizará como
máximo

8 El porcentaje para mayo de 2025 se estableció en el Decreto ejecutivo
No. 589 publicado en el Registro Oficial -- Cuarto Suplemento 9 del 31
de marzo de 2025.

                                                                                                                                         34

------------------------------------------------------------------------

     dos decimales, a excepción de los campos de precio unitario y cantidad que
     se podrá utilizar hasta 6 decimales, aplica para versión de comprobantes
     1.1.0 (Anexo 3)

9.18 Los contribuyentes deberán implementar los controles necesarios en
sus sistemas informáticos que utilizan para la generación de
comprobantes electrónicos, con el fin de que los comprobantes sean
emitidos en orden cronológico y secuencial, controlando que no exista
duplicidad tanto en la secuencia como en las claves de acceso; así como
también evitar el reenvío innecesario de comprobantes para su
autorización

9.19 Las representaciones impresas de los comprobantes electrónicos
(RIDE), tendrán validez tributaria y jurídica (Resolución 233 de junio
2018); como anexos se adjuntan modelos en los cuales se detallan las
posiciones de los requisitos. Se podrán imprimir datos adicionales en el
RIDE conforme lo requiera el contribuyente.

9.20 En las representaciones impresas el emisor podrá incorporar un
código de barras que contenga la clave de acceso u otro código opcional
de información que el contribuyente crea importante para sus procesos.

9.21 Se recomienda revisar aspectos técnicos acerca de la ubicación de
la impresión de código de barras (GS1 -- 128), para que puedan ser
leídos por máquinas lectoras de códigos de barras. Para más información
pueden ingresar a la siguiente dirección:
http://www.gs1mexico.org/site/wp-
content/uploads/2012/06/Guia-codigo-GS1-128.pdf

10. Caso específico de retenciones en los comercializadores /
    Distribuidores de derivados del petróleo y retención presuntiva de
    IVA a los editores, distribuidores y voceadores que participan en la
    comercialización de periódicos y/o revistas. Los comercializadores y
    distribuidores de derivados de petróleo, deberán aplicar los
    siguientes códigos de impuestos y tarifas de retenciones para la
    emisión de sus facturas:

TABLA 22

                      IMPUESTO A RETENER            CÓDIGO
                    IVA PRESUNTIVO Y RENTA            4


                                                                                35

------------------------------------------------------------------------

         TABLA 23

         •          Retención IVA

                                                                                                                     TARIFA EN EL
                         PORCENTAJE IVA RETENIDO Y/O PRESUNTIVO                                    CÓDIGO
                                                                                                                         XML
                       ** 100%9                                                                          3                1
                       12% (Retención de IVA presuntivo por Editores a
                                                                                                         4                  0.12
                       Margen de Comercialización Voceadores)
                       * 100% (Retención IVA venta periódicos y/o Revistas a
                                                                                                         5                   100
                       Distribuidores)
                       * 100% (Retención IVA Venta de Periódicos y/o
                                                                                                         6                   100
                       revistas a voceadores)
                                                 *Aplica para comprobantes de retención.
                ** Aplica para las retenciones de IVA de conformidad con Resolución No. NAC-DGERCGC21-00000063.


         •          Ejemplo

                                                                                      LLENADO DEL XML
             DESCRIPCIÓN              %
                                               <codigo>         <codigoPorcentaje>               <tarifa>                      <valor>10
          Gasolina súper             13%             4                       3                       1               IVA EN VENTAS * 13%
          Gasolina extra o
                                    5.85%            4                       3                       1              IVA EN VENTAS * 5.85%
              Ecopaís
               Diesel                 4%             4                       3                       1             IVA EN VENTAS * 4%
          Otros derivados                                                                                          IVA DEL MARGEN DE
                                    100%             4                       3                       1
            de petróleo                                                                                          COMERCIALIZACIÓN * 100%


         •          Retención RENTA

                              PORCENTAJE RENTA                                   CÓDIGO                      TARIFA EN EL XML
                                0.002 (2 por mil)                                  327                             0.20
                                0.003 (3 por mil)                                  328                             0.30


         11. Códigos de errores y advertencias de
         validación
                                                                                                                                       VALIDACIÓN:
     CÓDIGO
                                                                                                                                       RECEPCIÓN
       DE                DESCRIPCIÓN                                        MOTIVO DE ERROR
                                                                                                                                     /AUTORIZACIÓN/
     ERROR
                                                                                                                                         EMISOR
                      RUC del emisor se
                                                     Verificar que el número de RUC se encuentre en estado
          2             encuentra NO                                                                                                  AUTORIZACIÓN
                                                                             ACTIVO
                          ACTIVO.
                     Establecimiento del              No se autorizará comprobantes si el establecimiento
         10          emisor se encuentra            emisor ha sido clausurado, automáticamente se habilitará                          AUTORIZACIÓN
                        Clausurado.                         el servicio una vez concluido la clausura.
                        Tamaño máximo
         26                                                    Tamaño del archivo supera lo establecido                                  RECEPCIÓN
                           superado

9 Para el llenado de la sección de IVA presuntivo en el XML de la
factura electrónica se utilizará este código y la tarifa; sin embargo,
los valores de los porcentajes de retención corresponderán a los
establecidos en la Resolución Nro. NAC-DGERCGC21-00000063.

10 Para el llenado de esta etiqueta se debe considerar el tipo de campo,
formato y longitud establecida en el anexo 3.

                                                                                                                                                       36

------------------------------------------------------------------------

                                                                                                 VALIDACIÓN:

CÓDIGO RECEPCIÓN DE DESCRIPCIÓN MOTIVO DE ERROR /AUTORIZACIÓN/ ERROR
EMISOR La clase del contribuyente no puede emitir comprobantes 27 Clase
no permitido AUTORIZACIÓN electrónicos. Siempre el contribuyente debe
haber aceptado el acuerdo Acuerdo de medios de medio electrónicos en el
cual se establece que se 28 electrónicos no RECEPCIÓN acepta que lleguen
las notificaciones al buzón del aceptado contribuyente. 35 Documento
inválido Cuando el XML no pasa validación de esquema. RECEPCIÓN Versión
esquema 36 Cuando la versión del esquema no es la correcta. RECEPCIÓN
descontinuada RUC sin autorización Cuando el RUC del emisor no cuenta
con una solicitud de 37 AUTORIZACIÓN de emisión emisión de comprobantes
electrónicos. 39 Firma inválida Firma electrónica del emisor no es
válida. AUTORIZACIÓN No se encontró el certificado o no se puede
convertir en 40 Error en el certificado AUTORIZACIÓN certificad X509.
Clave acceso Cuando la clave de acceso ya se encuentra registrada en 43
RECEPCIÓN registrada la base de datos. Secuencial del comprobante ya se
encuentra registrado en 45 Secuencial registrado RECEPCIÓN la base de
datos Cuando el RUC emisor no existe en el Registro Único de 46 RUC no
existe AUTORIZACIÓN Contribuyentes.

         Tipo de comprobante        Cuando envían en el tipo de comprobante uno que no

47 RECEPCIÓN no existe exista en el catálogo de nuestros tipos de
comprobantes.

          Esquema XSD no           Cuando el esquema para el tipo de comprobante enviado

48 RECEPCIÓN existe no existe. Argumentos que 49 Cuando se consume el WS
con argumentos nulos. RECEPCIÓN envían al WS nulos 50 Error interno
general Cuando ocurre un error inesperado en el servidor. RECEPCIÓN 52
Error en diferencias Cuando existe error en los cálculos del
comprobante. AUTORIZACIÓN Establecimiento Cuando el establecimiento
desde el cual se genera el 56 AUTORIZACIÓN cerrado comprobante se
encuentra cerrado. Cuando la autorización para emisión de comprobantes
electrónicos para el emisor se encuentra suspendida por Autorización
procesos de control de la Administración Tributaria o el 57 AUTORIZACIÓN
suspendida contribuyente no tenía la autorización para emitir
comprobantes electrónicos a la fecha de emisión del comprobante Error en
la estructura Cuando la clave de acceso tiene componentes diferentes 58
AUTORIZACIÓN de clave acceso a los del comprobante.

                                    Cuando el RUC del emisor se encuentra clausurado por

63 RUC clausurado AUTORIZACIÓN procesos de control de la Administración
Tributaria.

                                      Cuando el comprobante emitido no fue enviado de
          Fecha de emisión                                                                       EMISOR/

65 acuerdo con el tiempo del tipo de emisión en el cual fue extemporánea
RECEPCIÓN realizado. 67 Fecha inválida Cuando existe errores en el
formato de la fecha. RECEPCIÓN Cuando se desea enviar un comprobante que
ha sido Clave de acceso en 70 enviado anteriormente y el mismo no ha
terminado su RECEPCIÓN procesamiento procesamiento.

                                                                                                         37

------------------------------------------------------------------------

                                                                                                     VALIDACIÓN:

CÓDIGO RECEPCIÓN DE DESCRIPCIÓN MOTIVO DE ERROR /AUTORIZACIÓN/ ERROR
EMISOR Cuando se ejecuta la consulta de autorización por clave de Error
en la estructura acceso y el valor de este parámetro supera los 49
dígitos, 80 AUTORIZACIÓN de clave acceso tiene caracteres alfanuméricos
o cuando el tag (claveAccesoComprobante) está vacío

            Error en la fecha de       Cuando la fecha de inicio de transporte es menor a la

82 RECEPCIÓN inicio de transporte fecha de emisión de la guía de
remisión.

            Error al validar monto   Cuando el valor registrado en el campo de devolución del

92 de devolución del IVA, en facturas y notas de débito, no corresponde
al que RECEPCIÓN IVA. fue autorizado por el servicio web DIG.

Notas:

1.  Todos aquellos comprobantes que hayan sido rechazados por cualquiera de
        los errores señalados en la tabla anterior pueden ser reenviados para su
        autorización una vez corregido el error motivo del rechazo sin generar nuevos
        números de clave de acceso o secuenciales para los comprobantes. A
        excepción de aquellos casos específicos en los que aun cuando el archivo
        esté correcto, el sistema no pueda autorizar el comprobante debido a algún
        impedimento como, por ejemplo: en el caso de RUC o establecimiento
        clausurado, RUC inactivo, establecimiento cerrado, entre otros. Los
        comprobantes devueltos no se guardarán en la base de datos del SRI, se
        almacenarán únicamente los comprobantes que no hayan sido autorizados.

2.  En el caso del error con código 70 – Clave de acceso en procesamiento, no
        se deberá reenviar el comprobante o generar el comprobante con otra clave
        de acceso y secuencial hasta recibir una respuesta de autorización o rechazo
        del mismo, en un tiempo máximo de 24 horas.

CÓDIGO DE DESCRIPCIÓN POSIBLE SOLUCIÓN ADVERTENCIA 59 Identificación no
existe Cuando el número de la identificación del adquirente no existe.
Siempre que el comprobante sea emitido en ambiente de 60 Ambiente
ejecución. certificación o pruebas se enviará como parte de la
autorización esta advertencia. Cuando el número de la identificación del
adquirente del 62 Identificación incorrecta comprobante está incorrecto.
Por ejemplo, cédulas no pasan el dígito verificador. 68 Documento
sustento Cuando el comprobante relacionado no existe como electrónico.

         Al momento de receptar el archivo se realizarán las siguientes validaciones,
         según el orden especificado, cabe mencionar que estas no serán revisadas
         en su totalidad; es decir, si el sistema detecta como inconsistente el tamaño
         del archivo ese será el error remitido:

ORDEN VALIDACIÓN DESCRIPCIÓN Tamaño archivo 1 Validación XML Esquema
activo XML bien formado y válido RUC activo 2 Validación contribuyente
emisor Establecimiento activo

                                                                                                                 38

------------------------------------------------------------------------

ORDEN VALIDACIÓN DESCRIPCIÓN Autorización para emitir comprobantes
electrónicos activa Autorización para emisión del tipo de comprobante
Clave acceso única 3 Validación unicidad Secuencial único Clave acceso
bien formada Validez firma y cadena de confianza 4 Validación Firma OCSP
Fecha emisión 5 Verificaciones adicionales identificación del receptor
del comprobante documentos de sustento

6 Validación diferencias

3.   Las validaciones que se muestran a continuación deberán ser implementadas
         en el sistema del contribuyente, a fin de garantizar que la información
         transmitida a la base de datos del SRI cumpla con los requisitos establecidos
         en la normativa tributaria y comercio electrónico.

                                                                                                VALIDACIÓN:

    CÓDIGO RECEPCIÓN DE DESCRIPCIÓN POSIBLE SOLUCIÓN /AUTORIZACIÓN/
    ERROR EMISOR Comprobante no Cuando el comprobante no ha sido
    autorizado como parte 34 EMISOR autorizado de la solicitud de
    emisión del contribuyente. Certificado que ha superado su fecha de
    caducidad, y no 42 Certificado revocado EMISOR ha sido renovado.

52 Error en diferencias Cuando existe error en los cálculos del
comprobante. EMISOR

                                 Cuando el código del documento sustento no existe en el
          Código documento

64 catálogo de documentos que se tiene en la EMISOR sustento
Administración. Cuando el comprobante emitido no fue enviado de Fecha de
emisión EMISOR/ 65 acuerdo con el tiempo del tipo de emisión en el cual
fue extemporánea RECEPCIÓN realizado. Cuando la identificación asociada
al adquirente no existe. Identificación del 69 En general cuando el RUC
del adquirente no existe en el EMISOR receptor Registro Único de
Contribuyentes.

Para acceder al catastro de RUC podrán descargarlo desde el siguiente
link: http://www.sri.gob.ec/web/guest/catastros

12. Códigos de error para aplicación de la devolución automática del IVA
    CÓDIGO DE VALIDACIÓN DESCRIPCIÓN

2000 EXITO Éxito.

2001 EXITO_VALIDACION Validación exitosa.

                                                                                                            39

------------------------------------------------------------------------

           CÓDIGO DE VALIDACIÓN                                      DESCRIPCIÓN

                                               Estimado contribuyente, los campos registrados no cu

3000 ERROR_FORMATO mplen con el formato establecido.

3001 ERROR_TRANSACCION No se logró hacer la transacción.

3003 ERROR_CLAVE_YA_PROCESADA Comprobante ya procesado.

3004 ERROR_CODIGO_OPERACION_INVALIDO Código operación inválido.

3005 ERROR_INTERNO_SERVIDOR Se ha producido un error.

3006 ERROR_TIME_OUT No se ha podido responder a tiempo.

                                               Estimado contribuyente, el código de verificación

3007 ERROR_CODIGO_BENEFICIO ingresado no se encuentra vigente.

3008 ERROR_WS_NO_DISPONIBLE WEB Service no disponible.

3009 ERROR_WS_NO_AUTORIZADO No está autorizado.

3011 ERROR_NO_MONTO_MINIMO El valor no cumple en monto mínimo a
devolver.

                                               La tarifa del impuesto calculado no coincide con el

3013 ERROR_TARIFA_IMPUESTO enviado.

3014 ERROR_TOKEN_BENEFICIARIO El token no pertenece al emisor.

3015 El beneficiario no tiene el canal automático habilitado o
ERROR_CANAL_AUTOMATICO_NO_HABILITADO\_ no existe un monto a devolver.
SALDO 3016: El beneficiario registra más de una
ERROR_MULTIPLE_TRANSACCIONES_LOTE transacción en el lote enviado

4000 LOTE_RECIBIDO Lote recibido.

4001 LOTE_RECHAZADO Lote rechazado.

4002 LOTE_EN_PROCESO Lote en proceso.

4003 LOTE_PROCESADO Lote procesado.

                                               Los parámetros: rucs, fecha inicio o fecha fin para el

5001 ERROR_CONFIGURACION_PILOTO piloto no están configurados.

6000 ANULACION_ERROR Error al realizar la anulación.

6001 No se realizó la transacción: comprobante electrónico
ANULACION_COMPROBANTE_NO_ENCONTRAD no encontrado. O No se realizó la
transacción: el monto del IVA a 6002 ANULACION_IVA_DEVOLVER_DIFERENTES
devolver no es igual al que se registró en el débito. El código del
beneficio no corresponde al registrado en 6004
ANULACION_BENEFICIO_INCORRECTO el SRI.

6005 ANULACION_FECHA_DIFERENTE_HOY La fecha de emisión no corresponde a
la de hoy.

6006 El comprobante tiene que ser una factura o una nota de
ANULACION_TIPO_COMPROBANTE_INCORRECT débito. O

                                                                                                        40

------------------------------------------------------------------------

          CÓDIGO DE VALIDACIÓN                                            DESCRIPCIÓN

6007 ANULACION_ENVIADA_EXITO Anulación enviada con éxito.

6008 No se realizó la transacción: falta el monto del IVA a
ANULACION_IVA_DEVOLVER_NO_ENCONTRADO devolver. 6009 No se realizó la
transacción: la identificación no ANULACION_IDENTIFICACIONES_DIFERENTES
corresponde a la clave de acceso. 6010 No se realizó la transacción: el
cálculo del IVA a ANULACION_IVA_CALCULADO_DIFERENTES devolver no es
igual al que se registró en el débito. 6011 No se realizó la
transacción: la base imponible no es ANULACION_BASE_IMPONIBLE_DIFERENTES
igual a la que se registró en el débito.

6012 ANULACION_NO_SALDO_DISPONIBLE No se realizó la transacción: no
tiene saldo disponible.

7000 No existen registros en el canal automático.
BENEFICIARIOS_ARCHIVO_NO_ENCONTRADO

13. Servicios web para la devolución automática del IVA a personas
    adultas mayores - DIG 13.1 Los enlaces WEB Service habilitados para
    los emisores electrónicos son los siguientes:

        1. Servicio para obtención de lista de beneficiarios
        2. Servicio para la recepción de información por lotes
        3. Servicio para la consulta de información por lote (respuesta)
        4. Servicio para la recepción de información individual
        5. Servicio para anulación de descuento de devolución del IVA

    Existen dos ambientes disponibles para la invocación de los enlaces
    WEB Service publicados por la Administración Tributaria:

Protocolo URL BASE Versión Ambiente

    HTTPS       https://celcer.sri.gob.ec/devolucion-iva/rest        V1        Certificación producción


    HTTPS      https://srienlinea.sri.gob.ec/devolucion-iva/rest     V1         Producción producción


     Uno es para el ambiente de pruebas, donde cada contribuyente certificará que
     su aplicación funcione correctamente con cada tipo de comprobante
     electrónico.

     El segundo es para el ambiente de producción, al cual cada contribuyente
     deberá acceder una vez que ha realizado las pruebas y esté seguro de que su
     aplicación funciona correctamente.


                                                                                                              41

------------------------------------------------------------------------

     Se deberá configurar el dominio para el consumo de los enlaces WEB Service
     dependiendo del ambiente a utilizar.

13.2 La seguridad para los servicios será provista mediante tokens del
protocolo OAuth2:

Protocolo URL Autenticación Versión

              https://celcer.sri.gob.ec/sri-seguridad-sso-api-servicio-internet/rest/seguridad-sso-

HTTPS rest/access- V1
token/RUC_CONTRIBUYENTE\[AD\]CEDULA_ADICIONAL/CLAVE_ENCRIPTAD
A_ADICIONAL_SHA-512

               https://srienlinea.sri.gob.ec/sri-seguridad-sso-api-servicio-internet/rest/seguridad-

HTTPS sso-rest/access- V1
token/RUC_CONTRIBUYENTE\[AD\]CEDULA_ADICIONAL/CLAVE_ENCRIPTAD
A_ADICIONAL_SHA-512

     Los parámetros de “RUC_CONTRIBUYENTE”, “CEDULA_ADICIONAL” y
     “CLAVE_ENCRIPTADA_ADICIONAL_SHA-512” deberán ser reemplazados
     con los datos propios del contribuyente emisor electrónico.

     El Token tendrá una vigencia de 35 minutos.

     En las llamadas a los servicios se deberá incluir el token generado como un
     parámetro de cabecera con la etiqueta Authorization.

                                                                                   Tipo de
      Tipo de operación            Parámetros                Tipo de dato                        Tamaño
                                                                                 parámetros
                             USUARIO_ADICIONAL
                                                                 String             Query
              GET                                                                                      13
                             CLAVE_ENCRIPTADA_                   string             Query
                             ADICIONAL_ SHA-512


     Para los valores monetarios que son variables de entrada o salida de los
     servicios deberán ser enviados o receptados con una precisión de dos
     decimales.

13.3 Servicio web para obtención de lista de beneficiarios

     La información que se requiere para el consumo de este servicio es:

          •   RUC del emisor electrónico

     El dato que devolverá el servicio es:

          •   Un archivo zip “cedulas_canal” que contiene las identificaciones de las
              personas que se encuentran habilitadas para acceder al beneficio por
              el mecanismo automático.

     Esta información se actualizará diariamente entre las 0:30 am y 2:00 am, y
     estará disponible durante el día.

     Para utilizar el servicio se deberá considerar lo siguiente:

                                                                                                                   42

------------------------------------------------------------------------

                           Método                             URL
                            POST                   /devolucionesBeneficiarios


                    URL BASE CON EL SERVICIO                                        Ambiente

                                                                                   Certificación

https://celcer.sri.gob.ec/devolucion-iva/rest/devolucionesBeneficiarios
Producción

                https://srienlinea.sri.gob.ec/devolucion-                           Producción
                   iva/rest/devolucionesBeneficiarios                               Producción


                Tipo de operación        Parámetros         Tipo de dato   Tipo de parámetros
                      HEAD                 Token               String            Header

                       POST                  ruc               string              body

13.4 Servicio web para la recepción de información por lotes

      El servicio para la recepción de información por lotes devolverá un código de
      operación por el lote (lista datos enviados).

      La longitud máxima de la lista de datos será de diez mil elementos, si los
      emisores requieren enviar listas más largas deberán dividir los datos y hacer
      uso varias veces del servicio.

      La información que se requiere en este servicio por parte del emisor
      electrónico en cada uno de los ítems de la lista de datos deberá contener:

          • RUC del emisor electrónico
          • Clave de acceso del comprobante
          • Identificación del beneficiario (cédula)
          • Base imponible gravada diferente a cero (subtotal del comprobante con
            IVA gravada diferente a cero)
          • Tarifa (porcentaje) del IVA diferente de cero
          • Monto del IVA diferente de cero

          El dato que devolverá el servicio es:

          • Código de operación (código lote)

      Para utilizar el servicio se deberá considerar lo siguiente:


                           Método                           URL
                            POST               /devolucionesLotesRecepciones


                            URL BASE CON EL SERVICIO                                        Ambiente

                                                                                           Certificación
      https://celcer.sri.gob.ec/devolucion-iva/rest/devolucionesLotesRecepciones
                                                                                           Producción


                                                                                                           43

------------------------------------------------------------------------

                                                                                           Producción

https://srienlinea.sri.gob.ec/devolucion-iva/rest/devolucionesLotesRecepciones
Producción

            Tipo de operación          Parámetros         Tipo de dato      Tipo de parámetro
                  HEAD                   Token               String               header

                  POST               datosBeneficio            json                 body


                              Trama que recibe            Trama de respuesta

                         DatosBeneficio:                Respuesta:
                         type: array                        type: object
                         properties:                        properties:
                         rucEmisor:                         codigoLote
                         required: true                     required: true
                         type: string                       type: string
                         claveAccesoComprobante:            MensajeRespueta
                         required: true                     required: true
                         type: string                       type: string
                         idBeneficiario:
                         required: true                 MensajeRespuesta:
                         type: string                   type: string
                         baseImponible:
                         required: true
                         type: number
                         porcentajeIva:
                         required: true
                         type: number
                         montoIva:
                         requiered: true
                         type: number

13.5 Servicio web para la respuesta de información por lotes (respuesta)

     Con el código de operación que se obtuvo del servicio para la recepción de
     información por lote, se podrán consultar los resultados de los descuentos de
     cada ítem de la lista de datos enviados anteriormente.

     La información que se requiere en este servicio por parte del emisor
     electrónico es:

     • Código de operación (Código lote)

      Los datos que devolverá el servicio es una lista de objetos cuyos atributos
      son:

     • Clave de acceso del comprobante
     • Valor del descuento IVA.
     • Mensaje asociado al valor.

     Para utilizar el servicio se deberá considerar lo siguiente:


                                                                                                        44

------------------------------------------------------------------------

                          Método                          URL
                           POST              /devolucionesLotesRespuestas


                          URL BASE CON EL SERVICIO                                         Ambiente

                                                                                       Certificación
     https://celcer.sri.gob.ec/devolucion-iva/rest/devolucionesLotesRespuestas
                                                                                       Producción

                                                                                           Producción
    https://srienlinea.sri.gob.ec/devolucion-iva/rest/devolucionesLotesRespuestas
                                                                                           Producción


            Tipo de operación          Parámetros          Tipo de dato     Tipo de parámetro
                  HEAD                   Token                String              Header

                   POST              codigoOperacion           string               body


              Trama que recibe                         Trama de respuesta

                  codigoLote         body:
                                     application/json:
                                     type: Respuesta
                                     required: true
                                     example:
                                     {listaDescuento:
                                     [
                                     { "claveAcceso": 12345678901234567890123454545454,
                                     "valor": 1,”descripcion”:”aprobado”},
                                     { "claveAcceso": 12345678901234567890123454545455,
                                     "valor": 2,”descripcion”:”aprobado”}
                                     ] , “codigo”: “4003”,”mensaje”:”lote_procesado”}

13.6 Servicio web para la recepción de información individual

     Este servicio estará disponible para aquellos emisores electrónicos cuya
     facturación se genere a demanda del cliente.

     La información que se requiere en este servicio por parte del emisor
     electrónico es:

       •    RUC del emisor electrónico
       •    Clave de acceso del comprobante
       •    Identificación del beneficiario (cédula)
       •    Código de acceso otorgado al beneficiario
       •    Base imponible gravada diferente a cero (Subtotal del comprobante con
            IVA gravada diferente a cero)
       •    Tarifa (porcentaje) del IVA diferente de cero
       •    Monto del IVA diferente de cero

            Los datos que devolverá el servicio son:

       •    Mensaje asociado al valor
       •    Valor del descuento IVA


                                                                                                        45

------------------------------------------------------------------------

     Nota: el código de confirmación en el ambiente de “Certificación Producción”
     es 1234 para los beneficiarios que se encuentren en el servicio web para
     obtención de lista de beneficiarios.

     Para utilizar el servicio se deberá considerar lo siguiente:

                          Método                          URL
                           POST           /devolucionesIndividualesRecepciones


                            URL BASE CON EL SERVICIO                                         Ambiente

                                                                                            Certificación

https://celcer.sri.gob.ec/devolucion-iva/rest/devolucionesIndividualesRecepciones
Producción

                                                                                            Producción

https://srienlinea.sri.gob.ec/devolucion-iva/rest/devolucionesIndividualesRecepciones
Producción

            Tipo de operación          Parámetros          Tipo de dato       Tipo de parámetro
                  HEAD                   Token                String                header

                   POST               DatosBeneficio        Object-json             query


                              Trama que recibe               Trama de respuesta

                       DatosBeneficio:                    Descuento:
                       type: object                       type: object
                       properties:                        properties:
                       rucEmisor:                         montoIvaDevolver:
                       required: true                     required: true
                       type: string                       type: number
                       claveAccesoComprobante:            codigo:
                       required: true                     required: true
                       type: string                       type: String
                       idBeneficiario:                    mensaje:
                       required: true                     required: true
                       type: string                       type: string
                              codigoBeneficio:
                       required: true
                       type: string
                       baseImponible:
                       required: true
                       type: number
                       porcentajeIva:
                       required: true
                       type: number
                       montoIva:
                       required: true
                       type: number

13.7 Servicio web para anulación de descuento de devolución del IVA

     El servicio se expone para los casos en que no se pueda concretar la
     transacción entre el cliente y el local comercial del emisor electrónico.

     La información que se requiere en este servicio por parte del emisor
     electrónico es:


                                                                                                            46

------------------------------------------------------------------------

• RUC del emisor electrónico • Clave de acceso del comprobante •
Identificación del beneficiario (cédula) • Código de acceso otorgado al
beneficiario • Base imponible gravada diferente a cero (Subtotal del
comprobante con IVA gravada diferente a cero) • Tarifa (porcentaje) del
IVA diferente de cero • Monto del IVA diferente de cero • Monto IVA a
devolver

      El dato que devolverá el servicio es:

• Mensaje de respuesta

      Nota: el código de confirmación en el ambiente de “Certificación Producción”
      es 1234 para los beneficiarios que se encuentren en el servicio web para
      obtención de lista de beneficiarios.

      Para utilizar el servicio se deberá considerar lo siguiente:

                           Método                          URL
                            POST           /devolucionesIndividualesAnulaciones


                              URL BASE CON EL SERVICIO                                       Ambiente

                                                                                            Certificación
     https://celcer.sri.gob.ec/devolucion-iva/rest/devolucionesIndividualesAnulaciones
                                                                                            Producción

                                                                                            Producción
    https://srienlinea.sri.gob.ec/devolucion-iva/rest/devolucionesIndividualesAnulaciones
                                                                                            Producción


             Tipo de operación          Parámetros          Tipo de dato      Tipo de parámetro
                   HEAD                   Token                String               header

                    POST               DatosAnulacion           object               body


                                  Trama que recibe          Trama de respuesta


                                                                                                            47

------------------------------------------------------------------------

                 DatosAnulacion:                         mensaje:
                 type: object                  required: true
                 properties:                   type: string
                 rucEmisor:
                 required: true
                 type: string
                 claveAccesoComprobante:
                 required: true
                 type: string
                 idBeneficiario:
                 required: true
                 type: string
                 codigoBeneficio:
                 required: true
                 type: string
                 baseImponible:
                 required: true
                 type: number
                 porcentajeIva:
                 required: true
                 type: number
                 montoIva:
                 required: true
                 type: number
                           montoIvaDevolver:
                 required: true
                 type: number

14. Anexos Se describe a continuación la estructura de los comprobantes
    electrónicos (no incluye firma electrónica ni autorización por parte
    del SRI).

ANEXO 1 - FORMATOS XML VERSIÓN 1.0.0 Para el desarrollo de los XML de
cualquier comprobante, se recuerda que los campos de tipo alfanumérico
no deberán contener espacios generados entre sus caracteres, ya que esto
será motivo de error de esquema que puede ocasionar rechazo del
comprobante o falta de respuesta en el envío; por ejemplo:

Error:

`<campoAdicional nombre="Dirección">`{=html}Av. 27 de febrero 1-47 y Av
10 de Agosto`</campoAdicional>`{=html}

Corrección:

`<campoAdicional nombre="Dirección">`{=html}Av. 27 de febrero 1-47 y Av
10 de Agosto`</campoAdicional>`{=html}

                                                                           48

------------------------------------------------------------------------

FORMATO XML FACTURA TIPO DE LONGITUD / ETIQUETAS O TAGS CARACTER CAMPO
FORMATO `<?xml version="1.0" encoding="UTF-8" ?>`{=html} Obligatorio - -
`<factura id="comprobante" version="1.0.0">`{=html} Obligatorio - -
`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1 `</ambiente>`{=html} conforme Numérico 1 tabla 4
Obligatorio, `<tipoEmision>`{=html}1 \</ tipoEmision\> conforme Numérico
1 tabla 2 `<razonSocial>`{=html}Distribuidora de Suministros Nacional
S.A.`</razonSocial>`{=html} Obligatorio Alfanumérico Max 300 Obligatorio
`<nombreComercial>`{=html}Empresa Importadora y Exportadora de Piezas\</
nombreComercial \> cuando Alfanumérico Max 300 corresponda
`<ruc>`{=html}1792146739001`</ruc>`{=html} Obligatorio Numérico 13
Obligatorio,
`<claveAcceso>`{=html}2110201101179214673900110020010000000011234567813`</claveAcceso>`{=html}
conforme Numérico 49 tabla 1 Obligatorio,
`<codDoc>`{=html}01`</codDoc>`{=html} conforme Numérico 2 tabla 3
`<estab>`{=html}002`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}001`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000001`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}Enrique Guerrero Portilla OE1-34 AV. Galo
Plaza Lasso`</dirMatriz>`{=html} Obligatorio Alfanumérico Max 300
`</infoTributaria>`{=html} Obligatorio - - `<infoFactura>`{=html}
Obligatorio - -
`<fechaEmision>`{=html}21/10/2012`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio `<dirEstablecimiento>`{=html}Sebastián
Moreno S/N Francisco García\</ dirEstablecimiento \> cuando Alfanumérico
Max 300 corresponda Obligatorio
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda Obligatorio
`<obligadoContabilidad>`{=html}SI\</ obligadoContabilidad \> cuando
Texto SI / NO corresponda Obligatorio,
`<tipoIdentificacionComprador>`{=html}04\</ tipoIdentificacionComprador
\> conforme Numérico 2 tabla 6 Obligatorio
`<guiaRemision>`{=html}001-001-000000001`</guiaRemision>`{=html} cuando
Numérico 15 corresponda `<razonSocialComprador>`{=html}PRUEBAS SERVICIO
DE RENTAS Obligatorio Alfanumérico Max 300
INTERNAS`</razonSocialComprador>`{=html}

`<identificacionComprador>`{=html}1713328506001\</
identificacionComprador \> Obligatorio Alfanumérico Max 20 Obligatorio,
`<direccionComprador>`{=html}salinas y
santiago`</direccionComprador>`{=html} cuando Alfanumérico Max 300
corresponda
`<totalSinImpuestos>`{=html}295000.00`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14
`<totalDescuento>`{=html}5005.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14 `<totalConImpuestos>`{=html} Obligatorio - -
`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}3`</codigo >`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}3072\</ codigoPorcentaje\>
conforme Numérico Min 1 Max 4 tabla 18
`<baseImponible>`{=html}295000.00\</ baseImponible \> Obligatorio
Numérico Max 14 `<valor>`{=html}14750.00`</valor >`{=html} Obligatorio
Numérico Max 14 `</totalImpuesto >`{=html} Obligatorio - -

`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo >`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}2\</ codigoPorcentaje\> Numérico
Min 1 Max 4 conforme

                                                                                                                          49

------------------------------------------------------------------------

                                                                              TIPO DE       LONGITUD /
                                 ETIQUETAS O TAGS             CARACTER
                                                                              CAMPO          FORMATO
                                                                 tabla 17
                                                                Opcional,
                                                               aplica para

`<descuentoAdicional>`{=html}5.00`</descuentoAdicional>`{=html} Numérico
Max 14 código impuesto 2. `<baseImponible>`{=html}309750.00\</
baseImponible \> Obligatorio Numérico Max 14
`<valor>`{=html}37169.40`</valor >`{=html} Obligatorio Numérico Max 14
`</totalImpuesto >`{=html} Obligatorio - - `<totalImpuesto>`{=html}
Obligatorio - - Obligatorio, `<codigo>`{=html}5`</codigo >`{=html}
conforme Numérico 1 tabla 16 Obligatorio,
`<codigoPorcentaje>`{=html}5001\</ codigoPorcentaje\> conforme Numérico
Min 1 Max 4 tabla 18 `<baseImponible>`{=html}12000.00\</ baseImponible
\> Obligatorio Numérico Max 14 `<valor>`{=html}240.00`</valor >`{=html}
Obligatorio Numérico Max 14 `</totalImpuesto >`{=html} Obligatorio - -
`</totalConImpuestos >`{=html} Obligatorio - -
`<propina>`{=html}0.00`</propina>`{=html} Obligatorio Numérico Max 14
`<importeTotal>`{=html}347159.40\</ importeTotal\> Obligatorio Numérico
Max 14 Obligatorio `<moneda>`{=html}DOLAR`</moneda>`{=html} cuando
Alfanumérico Max 15 corresponda `<pagos>`{=html} Obligatorio - -

`<pago>`{=html} Obligatorio - Obligatorio,
`<formaPago>`{=html}01`</formaPago>`{=html} conforme Numérico 2 tabla 24
`<total>`{=html}347159.40`</total>`{=html} Obligatorio Numérico Max 14
Obligatorio, `<plazo>`{=html}30`<plazo>`{=html} cuando Numérico Max 14
corresponda Obligatorio,
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} cuando Texto Max 10
corresponda `</pago>`{=html} Obligatorio - - `</pagos>`{=html}
Obligatorio - - `<valorRetIva>`{=html}10620.00`</valorRetIva>`{=html}
Opcional Numérico Max 14
`<valorRetRenta>`{=html}2950.00`</valorRetRenta>`{=html} Opcional
Numérico Max 14 `</infoFactura>`{=html} Obligatorio - -
`<detalles>`{=html} Obligatorio - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}125BJC-01`</codigoPrincipal >`{=html}
Obligatorio Alfanumérico Max 25 Obligatorio
`<codigoAuxiliar>`{=html}1234D56789-A`</codigoAuxiliar>`{=html} cuando
Alfanumérico Max 25 corresponda `<descripcion>`{=html}CAMIONETA 4X4
DIESEL 3.7`</descripcion>`{=html} Obligatorio Alfanumérico Max 300
`<cantidad>`{=html}10.00`</cantidad>`{=html} Obligatorio Numérico Max 14
`<precioUnitario>`{=html}300000.00`</precioUnitario>`{=html} Obligatorio
Numérico Max 14 `<descuento>`{=html}5000.00`</descuento>`{=html}
Obligatorio Numérico Max 14
`<precioTotalSinImpuesto>`{=html}295000.00\</ precioTotalSinImpuesto\>
Obligatorio Numérico Max 14 Obligatorio `<detallesAdicionales>`{=html}
cuando - - corresponda Obligatorio
`<detAdicional nombre="Marca Chevrolet" valor="Chevrolet"/>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`<detAdicional nombre="Modelo " valor="2012"/>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio
`<detAdicional nombre="Chasis" valor="8LDETA03V20003289"/>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`</detallesAdicionales>`{=html} cuando - - corresponda
`<impuestos>`{=html} Obligatorio - -

                                                                                                     50

------------------------------------------------------------------------

                                                                                          TIPO DE       LONGITUD /
                                     ETIQUETAS O TAGS                     CARACTER
                                                                                          CAMPO          FORMATO
     <impuesto>                                                           Obligatorio         -               -
                                                                          Obligatorio,
     <codigo>3</codigo>                                                    conforme       Numérico           1
                                                                            tabla 16
                                                                          Obligatorio,
     <codigoPorcentaje>3072</codigoPorcentaje>                             conforme       Numérico      Min 1 Max 4
                                                                            tabla 18
     <tarifa>5</ tarifa>                                                  Obligatorio     Numérico      Min 1 Max 4
     <baseImponible>295000.00</baseImponible>                             Obligatorio     Numérico        Max 14

     <valor>14750.00</valor>                                              Obligatorio     Numérico        Max 14

     </impuesto>                                                          Obligatorio         -               -

     <impuesto>                                                           Obligatorio         -               -
                                                                          Obligatorio,
     <codigo>2</codigo>                                                    conforme       Numérico           1
                                                                            tabla 16
                                                                          Obligatorio,
     <codigoPorcentaje>2</codigoPorcentaje>                                conforme       Numérico      Min 1 Max 4
                                                                            tabla 17
                                                                                                        Min 1 Max 4 /
     <tarifa>12</ tarifa>                                                 Obligatorio     Numérico      2 enteros, 2
                                                                                                         decimales
     <baseImponible>309750.00</baseImponible>                             Obligatorio     Numérico        Max 14
     <valor>37170.00</valor>                                              Obligatorio     Numérico        Max 14

     </impuesto>                                                          Obligatorio         -               -
     <impuesto>                                                           Obligatorio         -               -
                                                                          Obligatorio,
     <codigo>5</codigo>                                                    conforme       Numérico           1
                                                                            tabla 16
                                                                          Obligatorio,
     <codigoPorcentaje>5001</codigoPorcentaje>                             conforme       Numérico      Min 1 Max 4
                                                                            tabla 18
     <tarifa>0.02</ tarifa>                                               Obligatorio     Numérico      Min 1 Max 4
     <baseImponible>12000.00</baseImponible>                              Obligatorio     Numérico        Max 14
     <valor>240.00</valor>                                                Obligatorio     Numérico        Max 14

     </impuesto>                                                          Obligatorio         -               -

     </impuestos>                                                         Obligatorio         -               -

     <detalle>                                                            Obligatorio         -               -

     <detalles>                                                           Obligatorio         -               -
                                                                           Obligatorio
     <infoAdicional>                                                        cuando            -               -
                                                                          corresponda
                                                                           Obligatorio
     <campoAdicional nombre="Codigo Impuesto ISD">4580</campoAdicional>     cuando       Alfanumérico     Max 300
                                                                          corresponda
                                                                           Obligatorio
     <campoAdicional nombre="Impuesto ISD">15.42x</campoAdicional>          cuando       Alfanumérico     Max 300
                                                                          corresponda
                                                                           Obligatorio
     </infoAdicional>                                                       cuando            -               -
                                                                          corresponda
     </factura>                                                           Obligatorio         -               -


     FORMATO XML COMPROBANTE RETENCIÓN
                                                                                          TIPO DE       LONGITUD /
                                     ETIQUETAS O TAGS                     CARACTER
                                                                                          CAMPO          FORMATO

     <?xml version="1.0" encoding="UTF-8" ?>                              Obligatorio         -               -

     <comprobanteRetencion id="comprobante" version="1.0.0">              Obligatorio         -               -

\<\< `<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1`</ambiente>`{=html} conforme Numérico 1 tabla 4

                                                                                                                  51

------------------------------------------------------------------------

                                                                                                     TIPO DE       LONGITUD /
                                  ETIQUETAS O TAGS                                  CARACTER
                                                                                                     CAMPO          FORMATO
                                                                                    Obligatorio,

`<tipoEmision>`{=html}1\</ tipoEmision\> conforme Numérico 1 tabla 2
`<razonSocial>`{=html}Distribuidora de Suministros Nacional
S.A.`</razonSocial>`{=html} Obligatorio Alfanumérico Max 300 Obligatorio
`<nombreComercial>`{=html}Empresa Importadora y Exportadora de Piezas y
Partes de Equipos cuando Alfanumérico Max 300 de Oficina\</
nombreComercial \> corresponda
`<ruc>`{=html}1792146739001`</ruc>`{=html} Obligatorio Numérico 13
Obligatorio,
`<claveAcceso>`{=html}2410201107179214673900110020010000000011234567815`</claveAcceso>`{=html}
conforme Numérico 49 tabla 1 Obligatorio,
`<codDoc>`{=html}07`</codDoc>`{=html} conforme Numérico 2 tabla 3
`<estab>`{=html}002`</estab>`{=html} Obligatorio Numérico 3

`<ptoEmi>`{=html}001`</ptoEmi>`{=html} Obligatorio Numérico 3

`<secuencial>`{=html}000000001`</secuencial>`{=html} Obligatorio
Numérico 9

`<dirMatriz>`{=html}Enrique Guerrero Portilla OE1-34 AV. GALO PLAZA
LASSO`</dirMatriz>`{=html} Obligatorio Alfanumérico Max 300

`</infoTributaria>`{=html} Obligatorio - -

`<infoCompRetencion>`{=html} Obligatorio - -

`<fechaEmision>`{=html}15/01/2012`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio `<dirEstablecimiento>`{=html}Rodrigo Moreno
S/N Francisco García\</ dirEstablecimiento \> cuando Alfanumérico Max
300 corresponda Obligatorio
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda Obligatorio
`<obligadoContabilidad>`{=html}SI\</ obligadoContabilidad \> cuando
Texto SI / NO corresponda Obligatorio,
`<tipoIdentificacionSujetoRetenido>`{=html}04`</tipoIdentificacionSujetoRetenido>`{=html}
conforme Numérico 2 tabla 6

`<razonSocialSujetoRetenido>`{=html}Juan Pablo Chávez
Núñez`</razonSocialSujetoRetenido>`{=html} Obligatorio Alfanumérico Max
300

`<identificacionSujetoRetenido>`{=html}1713328506001`</identificacionSujetoRetenido>`{=html}
Obligatorio Alfanumérico Max 20
`<periodoFiscal>`{=html}03/2012`</periodoFiscal>`{=html} Obligatorio
Fecha mm/aaaa `</infoCompRetencion>`{=html} Obligatorio - -

`<impuestos>`{=html} Obligatorio - -

`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<código>`{=html}2`</código>`{=html} conforme tabla Numérico 1 19
Obligatorio, `<codigoRetencion>`{=html}1`</codigoRetencion>`{=html}
conforme tabla Alfanumérico Min 1 Max 5 20
`<baseImponible>`{=html}101.94`</baseImponible>`{=html} Obligatorio
Numérico Max 14 Obligatorio, Min 1 Max 5
`<porcentajeRetener>`{=html}30`</porcentajeRetener>`{=html} conforme
tabla Numérico entre enteros 20 y decimales
`<valorRetenido>`{=html}30.58`</valorRetenido>`{=html} Obligatorio
Numérico Max 14 `<codDocSustento>`{=html}01`</codDocSustento>`{=html}
Obligatorio Numérico Min 2 Max 3
`<numDocSustento>`{=html}002001000000001`</numDocSustento>`{=html}
Opcional Numérico 15 Obligatorio
`<fechaEmisionDocSustento>`{=html}20/01/2012`</fechaEmisionDocSustento>`{=html}
cuando Fecha dd/mm/aaaa corresponda `</impuesto>`{=html} Obligatorio - -
`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<código >`{=html}1`</código>`{=html} conforme tabla Numérico 1 19
Obligatorio, `<codigoRetencion>`{=html}323B1`</codigoRetencion>`{=html}
conforme tabla Alfanumérico Min 1 Max 5 20
`<baseImponible>`{=html}10904.50`</baseImponible>`{=html} Obligatorio
Numérico Max 14

                                                                                                                             52

------------------------------------------------------------------------

                                                                                                        TIPO DE        LONGITUD /
                                  ETIQUETAS O TAGS                                     CARACTER
                                                                                                        CAMPO           FORMATO
                                                                                       Obligatorio,

`<porcentajeRetener>`{=html}2`</porcentajeRetener>`{=html} conforme
tabla Numérico Min 1 Max 5 20
`<valorRetenido>`{=html}218.09`</valorRetenido>`{=html} Obligatorio
Numérico Max 14 `<codDocSustento>`{=html}01`</codDocSustento>`{=html}
Opcional Numérico 2
`<numDocSustento>`{=html}002001000000001`</numDocSustento>`{=html}
Opcional Numérico 15 Obligatorio
`<fechaEmisionDocSustento>`{=html}20/01/2012`</fechaEmisionDocSustento>`{=html}
cuando Fecha dd/mm/aaaa corresponda `</impuesto>`{=html} Obligatorio - -
`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<código>`{=html}6`</código>`{=html} conforme tabla Numérico 1 19
Obligatorio, `<codigoRetencion>`{=html}4580`</codigoRetencion>`{=html}
conforme tabla Alfanumérico Min 1 Max 5 20
`<baseImponible>`{=html}2000`</baseImponible>`{=html} Obligatorio
Numérico Max 14 Obligatorio,
`<porcentajeRetener>`{=html}5`</porcentajeRetener>`{=html} conforme
tabla Numérico Min 1 Max 5 20
`<valorRetenido>`{=html}100`</valorRetenido>`{=html} Obligatorio
Numérico Max 14 `<codDocSustento>`{=html}12`</codDocSustento>`{=html}
Obligatorio Numérico Min 2 Max 3
`<numDocSustento>`{=html}002001000000001`</numDocSustento>`{=html}
Opcional Numérico 15 Obligatorio
`<fechaEmisionDocSustento>`{=html}20/01/2012`</fechaEmisionDocSustento>`{=html}
cuando Fecha dd/mm/aaaa corresponda `</impuesto>`{=html} Obligatorio - -
`</impuestos>`{=html} Obligatorio - - Obligatorio
`<infoAdicional>`{=html} cuando - - corresponda Obligatorio
`<campoAdicional nombre="ConvenioDobleTributacion">`{=html}MA123456`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`<campoAdicional nombre="documentoIFIS">`{=html}BP2010-01-0014`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`<campoAdicional nombre="valorpagadoIRsociedaddividendos">`{=html}20000`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`</infoAdicional>`{=html} cuando - - corresponda
`</comprobanteRetencion>`{=html} Obligatorio - -

FORMATO XML GUÍA DE REMISIÓN TIPO DE LONGITUD / ETIQUETAS O TAGS
CARACTER CAMPO FORMATO `<?xml version="1.0" encoding="UTF-8" ?>`{=html}
Obligatorio - - `<guiaRemision id="comprobante" version="1.0.0">`{=html}
Obligatorio - - `<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1`</ambiente>`{=html} conforme Numérico 1 tabla 4
Obligatorio, `<tipoEmision>`{=html}1\</ tipoEmision\> conforme Numérico
1 tabla 2 `<razonSocial>`{=html}Distribuidora de Suministros Nacional
S.A.`</razonSocial>`{=html} Obligatorio Alfanumérico Max 300 Obligatorio
`<nombreComercial>`{=html}Empresa Importadora y Exportadora de Piezas y
Partes de Equipos de cuando Alfanumérico Max 300 Oficina\</
nombreComercial \> corresponda
`<ruc>`{=html}1792146739001`</ruc>`{=html} Obligatorio Numérico 13
Obligatorio,
`<claveAcceso>`{=html}2110201106179214673900100110020010000000011234567815`</claveAcceso>`{=html}
conforme Numérico 49 tabla 1 Obligatorio,
`<codDoc>`{=html}06`</codDoc>`{=html} conforme Numérico 2 tabla 3

                                                                                                                                    53

------------------------------------------------------------------------

                                                                                                             TIPO DE       LONGITUD /
                                     ETIQUETAS O TAGS                                      CARACTER
                                                                                                             CAMPO          FORMATO

`<estab>`{=html}002`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}001`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000001`</secuencial>`{=html} Obligatorio
Numérico 9

`<dirMatriz>`{=html}Enrique Guerrero Portilla OE1-34 AV. Galo Plaza
Lasso`</dirMatriz>`{=html} Obligatorio Alfanumérico Max 300

`</infoTributaria>`{=html} Obligatorio - - `<infoGuiaRemision>`{=html}
Obligatorio - - Obligatorio `<dirEstablecimiento>`{=html}Sebastián
Moreno S/N Francisco García\</ dirEstablecimiento \> cuando Alfanumérico
Max 300 corresponda `<dirPartida>`{=html}Av. Eloy Alfaro 34 y Av.
Libertad Esq.`</dirPartida>`{=html} Obligatorio Alfanumérico Max 300
`<razonSocialTransportista>`{=html}Transportes
S.A.`</razonSocialTransportista>`{=html} Obligatorio Alfanumérico Max
300 Obligatorio,
`<tipoIdentificacionTransportista>`{=html}04`</tipoIdentificacionTransportista>`{=html}
conforme Numérico 2 tabla 6
`<rucTransportista>`{=html}1796875790001`</rucTransportista>`{=html}
Obligatorio Alfanumérico Max 13 Obligatorio `<rise>`{=html}Contribuyente
Regimen Simplificado RISE`</rise>`{=html} cuando Alfanumérico Max 40
corresponda Obligatorio `<obligadoContabilidad>`{=html}SI\</
obligadoContabilidad \> cuando Texto SI / NO corresponda Obligatorio
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda
`<fechaIniTransporte>`{=html}21/10/2011`</fechaIniTransporte>`{=html}
Obligatorio Fecha dd/mm/aaaa
`<fechaFinTransporte>`{=html}22/10/2011`</fechaFinTransporte>`{=html}
Obligatorio Fecha dd/mm/aaaa `<placa>`{=html}MCL0827`</placa>`{=html}
Obligatorio Alfanumérico Max 20

`</infoGuiaRemision>`{=html} Obligatorio - - `<destinatarios>`{=html}
Obligatorio - - `<destinatario>`{=html} Obligatorio - -
`<identificacionDestinatario>`{=html}1716849140001`</identificacionDestinatario>`{=html}
Obligatorio Alfanumérico Max 20
`<razonSocialDestinatario>`{=html}Alvarez Mina John
Henry`</razonSocialDestinatario>`{=html} Obligatorio Alfanumérico Max
300 `<dirDestinatario>`{=html}Av. Simón Bolívar S/N
Intercambiador`</dirDestinatario>`{=html} Obligatorio Alfanumérico Max
300 `<motivoTraslado>`{=html}Venta de Maquinaria de
Impresión`</motivoTraslado>`{=html} Obligatorio Alfanumérico Max 300
Obligatorio
`<docAduaneroUnico>`{=html}0041324846887`</docAduaneroUnico>`{=html}
cuando Alfanumérico Max 20 corresponda Obligatorio
`<codEstabDestino>`{=html}001`</codEstabDestino>`{=html} cuando Numérico
3 corresponda Obligatorio `<ruta>`{=html}Quito -- Cayambe -
Otavalo`</ruta>`{=html} cuando Alfanumérico Max 300 corresponda
Obligatorio cuando `<codDocSustento>`{=html}01`</codDocSustento>`{=html}
corresponda, Numérico Min 2 Max 3 conforme tabla 3 Obligatorio
`<numDocSustento>`{=html}002-001-000000001`</numDocSustento>`{=html}
cuando Numérico 15 corresponda Obligatorio
`<numAutDocSustento>`{=html}2110201116302517921467390011234567891`</numAutDocSustento>`{=html}
cuando Numérico 10 o 37 o 49 corresponda Obligatorio
`<fechaEmisionDocSustento>`{=html}21/10/2011`</fechaEmisionDocSustento>`{=html}
cuando Fecha dd/mm/aaaa corresponda `<detalles>`{=html} Obligatorio - -

`<detalle>`{=html} Obligatorio - - 11
`<codigoInterno>`{=html}125BJC-01\</ codigoInterno \> Opcional
Alfanumérico Max 25

11 Reglamento de Comprobantes de Venta, Retención y Documentos
Complementarios. - Artículo 19, numeral 2: Descripción o concepto del

bien transferido o del servicio prestado, indicando la cantidad y unidad
de medida, cuando proceda. Tratándose de bienes que están identificados
mediante códigos, número de serie o número de motor, deberá consignarse
obligatoriamente dicha información.

                                                                                                                                    54

------------------------------------------------------------------------

                                                                                                        TIPO DE       LONGITUD /
                                  ETIQUETAS O TAGS                                    CARACTER
                                                                                                        CAMPO          FORMATO
                                                                                       Obligatorio

`<codigoAdicional>`{=html}1234D56789-A`</codigoAdicional>`{=html} cuando
Alfanumérico Max 25 corresponda `<descripcion>`{=html}CAMIONETA 4X4
DIESEL 3.7`</descripcion>`{=html} Obligatorio Alfanumérico Max 300
`<cantidad>`{=html}10.00`</cantidad>`{=html} Obligatorio Numérico Max 14
Obligatorio `<detallesAdicionales>`{=html} cuando - - corresponda
Obligatorio `<detAdicional nombre="Marca" valor="Chevrolet"/>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`<detAdicional nombre="Modelo" valor="2012"/>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio
`<detAdicional nombre="Chasis" valor="8LDETA03V20003289"/>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`</detallesAdicionales>`{=html} cuando - - corresponda
`</detalle>`{=html} Obligatorio - - `</detalles>`{=html} Obligatorio - -
`</destinatario>`{=html} Obligatorio - - `</destinatarios>`{=html}
Obligatorio - - Obligatorio `<infoAdicional>`{=html} cuando - -
corresponda Obligatorio
`<campoAdicional nombre="TELEFONO">`{=html}098568541`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`<campoAdicional nombre="E-MAIL">`{=html}info@organizacion.com`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`<campoAdicional nombre="SUCURSAL 03">`{=html}Guayaquil--12 de octubre y
cuando Alfanumérico Max 300 Universo`</campoAdicional>`{=html}
corresponda Obligatorio `</infoAdicional>`{=html} cuando - - corresponda
`</guiaRemision>`{=html} Obligatorio - -

FORMATO XML NOTA DE CRÉDITO Nota: La tarifa de IVA corresponderá a la
fecha de emisión del documento de sustento.

                                                                                                      TIPO DE        LONGITUD /
                                  ETIQUETAS O TAGS                                   CARACTER
                                                                                                      CAMPO           FORMATO

`<?xml version="1.0" encoding="UTF-8" ?>`{=html} Obligatorio - -

`<notaCredito id="comprobante" version="1.0.0">`{=html} Obligatorio - -

`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1`</ambiente>`{=html} conforme Numérico 1 tabla 4
Obligatorio, `<tipoEmision>`{=html}1\</ tipoEmision\> conforme Numérico
1 tabla 2 `<razonSocial>`{=html}Distribuidora de Suministros Nacional
S.A.`</razonSocial>`{=html} Obligatorio Alfanumérico Max 300 Obligatorio
`<nombreComercial>`{=html}Empresa Importadora y Exportadora de Piezas
\</ nombreComercial \> cuando Alfanumérico Max 300 corresponda
`<ruc>`{=html}1792146739001001`</ruc>`{=html} Obligatorio Numérico 13
Obligatorio,
`<claveAcceso>`{=html}2110201104179214673900110020010000000011234567812`</claveAcceso>`{=html}
conforme Numérico 49 tabla 1

                                                                                                                                 55

------------------------------------------------------------------------

                                                                                                  TIPO DE       LONGITUD /
                                  ETIQUETAS O TAGS                                CARACTER
                                                                                                  CAMPO          FORMATO
                                                                                  Obligatorio,

`<codDoc>`{=html}04`</codDoc>`{=html} conforme Numérico 2 tabla 3
`<estab>`{=html}002`</estab>`{=html} Obligatorio Numérico 3

`<ptoEmi>`{=html}001`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000001`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}ENRIQUE GUERRERO PORTILLA OE1-34 AV. GALO
PLAZA Obligatorio Alfanumérico Max 300 LASSO`</dirMatriz>`{=html}
`</infoTributaria>`{=html} Obligatorio - -

`<infoNotaCredito>`{=html} Obligatorio - -

`<fechaEmision>`{=html}21/10/2012`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio `<dirEstablecimiento>`{=html}Sebastián
Moreno S/N Francisco García\</ dirEstablecimiento\> cuando Alfanumérico
Max 300 corresponda Obligatorio,
`<tipoIdentificacionComprador>`{=html}04\</ tipoIdentificacionComprador
\> conforme Numérico 2 tabla 6 `<razonSocialComprador>`{=html}PRUEBAS
SERVICIO DERENTAS Obligatorio Alfanumérico Max 300
INTERNAS`</razonSocialComprador>`{=html}

`<identificacionComprador>`{=html}1713328506001`</identificacionComprador>`{=html}
Obligatorio Alfanumérico Max 20 Obligatorio
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda Obligatorio
`<obligadoContabilidad>`{=html}SI\</ obligadoContabilidad\> cuando Texto
SI / NO corresponda Obligatorio `<rise>`{=html}Contribuyente Régimen
Simplificado RISE`</rise>`{=html} cuando Alfanumérico Max 40 corresponda
Obligatorio, `<codDocModificado>`{=html}01`</codDocModificado>`{=html}
conforme Numérico 2 tabla 3
`<numDocModificado>`{=html}002-001-000000001`</numDocModificado>`{=html}
Obligatorio Numérico 15

`<fechaEmisionDocSustento>`{=html}21/10/2011`</fechaEmisionDocSustento>`{=html}
Obligatorio Fecha dd/mm/aaaa

`<totalSinImpuestos>`{=html}295000.00`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14

`<valorModificacion>`{=html}346920.00`</valorModificacion>`{=html}
Obligatorio Numérico Max 14 Obligatorio
`<moneda>`{=html}DOLAR`</moneda>`{=html} cuando Alfanumérico Max 15
corresponda `<totalConImpuestos>`{=html} Obligatorio - -

`<totalImpuesto>`{=html} Obligatorio - -

                                                                                  Obligatorio,

`<codigo>`{=html}3`</codigo >`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}3072\</ codigoPorcentaje\>
conforme Numérico Min 1 Max 4 tabla 18
`<baseImponible>`{=html}295000.00\</ baseImponible \> Obligatorio
Numérico Max 14 `<valor>`{=html}14750.00`</valor >`{=html} Obligatorio
Numérico Max 14

`</totalImpuesto >`{=html} Obligatorio - -

`<totalImpuesto>`{=html} Obligatorio - -

                                                                                  Obligatorio,

`<codigo>`{=html}2`</codigo >`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}2\</ codigoPorcentaje\> conforme
Numérico Min 1 Max 4 tabla 17 `<baseImponible>`{=html}339250.25\</
baseImponible \> Obligatorio Numérico Max 14

`<valor>`{=html}37170.00`</valor >`{=html} Obligatorio Numérico Max 14

`</totalImpuesto >`{=html} Obligatorio - -

                                                                                                                         56

------------------------------------------------------------------------

                                                                              TIPO DE       LONGITUD /
                                 ETIQUETAS O TAGS             CARACTER
                                                                              CAMPO          FORMATO

`</totalConImpuestos >`{=html} Obligatorio - -

`<motivo>`{=html}DEVOLUCIÓN`</motivo>`{=html} Obligatorio Alfanumérico
Max 300

`</infoNotaCredito>`{=html} Obligatorio - -

`<detalles>`{=html} Obligatorio - -

`<detalle>`{=html} Obligatorio - -

`<codigoInterno>`{=html}125BJC-01`</codigoInterno >`{=html} Opcional
Alfanumérico Max 25 Obligatorio
`<codigoAdicional>`{=html}1234D56789-A`</codigoAdicional>`{=html} cuando
Alfanumérico Max 25 corresponda `<descripcion>`{=html}CAMIONETA 4X4
DIESEL 3.7`</descripcion>`{=html} Obligatorio Alfanumérico Max 300

`<cantidad>`{=html}10.00`</cantidad>`{=html} Obligatorio Numérico Max 14

`<precioUnitario>`{=html}30000.00`</precioUnitario>`{=html} Obligatorio
Numérico Max 14 Obligatorio
`<descuento>`{=html}5000.00`</descuento>`{=html} cuando Numérico Max 14
corresponda `<precioTotalSinImpuesto>`{=html}295000.00\</
precioTotalSinImpuesto\> Obligatorio Numérico Max 14 Obligatorio
`<detallesAdicionales>`{=html} cuando corresponda Obligatorio
`<detAdicional nombre="Marca" valor="Chevrolet"/>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio
`<detAdicional nombre="Modelo" valor="2012"/>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio
`<detAdicional nombre="Chasis" valor="8LDETA03V20003289"/>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`</detallesAdicionales>`{=html} cuando corresponda `<impuestos>`{=html}
Obligatorio - - `<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}3`</codigo>`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}3072`</codigoPorcentaje>`{=html}
conforme Numérico Min 1 Max 4 tabla 18 Obligatorio `<tarifa>`{=html}5\</
tarifa\> cuando Numérico Min 1 Max 3 corresponda
`<baseImponible>`{=html}295000.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14

`<valor>`{=html}14750.00`</valor>`{=html} Obligatorio Numérico Max 14

`</impuesto>`{=html} Obligatorio - -

`<impuesto>`{=html} Obligatorio - -

                                                              Obligatorio,

`<codigo>`{=html}2`</codigo>`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
conforme Numérico Min 1 Max 4 tabla 17 Obligatorio Min 1 Max 4
`<tarifa>`{=html}12\</ tarifa\> cuando Numérico / 2 enteros, 2
corresponda decimales
`<baseImponible>`{=html}309750.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14

`<valor>`{=html}37170.00`</valor>`{=html} Obligatorio Numérico Max 14

`</impuesto>`{=html} Obligatorio - -

`</impuestos>`{=html} Obligatorio - -

                                                                                                      57

------------------------------------------------------------------------

                                                                                               TIPO DE       LONGITUD /
                                 ETIQUETAS O TAGS                              CARACTER
                                                                                               CAMPO          FORMATO

`<detalle>`{=html} Obligatorio - -

`<detalles>`{=html} Obligatorio - - Obligatorio `<infoAdicional>`{=html}
cuando - - corresponda Obligatorio
`<campoAdicional nombre="E-MAIL">`{=html}info@organizacion.com`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`</infoAdicional>`{=html} cuando - - corresponda `</notaCredito>`{=html}
Obligatorio - -

FORMATO XML NOTA DE DÉBITO Nota: la tarifa de IVA corresponderá a la
fecha de emisión del documento de sustento.

                                                                                               TIPO DE       LONGITUD /
                                 ETIQUETAS O TAGS                              CARACTER
                                                                                               CAMPO          FORMATO

```{=html}
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
```
Obligatorio - -

`<notaDebito version="1.0.0" id="comprobante">`{=html} Obligatorio - -
`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1`</ambiente>`{=html} conforme Numérico 1 tabla 4
Obligatorio, `<tipoEmision>`{=html}1`</tipoEmision>`{=html} conforme
Numérico 1 tabla 2 `<razonSocial>`{=html}PRUEBA`</razonSocial>`{=html}
Obligatorio Alfanumérico Max 300 Obligatorio
`<nombreComercial>`{=html}PRUEBA 2`</nombreComercial>`{=html} cuando
Alfanumérico Max 300 corresponda
`<ruc>`{=html}1760013210001`</ruc>`{=html} Obligatorio Numérico 13
Obligatorio,
`<claveAcceso>`{=html}2103201605176001321000110010010000000011234567814`</claveAcceso>`{=html}
conforme Numérico 49 tabla 1 Obligatorio,
`<codDoc>`{=html}05`</codDoc>`{=html} conforme Numérico 2 tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}001`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000001`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}SALINAS`</dirMatriz>`{=html} Obligatorio
Alfanumérico Max 300 `</infoTributaria>`{=html} Obligatorio - -
`<infoNotaDebito>`{=html} Obligatorio - -
`<fechaEmision>`{=html}21/03/2016`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio
`<dirEstablecimiento>`{=html}PÁEZ`</dirEstablecimiento>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio,
`<tipoIdentificacionComprador>`{=html}04`</tipoIdentificacionComprador>`{=html}
conforme Alfanumérico Max 20 tabla 6
`<razonSocialComprador>`{=html}PRUEBA
SRI`</razonSocialComprador>`{=html} Obligatorio Alfanumérico Max 300

`<identificacionComprador>`{=html}1713328506001`</identificacionComprador>`{=html}
Obligatorio Alfanumérico Max 20 Obligatorio
`<contribuyenteEspecial>`{=html}12345`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda Obligatorio
`<obligadoContabilidad>`{=html}SI`</obligadoContabilidad>`{=html} cuando
Texto SI / NO corresponda

                                                                                                                      58

------------------------------------------------------------------------

                                                                                             TIPO DE       LONGITUD /
                                  ETIQUETAS O TAGS                           CARACTER
                                                                                             CAMPO          FORMATO
                                                                             Obligatorio,

`<codDocModificado>`{=html}01`</codDocModificado>`{=html} conforme
Numérico 2 tabla 3
`<numDocModificado>`{=html}001-001-112312315`</numDocModificado>`{=html}
Obligatorio Numérico 15

`<fechaEmisionDocSustento>`{=html}21/03/2016`</fechaEmisionDocSustento>`{=html}
Obligatorio Fecha dd/mm/aaaa

`<totalSinImpuestos>`{=html}50.0`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14

`<impuestos>`{=html} Obligatorio - -

`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
conforme Numérico Min 1 Max 4 tabla 17 Min 1 Max 4
`<tarifa>`{=html}12.00`</tarifa>`{=html} Obligatorio Numérico / 2
enteros, 2 decimales
`<baseImponible>`{=html}50.0`</baseImponible>`{=html} Obligatorio
Numérico Max 14

`<valor>`{=html}6.00`</valor>`{=html} Obligatorio Numérico Max 14

`</impuesto>`{=html} Obligatorio - -

`</impuestos>`{=html} Obligatorio - -

`<valorTotal>`{=html}56.00`</valorTotal>`{=html} Obligatorio Numérico
Max 14

`<pagos>`{=html} Obligatorio - - `<pago>`{=html} Obligatorio - -
Obligatorio, `<formaPago>`{=html}17`</formaPago>`{=html} conforme
Numérico 2 tabla 24 `<total>`{=html}56,00`</total>`{=html} Obligatorio
Numérico Max 14 Obligatorio, `<plazo>`{=html}15`<plazo>`{=html} cuando
Numérico Max 14 corresponda Obligatorio,
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} cuando Texto Max 10
corresponda `</pago>`{=html} Obligatorio - -

`</pagos>`{=html} Obligatorio - -

`</infoNotaDebito>`{=html} Obligatorio - -

`<motivos>`{=html} Obligatorio - -

`<motivo>`{=html} Obligatorio - -

`<razon>`{=html}Interés por mora`</razon>`{=html} Obligatorio
Alfanumérico Max 300

`<valor>`{=html}50.00`</valor>`{=html} Obligatorio Alfanumérico Max 300

`</motivo>`{=html} Obligatorio - -

`</motivos>`{=html} Obligatorio - -

`<infoAdicional>`{=html} Obligatorio - - Obligatorio
`<campoAdicional nombre="Dirección">`{=html}AMAZONAS S/N
ROCA`</campoAdicional>`{=html} cuando Alfanumérico Max 300 corresponda
Obligatorio
`<campoAdicional nombre="Email">`{=html}prueba@sri.gob.ec`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`<campoAdicional nombre="Teléfono">`{=html}0222222222222 ext.
3322`</campoAdicional>`{=html} cuando Alfanumérico Max 300 corresponda
`</infoAdicional>`{=html} Obligatorio - -

`</notaDebito>`{=html} Obligatorio - -

                                                                                                                     59

------------------------------------------------------------------------

ANEXO 2 - FORMATO DE REPRESENTACIONES IMPRESAS DE DOCUMENTOS
ELECTRÓNICOS (RIDE) FACTURA

Nota: • Para los contribuyentes comercializadores de derivados de
petróleo, y, Editores, Distribuidores y Voceadores que participan en la
comercialización de periódicos y/o revistas, deberán ajustar el formato
RIDE de acuerdo con la información contenida en el comprobante
electrónico con respecto a las retenciones. Se podrán imprimir datos
adicionales en el RIDE conforme lo requiera el contribuyente. • Los RIDE
que se descarguen del portal web del SRI contendrán hora y fecha de
autorización, dicha información no es obligatoria registrarla en el RIDE
generado por los emisores de comprobantes electrónicos. • El número de
la clave de acceso corresponde al número de autorización. • Conforme
consta en el numeral 9.20, el código de barras es opcional. • El campo
"Subtotal tarifa especial" corresponde a la tarifa de IVA por
actividades de turismo. • Los contribuyentes podrán visualizar solo los
subtotales que fueron llenados.

                                                                                                                       60

------------------------------------------------------------------------

NOTA DE CRÉDITO

                  61

------------------------------------------------------------------------

NOTA DE DÉBITO

                 62

------------------------------------------------------------------------

COMPROBANTE DE RETENCIÓN

                           63

------------------------------------------------------------------------

GUÍA DE REMISIÓN

                   64

------------------------------------------------------------------------

LIQUIDACIÓN DE COMPRA DE BIENES Y PRESTACIÓN DE SERVICIOS

                                             65

------------------------------------------------------------------------

ANEXO 3 - FORMATOS XML VERSIÓN 1.1.0 Incluyen el aumento de 2 a 6
decimales en los campos de cantidad y precio unitario para quienes lo
requieran. En el caso del formato de factura adicionalmente contiene
información de retenciones de IVA presuntivo e Impuesto a la Renta que
aplica para comercializadores de derivados de petróleo y retención
presuntiva de IVA a los editores, distribuidores y voceadores que
participan en la comercialización de periódicos y/o revistas.

FORMATO XML FACTURA TIPO DE LONGITUD / ETIQUETAS O TAGS CARACTER CAMPO
FORMATO `<?xml version="1.0" encoding="UTF-8" ?>`{=html} Obligatorio - -
`<factura id="comprobante" version="1.1.0">`{=html} Obligatorio - -
`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1 `</ambiente>`{=html} conforme Numérico 1 tabla 4
Obligatorio, `<tipoEmision>`{=html}1 \</ tipoEmision\> conforme Numérico
1 tabla 2 `<razonSocial>`{=html}EMPRESA PUBLICA DE HIDROCARBUROS DEL
ECUADOR EP Obligatorio Alfanumérico Max 300
PETROECUADOR`</razonSocial>`{=html} Obligatorio
`<nombreComercial>`{=html}EMPRESA PUBLICA DE HIDROCARBUROS DEL ECUADOR
EP cuando Alfanumérico Max 300 PETROECUADOR\</ nombreComercial \>
corresponda `<ruc>`{=html}1768153530001`</ruc>`{=html} Obligatorio
Numérico 13 Obligatorio,
`<claveAcceso>`{=html}0403201301176815353000110015010000000081234567816`</claveAcceso>`{=html}
conforme Numérico 49 tabla 1 Obligatorio,
`<codDoc>`{=html}01`</codDoc>`{=html} conforme Numérico 2 tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}501`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000008`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}Alpallana`</dirMatriz>`{=html}
Obligatorio Alfanumérico Max 300 `</infoTributaria>`{=html}
Obligatorio - - `<infoFactura>`{=html} Obligatorio - -
`<fechaEmision>`{=html}04/03/2013`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio `<dirEstablecimiento>`{=html}Alpallana\</
dirEstablecimiento \> cuando Alfanumérico Max 300 corresponda
Obligatorio
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda Obligatorio
`<obligadoContabilidad>`{=html}SI\</ obligadoContabilidad \> cuando
Texto SI / NO corresponda Obligatorio,
`<tipoIdentificacionComprador>`{=html}04\</ tipoIdentificacionComprador
\> conforme Numérico 2 tabla 6 Obligatorio
`<guiaRemision>`{=html}001-001-000000001`</guiaRemision>`{=html} cuando
Numérico 15 corresponda `<razonSocialComprador>`{=html}PRUEBAS SERVICIO
DERENTAS Obligatorio Alfanumérico Max 300
INTERNAS`</razonSocialComprador>`{=html}
`<identificacionComprador>`{=html}1760013210001\</
identificacionComprador \> Obligatorio Alfanumérico Max 20 Obligatorio,
`<direccionComprador>`{=html}salinas y
santiago`</direccionComprador>`{=html} cuando Alfanumérico Max 300
corresponda
`<totalSinImpuestos>`{=html}64.94`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14
`<totalDescuento>`{=html}5.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14

`<totalConImpuestos>`{=html} Obligatorio - -

                                                                                                                      66

------------------------------------------------------------------------

                                                                          TIPO DE       LONGITUD /
                                  ETIQUETAS O TAGS        CARACTER
                                                                          CAMPO          FORMATO

`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo >`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}2\</ codigoPorcentaje\> conforme
Numérico Min 1 Max 4 tabla 17 Opcional, aplica para
`<descuentoAdicional>`{=html}5.00`</descuentoAdicional>`{=html} Numérico
Max 14 código impuesto 2. `<baseImponible>`{=html}68.19\</ baseImponible
\> Obligatorio Numérico Max 14 `<valor>`{=html}7.58`</valor >`{=html}
Obligatorio Numérico Max 14 `</totalImpuesto >`{=html} Obligatorio - -
`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}3`</codigo >`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}3072\</ codigoPorcentaje\>
conforme Numérico Min 1 Max 4 tabla 18 `<baseImponible>`{=html}64.94\</
baseImponible \> Obligatorio Numérico Max 14
`<valor>`{=html}3.25`</valor >`{=html} Obligatorio Numérico Max 14
`</totalImpuesto >`{=html} Obligatorio - -
`</totalConImpuestos >`{=html} Obligatorio - -
`<propina>`{=html}0.00`</propina>`{=html} Obligatorio Numérico Max 14
`<importeTotal>`{=html}73.09\</ importeTotal\> Obligatorio Numérico Max
14 Obligatorio `<moneda>`{=html}DOLAR`</moneda>`{=html} cuando
Alfanumérico Max 15 corresponda `<pagos>`{=html} Obligatorio - -
`<pago>`{=html} Obligatorio - Obligatorio,
`<formaPago>`{=html}21`</formaPago>`{=html} conforme Numérico 2 tabla 24
`<total>`{=html}73,09`</total>`{=html} Obligatorio Numérico Max 14
Obligatorio, `<plazo>`{=html}60`<plazo>`{=html} cuando Numérico Max 14
corresponda Obligatorio,
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} cuando Texto Max 10
corresponda `</pago>`{=html} Obligatorio - - `</pagos>`{=html}
Obligatorio `<valorRetIva>`{=html}0.00`</valorRetIva>`{=html} Opcional
Numérico Max 14 `<valorRetRenta>`{=html}0.00`</valorRetRenta>`{=html}
Opcional Numérico Max 14 `</infoFactura>`{=html} Obligatorio - -
`<detalles>`{=html} Obligatorio - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}125BJC-01`</codigoPrincipal >`{=html}
Obligatorio Alfanumérico Max 25 Obligatorio
`<codigoAuxiliar>`{=html}1234D56789-A`</codigoAuxiliar>`{=html} cuando
Alfanumérico Max 25 corresponda `<descripcion>`{=html}DERIVADOS
PETRÓLEO`</descripcion>`{=html} Obligatorio Alfanumérico Max 300 Max 18,
`<cantidad>`{=html}2.542563`</cantidad>`{=html} Obligatorio Numérico
hasta 6 decimales Max 18,
`<precioUnitario>`{=html}25.542365`</precioUnitario>`{=html} Obligatorio
Numérico hasta 6 decimales `<descuento>`{=html}0.00`</descuento>`{=html}
Obligatorio Numérico Max 14 `<precioTotalSinImpuesto>`{=html}64.94\</
precioTotalSinImpuesto\> Obligatorio Numérico Max 14 Obligatorio
`<detallesAdicionales>`{=html} cuando - - corresponda Obligatorio
`<detAdicional nombre="ABCD" valor="EFGH"/>`{=html} cuando Alfanumérico
Max 300 corresponda Obligatorio
`<detAdicional nombre="ABCD " valor="EFGH"/>`{=html} Alfanumérico Max
300 cuando

                                                                                                 67

------------------------------------------------------------------------

                                                                   TIPO DE       LONGITUD /
                                ETIQUETAS O TAGS   CARACTER
                                                                   CAMPO          FORMATO
                                                   corresponda
                                                    Obligatorio

`<detAdicional nombre="ABCD" valor="EFGH"/>`{=html} cuando Alfanumérico
Max 300 corresponda Obligatorio `</detallesAdicionales>`{=html}
cuando - - corresponda `<impuestos>`{=html} Obligatorio - -
`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
conforme Numérico Min 1 Max 4 tabla 17 Min 1 Max 4
`<tarifa>`{=html}12\</ tarifa\> Obligatorio Numérico / 2 enteros, 2
decimales `<baseImponible>`{=html}68.19`</baseImponible>`{=html}
Obligatorio Numérico Max 14 `<valor>`{=html}8.18`</valor>`{=html}
Obligatorio Numérico Max 14 `</impuesto>`{=html} Obligatorio - -
`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}3`</codigo>`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}3072`</codigoPorcentaje>`{=html}
conforme Numérico Min 1 Max 4 tabla 18 `<tarifa>`{=html}5\</ tarifa\>
Obligatorio Numérico Min 1 Max 4

`<baseImponible>`{=html}64.94`</baseImponible>`{=html} Obligatorio
Numérico Max 14

`<valor>`{=html}3.25`</valor>`{=html} Obligatorio Numérico Max 14
`</impuesto>`{=html} Obligatorio - - `</impuestos>`{=html}
Obligatorio - - `</detalle>`{=html} Obligatorio - - `</detalles>`{=html}
Obligatorio - - Obligatorio `<retenciones>`{=html} cuando - -
corresponda Obligatorio `<retencion>`{=html} cuando - - corresponda
Obligatorio cuando `<codigo>`{=html}4`</codigo>`{=html} corresponda,
Numérico 1 conforme tabla 22 Obligatorio cuando
`<codigoPorcentaje>`{=html}327`</codigoPorcentaje>`{=html} corresponda,
Numérico Min 1 Max 3 conforme tabla 23 Min 1 Max 5 / Obligatorio 3
enteros, `<tarifa>`{=html}0.20`</tarifa>`{=html} cuando Numérico dos
corresponda decimales Obligatorio Max 14 /12
`<valor>`{=html}0.13`</valor>`{=html} cuando Numérico enteros, 2
corresponda decimales Obligatorio `</retencion>`{=html} cuando - -
corresponda Obligatorio `<retencion>`{=html} cuando - - corresponda
Obligatorio cuando `<codigo>`{=html}4`</codigo>`{=html} corresponda,
Numérico 1 conforme tabla 22 Obligatorio cuando
`<codigoPorcentaje>`{=html}328`</codigoPorcentaje>`{=html} corresponda,
Numérico Min 1 Max 3 conforme tabla 23

                                                                                           68

------------------------------------------------------------------------

                                                                                     TIPO DE       LONGITUD /
                                ETIQUETAS O TAGS                     CARACTER
                                                                                     CAMPO          FORMATO
                                                                                                   Min 1 Max 5 /
                                                                      Obligatorio
                                                                                                     3 enteros,

`<tarifa>`{=html}0.30`</tarifa>`{=html} cuando Numérico dos corresponda
decimales Obligatorio Max 14 /12 `<valor>`{=html}0.19`</valor>`{=html}
cuando Numérico enteros, 2 corresponda decimales Obligatorio
`</retencion>`{=html} cuando - - corresponda Obligatorio
`<retencion>`{=html} cuando - - corresponda Obligatorio cuando
`<codigo>`{=html}4`</codigo>`{=html} corresponda, Numérico 1 conforme
tabla 22 Obligatorio cuando
`<codigoPorcentaje>`{=html}3`</codigoPorcentaje>`{=html} corresponda,
Numérico Min 1 Max 3 conforme tabla 23 Min 1 Max 5 / Obligatorio 3
enteros, `<tarifa>`{=html}1`</tarifa>`{=html} cuando Numérico dos
corresponda decimales Obligatorio Max 14 /12
`<valor>`{=html}2.00`</valor>`{=html} cuando Numérico enteros, 2
corresponda decimales Obligatorio `</retencion>`{=html} cuando - -
corresponda Obligatorio `</retenciones>`{=html} cuando - - corresponda
Obligatorio `<infoAdicional>`{=html} cuando - - corresponda Obligatorio
`<campoAdicional nombre="Codigo Impuesto ISD">`{=html}4580`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`<campoAdicional nombre="Impuesto ISD">`{=html}15.42x`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`</infoAdicional>`{=html} cuando - - corresponda `</factura>`{=html}
Obligatorio - -

                                                                                                             69

------------------------------------------------------------------------

FORMATO XML GUÍA DE REMISIÓN TIPO DE LONGITUD / ETIQUETAS O TAGS
CARACTER CAMPO FORMATO `<?xml version="1.0" encoding="UTF-8" ?>`{=html}
Obligatorio - -

`<guiaRemision id="comprobante" version="1.1.0">`{=html} Obligatorio - -
`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1`</ambiente>`{=html} conforme Numérico 1 tabla 4
Obligatorio, `<tipoEmision>`{=html}1\</ tipoEmision\> conforme Numérico
1 tabla 2 `<razonSocial>`{=html} EMPRESA PUBLICA DE HIDROCARBUROS DEL
ECUADOR EP Obligatorio Alfanumérico Max 300 PETROECUADOR
`</razonSocial>`{=html} Obligatorio `<nombreComercial>`{=html} EMPRESA
PUBLICA DE HIDROCARBUROS DEL ECUADOR EP cuando Alfanumérico Max 300
PETROECUADOR \</ nombreComercial \> corresponda
`<ruc>`{=html}1760013210001`</ruc>`{=html} Obligatorio Numérico 13
Obligatorio,
`<claveAcceso>`{=html}0603201306176001321000110015010000000081234567812`</claveAcceso>`{=html}
conforme Numérico 49 tabla 1 Obligatorio,
`<codDoc>`{=html}06`</codDoc>`{=html} conforme Numérico 2 tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}501`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000008`</secuencial>`{=html} Obligatorio
Numérico 9

`<dirMatriz>`{=html}ALPALLANA`</dirMatriz>`{=html} Obligatorio
Alfanumérico Max 300

`</infoTributaria>`{=html} Obligatorio - - `<infoGuiaRemision>`{=html}
Obligatorio - - Obligatorio `<dirEstablecimiento>`{=html}ALPALLANA\</
dirEstablecimiento \> cuando Alfanumérico Max 300 corresponda
`<dirPartida>`{=html}Av. Eloy Alfaro 34 y Av. Libertad
Esq.`</dirPartida>`{=html} Obligatorio Alfanumérico Max 300

`<razonSocialTransportista>`{=html}Transportes
S.A.`</razonSocialTransportista>`{=html} Obligatorio Alfanumérico Max
300 Obligatorio,
`<tipoIdentificacionTransportista>`{=html}04`</tipoIdentificacionTransportista>`{=html}
conforme Numérico 2 tabla 6
`<rucTransportista>`{=html}1796875790001`</rucTransportista>`{=html}
Obligatorio Alfanumérico Max 13 Obligatorio `<rise>`{=html}Contribuyente
Regimen Simplificado RISE`</rise>`{=html} cuando Alfanumérico Max 40
corresponda Obligatorio `<obligadoContabilidad>`{=html}SI\</
obligadoContabilidad \> cuando Texto SI / NO corresponda Obligatorio
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda
`<fechaIniTransporte>`{=html}06/03/2013`</fechaIniTransporte>`{=html}
Obligatorio Fecha dd/mm/aaaa

`<fechaFinTransporte>`{=html}06/03/2013`</fechaFinTransporte>`{=html}
Obligatorio Fecha dd/mm/aaaa

`<placa>`{=html}MCL0827`</placa>`{=html} Obligatorio Alfanumérico Max 20

`</infoGuiaRemision>`{=html} Obligatorio - -

`<destinatarios>`{=html} Obligatorio - -

`<destinatario>`{=html} Obligatorio - -

`<identificacionDestinatario>`{=html}1716849140001`</identificacionDestinatario>`{=html}
Obligatorio Alfanumérico Max 20

`<razonSocialDestinatario>`{=html}Alvarez Mina John
Henry`</razonSocialDestinatario>`{=html} Obligatorio Alfanumérico Max
300

`<dirDestinatario>`{=html}Av. Simón Bolívar S/N
Intercambiador`</dirDestinatario>`{=html} Obligatorio Alfanumérico Max
300

`<motivoTraslado>`{=html}Venta de Maquinaria de
Impresión`</motivoTraslado>`{=html} Obligatorio Alfanumérico Max 300
Obligatorio
`<docAduaneroUnico>`{=html}0041324846887`</docAduaneroUnico>`{=html}
cuando Alfanumérico Max 20 corresponda Obligatorio
`<codEstabDestino>`{=html}001`</codEstabDestino>`{=html} cuando Numérico
3 corresponda

                                                                                                                      70

------------------------------------------------------------------------

                                                                                                TIPO DE       LONGITUD /
                                 ETIQUETAS O TAGS                              CARACTER
                                                                                                CAMPO          FORMATO
                                                                                Obligatorio

`<ruta>`{=html}Quito -- Cayambe - Otavalo`</ruta>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio cuando
`<codDocSustento>`{=html}01`</codDocSustento>`{=html} corresponda,
Numérico Min 2 Max 3 conforme tabla 3 Obligatorio
`<numDocSustento>`{=html}002-001-000000001`</numDocSustento>`{=html}
cuando Numérico 15 corresponda Obligatorio
`<numAutDocSustento>`{=html}211020111630251792146739011234567891`</numAutDocSustento>`{=html}
cuando Numérico 10 o 37 o 49 corresponda Obligatorio
`<fechaEmisionDocSustento>`{=html}21/10/2011`</fechaEmisionDocSustento>`{=html}
cuando Fecha dd/mm/aaaa corresponda `<detalles>`{=html} Obligatorio - -
`<detalle>`{=html} Obligatorio - -

`<codigoInterno>`{=html}125BJC-01\</ codigoInterno \> Opcional1
Alfanumérico Max 25 Obligatorio
`<codigoAdicional>`{=html}1234D56789-A`</codigoAdicional>`{=html} cuando
Alfanumérico Max 25 corresponda
`<descripcion>`{=html}DIESEL`</descripcion>`{=html} Obligatorio
Alfanumérico Max 300 Max 18,
`<cantidad>`{=html}10.254632`</cantidad>`{=html} Obligatorio Numérico
hasta 6 decimales Obligatorio `<detallesAdicionales>`{=html} cuando - -
corresponda Obligatorio
`<detAdicional nombre="ABCD" valor="EFGH"/>`{=html} cuando Alfanumérico
Max 300 corresponda Obligatorio
`<detAdicional nombre="ABCD" valor="EFGH"/>`{=html} cuando Alfanumérico
Max 300 corresponda Obligatorio
`<detAdicional nombre="ABCD" valor="EFHG"/>`{=html} cuando Alfanumérico
Max 300 corresponda Obligatorio `</detallesAdicionales>`{=html}
cuando - - corresponda `</detalle>`{=html} Obligatorio - -
`</detalles>`{=html} Obligatorio - - `</destinatario>`{=html}
Obligatorio - - `</destinatarios>`{=html} Obligatorio - - Obligatorio
`<infoAdicional>`{=html} cuando - - corresponda Obligatorio
`<campoAdicional nombre="TELEFONO">`{=html}098568541`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`<campoAdicional nombre="E-MAIL">`{=html}info@organizacion.com`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`<campoAdicional nombre="SUCURSAL 03">`{=html}Guayaquil--12 de octubre y
cuando Alfanumérico Max 300 Universo`</campoAdicional>`{=html}
corresponda Obligatorio `</infoAdicional>`{=html} cuando - - corresponda
`</guiaRemision>`{=html} Obligatorio - -

                                                                                                                       71

------------------------------------------------------------------------

FORMATO XML NOTA DE CRÉDITO TIPO DE LONGITUD / ETIQUETAS O TAGS CARACTER
CAMPO FORMATO `<?xml version="1.0" encoding="UTF-8" ?>`{=html}
Obligatorio - -

`<notaCredito id="comprobante" version="1.1.0">`{=html} Obligatorio - -

`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1`</ambiente>`{=html} conforme Numérico 1 tabla 4
Obligatorio, `<tipoEmision>`{=html}1\</ tipoEmision\> conforme Numérico
1 tabla 2 `<razonSocial>`{=html} EMPRESA PUBLICA DE HIDROCARBUROS DEL
ECUADOR EP Obligatorio Alfanumérico Max 300 PETROECUADOR
`</razonSocial>`{=html} Obligatorio `<nombreComercial>`{=html}EMPRESA
PUBLICA DE HIDROCARBUROS DEL ECUADOR EP cuando Alfanumérico Max 300
PETROECUADOR\</ nombreComercial \> corresponda
`<ruc>`{=html}1760013210001`</ruc>`{=html} Obligatorio Numérico 13
Obligatorio,
`<claveAcceso>`{=html}0603201304176001321000110015010000000461234567817`</claveAcceso>`{=html}
conforme Numérico 49 tabla 1 Obligatorio,
`<codDoc>`{=html}04`</codDoc>`{=html} conforme Numérico 2 tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3

`<ptoEmi>`{=html}501`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000046`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}ALPALLANA`</dirMatriz>`{=html}
Obligatorio Alfanumérico Max 300 `</infoTributaria>`{=html}
Obligatorio - - `<infoNotaCredito>`{=html} Obligatorio - -

`<fechaEmision>`{=html}06/03/2013`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio `<dirEstablecimiento>`{=html}ALPALLANA\</
dirEstablecimiento\> cuando Alfanumérico Max 300 corresponda
Obligatorio, `<tipoIdentificacionComprador>`{=html}04\</
tipoIdentificacionComprador \> conforme Numérico 2 tabla 6
`<razonSocialComprador>`{=html}PRUEBAS SERVICIO DE RENTAS Obligatorio
Alfanumérico Max 300 INTERNAS`</razonSocialComprador>`{=html}
`<identificacionComprador>`{=html}1792107865001`</identificacionComprador>`{=html}
Obligatorio Alfanumérico Max 20 Obligatorio
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda Obligatorio
`<obligadoContabilidad>`{=html}SI\</ obligadoContabilidad\> cuando Texto
SI / NO corresponda Obligatorio `<rise>`{=html}Contribuyente Régimen
Simplificado RISE`</rise>`{=html} cuando Alfanumérico Max 40 corresponda
Obligatorio, `<codDocModificado>`{=html}01`</codDocModificado>`{=html}
conforme Numérico 2 tabla 3
`<numDocModificado>`{=html}002-001-000000001`</numDocModificado>`{=html}
Opcional Numérico 15

`<fechaEmisionDocSustento>`{=html}03/03/2013`</fechaEmisionDocSustento>`{=html}
Obligatorio Fecha dd/mm/aaaa
`<totalSinImpuestos>`{=html}38327.96`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14

`<valorModificacion>`{=html}45073.68`</valorModificacion>`{=html}
Obligatorio Numérico Max 14 Obligatorio
`<moneda>`{=html}DOLAR`</moneda>`{=html} cuando Alfanumérico Max 15
corresponda `<totalConImpuestos>`{=html} Obligatorio - -
`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}3`</codigo >`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}3072\</ codigoPorcentaje\>
conforme Numérico Min 1 Max 4 tabla 18
`<baseImponible>`{=html}38327.96\</ baseImponible \> Obligatorio
Numérico Max 14

                                                                                                                      72

------------------------------------------------------------------------

                                                                             TIPO DE       LONGITUD /
                                 ETIQUETAS O TAGS            CARACTER
                                                                             CAMPO          FORMATO

`<valor>`{=html}1916.40`</valor >`{=html} Obligatorio Numérico Max 14
`</totalImpuesto >`{=html} Obligatorio - - `<totalImpuesto>`{=html}
Obligatorio - - Obligatorio, `<codigo>`{=html}2`</codigo >`{=html}
conforme Numérico 1 tabla 16 Obligatorio,
`<codigoPorcentaje>`{=html}2\</ codigoPorcentaje\> conforme Numérico Min
1 Max 4 tabla 17 `<baseImponible>`{=html}40244.36\</ baseImponible \>
Obligatorio Numérico Max 14 `<valor>`{=html}4829.32`</valor >`{=html}
Obligatorio Numérico Max 14 `</totalImpuesto >`{=html} Obligatorio - -

`</totalConImpuestos >`{=html} Obligatorio - -
`<motivo>`{=html}DEVOLUCIÓN`</motivo>`{=html} Obligatorio Alfanumérico
Max 300 `</infoNotaCredito>`{=html} Obligatorio - -

`<detalles>`{=html} Obligatorio - -

`<detalle>`{=html} Obligatorio - -
`<codigoInterno>`{=html}125BJC-01`</codigoInterno >`{=html} Opcional
Alfanumérico Max 25 Obligatorio
`<codigoAdicional>`{=html}1234D56789-A`</codigoAdicional>`{=html} cuando
Alfanumérico Max 25 corresponda `<descripcion>`{=html}
ABCD`</descripcion>`{=html} Obligatorio Alfanumérico Max 300 Max 18,
hasta `<cantidad>`{=html}1500.564125`</cantidad>`{=html} Obligatorio
Numérico 6 decimales Max 18, hasta
`<precioUnitario>`{=html}25.542365`</precioUnitario>`{=html} Obligatorio
Numérico 6 decimales Obligatorio
`<descuento>`{=html}0.00`</descuento>`{=html} cuando Numérico Max 14
corresponda

`<precioTotalSinImpuesto>`{=html}38327.96\</ precioTotalSinImpuesto\>
Obligatorio Numérico Max 14

                                                              Obligatorio

`<detallesAdicionales>`{=html} cuando corresponda Obligatorio
`<detAdicional nombre="Marca" valor="Chevrolet"/>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio
`<detAdicional nombre="Modelo" valor="2012"/>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio
`<detAdicional nombre="Chasis" valor="8LDETA03V20003289"/>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`</detallesAdicionales>`{=html} cuando corresponda `<impuestos>`{=html}
Obligatorio - - `<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}3`</codigo>`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}3072`</codigoPorcentaje>`{=html}
conforme Numérico Min 1 Max 4 tabla 18 Obligatorio `<tarifa>`{=html}5\</
tarifa\> cuando Numérico Min 1 Max 3 corresponda
`<baseImponible>`{=html}38327.96`</baseImponible>`{=html} Obligatorio
Numérico Max 14

`<valor>`{=html}1916.40`</valor>`{=html} Obligatorio Numérico Max 14

`</impuesto>`{=html} Obligatorio - -

`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} conforme Numérico 1 tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
conforme Numérico Min 1 Max 4 tabla 17 Obligatorio
`<tarifa>`{=html}12\</ tarifa\> Numérico Min 1 Max 4 cuando

                                                                                                     73

------------------------------------------------------------------------

                                                                                                 TIPO DE      LONGITUD /
                                    ETIQUETAS O TAGS                            CARACTER
                                                                                                 CAMPO         FORMATO
                                                                                corresponda                   / 2 enteros, 2
                                                                                                                decimales

`<baseImponible>`{=html}40244.36`</baseImponible>`{=html} Obligatorio
Numérico Max 14

`<valor>`{=html}4829.32`</valor>`{=html} Obligatorio Numérico Max 14

`</impuesto>`{=html} Obligatorio - -

`</impuestos>`{=html} Obligatorio - -

`<detalle>`{=html} Obligatorio - -

`<detalles>`{=html} Obligatorio - - Obligatorio `<infoAdicional>`{=html}
cuando - - corresponda Obligatorio
`<campoAdicional nombre="E-MAIL">`{=html}info@organizacion.com`</campoAdicional>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio
`</infoAdicional>`{=html} cuando - - corresponda `</notaCredito>`{=html}
Obligatorio - -

ANEXO 4 - FORMATOS XML FACTURA EXPORTACIÓN APLICADOS A LAS VERSIONES
1.0.0 y 1.1.0 Incluyen los campos requeridos para exportación,
adicionalmente en el diseño del RIDE se podrá incluir e imprimir datos
adicionales conforme lo requiera el contribuyente. Los campos nuevos
contenidos en los siguientes formatos deberán ser utilizados únicamente
en exportaciones, caso contrario se deberá utilizar los formatos de
factura establecidos en el Anexo 1 y Anexo 3 según corresponda.

FACTURA VERSIÓN 1.0.0 TIPO DE LONGITUD / ETIQUETAS O TAGS CARACTER CAMPO
FORMATO `<?xml version="1.0" encoding="UTF-8" ?>`{=html} Obligatorio - -
`<factura id="comprobante" version="1.0.0">`{=html} Obligatorio - -

`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1 `</ambiente>`{=html} Numérico 1 conforme tabla 4
Obligatorio, `<tipoEmision>`{=html}1 \</ tipoEmision\> Numérico 1
conforme tabla 2 `<razonSocial>`{=html}CONTRIBUYENTE
PRUEBA`</razonSocial>`{=html} Obligatorio Alfanumérico Max 300
Obligatorio, `<nombreComercial>`{=html}PRUEBA
UNO`</nombreComercial>`{=html} cuando Alfanumérico Max 300 corresponda
`<ruc>`{=html}1792261104001`</ruc>`{=html} Obligatorio Numérico 13
`<claveAcceso>`{=html}0403201301179226110400110015010000000081234567816`</claveAcc     Obligatorio,
                                                                                                Numérico           49
eso>`{=html} conforme tabla 1 Obligatorio,
`<codDoc>`{=html}01`</codDoc>`{=html} Numérico 2 conforme tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}501`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000008`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}Alpallana`</dirMatriz>`{=html}
Obligatorio Alfanumérico Max 300 `</infoTributaria>`{=html}
Obligatorio - -

                                                                                                                        74

------------------------------------------------------------------------

                                                                                         TIPO DE       LONGITUD /
                               ETIQUETAS O TAGS                      CARACTER
                                                                                         CAMPO          FORMATO

`<infoFactura>`{=html} Obligatorio - -

`<fechaEmision>`{=html}04/03/2013`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio,
`<dirEstablecimiento>`{=html}Alpallana`</dirEstablecimiento>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio,
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda Obligatorio,
`<obligadoContabilidad>`{=html}SI\</ obligadoContabilidad \> cuando
Texto SI/NO corresponda Texto, Mayúsculas,
`<comercioExterior>`{=html}EXPORTADOR`</comercioExterior>`{=html}
Obligatorio 10 siempre es EXPORTADOR Texto,
`<IncoTermFactura>`{=html}CIF`</IncoTermFactura>`{=html} Obligatorio Max
10 Mayúsculas `<lugarIncoTerm>`{=html}GUAYAQUIL`</lugarIncoTerm>`{=html}
Obligatorio Alfanumérico Max 300 Obligatorio,
`<paisOrigen>`{=html}593`</paisOrigen>`{=html} Numérico 3 conforme tabla
25 `<puertoEmbarque>`{=html}GUAYAQUIL`</puertoEmbarque>`{=html}
Obligatorio Alfanumérico Max 300
`<puertoDestino>`{=html}CHINA`</puertoDestino>`{=html} Obligatorio
Alfanumérico Max 300 Opcional,
`<paisDestino>`{=html}593`</paisDestino>`{=html} Numérico 3 conforme
tabla 25 Opcional,
`<paisAdquisicion>`{=html}593`</paisAdquisicion>`{=html} Numérico 3
conforme tabla 25 Obligatorio,
`<tipoIdentificacionComprador>`{=html}04`</tipoIdentificacionComprador>`{=html}
Numérico 2 conforme tabla 6 Obligatorio,
`<guiaRemision>`{=html}001-001-000000001`</guiaRemision>`{=html} cuando
Numérico 15 corresponda `<razonSocialComprador>`{=html}PRUEBAS SERVICIO
DE RENTAS Obligatorio Alfanumérico Max 300
INTERNAS`</razonSocialComprador>`{=html}
`<identificacionComprador>`{=html}1760013210001`</identificacionComprador>`{=html}
Obligatorio Numérico Max 20 Obligatorio,
`<direccionComprador>`{=html}salinas y
santiago`</direccionComprador>`{=html} cuando Alfanumérico Max 300
corresponda
`<totalSinImpuestos>`{=html}295000.00`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14 Texto,
`<incoTermTotalSinImpuestos>`{=html}FOB`</incoTermTotalSinImpuestos>`{=html}
Obligatorio Max 10 Mayúsculas
`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14 `<totalConImpuestos>`{=html} Obligatorio - -
`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} Numérico 1 conforme tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}0`</codigoPorcentaje>`{=html}
Numérico Min 1 Max 4 conforme tabla 17 Opcional, aplica
`<descuentoAdicional>`{=html}0.00`</descuentoAdicional>`{=html} para
código Numérico Max 14 impuesto 2.
`<baseImponible>`{=html}295000.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}0.00`<valor>`{=html} Obligatorio
Numérico Max 14 `</totalImpuesto>`{=html} Obligatorio - -
`</totalConImpuesto>`{=html} Obligatorio - -
`<propina>`{=html}0.00`<propina>`{=html} Obligatorio Numérico Max 14
Obligatorio,
`<fleteInternacional>`{=html}1000.00`<fleteInternacional>`{=html} cuando
Numérico Max 14 corresponda Obligatorio,
`<seguroInternacional>`{=html}200.00`<seguroInternacional>`{=html}
cuando Numérico Max 14 corresponda Obligatorio,
`<gastos Aduaneros>`{=html}800.00`<gastos Aduaneros>`{=html} cuando
Numérico Max 14 corresponda Obligatorio,
`<gastosTransporteOtros>`{=html}350.00`<gastosTransporteOtros>`{=html}
cuando Numérico Max 14 corresponda
`<importeTotal>`{=html}297350.00`<importeTotal>`{=html} Obligatorio
Numérico Max 14 Obligatorio, `<moneda>`{=html}DOLAR`<moneda>`{=html}
cuando Alfanumérico Max 15 corresponda

                                                                                                                  75

------------------------------------------------------------------------

                                                                                    TIPO DE       LONGITUD /
                               ETIQUETAS O TAGS                  CARACTER
                                                                                    CAMPO          FORMATO

`<pagos>`{=html} Obligatorio - -

`<pago>`{=html} Obligatorio - Obligatorio,
`<formaPago>`{=html}15`</formaPago>`{=html} Numérico 2 conforme tabla 24
`<total>`{=html}200000`</total>`{=html} Obligatorio Numérico Max 14
Obligatorio, `<plazo>`{=html}30`<plazo>`{=html} cuando Numérico Max 14
corresponda Obligatorio,
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} cuando Texto Max 10
corresponda `</pago>`{=html} Obligatorio - - `<pago>`{=html}
Obligatorio - - Obligatorio, `<formaPago>`{=html}18`</formaPago>`{=html}
Numérico 2 conforme tabla 24 `<total>`{=html}97350`</total>`{=html}
Obligatorio Numérico Max 14 Obligatorio,
`<plazo>`{=html}15`<plazo>`{=html} cuando Numérico Max 14 corresponda
Obligatorio, `<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} cuando
Texto Max 10 corresponda `</pago>`{=html} Obligatorio - -
`</pagos>`{=html} Obligatorio - -
`<valorRetIva>`{=html}0.00`</valorRetIva>`{=html} Opcional Numérico Max
14 `<valorRetRenta>`{=html}0.00`</valorRetRenta>`{=html} Opcional
Numérico Max 14 `</infoFactura>`{=html} Obligatorio - -
`<detalles>`{=html} Obligatorio - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}003`</codigoPrincipal>`{=html} Obligatorio
Alfanumérico Max 25 Obligatorio,
`<codigoAuxiliar>`{=html}SER003`</codigoAuxiliar>`{=html} cuando
Alfanumérico Max 25 corresponda `<descripcion>`{=html}FROZEN MOONFISH
WR`</descripcion>`{=html} Obligatorio Alfanumérico Max 300 Obligatorio,
`<unidadMedida>`{=html}Kilos`</unidadMedida>`{=html} cuando Alfanumérico
Max 50 corresponda `<cantidad>`{=html}100.00`</cantidad>`{=html}
Obligatorio Numérico Max 14
`<precioUnitario>`{=html}2950.00`</precioUnitario>`{=html} Obligatorio
Numérico Max 14

`<descuento>`{=html}0.00`</descuento>`{=html} Obligatorio Numérico Max
14

`<precioTotalSinImpuestos>`{=html}295000.00`</precioTotalSinImpuestos>`{=html}
Obligatorio Numérico Max 14 Obligatorio, `<detallesAdicionales>`{=html}
cuando - - corresponda Obligatorio,
`<detAdicional valor="KILOS"nombre="PESO NETO"/>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio,
`<detAdicional valor="KILOS"nombre="PESO BRUTO"/>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio,
`<detAdicional valor="KILOS"nombre="PARTIDA ARANCELARIA"/>`{=html}
cuando Alfanumérico Max 300 corresponda Obligatorio,
`</detallesAdicionales>`{=html} cuando - - corresponda
`<impuestos>`{=html} Obligatorio - - `<impuesto>`{=html} Obligatorio - -
Obligatorio, `<codigo>`{=html}2`</codigo>`{=html} Numérico 1 conforme
tabla 16 Obligatorio,
`<codigoPorcentaje>`{=html}0`</codigoPorcentaje>`{=html} Numérico Min 1
Max 4 conforme tabla 17 Min 1 Max 4 `<tarifa>`{=html}0\</ tarifa\>
Obligatorio Numérico / 2 enteros, 2 decimales
`<baseImponible>`{=html}295000.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}0.00`</valor>`{=html} Obligatorio
Numérico Max 14

                                                                                                            76

------------------------------------------------------------------------

                                                                                                   TIPO DE         LONGITUD /
                                 ETIQUETAS O TAGS                             CARACTER
                                                                                                   CAMPO            FORMATO

`</impuesto>`{=html} Obligatorio - - `</impuestos>`{=html}
Obligatorio - - `</detalle>`{=html} Obligatorio - -

`</detalles>`{=html} Obligatorio - - Obligatorio cuando
`<infoAdicional>`{=html} - - corresponda
`<campoAdicional nombre="DESCRIPCION DE CARGA">`{=html}CAJAS DE 10
Obligatorio cuando Alfanumérico Max 300 KILOS`</campoAdicional>`{=html}
corresponda
`<campoAdicional nombre="INFORMACION BANCARIA">`{=html}NUMERO DE CUENTA
DE Obligatorio cuando Alfanumérico Max 300 BANCO
1243546`</campoAdicional>`{=html} corresponda Obligatorio cuando
`</infoAdicional>`{=html} - corresponda `</factura>`{=html} Obligatorio
-

FACTURA VERSIÓN 1.1.0 En esta versión se podrá utilizar de 2 a 6
decimales en los campos de cantidad y precio unitario para
contribuyentes que lo requieran. TIPO DE LONGITUD / ETIQUETAS O TAGS
CARACTER CAMPO FORMATO `<?xml version="1.0" encoding="UTF-8" ?>`{=html}
Obligatorio - - -`<factura id="comprobante" version="1.1.0">`{=html}
Obligatorio - - - `<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1 `</ambiente>`{=html} Numérico 1 conforme tabla 4
Obligatorio, `<tipoEmision>`{=html}1 \</ tipoEmision\> Numérico 1
conforme tabla 2 `<razonSocial>`{=html}EMPRESA PUBLICA DE HIDROCARBUROS
DEL ECUADOR EP Obligatorio Alfanumérico Max 300
PETROECUADOR`</razonSocial>`{=html} `<nombreComercial>`{=html}EMPRESA
PUBLICA DE HIDROCARBUROS DEL ECUADOR EP Obligatorio cuando Alfanumérico
Max 300 PETROECUADOR\</ nombreComercial \> corresponda
`<ruc>`{=html}1768153530001`</ruc>`{=html} Obligatorio Numérico 13
`<claveAcceso>`{=html}0403201301176815353000110015010000000081234567816`</claveAcce      Obligatorio,
                                                                                                     Numérico              49
so>`{=html} conforme tabla 1 Obligatorio,
`<codDoc>`{=html}01`</codDoc>`{=html} Numérico 2 conforme tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}501`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000008`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}Alpallana`</dirMatriz>`{=html}
Obligatorio Alfanumérico Max 300 `</infoTributaria>`{=html}
Obligatorio - - `<infoFactura>`{=html} Obligatorio - -
`<fechaEmision>`{=html}04/03/2013`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio cuando
`<dirEstablecimiento>`{=html}Alpallana\</ dirEstablecimiento \>
Alfanumérico Max 300 corresponda Obligatorio cuando
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
Alfanumérico Min 3 Max 13 corresponda Obligatorio cuando
`<obligadoContabilidad>`{=html}SI\</ obligadoContabilidad \> Texto SI /
NO corresponda Texto, Mayúsculas,
`<comercioExterior>`{=html}EXPORTADOR`</comercioExterior>`{=html}
Obligatorio 10 siempre es EXPORTADOR Texto,
`<IncoTermFactura>`{=html}FOB`</IncoTermFactura>`{=html} Obligatorio Max
10 Mayúsculas `<lugarIncoTerm>`{=html}GUAYAQUIL`</lugarIncoTerm>`{=html}
Obligatorio Alfanumérico Max 300 Obligatorio,
`<paisOrigen>`{=html}593`</paisOrigen>`{=html} Numérico 3 conforme tabla
25 `<puertoEmbarque>`{=html}GUAYAQUIL`</puertoEmbarque>`{=html}
Obligatorio Alfanumérico Max 300
`<puertoDestino>`{=html}CHINA`</puertoDestino>`{=html} Obligatorio
Alfanumérico Max 300 Opcional, conforme
`<paisDestino>`{=html}593`</paisDestino>`{=html} Numérico 3 tabla 25
Opcional, conforme
`<paisAdquisicion>`{=html}593`</paisAdquisicion>`{=html} Numérico 3
tabla 25 Obligatorio, `<tipoIdentificacionComprador>`{=html}04\</
tipoIdentificacionComprador \> Numérico 2 conforme tabla 6 Obligatorio
cuando `<guiaRemision>`{=html}001-001-000000001`</guiaRemision>`{=html}
Numérico 15 corresponda `<razonSocialComprador>`{=html}PRUEBAS SERVICIO
DE RENTAS Obligatorio Alfanumérico Max 300
INTERNAS`</razonSocialComprador>`{=html}
`<identificacionComprador>`{=html}1760013210001\</
identificacionComprador \> Obligatorio Alfanumérico Max 20
`<direccionComprador>`{=html}salinas y
santiago`</direccionComprador>`{=html} Obligatorio Alfanumérico Max 300

                                                                                                                               77

------------------------------------------------------------------------

                                                                                            TIPO DE       LONGITUD /
                                ETIQUETAS O TAGS                        CARACTER
                                                                                            CAMPO          FORMATO

`<totalSinImpuestos>`{=html}64.94`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14 Texto,
`<incoTermTotalSinImpuestos>`{=html}FOB`</incoTermTotalSinImpuestos>`{=html}
Obligatorio Max 10 Mayúsculas
`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14 `<totalConImpuestos>`{=html} Obligatorio - -
`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo >`{=html} Numérico 1 conforme tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}0\</ codigoPorcentaje\> Numérico
Min 1 Max 4 conforme tabla 17 Opcional, aplica
`<descuentoAdicional>`{=html}0.00`</descuentoAdicional>`{=html} para
código Numérico Max 14 impuesto 2. `<baseImponible>`{=html}64.94\</
baseImponible \> Obligatorio Numérico Max 14
`<valor>`{=html}0.00`</valor >`{=html} Obligatorio Numérico Max 14
`</totalImpuesto >`{=html} Obligatorio - -
`</totalConImpuestos >`{=html} Obligatorio - -
`<propina>`{=html}0.00`</propina>`{=html} Obligatorio Numérico Max 14
Obligatorio, cuando
`<fleteInternacional>`{=html}0.00`<fleteInternacional>`{=html} Numérico
Max 14 corresponda Obligatorio, cuando
`<seguroInternacional>`{=html}0.00`<seguroInternacional>`{=html}
Numérico Max 14 corresponda Obligatorio, cuando
`<gastos Aduaneros>`{=html}0.00`<gastos Aduaneros>`{=html} Numérico Max
14 corresponda Obligatorio, cuando
`<gastosTransporteOtros>`{=html}0.00`<gastosTransporteOtros>`{=html}
Numérico Max 14 corresponda `<importeTotal>`{=html}65.07\</
importeTotal\> Obligatorio Numérico Max 14 Obligatorio cuando
`<moneda>`{=html}DOLAR`</moneda>`{=html} Alfanumérico Max 15 corresponda
`<pagos>`{=html} Obligatorio - `<pago>`{=html} Obligatorio -
Obligatorio, `<formaPago>`{=html}16`</formaPago>`{=html} Numérico 2
conforme tabla 24 `<total>`{=html}30.00`</total>`{=html} Obligatorio
Numérico Max 14 Obligatorio, cuando `<plazo>`{=html}90`<plazo>`{=html}
Numérico Max 14 corresponda Obligatorio, cuando
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} Texto Max 10
corresponda `</pago>`{=html} Obligatorio - - `<pago>`{=html}
Obligatorio - - Obligatorio, `<formaPago>`{=html}19`</formaPago>`{=html}
Numérico 2 conforme tabla 24 `<total>`{=html}34.94`</total>`{=html}
Obligatorio Numérico Max 14 Obligatorio, cuando
`<plazo>`{=html}90`<plazo>`{=html} Numérico Max 14 corresponda
Obligatorio, cuando `<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html}
Texto Max 10 corresponda `</pago>`{=html} Obligatorio -
`</pagos>`{=html} Obligatorio - -
`<valorRetIva>`{=html}0.00`</valorRetIva>`{=html} Opcional Numérico Max
14 `<valorRetRenta>`{=html}0.00`</valorRetRenta>`{=html} Opcional
Numérico Max 14 `</infoFactura>`{=html} Obligatorio - - -
`<detalles>`{=html} Obligatorio - - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}003`</codigoPrincipal >`{=html} Obligatorio
Alfanumérico Max 25 Obligatorio cuando
`<codigoAuxiliar>`{=html}001`</codigoAuxiliar>`{=html} Alfanumérico Max
25 corresponda `<descripcion>`{=html} FROZEN MOONFISH WR
`</descripcion>`{=html} Obligatorio Alfanumérico Max 300 Max 18,
`<cantidad>`{=html}2.542563`</cantidad>`{=html} Obligatorio Numérico
hasta 6 decimales Max 18,
`<precioUnitario>`{=html}25.542365`</precioUnitario>`{=html} Obligatorio
Numérico hasta 6 decimales `<descuento>`{=html}0.00`</descuento>`{=html}
Obligatorio Numérico Max 14 `<precioTotalSinImpuesto>`{=html}64.94\</
precioTotalSinImpuesto\> Obligatorio Numérico Max 14 Obligatorio cuando
`<detallesAdicionales>`{=html} - - corresponda Obligatorio cuando
`<detAdicional nombre="KILOS" valor="PESO NETO"/>`{=html} Alfanumérico
Max 300 corresponda Obligatorio cuando
`<detAdicional nombre="KILOS " valor="PESO BRUTO"/>`{=html} Alfanumérico
Max 300 corresponda Obligatorio cuando
`<detAdicional nombre="0303.89.00.90" valor="PARTIDA ARANCELARIA"/>`{=html}
Alfanumérico Max 300 corresponda Obligatorio cuando
`</detallesAdicionales>`{=html} - - corresponda `<impuestos>`{=html}
Obligatorio - - `<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} Numérico 1 conforme tabla 16
`<codigoPorcentaje>`{=html}0`</codigoPorcentaje>`{=html} Obligatorio,
Numérico Min 1 Max 4

                                                                                                                   78

------------------------------------------------------------------------

                                                                                                 TIPO DE        LONGITUD /
                              ETIQUETAS O TAGS                               CARACTER
                                                                                                 CAMPO           FORMATO
                                                                         conforme tabla 17
                                                                                                                Min 1 Max 4

`<tarifa>`{=html}0\</ tarifa\> Obligatorio Numérico / 2 enteros, 2
decimales `<baseImponible>`{=html}64.94`</baseImponible>`{=html}
Obligatorio Numérico Max 14 `<valor>`{=html}0.00`</valor>`{=html}
Obligatorio Numérico Max 14 `</impuesto>`{=html} Obligatorio - -
`</impuestos>`{=html} Obligatorio - - `</detalle>`{=html}
Obligatorio - - `</detalles>`{=html} Obligatorio - - Obligatorio cuando
corresponda. Aplica para comercializadores de Derivados de Petróleo y
Retención presuntiva de IVA a `<retenciones>`{=html} - - los Editores,
Distribuidores y Voceadores que participan en la comercialización de
periódicos y/o revistas. Obligatorio cuando -`<retencion>`{=html} - -
corresponda Obligatorio cuando `<codigo>`{=html}4`</codigo>`{=html}
corresponda Numérico 1 conforme tabla 22 Obligatorio cuando
`<codigoPorcentaje>`{=html}327`</codigoPorcentaje>`{=html} corresponda
Numérico Min 1 Max 3 conforme tabla 23 Min 1 Max 5 / Obligatorio cuando
3 enteros, `<tarifa>`{=html}0.20`</tarifa>`{=html} Numérico corresponda
dos decimales Max 14 /12 Obligatorio cuando
`<valor>`{=html}0.13`</valor>`{=html} Numérico enteros, 2 corresponda
decimales Obligatorio cuando `</retencion>`{=html} - - corresponda
Obligatorio cuando `</retenciones>`{=html} - - corresponda Obligatorio
cuando `<infoAdicional>`{=html} - - corresponda
`<campoAdicional nombre=" DESCRIPCION DE CARGA ">`{=html} CAJAS DE 10
KILOS Obligatorio cuando Alfanumérico Max 300 `</campoAdicional>`{=html}
corresponda \<campoAdicionalnombre=" INFORMACION BANCARIA "\> NUMERO DE
CUENTA DE Obligatorio cuando Alfanumérico Max 300 BANCO
1243546`</campoAdicional>`{=html} corresponda Obligatorio cuando
`</infoAdicional>`{=html} - - corresponda `</factura>`{=html}
Obligatorio - -

TABLA 24: FORMAS DE PAGO

                              FORMAS DE PAGO                          CÓDIGO FECHA INICIO FECHA FIN

                  SIN UTILIZACION DEL SISTEMA FINANCIERO                01         01/01/2013               -

                        COMPENSACIÓN DE DEUDAS                          15         01/01/2013               -
                             TARJETA DE DÉBITO                          16         01/06/2016               -
                           DINERO ELECTRÓNICO                           17         01/06/2016               -
                             TARJETA PREPAGO                            18         01/06/2016               -
                            TARJETA DE CRÉDITO                          19         01/06/2016               -

          OTROS CON UTILIZACIÓN DEL SISTEMA FINANCIERO                  20         01/06/2016               -

                            ENDOSO DE TÍTULOS                           21         01/06/2016               -


                                                                                                                          79

------------------------------------------------------------------------

Las formas de pago señaladas corresponden al Catálogo del Anexo
Transaccional Simplificado, publicado en la página web www.sri.gob.ec:
Información sobre impuestos/Cómo declaro mis impuestos? / Anexos y
guías.

TABLA 25: PAÍSES

     CÓDIGO         DESCRIPCIÓN             CÓDIGO        DESCRIPCIÓN
       016          AMERICAN SAMOA           334                 QATAR
       074           BOUVET ISLAND           335               MALDIVAS
       101              ARGENTINA            336                  NEPAL
       102                BOLIVIA            337                  OMAN
       103                 BRASIL            338               SINGAPUR
       104                CANADÁ             339          SRI LANKA (CEILAN)
       105              COLOMBIA             341                VIETNAM
       106             COSTA RICA            342                 YEMEN
       107                  CUBA             343      ISLAS HEARD Y MCDONALD
       108                 CHILE             344         BRUNEI DARUSSALAM
       109               ANGUILA             346                TURQUÍA
       110          ESTADOS UNIDOS           347              AZERBAIJÁN
       111             GUATEMALA             348              KAZAJSTÁN
       112                  HAITÍ            349             KIRGUIZISTÁN
       113              HONDURAS             350              TAJIKISTAN
       114               JAMAICA             351            TURKMENISTÁN
       115           MALVINAS ISLAS          352              UZBEKISTÁN
       116                MÉXICO             353               PALESTINA
       117             NICARAGUA             354              HONG KONG
       118                PANAMÁ             355                 MACAO
       119              PARAGUAY             356                ARMENIA
       120                  PERÚ             382             MONTENEGRO
       121            PUERTO RICO            402            BURKINA FASO
       122       REPÚBLICA DOMINICANA        403                ARGELIA
       123            EL SALVADOR            404                BURUNDÍ
       124         TRINIDAD Y TOBAGO         405               CAMERÚN
       125               URUGUAY             406                 CONGO
       126             VENEZUELA             407                 ETIOPÍA
       127               CURAZAO             408                 GAMBIA
       129               BAHAMAS             409                 GUINEA
       130              BARBADOS             410                 LIBERIA
       131               GRANADA             412             MADAGASCAR
       132                GUYANA             413                 MALAWI
       133               SURINAM             414                   MALÍ
       134        ANTIGUA Y BARBUDA          415             MARRUECOS
       135                 BELICE            416              MAURITANIA
       136               DOMINICA            417                NIGERIA
       137       SAN CRISTOBAL Y NEVIS       419        ZIMBABWE (RHODESIA)
       138             SANTA LUCÍA           420                SENEGAL
       139     SAN VICENTE Y LAS GRANAD.     421                 SUDÁN
       140       ANTILLAS HOLANDESAS         422          SUDAFRICA (CISKEI)
       141                 ARUBA             423            SIERRA LEONA
       142               BERMUDA             425               TANZANIA
       143             GUADALUPE             426                UGANDA
       144         GUYANA FRANCESA           427                 ZAMBIA
       145            ISLAS CAIMÁN           428            ÅLAND ISLANDS
       146    ISLAS VIRGENES (BRITANICAS)    429                  BENIN
       147           JOHNSTON ISLA           430              BOTSWANA
       148              MARTINICA            431     REPUBLICA CENTROAFRICANA
       149          MONTSERRAT ISLA          432           COSTA DE MARFIL
       151       TURCAS Y CAICOS ISLAS       433                  CHAD


                                                                                80

------------------------------------------------------------------------

CÓDIGO DESCRIPCIÓN CÓDIGO DESCRIPCIÓN 152 VIRGENES, ISLAS (NORT.AMER.)
434 EGIPTO 201 ALBANIA 435 GABON 202 ALEMANIA 436 GHANA 203 AUSTRIA 437
GUINEA-BISSAU 204 BÉLGICA 438 GUINEA ECUATORIAL 205 BULGARIA 439 KENIA
207 ALBORAN Y PEREJIL 440 LESOTHO 208 DINAMARCA 441 MAURICIO 209 ESPAÑA
442 MOZAMBIQUE 211 FRANCIA 443 MAYOTTE 212 FINLANDIA 444 NIGER 213 REINO
UNIDO 445 RWANDA 214 GRECIA 446 SEYCHELLES 215 PAISES BAJOS (HOLANDA)
447 SAHARA OCCIDENTAL 216 HUNGRÍA 448 SOMALIA 217 IRLANDA 449 SANTO TOME
Y PRINCIPE 218 ISLANDIA 450 SWAZILANDIA 219 ITALIA 451 TOGO 220
LUXEMBURGO 452 TUNEZ 221 MALTA 453 ZAIRE 222 NORUEGA 454 ANGOLA 223
POLONIA 456 CABO VERDE 224 PORTUGAL 458 COMORAS 225 RUMANIA 459 DJIBOUTI
226 SUECIA 460 NAMIBIA 227 SUIZA 463 ERITREA 228 CANARIAS ISLAS 464
MOROCCO 229 UCRANIA 465 REUNION 230 RUSIA 466 SANTA ELENA 231 YUGOSLAVIA
499 JERSEY 233 ANDORRA 501 AUSTRALIA 234 LIECHTENSTEIN 503 NUEVA ZELANDA
235 MÓNACO 504 SAMOA OCCIDENTAL 237 SAN MARINO 506 FIJI 238 VATICANO
(SANTA SEDE) 507 PAPUA NUEVA GUINEA 239 GIBRALTAR 508 TONGA 241 BELARUS
509 PALAO (BELAU) ISLAS 242 BOSNIA Y HERZEGOVINA 510 KIRIBATI 243
CROACIA 511 MARSHALL ISLAS 244 ESLOVENIA 512 MICRONESIA 245 ESTONIA 513
NAURU 246 GEORGIA 514 SALOMON ISLAS 247 GROENLANDIA 515 TUVALU 248
LETONIA 516 VANUATU 249 LITUANIA 517 GUAM 250 MOLDOVA 518 ISLAS COCOS
(KEELING) 251 MACEDONIA 519 ISLAS COOK 252 ESLOVAQUIA 520 ISLAS NAVIDAD
253 ISLAS FAROE 521 MIDWAY ISLAS 260 FRENCH SOUTHERN TERRITORIES 522
NIUE ISLA 301 AFGANISTAN 523 NORFOLK ISLA 302 ARABIA SAUDITA 524 NUEVA
CALEDONIA 303 MYANMAR (BURMA) 525 PITCAIRN, ISLA 304 CAMBOYA 526
POLINESIA FRANCESA 306 COREA NORTE 529 TIMOR DEL ESTE 307 TAIWAN (CHINA)
530 TOKELAI 308 FILIPINAS 531 WAKE ISLA 309 INDIA 532 WALLIS Y FUTUNA,
ISLAS

                                                                           81

------------------------------------------------------------------------

           CÓDIGO                   DESCRIPCIÓN              CÓDIGO                   DESCRIPCIÓN
              310                   INDONESIA                   590              SAINT BARTHELEMY
              311                       IRAK                    593                    ECUADOR
              312           IRÁN (REPÚBLICA ISLÁMICA)           594           AGUAS INTERNACIONALES
              313                      ISRAEL                   595                   ALTO VOLTA
              314                      JAPÓN                    596                  BIELORRUSIA
              315                    JORDANIA                   597                 COTE DÍVOIRE
              316                     KUWAIT                    598                     CYPRUS
              317             LAOS, REP. POP. DEMOC.            599               REPÚBLICA CHECA
              318                      LIBANO                   600               FALKLAND ISLANDS
              319                     MALASIA                   601                      LATVIA
              321             MONGOLIA (MANCHURIA)              602                       LIBIA
              322                    PAKISTÁN                   603            NORTHERN MARIANA ISL
              323                       SIRIA                   604             ST. PIERRE AND MIQUE
              325                    TAILANDIA                  605             SYRIAN ARAB REPUBLIC
              327                     BAHREIN                   606        TERRITORIO ANTÁRTICO BRITÁNICO

              328                    BANGLADESH                 607        TERRITORIO BRITÁNICO OCÉANO IN

              329                   BUTÁN                       688                        SERBIA
              330               COREA DEL SUR                   831                      GUERNSEY
              331               CHINA POPULAR                   832                       JERSEY
              332                   CHIPRE                      833                     ISLE OF MAN
              333           EMIRATOS ARABES UNIDOS

Los códigos establecidos para países corresponden al Catálogo de Anexo
Transaccional Simplificado, publicado en la página web www.sri.gob.ec:
Información sobre impuestos / Cómo declaro mis impuestos? / Anexos y
guías.

ANEXO 5 - FORMATOS XML FACTURA REEMBOLSO APLICADO EN LAS VERSIONES 1.0.0
y 1.1.0 Incluyen los campos requeridos exclusivamente para reembolso,
caso contrario se deberá utilizar los formatos de factura establecidos
en el anexo 1 y anexo 3 según corresponda.

FACTURA VERSIÓN 1.0.0 TIPO DE LONGITUD / ETIQUETAS O TAGS CARACTER CAMPO
FORMATO `<?xml version="1.0" encoding="UTF-8"?>`{=html} Obligatorio - -
`<factura id="comprobante" version="1.0.0">`{=html} Obligatorio - -
`<infoTributaria>`{=html} Obligatorio - - Obligatorio, conforme
`<ambiente>`{=html}1 `</ambiente>`{=html} Numérico 1 tabla 4
Obligatorio, conforme `<tipoEmision>`{=html}1 \</ tipoEmision\> Numérico
1 tabla 2 `<razonSocial>`{=html}CONTRIBUYENTE
PRUEBA`</razonSocial>`{=html} Obligatorio Alfanumérico Max 300
Obligatorio, cuando `<nombreComercial>`{=html}PRUEBA
UNO`</nombreComercial>`{=html} Alfanumérico Max 300 corresponda
`<ruc>`{=html}1792261104001`</ruc>`{=html} Obligatorio Numérico 13
`<claveAcceso>`{=html}0403201301179226110400110015010000000081234567816`</claveAcc     Obligatorio, conforme
                                                                                                      Numérico          49
eso>`{=html} tabla 1 Obligatorio, conforme
`<codDoc>`{=html}01`</codDoc>`{=html} Numérico 2 tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}501`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000008`</secuencial>`{=html} Obligatorio
Numérico 9

                                                                                                                             82

------------------------------------------------------------------------

                                                                                                 TIPO DE      LONGITUD /
                               ETIQUETAS O TAGS                          CARACTER
                                                                                                  CAMPO        FORMATO

`<dirMatriz>`{=html}Alpallana`</dirMatriz>`{=html} Obligatorio
Alfanumérico Max 300 `</infoTributaria>`{=html} Obligatorio - -
`<infoFactura>`{=html} Obligatorio - -
`<fechaEmision>`{=html}04/03/2013`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio, cuando
`<dirEstablecimiento>`{=html}Alpallana`</dirEstablecimiento>`{=html}
Alfanumérico Max 300 corresponda Obligatorio, cuando
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
Alfanumérico Min 3 Max 13 corresponda Obligatorio, cuando
`<obligadoContabilidad>`{=html}SI\</ obligadoContabilidad \> Texto SI/NO
corresponda Obligatorio, conforme
`<tipoIdentificacionComprador>`{=html}04`</tipoIdentificacionComprador>`{=html}
Numérico 2 tabla 6 Obligatorio, cuando
`<guiaRemision>`{=html}001-001-000000001`</guiaRemision>`{=html}
Numérico 15 corresponda `<razonSocialComprador>`{=html}PRUEBAS SERVICIO
DE RENTAS Obligatorio Alfanumérico Max 300
INTERNAS`</razonSocialComprador>`{=html}
`<identificacionComprador>`{=html}1760013210001`</identificacionComprador>`{=html}
Obligatorio Numérico Max 20 Obligatorio, cuando
`<direccionComprador>`{=html}salinas y
santiago`</direccionComprador>`{=html} Alfanumérico Max 300 corresponda
`<totalSinImpuestos>`{=html}150.00`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14
`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14 Obligatorio cuando
`<codDocReemb>`{=html}41`</codDocReemb>`{=html} corresponda a Numérico 2
Reembolso (41) Obligatorio cuando `<codDocReemb>`{=html}\> sea igual a
41, sumatoria de
`<totalComprobantesReembolso>`{=html}150.00`</totalComprobantesReembolso>`{=html}
Numérico Max 14 `<totalBaseImponibleRe
                                                                            embolso>`{=html}
y `<totalImpuestoReembol
                                                                                so>`{=html}.
Obligatorio cuando `<codDocReemb>`{=html} sea igual a 41, en base a la
información
`<totalBaseImponibleReembolso>`{=html}133.93`</totalBaseImponibleReembolso>`{=html}
Numérico Max 14 `<reembolsos>`{=html}, sumatoria de `<baseImponibleReemb
                                                                               olso>`{=html}.
Obligatorio cuando `<codDocReemb>`{=html}\> sea igual a 41, en base a la
`<totalImpuestoReembolso>`{=html}16.07`</totalImpuestoReembolso>`{=html}
información Numérico Max 14 `<reembolsos>`{=html} sumatoria de
`<impuestoReembolso>`{=html}. `<totalConImpuesto>`{=html}
Obligatorio - - `<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
conforme `<codigo>`{=html}2`</codigo>`{=html} Numérico 1 tabla 16
Obligatorio, conforme
`<codigoPorcentaje>`{=html}6`</codigoPorcentaje>`{=html} Numérico Min 1
Max 4 tabla 17 `<baseImponible>`{=html}150.00`</baseImponible>`{=html}
Obligatorio Numérico Max 14 `<valor>`{=html}0.00`<valor>`{=html}
Obligatorio Numérico Max 14 `</totalImpuesto>`{=html} Obligatorio - -
`</totalConImpuesto>`{=html} Obligatorio - -
`<propina>`{=html}0.00`<propina>`{=html} Obligatorio Numérico Max 14
`<importeTotal>`{=html}150.00`<importeTotal>`{=html} Obligatorio
Numérico Max 14 Obligatorio, cuando
`<moneda>`{=html}DOLAR`<moneda>`{=html} Alfanumérico Max 15 corresponda
`<pagos>`{=html} Obligatorio - - `<pago>`{=html} Obligatorio - -
Obligatorio, conforme `<formaPago>`{=html}01`</formaPago>`{=html}
Numérico 2 tabla 24 `<total>`{=html}150`</total>`{=html} Obligatorio
Numérico Max 14 Obligatorio, cuando `<plazo>`{=html}0`<plazo>`{=html}
Numérico Max 14 corresponda Obligatorio, cuando
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} Texto Max 10
corresponda `</pago>`{=html} Obligatorio - - `</pagos>`{=html}
Obligatorio - - `<valorRetIva>`{=html}0.00`</valorRetIva>`{=html}
Opcional Numérico Max 14
`<valorRetRenta>`{=html}0.00`</valorRetRenta>`{=html} Opcional Numérico
Max 14 `</infoFactura>`{=html} Obligatorio - - `<detalles>`{=html}
Obligatorio - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}003`</codigoPrincipal>`{=html} Obligatorio
Alfanumérico Max 25
`<codigoAuxiliar>`{=html}001`</codigoAuxiliar>`{=html} Obligatorio,
cuando Alfanumérico Max 25

                                                                                                                       83

------------------------------------------------------------------------

                                                                                                         TIPO DE       LONGITUD /
                              ETIQUETAS O TAGS                                      CARACTER
                                                                                                         CAMPO          FORMATO
                                                                                    corresponda

`<descripcion>`{=html}REEMBOLSO DE GASTOS`</descripcion>`{=html}
Obligatorio Alfanumérico Max 300
`<cantidad>`{=html}1`</cantidad>`{=html} Obligatorio Numérico Max 14
`<precioUnitario>`{=html}150.00`</precioUnitario>`{=html} Obligatorio
Numérico Max 14 `<descuento>`{=html}0`</descuento>`{=html} Obligatorio
Numérico Max 14
`<precioTotalSinImpuestos>`{=html}150.00`</precioTotalSinImpuestos>`{=html}
Obligatorio Numérico Max 14 Obligatorio, cuando
`<detallesAdicionales>`{=html} - - corresponda Obligatorio, cuando
`<detAdicional nombre="TECLADO DELL" valor="COMPRA DE REPUESTOS"/>`{=html}
Alfanumérico Max 300 corresponda Obligatorio, cuando
`</detallesAdicionales>`{=html} - - corresponda `<impuestos>`{=html}
Obligatorio - - `<impuesto>`{=html} Obligatorio - - Obligatorio,
conforme `<codigo>`{=html}2`</codigo>`{=html} Numérico 1 tabla 16
Obligatorio, conforme
`<codigoPorcentaje>`{=html}6`</codigoPorcentaje>`{=html} Numérico Min 1
Max 4 tabla 17 Min 1 Max 4 `<tarifa>`{=html}0.00\</ tarifa\> Obligatorio
Numérico / 2 enteros, 2 decimales
`<baseImponible>`{=html}150.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}0.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</impuesto>`{=html} Obligatorio - -
`</impuestos>`{=html} Obligatorio - - `</detalle>`{=html}
Obligatorio - - `</detalles>`{=html} Obligatorio - - Obligatorio cuando
`<reembolsos>`{=html} `<codDocReemb>`{=html} sea - - igual a 41
Obligatorio cuando `<reembolsoDetalle>`{=html} `<codDocReemb>`{=html}
sea - - igual a 41 Obligatorio cuando
`<tipoIdentificacionProveedorReembolso>`{=html}04`</tipoIdentificacionProveedorReembol    <codDocReemb>`{=html}sea
Numérico 2 so\> igual a 41, conforme tabla 6 Obligatorio cuando
`<identificacionProveedorReembolso>`{=html}1760013210001`</identificacionProveedorRee
                                                                                <codDocReemb>`{=html}
sea Alfanumérico Max 13 mbolso\> igual a 41 Obligatorio cuando
`<codDocReemb>`{=html} sea
`<codPaisPagoProveedorReembolso>`{=html}593`</codPaisPagoProveedorReembolso>`{=html}
Numérico 3 igual a 41, conforme tabla 25 Obligatorio cuando
`<codDocReemb>`{=html} sea
`<tipoProveedorReembolso>`{=html}01`</tipoProveedorReembolso>`{=html}
Numérico 2 igual a 41, conforme tabla 26 Obligatorio cuando
`<codDocReemb>`{=html} sea igual a 41, conforme
`<codDocReembolso>`{=html}01`</codDocReembolso>`{=html} Numérico Min 2
Max 3 documentos de reembolso del catálogo del ATS Obligatorio cuando
`<estabDocReembolso>`{=html}001`</estabDocReembolso>`{=html}
`<codDocReemb>`{=html} sea Numérico 3 igual a 41 Obligatorio cuando
`<ptoEmiDocReembolso>`{=html}501`</ptoEmiDocReembolso>`{=html}
`<codDocReemb>`{=html} sea Numérico 3 igual a 41 Obligatorio cuando
`<secuencialDocReembolso>`{=html}000000008`</secuencialDocReembolso>`{=html}
`<codDocReemb>`{=html} sea Numérico 9 igual a 41 Obligatorio cuando
`<fechaEmisionDocReembolso>`{=html}04/03/2013`</fechaEmisionDocReembolso>`{=html}
`<codDocReemb>`{=html} sea Fecha dd/mm/aaaa igual a 41 Obligatorio
cuando
`<numeroautorizacionDocReemb>`{=html}040320130117922611040011001501000000008123
`<codDocReemb>`{=html} sea Numérico 10, 37 o 49
4567816`</numeroautorizacionDocReemb>`{=html} igual a 41 Obligatorio
cuando `<detalleImpuestos>`{=html} `<codDocReemb>`{=html} sea - - igual
a 41 Obligatorio cuando `<detalleImpuesto>`{=html}
`<codDocReemb>`{=html} sea - - igual a 41 Obligatorio cuando
`<codDocReemb>`{=html} sea `<codigo>`{=html}2`</codigo>`{=html} Numérico
1 igual a 41, conforme tabla 16
`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} Obligatorio
cuando Numérico Min 1 Max 4

                                                                                                                                 84

------------------------------------------------------------------------

                                                                                                     TIPO DE        LONGITUD /
                                  ETIQUETAS O TAGS                            CARACTER
                                                                                                     CAMPO           FORMATO
                                                                          <codDocReemb> sea
                                                                           igual a 41, conforme
                                                                                  tabla 17
                                                                            Obligatorio cuando                      Min 1 Max 4 / 2

`<tarifa>`{=html}12`</tarifa>`{=html} `<codDocReemb>`{=html} sea
Numérico enteros, 2 igual a 41 decimales Obligatorio cuando
`<baseImponibleReembolso>`{=html}133.93`</baseImponibleReembolso>`{=html}
`<codDocReemb>`{=html} sea Numérico Max 14 igual a 41 Obligatorio cuando
`<impuestoReembolso>`{=html}16.07`</impuestoReembolso>`{=html}
`<codDocReemb>`{=html} sea Numérico Max 14 igual a 41 Obligatorio cuando
`</detalleImpuesto>`{=html} `<codDocReemb>`{=html} sea - - igual a 41
Obligatorio cuando `</detalleImpuestos>`{=html} `<codDocReemb>`{=html}
sea - - igual a 41 Obligatorio cuando `</reembolsoDetalle>`{=html}
`<codDocReemb>`{=html} sea - - igual a 41 Obligatorio cuando
`</reembolsos>`{=html} `<codDocReemb>`{=html}sea - - igual a 41
Obligatorio cuando `<infoAdicional>`{=html} - - corresponda Obligatorio
cuando
`<campoAdicional nombre="Codigo Impuesto ISD">`{=html}4580`</campoAdicional>`{=html}
Alfanumérico Max 300 corresponda Obligatorio cuando
`</infoAdicional>`{=html} - - corresponda `</factura>`{=html}
Obligatorio - -

FACTURA VERSIÓN 1.1.0 En esta versión se podrá utilizar de 2 a 6
decimales en los campos de cantidad y precio unitario para
contribuyentes que lo requieran. TIPO DE LONGITUD / ETIQUETAS O TAGS
CARACTER CAMPO FORMATO `<?xml version="1.0" encoding="UTF-8" ?>`{=html}
Obligatorio - - `<factura id="comprobante" version="1.1.0">`{=html}
Obligatorio - - `<infoTributaria>`{=html} Obligatorio - - Obligatorio,
conforme `<ambiente>`{=html}1 `</ambiente>`{=html} Numérico 1 tabla 4
Obligatorio, conforme `<tipoEmision>`{=html}1 \</ tipoEmision\> Numérico
1 tabla 2 `<razonSocial>`{=html}EMPRESA PUBLICA DE HIDROCARBUROS DEL
ECUADOR Obligatorio Alfanumérico Max 300 EP
PETROECUADOR`</razonSocial>`{=html} `<nombreComercial>`{=html}EMPRESA
PUBLICA DE HIDROCARBUROS DEL Obligatorio cuando Alfanumérico Max 300
ECUADOR EP PETROECUADOR\</ nombreComercial \> corresponda
`<ruc>`{=html}1768153530001`</ruc>`{=html} Obligatorio Numérico 13
`<claveAcceso>`{=html}0403201301179226110400110015010000000081234567816`</cl   Obligatorio, conforme
                                                                                                   Numérico             49
 aveAcceso>`{=html} tabla 1 Obligatorio, conforme
`<codDoc>`{=html}01`</codDoc>`{=html} Numérico 2 tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}501`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000008`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}Alpallana`</dirMatriz>`{=html}
Obligatorio Alfanumérico Max 300

`</infoTributaria>`{=html} Obligatorio - - `<infoFactura>`{=html}
Obligatorio - -
`<fechaEmision>`{=html}04/03/2013`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio cuando
`<dirEstablecimiento>`{=html}Alpallana\</ dirEstablecimiento \>
Alfanumérico Max 300 corresponda Obligatorio cuando
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
Alfanumérico Min 3 Max 13 corresponda Obligatorio cuando
`<obligadoContabilidad>`{=html}SI\</ obligadoContabilidad \> Texto SI /
NO corresponda `<tipoIdentificacionComprador>`{=html}04\</
tipoIdentificacionComprador \> Obligatorio, conforme Numérico 2

                                                                                                                                 85

------------------------------------------------------------------------

                                                                                                     TIPO DE       LONGITUD /
                            ETIQUETAS O TAGS                                CARACTER
                                                                                                     CAMPO          FORMATO
                                                                               tabla 6
                                                                         Obligatorio cuando

`<guiaRemision>`{=html}001-001-000000001`</guiaRemision>`{=html}
Numérico 15 corresponda `<razonSocialComprador>`{=html}PRUEBAS SERVICIO
DE RENTAS Obligatorio Alfanumérico Max 300
INTERNAS`</razonSocialComprador>`{=html}
`<identificacionComprador>`{=html}1760013210001\</
identificacionComprador \> Obligatorio Alfanumérico Max 20 Obligatorio
cuando `<direccionComprador>`{=html}salinas y
santiago`</direccionComprador>`{=html} Alfanumérico Max 300 corresponda
`<totalSinImpuestos>`{=html}150.00`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14

`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14 Obligatorio cuando
`<codDocReembolso>`{=html}41`</codDocReembolso>`{=html} corresponda a
Reembolso Numérico 2 (41) Obligatorio cuando `<codDocReemb>`{=html}\>
sea igual a 41, sumatoria de
`<totalComprobantesReembolso>`{=html}150.00`</totalComprobantesReembolso>`{=html}
Numérico Max 14 `<totalBaseImponibleReemb
                                                                                  olso>`{=html}
y `<totalImpuestoReembolso>`{=html}. Obligatorio cuando
`<codDocReemb>`{=html} sea igual a 41, en base a la
`<totalBaseImponibleReembolso>`{=html}133.93`</totalBaseImponibleReembolso>`{=html}
información `<reembolsos>`{=html}, Numérico Max 14 sumatoria de
`<baseImponibleReembolso
                                                                                     >`{=html}.
Obligatorio cuando `<codDocReemb>`{=html}\> sea igual a 41, en base a la
`<totalImpuestoReembolso>`{=html}16.07`</totalImpuestoReembolso>`{=html}
Numérico Max 14 información `<reembolsos>`{=html} sumatoria de
`<impuestoReembolso>`{=html}. `<totalConImpuestos>`{=html}
Obligatorio - - `<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
conforme `<codigo>`{=html}2`</codigo >`{=html} Numérico 1 tabla 16
Obligatorio, conforme `<codigoPorcentaje>`{=html}6\</ codigoPorcentaje\>
Numérico Min 1 Max 4 tabla 17 Opcional, aplica para
`<descuentoAdicional>`{=html}0.00`</descuentoAdicional>`{=html} Numérico
Max 14 código impuesto 2. `<baseImponible>`{=html}150.00\</
baseImponible \> Obligatorio Numérico Max 14

`<valor>`{=html}0.00`</valor >`{=html} Obligatorio Numérico Max 14

`</totalImpuesto >`{=html} Obligatorio - -

`</totalConImpuestos >`{=html} Obligatorio - -

`<propina>`{=html}0.00`</propina>`{=html} Obligatorio Numérico Max 14

`<importeTotal>`{=html}150.13\</ importeTotal\> Obligatorio Numérico Max
14 Obligatorio cuando `<moneda>`{=html}DOLAR`</moneda>`{=html}
Alfanumérico Max 15 corresponda `<pagos>`{=html} Obligatorio -

`<pago>`{=html} Obligatorio - Obligatorio, cuando
`<formaPago>`{=html}01`</formaPago>`{=html} corresponda conforme
Numérico 2 tabla 24 `<total>`{=html}150.13`</total>`{=html} Obligatorio
Numérico Max 14 Obligatorio, cuando `<plazo>`{=html}0`<plazo>`{=html}
Numérico Max 14 corresponda Obligatorio, cuando
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} Texto Max 10
corresponda `</pago>`{=html} Obligatorio - - `<pagos>`{=html}
Obligatorio - - `<valorRetIva>`{=html}0.00`</valorRetIva>`{=html}
Opcional Numérico Max 14
`<valorRetRenta>`{=html}0.00`</valorRetRenta>`{=html} Opcional Numérico
Max 14 `</infoFactura>`{=html} Obligatorio - -

`<detalles>`{=html} Obligatorio - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}003`</codigoPrincipal >`{=html} Obligatorio
Alfanumérico Max 25

                                                                                                                            86

------------------------------------------------------------------------

                                                                                                     TIPO DE       LONGITUD /
                            ETIQUETAS O TAGS                                   CARACTER
                                                                                                     CAMPO          FORMATO
                                                                            Obligatorio cuando

`<codigoAuxiliar>`{=html}001`</codigoAuxiliar>`{=html} Alfanumérico Max
25 corresponda `<descripcion>`{=html} Reembolso de Gastos
`</descripcion>`{=html} Obligatorio Alfanumérico Max 300 Max 18,
`<cantidad>`{=html}1.000000`</cantidad>`{=html} Obligatorio Numérico
hasta 6 decimales Max 18,
`<precioUnitario>`{=html}150.000000`</precioUnitario>`{=html}
Obligatorio Numérico hasta 6 decimales
`<descuento>`{=html}0.00`</descuento>`{=html} Obligatorio Numérico Max
14

`<precioTotalSinImpuesto>`{=html}150.00\</ precioTotalSinImpuesto\>
Obligatorio Numérico Max 14 Obligatorio cuando
`<detallesAdicionales>`{=html} - - corresponda \<detAdicional
nombre="PARTES Y PIEZAS DE COMPUTADORA" Obligatorio cuando Alfanumérico
Max 300 valor="MOUSE HP"/\> corresponda Obligatorio cuando
`</detallesAdicionales>`{=html} - - corresponda `<impuestos>`{=html}
Obligatorio - - `<impuesto>`{=html} Obligatorio - - Obligatorio,
conforme `<codigo>`{=html}2`</codigo>`{=html} Numérico 1 tabla 16
Obligatorio, conforme
`<codigoPorcentaje>`{=html}6`</codigoPorcentaje>`{=html} Numérico Min 1
Max 4 tabla 17 Min 1 Max 4 `<tarifa>`{=html}0\</ tarifa\> Obligatorio
Numérico / 2 enteros, 2 decimales
`<baseImponible>`{=html}150.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14

`<valor>`{=html}0.00`</valor>`{=html} Obligatorio Numérico Max 14

`</impuesto>`{=html} Obligatorio - -

`</impuestos>`{=html} Obligatorio - -

`</detalle>`{=html} Obligatorio - -

`</detalles>`{=html} Obligatorio - - Obligatorio cuando
`<reembolsos>`{=html} `<codDocReemb>`{=html} sea igual - - a 41
Obligatorio cuando `<reembolsoDetalle>`{=html} `<codDocReemb>`{=html}
sea igual - - a 41 Obligatorio cuando
`<tipoIdentificacionProveedorReembolso>`{=html}04`</tipoIdentificacionProveedorR
                                                                         <codDocReemb>`{=html}sea
igual Numérico 2 eembolso\> a 41, conforme tabla 6 Obligatorio cuando
`<identificacionProveedorReembolso>`{=html}1760013210001`</identificacionProvee
                                                                         <codDocReemb>`{=html}
sea igual Alfanumérico Max 13 dorReembolso\> a 41 Obligatorio cuando
`<codPaisPagoProveedorReembolso>`{=html}593`</codPaisPagoProveedorReembol
                                                                         <codDocReemb>`{=html}
sea igual Numérico 3 so\> a 41, conforme tabla 25 Obligatorio cuando
`<tipoProveedorReembolso>`{=html}01`</tipoProveedorReembolso>`{=html}
`<codDocReemb>`{=html} sea igual Numérico 2 a 41, conforme tabla 26
Obligatorio cuando
`<codDocReembolso>`{=html}01`</codDocReembolso>`{=html}
`<codDocReemb>`{=html} sea igual Numérico 2 a 41, conforme tabla 3
Obligatorio cuando
`<estabDocReembolso>`{=html}001`</estabDocReembolso>`{=html}
`<codDocReemb>`{=html} sea igual Numérico 3 a 41 Obligatorio cuando
`<ptoEmiDocReembolso>`{=html}501`</ptoEmiDocReembolso>`{=html}
`<codDocReemb>`{=html} sea igual Numérico 3 a 41 Obligatorio cuando
`<secuencialDocReembolso>`{=html}000000008`</secuencialDocReembolso>`{=html}
`<codDocReemb>`{=html} sea igual Numérico 9 a 41 Obligatorio cuando
`<fechaEmisionDocReembolso>`{=html}04/03/2013`</fechaEmisionDocReembolso>`{=html}
`<codDocReemb>`{=html} sea igual Fecha dd/mm/aaaa a 41 Obligatorio
cuando
`<numeroautorizacionDocReemb>`{=html}04032013011792261104001100150100000
`<codDocReemb>`{=html} sea igual Numérico 10, 37 o 49
00081234567816`</numeroautorizacionDocReemb>`{=html} a 41 Obligatorio
cuando `<detalleImpuestos>`{=html} `<codDocReemb>`{=html} sea igual - -
a 41 Obligatorio cuando `<detalleImpuesto>`{=html} - -
`<codDocReemb>`{=html} sea igual

                                                                                                                             87

------------------------------------------------------------------------

                                                                                                   TIPO DE       LONGITUD /
                          ETIQUETAS O TAGS                                  CARACTER
                                                                                                   CAMPO          FORMATO
                                                                                  a 41
                                                                          Obligatorio cuando

`<codigo>`{=html}2`</codigo>`{=html} `<codDocReemb>`{=html} sea igual
Numérico 1 a 41, conforme tabla 16 Obligatorio cuando
`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
`<codDocReemb>`{=html} sea igual Numérico Min 1 Max 4 a 41, conforme
tabla 17 Obligatorio cuando Min 1 Max 4 /
`<tarifa>`{=html}12`</tarifa>`{=html} `<codDocReemb>`{=html} sea igual
Numérico 2 enteros, 2 a 41 decimales Obligatorio cuando
`<baseImponibleReembolso>`{=html}133.93`</baseImponibleReembolso>`{=html}
`<codDocReemb>`{=html} sea igual Numérico Max 14 a 41 Obligatorio cuando
`<impuestoReembolso>`{=html}16.07`</impuestoReembolso>`{=html}
`<codDocReemb>`{=html} sea igual Numérico Max 14 a 41 Obligatorio cuando
`</detalleImpuesto>`{=html} `<codDocReemb>`{=html} sea igual - - a 41
Obligatorio cuando `</detalleImpuestos>`{=html} `<codDocReemb>`{=html}
sea igual - - a 41 Obligatorio cuando `</reembolsoDetalle>`{=html}
`<codDocReemb>`{=html} sea igual - - a 41 Obligatorio cuando
`</reembolsos>`{=html} `<codDocReemb>`{=html}sea igual - - a 41
Obligatorio cuando corresponda. Aplica para `<retenciones>`{=html} - -
comercializadores de Derivados de Petróleo. Obligatorio cuando
`<retencion>`{=html} - - corresponda Obligatorio cuando
`<codigo>`{=html}4`</codigo>`{=html} corresponda conforme Numérico 1
tabla 22 Obligatorio cuando
`<codigoPorcentaje>`{=html}327`</codigoPorcentaje>`{=html} corresponda
conforme Numérico Min 1 Max 3 tabla 23 Min 1 Max 5 / Obligatorio cuando
3 enteros, `<tarifa>`{=html}0.20`</tarifa>`{=html} Numérico corresponda
dos decimales Max 14 /12 Obligatorio cuando
`<valor>`{=html}0.13`</valor>`{=html} Numérico enteros, 2 corresponda
decimales Obligatorio cuando `</retencion>`{=html} - - corresponda
Obligatorio cuando `</retenciones>`{=html} - - corresponda Obligatorio
cuando `<infoAdicional>`{=html} - - corresponda
`<campoAdicional nombre=" DESCRIPCION DE CARGA ">`{=html} CAJAS DE 10
Obligatorio cuando Alfanumérico Max 300 KILOS `</campoAdicional>`{=html}
corresponda

\<campoAdicionalnombre=" INFORMACION BANCARIA "\> NUMERO DE Obligatorio
cuando Alfanumérico Max 300 CUENTA DE BANCO
1243546`</campoAdicional>`{=html} corresponda Obligatorio cuando
`</infoAdicional>`{=html} - - corresponda `</factura>`{=html}
Obligatorio - -

TABLA 26: Tipo Proveedor de Reembolso

                                                TIPO           CÓDIGO

                                           PERSONA NATURAL       01


                                              SOCIEDAD           02


                                                                                                                           88

------------------------------------------------------------------------

ANEXO 6 - FORMATOS XML FACTURA CON SUBSIDIOS APLICADO EN LAS VERSIONES
1.0.0 y 1.1.0 Incluyen los campos requeridos exclusivamente solo para
subsidio; caso contrario se deberá utilizar los formatos de factura
establecidos en el anexo 1 y anexo 3 según corresponda12.

FACTURA VERSIÓN 1.0.0 TIPO DE LONGITUD ETIQUETAS O TAGS CARACTER CAMPO /
FORMATO `<?xml version="1.0" encoding="UTF-8" ?>`{=html} Obligatorio - -
-`<factura id="comprobante" version="1.0.0">`{=html} Obligatorio - - -
`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1`</ambiente>`{=html} Numérico 1 conforme tabla 4
Obligatorio, `<tipoEmision>`{=html}1`</tipoEmision>`{=html} Numérico 1
conforme tabla 2 `<razonSocial>`{=html}SERVICIO DE RENTAS
INTERNAS`</razonSocial>`{=html} Obligatorio Alfanumérico Max 300
Obligatorio, cuando
`<nombreComercial>`{=html}SRI`</nombreComercial>`{=html} Alfanumérico
Max 300 corresponda `<ruc>`{=html}1760013210001`</ruc>`{=html}
Obligatorio Numérico 13 Obligatorio,
`<claveAcceso>`{=html}0601201601176001321000110011230000000081234567817`</claveAcceso>`{=html}
Numérico 49 conforme tabla 1 Obligatorio,
`<codDoc>`{=html}01`</codDoc>`{=html} Numérico 2 conforme tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}123`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000008`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}SALINAS`</dirMatriz>`{=html} Obligatorio
Alfanumérico Max 300 `</infoTributaria>`{=html} Obligatorio - -
`<infoFactura>`{=html} Obligatorio - -

`<fechaEmision>`{=html}06/01/2016`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio, cuando
`<dirEstablecimiento>`{=html}PÁEZ`</dirEstablecimiento>`{=html}
Alfanumérico Max 300 corresponda Obligatorio, cuando Min 3 Max
`<contribuyenteEspecial>`{=html}123A`</contribuyenteEspecial>`{=html}
Alfanumérico corresponda 13 Obligatorio, cuando
`<obligadoContabilidad>`{=html}SI`</obligadoContabilidad>`{=html} Texto
SI/NO corresponda Obligatorio,
`<tipoIdentificacionComprador>`{=html}04`</tipoIdentificacionComprador>`{=html}
Numérico 2 conforme tabla 6 `<razonSocialComprador>`{=html}EMPRESA
ABC`</razonSocialComprador>`{=html} Obligatorio Alfanumérico Max 300
`<identificacionComprador>`{=html}1794567890001`</identificacionComprador>`{=html}
Obligatorio Numérico Max 13 Obligatorio, cuando
`<direccionComprador>`{=html}salinas y
santiago`</direccionComprador>`{=html} Alfanumérico Max 300 corresponda
`<totalSinImpuestos>`{=html}25.00`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14 Opcional y se llenará
`<totalSubsidio>`{=html}10.00`</totalSubsidio>`{=html} cuando exista el
tag Numérico Max 14 `<precioSinSubsidio>`{=html}.
`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14 `<totalConImpuestos>`{=html} Obligatorio - -
`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} Numérico 1 conforme tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
Numérico Min 1 Max 4 conforme tabla 17
`<baseImponible>`{=html}25.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14

12 Resolución NAC-DGERCGC15-00003184, publicada en el Registro Oficial
661 de 4 de enero de 2016

                                                                                                                                      89

------------------------------------------------------------------------

                                                                                 TIPO DE        LONGITUD
                                  ETIQUETAS O TAGS           CARACTER
                                                                                 CAMPO         / FORMATO

`<valor>`{=html}3.00`</valor>`{=html} Obligatorio Numérico Max 14
`</totalImpuesto>`{=html} Obligatorio - - `</totalConImpuestos>`{=html}
Obligatorio - - `<propina>`{=html}0.00`</propina>`{=html} Obligatorio
Numérico Max 14 `<importeTotal>`{=html}28.00`</importeTotal>`{=html}
Obligatorio Numérico Max 14 Obligatorio, cuando
`<moneda>`{=html}DOLAR`</moneda>`{=html} Alfanumérico Max 15 corresponda
`<pagos>`{=html} Obligatorio - - `<pago>`{=html} Obligatorio -
Obligatorio, `<formaPago>`{=html}19`</formaPago>`{=html} Numérico 2
conforme tabla 24 `<total>`{=html}28,000`</total>`{=html} Obligatorio
Numérico Max 14 Obligatorio, cuando `<plazo>`{=html}30`<plazo>`{=html}
Numérico Max 14 corresponda Obligatorio, cuando
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} Texto Max 10
corresponda `</pago>`{=html} Obligatorio - - `</pagos>`{=html}
Obligatorio `<valorRetIva>`{=html}10620.00`</valorRetIva>`{=html}
Opcional Numérico Max 14
`<valorRetRenta>`{=html}2950.00`</valorRetRenta>`{=html} Opcional
Numérico Max 14 `</infoFactura>`{=html} Obligatorio - -
`<detalles>`{=html} Obligatorio - - `<detalle>`{=html} Obligatorio - -
Obligatorio, (para
`<codigoPrincipal>`{=html}0011`</codigoPrincipal>`{=html} venta de
combustible Alfanumérico Max 25 ver tabla 30) Obligatorio, cuando
`<codigoAuxiliar>`{=html}0011`</codigoAuxiliar>`{=html} Alfanumérico Max
25 corresponda Obligatorio, (para
`<descripcion>`{=html}COMBUSTIBLE`</descripcion>`{=html} venta de
combustible Alfanumérico Max 300 ver tabla 30)
`<cantidad>`{=html}1`</cantidad>`{=html} Obligatorio Numérico Max 14
`<precioUnitario>`{=html}25`</precioUnitario>`{=html} Obligatorio
Numérico Max 14 Obligatorio, cuando
`<precioSinSubsidio>`{=html}35.00`</precioSinSubsidio>`{=html} Numérico
Max 14 corresponda. `<descuento>`{=html}0`</descuento>`{=html}
Obligatorio Numérico Max 14
`<precioTotalSinImpuesto>`{=html}25.00`</precioTotalSinImpuesto>`{=html}
Obligatorio. Numérico Max 14 `<impuestos>`{=html} Obligatorio - -
`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} Numérico 1 conforme tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
Numérico Min 1 Max 4 conforme tabla 17 Min 1 Max
`<tarifa>`{=html}12.00`</tarifa>`{=html} Obligatorio Numérico 4/2
enteros, 2 decimales
`<baseImponible>`{=html}25.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}3.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</impuesto>`{=html} Obligatorio - -
`</impuestos>`{=html} Obligatorio - - `</detalle>`{=html}
Obligatorio - - `</detalles>`{=html} Obligatorio - - `</factura>`{=html}
Obligatorio - -

FACTURA VERSIÓN 1.1.0 En esta versión se podrá utilizar de 2 a 6
decimales en los campos de cantidad y precio unitario para
contribuyentes que lo requieran.

                                                                                                        90

------------------------------------------------------------------------

                                                                                                        TIPO DE       LONGITUD /
                                  ETIQUETAS O TAGS                                 CARACTER
                                                                                                        CAMPO          FORMATO

```{=html}
<?xml version="1.0" encoding="UTF-8" ?>
```
Obligatorio - - -`<factura id="comprobante" version="1.1.0">`{=html}
Obligatorio - -

-   `<infoTributaria>`{=html} Obligatorio - - Obligatorio,
    `<ambiente>`{=html}1`</ambiente>`{=html} Numérico 1 conforme tabla 4
    Obligatorio, `<tipoEmision>`{=html}1`</tipoEmision>`{=html} Numérico
    1 conforme tabla 2 `<razonSocial>`{=html}SERVICIO DE RENTAS
    INTERNAS`</razonSocial>`{=html} Obligatorio Alfanumérico Max 300
    Obligatorio, cuando
    `<nombreComercial>`{=html}SRI`</nombreComercial>`{=html}
    Alfanumérico Max 300 corresponda
    `<ruc>`{=html}1760013210001`</ruc>`{=html} Obligatorio Numérico 13
    Obligatorio,
    `<claveAcceso>`{=html}0601201601176001321000110011230000000081234567817`</claveAcceso>`{=html}
    Numérico 49 conforme tabla 1 Obligatorio,
    `<codDoc>`{=html}01`</codDoc>`{=html} Numérico 2 conforme tabla 3
    `<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
    `<ptoEmi>`{=html}123`</ptoEmi>`{=html} Obligatorio Numérico 3
    `<secuencial>`{=html}000000008`</secuencial>`{=html} Obligatorio
    Numérico 9 `<dirMatriz>`{=html}SALINAS`</dirMatriz>`{=html}
    Obligatorio Alfanumérico Max 300 `</infoTributaria>`{=html}
    Obligatorio - - `<infoFactura>`{=html} Obligatorio - -
    `<fechaEmision>`{=html}06/01/2016`</fechaEmision>`{=html}
    Obligatorio Fecha dd/mm/aaaa Obligatorio, cuando
    `<dirEstablecimiento>`{=html}PÁEZ`</dirEstablecimiento>`{=html}
    Alfanumérico Max 300 corresponda Obligatorio, cuando
    `<contribuyenteEspecial>`{=html}123A`</contribuyenteEspecial>`{=html}
    Alfanumérico Min 3 Max 13 corresponda Obligatorio, cuando
    `<obligadoContabilidad>`{=html}SI`</obligadoContabilidad>`{=html}
    Texto SI/NO corresponda Obligatorio,
    `<tipoIdentificacionComprador>`{=html}04`</tipoIdentificacionComprador>`{=html}
    Numérico 2 conforme tabla 6 `<razonSocialComprador>`{=html}EMPRESA
    ABC`</razonSocialComprador>`{=html} Obligatorio Alfanumérico Max 300
    `<identificacionComprador>`{=html}1794567890001`</identificacionComprador>`{=html}
    Obligatorio Numérico Max 13 Obligatorio, cuando
    `<direccionComprador>`{=html}salinas y
    santiago`</direccionComprador>`{=html} Alfanumérico Max 300
    corresponda
    `<totalSinImpuestos>`{=html}25.00`</totalSinImpuestos>`{=html}
    Obligatorio Numérico Max 14 Opcional y se llenará
    `<totalSubsidio>`{=html}10.00`</totalSubsidio>`{=html} cuando exista
    el tag Numérico Max 14 `<precioSinSubsidio>`{=html}.
    `<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} Obligatorio
    Numérico Max 14 `<totalConImpuestos>`{=html} Obligatorio - -
    `<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
    `<codigo>`{=html}2`</codigo>`{=html} Numérico 1 conforme tabla 16
    Obligatorio,
    `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} Numérico
    Min 1 Max 4 conforme tabla 17
    `<baseImponible>`{=html}25.00`</baseImponible>`{=html} Obligatorio
    Numérico Max 14 `<valor>`{=html}3.00`</valor>`{=html} Obligatorio
    Numérico Max 14 `</totalImpuesto>`{=html} Obligatorio - -
    `</totalConImpuestos>`{=html} Obligatorio - -
    `<propina>`{=html}0.00`</propina>`{=html} Obligatorio Numérico Max
    14 `<importeTotal>`{=html}28.00`</importeTotal>`{=html} Obligatorio
    Numérico Max 14 Obligatorio, cuando
    `<moneda>`{=html}DOLAR`</moneda>`{=html} Alfanumérico Max 15
    corresponda `<pagos>`{=html} Obligatorio - - `<pago>`{=html}
    Obligatorio - Obligatorio,
    `<formaPago>`{=html}20`</formaPago>`{=html} Numérico 2 conforme
    tabla 24 `<total>`{=html}28,000`</total>`{=html} Obligatorio
    Numérico Max 14 Obligatorio, cuando
    `<plazo>`{=html}30`<plazo>`{=html} Numérico Max 14 corresponda
    Obligatorio, cuando
    `<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} Texto Max 10
    corresponda `</pago>`{=html} Obligatorio - - `</pagos>`{=html}
    Obligatorio - - `<valorRetIva>`{=html}0.00`</valorRetIva>`{=html}
    Opcional Numérico Max 14

                                                                                                                                 91

------------------------------------------------------------------------

                                                                                 TIPO DE       LONGITUD /
                                  ETIQUETAS O TAGS           CARACTER
                                                                                 CAMPO          FORMATO

`<valorRetRenta>`{=html}0.00`</valorRetRenta>`{=html} Opcional Numérico
Max 14 `</infoFactura>`{=html} Obligatorio - - `<detalles>`{=html}
Obligatorio - - `<detalle>`{=html} Obligatorio - - Obligatorio, (para
`<codigoPrincipal>`{=html}0011`</codigoPrincipal>`{=html} venta de
combustible Alfanumérico Max 25 ver tabla 30) Obligatorio, cuando
`<codigoAuxiliar>`{=html}0011`</codigoAuxiliar>`{=html} Alfanumérico Max
25 corresponda Obligatorio, (para
`<descripcion>`{=html}COMBUSTIBLE`</descripcion>`{=html} venta de
combustible Alfanumérico Max 300 ver tabla 30) Max 18,
`<cantidad>`{=html}1`</cantidad>`{=html} Obligatorio Numérico hasta 6
decimales Max 18, `<precioUnitario>`{=html}25`</precioUnitario>`{=html}
Obligatorio Numérico hasta 6 decimales Obligatorio, cuando
`<precioSinSubsidio>`{=html}35.00`</precioSinSubsidio>`{=html} Numérico
Max 14 corresponda. `<descuento>`{=html}0`</descuento>`{=html}
Obligatorio Numérico Max 14
`<precioTotalSinImpuesto>`{=html}25.00`</precioTotalSinImpuesto>`{=html}
Obligatorio. Numérico Max 14 `<impuestos>`{=html} Obligatorio - -
`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} Numérico 1 conforme tabla 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
Numérico Min 1 Max 4 conforme tabla 17 Min 1 Max 4
`<tarifa>`{=html}12.00`</tarifa>`{=html} Obligatorio Numérico / 2
enteros, 2 decimales
`<baseImponible>`{=html}25.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}3.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</impuesto>`{=html} Obligatorio - -
`</impuestos>`{=html} Obligatorio - - `</detalle>`{=html}
Obligatorio - - `</detalles>`{=html} Obligatorio - - `</factura>`{=html}
Obligatorio - -

                                                                                                         92

------------------------------------------------------------------------

ANEXO 7 -- FORMATOS DE REPRESENTACIÓN IMPRESA DE DOCUMENTO ELECTRÓNICO
CON SUBSIDIO (RIDE)

Nota:

• El campo VALOR TOTAL SIN SUBSIDIO, corresponde a: precio sin
subsidio + IVA según corresponda.

55.00 + 12% = \$6.60 55.00 + 6.60 = \$61.60

• El campo AHORRO POR SUBSIDIO, corresponde al subsidio + IVA según
corresponda.

27.75 + 12% = \$3.33 27.75 + 3.33 = \$31.08

• La diferencia entre VALOR TOTAL SIN SUBSIDIO menos AHORRO POR SUBSIDIO
es igual al valor total de la factura, es decir: \$30.52

                                                                                                         93

------------------------------------------------------------------------

ANEXO 8 - FORMATOS XML FACTURA CON RUBROS DE TERCEROS APLICADO EN LAS
VERSIONES 2.0.0 y 2.1.0 Incluyen los campos requeridos exclusivamente
para rubros de terceros, caso contrario se deberá utilizar los formatos
de factura establecidos en el anexo 1 y anexo 3 según corresponda13.

FACTURA VERSIÓN 2.0.0 TIPO DE LONGITUD / ETIQUETAS O TAGS CARACTER CAMPO
FORMATO `<?xml version="1.0" encoding="UTF-8"?>`{=html} Obligatorio - -
`<factura id="comprobante" version="2.0.0">`{=html} Obligatorio - -
`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1`</ambiente>`{=html} Numérico 1 conforme tabla 4
Obligatorio, `<tipoEmision>`{=html}1`</tipoEmision>`{=html} Numérico 1
conforme tabla 2 `<razonSocial>`{=html}PRUEBA`</razonSocial>`{=html}
Obligatorio Alfanumérico Max 300 Obligatorio,
`<nombreComercial>`{=html}PRUEBA 2`</nombreComercial>`{=html} cuando
Alfanumérico Max 300 corresponda
`<ruc>`{=html}1760013210001`</ruc>`{=html} Obligatorio Numérico 13
Obligatorio,
`<claveAcceso>`{=html}2103201601176001321000110010010000000061234567816`</claveAcceso>`{=html}
conforme tabla Numérico 49 1 Obligatorio,
`<codDoc>`{=html}01`</codDoc>`{=html} Numérico 2 conforme tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}001`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000006`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}SALINAS`</dirMatriz>`{=html} Obligatorio
Alfanumérico Max 300 `</infoTributaria>`{=html} Obligatorio - -
`<infoFactura>`{=html} Obligatorio - -
`<fechaEmision>`{=html}21/03/2016`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio,
`<dirEstablecimiento>`{=html}PÁEZ`</dirEstablecimiento>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio,
`<contribuyenteEspecial>`{=html}12345`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda Obligatorio,
`<obligadoContabilidad>`{=html}SI`</obligadoContabilidad>`{=html} cuando
Texto SI/NO corresponda Obligatorio,
`<tipoIdentificacionComprador>`{=html}07`</tipoIdentificacionComprador>`{=html}
Numérico 2 conforme tabla 6 `<razonSocialComprador>`{=html}CONSUMIDOR
FINAL`</razonSocialComprador>`{=html} Obligatorio Alfanumérico Max 300
`<identificacionComprador>`{=html}9999999999999`</identificacionComprador>`{=html}
Obligatorio Numérico Max 13 Obligatorio,
`<direccionComprador>`{=html}salinas y
santiago`</direccionComprador>`{=html} cuando Alfanumérico Max 300
corresponda
`<totalSinImpuestos>`{=html}50.00`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14
`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14 `<totalConImpuestos>`{=html} Obligatorio - -
`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} conforme tabla Numérico 1 16
`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} Obligatorio,
Numérico Min 1 Max 4

13 Resolución NAC-DGERCGC15-00003184, publicada en el Registro Oficial
661 de 4 de enero de 2016

                                                                                                                                   94

------------------------------------------------------------------------

                                                                           TIPO DE       LONGITUD /
                                  ETIQUETAS O TAGS        CARACTER
                                                                           CAMPO          FORMATO
                                                         conforme tabla
                                                               17

`<baseImponible>`{=html}50.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}6.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</totalImpuesto>`{=html} Obligatorio - -
`</totalConImpuestos>`{=html} Obligatorio - -
`<propina>`{=html}0.00`</propina>`{=html} Obligatorio Numérico Max 14
`<importeTotal>`{=html}61.00`</importeTotal>`{=html} Obligatorio
Numérico Max 14 Obligatorio, `<moneda>`{=html}DOLAR`</moneda>`{=html}
cuando Alfanumérico Max 15 corresponda Obligatorio, `<pagos>`{=html}
cuando - - corresponda `<pago>`{=html} Obligatorio - Obligatorio,
`<formaPago>`{=html}19`</formaPago>`{=html} conforme tabla Numérico 2 24
`<total>`{=html}61,00`</total>`{=html} Obligatorio Numérico Max 14
Obligatorio, `<plazo>`{=html}30`<plazo>`{=html} cuando Numérico Max 14
corresponda Obligatorio,
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} cuando Texto Max 10
corresponda `</pago>`{=html} Obligatorio - - `</pagos>`{=html}
Obligatorio - - `<valorRetIva>`{=html}0.00`</valorRetIva>`{=html}
Opcional Numérico Max 14
`<valorRetRenta>`{=html}0.00`</valorRetRenta>`{=html} Opcional Numérico
Max 14 `</infoFactura>`{=html} Obligatorio - - `<detalles>`{=html}
Obligatorio - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}001`</codigoPrincipal>`{=html} Obligatorio
Alfanumérico Max 25 Obligatorio,
`<codigoAuxiliar>`{=html}0011`</codigoAuxiliar>`{=html} cuando
Alfanumérico Max 25 corresponda
`<descripcion>`{=html}BIEN`</descripcion>`{=html} Obligatorio
Alfanumérico Max 300 `<cantidad>`{=html}1`</cantidad>`{=html}
Obligatorio Numérico Max 14
`<precioUnitario>`{=html}50`</precioUnitario>`{=html} Obligatorio
Numérico Max 14 `<descuento>`{=html}0`</descuento>`{=html} Obligatorio
Numérico Max 14
`<precioTotalSinImpuesto>`{=html}50.00`</precioTotalSinImpuesto>`{=html}
Obligatorio. Numérico Max 14 `<impuestos>`{=html} Obligatorio - -
`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} conforme tabla Numérico 1 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
conforme tabla Numérico Min 1 Max 4 17 Min 1 Max 4
`<tarifa>`{=html}12.00`</tarifa>`{=html} Obligatorio Numérico / 2
enteros, 2 decimales
`<baseImponible>`{=html}50.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}6.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</impuesto>`{=html} Obligatorio - -
`</impuestos>`{=html} Obligatorio - - `</detalle>`{=html}
Obligatorio - - `</detalles>`{=html} Obligatorio - -
`<otrosRubrosTerceros>`{=html} Obligatorio - - `<rubro>`{=html}
Obligatorio - - `<concepto>`{=html}CONCEPTO1`</concepto>`{=html}
Obligatorio Alfanumérico Max 300 `<total>`{=html}10`</total>`{=html}
Obligatorio Numérico Min 1 Max 4 `</rubro>`{=html} Obligatorio - -
`<rubro>`{=html} Obligatorio - -
`<concepto>`{=html}CONCEPTO2`</concepto>`{=html} Obligatorio
Alfanumérico Max 300 `<total>`{=html}12`</total>`{=html} Obligatorio
Numérico Min 1 Max 4 `</rubro>`{=html} Obligatorio - - `<rubro>`{=html}
Obligatorio - -

                                                                                                   95

------------------------------------------------------------------------

                                                                                                  TIPO DE      LONGITUD /
                                 ETIQUETAS O TAGS                               CARACTER
                                                                                                   CAMPO        FORMATO

`<concepto>`{=html}CONCEPTO3`</concepto>`{=html} Obligatorio
Alfanumérico Max 300 `<total>`{=html}5`</total>`{=html} Obligatorio
Numérico Min 1 Max 4 `</rubro>`{=html} Obligatorio - - `<rubro>`{=html}
Obligatorio - - `<concepto>`{=html}CONCEPTO4`</concepto>`{=html}
Obligatorio Alfanumérico Max 300 `<total>`{=html}25`</total>`{=html}
Obligatorio Numérico Min 1 Max 4 `</rubro>`{=html} Obligatorio - -
`</otrosRubrosTerceros>`{=html} Obligatorio - - `</factura>`{=html}
Obligatorio - -

FACTURA VERSIÓN 2.1.0

En esta versión se podrá utilizar de 2 a 6 decimales en los campos de
cantidad y precio unitario para contribuyentes que lo requieran. TIPO DE
LONGITUD / ETIQUETAS O TAGS CARACTER CAMPO FORMATO
`<?xml version="1.0" encoding="UTF-8"?>`{=html} Obligatorio - -
`<factura id="comprobante" version="2.1.0">`{=html} Obligatorio - -
`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1`</ambiente>`{=html} conforme tabla Numérico 1 4
Obligatorio, `<tipoEmision>`{=html}1`</tipoEmision>`{=html} conforme
tabla Numérico 1 2 `<razonSocial>`{=html}PRUEBA`</razonSocial>`{=html}
Obligatorio Alfanumérico Max 300 Obligatorio,
`<nombreComercial>`{=html}PRUEBA 2`</nombreComercial>`{=html} cuando
Alfanumérico Max 300 corresponda
`<ruc>`{=html}1760013210001`</ruc>`{=html} Obligatorio Numérico 13
Obligatorio,
`<claveAcceso>`{=html}2103201601176001321000110010010000000061234567816`</claveAcceso>`{=html}
conforme Numérico 49 tabla 1 Obligatorio,
`<codDoc>`{=html}01`</codDoc>`{=html} conforme tabla Numérico 2 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}001`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000006`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}SALINAS`</dirMatriz>`{=html} Obligatorio
Alfanumérico Max 300 `</infoTributaria>`{=html} Obligatorio - -
`<infoFactura>`{=html} Obligatorio - -

`<fechaEmision>`{=html}21/03/2016`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio,
`<dirEstablecimiento>`{=html}PÁEZ`</dirEstablecimiento>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio,
`<contribuyenteEspecial>`{=html}12345`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda Obligatorio,
`<obligadoContabilidad>`{=html}SI`</obligadoContabilidad>`{=html} cuando
Texto SI/NO corresponda Obligatorio,
`<tipoIdentificacionComprador>`{=html}07`</tipoIdentificacionComprador>`{=html}
conforme tabla Numérico 2 6 `<razonSocialComprador>`{=html}CONSUMIDOR
FINAL`</razonSocialComprador>`{=html} Obligatorio Alfanumérico Max 300
`<identificacionComprador>`{=html}9999999999999`</identificacionComprador>`{=html}
Obligatorio Numérico Max 13 Obligatorio,
`<direccionComprador>`{=html}salinas y
santiago`</direccionComprador>`{=html} cuando Alfanumérico Max 300
corresponda
`<totalSinImpuestos>`{=html}50.00`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14
`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14 `<totalConImpuestos>`{=html} Obligatorio - -
`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} Numérico 1 conforme tabla

                                                                                                                          96

------------------------------------------------------------------------

                                                                           TIPO DE       LONGITUD /
                                  ETIQUETAS O TAGS        CARACTER
                                                                           CAMPO          FORMATO
                                                               16
                                                          Obligatorio,

`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} conforme tabla
Numérico Min 1 Max 4 17
`<baseImponible>`{=html}50.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}6.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</totalImpuesto>`{=html} Obligatorio - -
`</totalConImpuestos>`{=html} Obligatorio - -
`<propina>`{=html}0.00`</propina>`{=html} Obligatorio Numérico Max 14

`<importeTotal>`{=html}61.00`</importeTotal>`{=html} Obligatorio
Numérico Max 14 Obligatorio, `<moneda>`{=html}DOLAR`</moneda>`{=html}
cuando Alfanumérico Max 15 corresponda `<pagos>`{=html} Obligatorio - -
`<pago>`{=html} Obligatorio - Obligatorio,
`<formaPago>`{=html}19`</formaPago>`{=html} conforme tabla Numérico 2 24
`<total>`{=html}61,00`</total>`{=html} Obligatorio Numérico Max 14
Obligatorio, `<plazo>`{=html}30`<plazo>`{=html} cuando Numérico Max 14
corresponda Obligatorio,
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} cuando Texto Max 10
corresponda `</pago>`{=html} Obligatorio - - `</pagos>`{=html}
Obligatorio - - `<valorRetIva>`{=html}0.00`</valorRetIva>`{=html}
Opcional Numérico Max 14
`<valorRetRenta>`{=html}0.00`</valorRetRenta>`{=html} Opcional Numérico
Max 14

`</infoFactura>`{=html} Obligatorio - -

`<detalles>`{=html} Obligatorio - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}001`</codigoPrincipal>`{=html} Obligatorio
Alfanumérico Max 25 Obligatorio,
`<codigoAuxiliar>`{=html}0011`</codigoAuxiliar>`{=html} cuando
Alfanumérico Max 25 corresponda
`<descripcion>`{=html}BIEN`</descripcion>`{=html} Obligatorio
Alfanumérico Max 300 Max 18, `<cantidad>`{=html}1`</cantidad>`{=html}
Obligatorio Numérico hasta 6 decimales Max 18,
`<precioUnitario>`{=html}50`</precioUnitario>`{=html} Obligatorio
Numérico hasta 6 decimales `<descuento>`{=html}0`</descuento>`{=html}
Obligatorio Numérico Max 14
`<precioTotalSinImpuesto>`{=html}50.00`</precioTotalSinImpuesto>`{=html}
Obligatorio. Numérico Max 14 `<impuestos>`{=html} Obligatorio - -
`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} conforme tabla Numérico 1 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
conforme tabla Numérico Min 1 Max 4 17 Min 1 Max 4
`<tarifa>`{=html}12.00`</tarifa>`{=html} Obligatorio Numérico / 2
enteros, 2 decimales
`<baseImponible>`{=html}50.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}6.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</impuesto>`{=html} Obligatorio - -
`</impuestos>`{=html} Obligatorio - - `</detalle>`{=html}
Obligatorio - - `</detalles>`{=html} Obligatorio - -
`<otrosRubrosTerceros>`{=html} Obligatorio - - `<rubro>`{=html}
Obligatorio - -

                                                                                                     97

------------------------------------------------------------------------

                                                                                                           TIPO DE      LONGITUD /
                                  ETIQUETAS O TAGS                                      CARACTER
                                                                                                            CAMPO        FORMATO

`<concepto>`{=html}CONCEPTO1`</concepto>`{=html} Obligatorio
Alfanumérico Max 300 `<total>`{=html}1`</total>`{=html} Obligatorio
Numérico Min 1 Max 4 `</rubro>`{=html} Obligatorio - - `<rubro>`{=html}
Obligatorio - - `<concepto>`{=html}CONCEPTO2`</concepto>`{=html}
Obligatorio Alfanumérico Max 300 `<total>`{=html}1`</total>`{=html}
Obligatorio Numérico Min 1 Max 4 `</rubro>`{=html} Obligatorio - -
`<rubro>`{=html} Obligatorio - -
`<concepto>`{=html}CONCEPTO3`</concepto>`{=html} Obligatorio
Alfanumérico Max 300 `<total>`{=html}1`</total>`{=html} Obligatorio
Numérico Min 1 Max 4 `</rubro>`{=html} Obligatorio - - `<rubro>`{=html}
Obligatorio - - `<concepto>`{=html}CONCEPTO4`</concepto>`{=html}
Obligatorio Alfanumérico Max 300 `<total>`{=html}1`</total>`{=html}
Obligatorio Numérico Min 1 Max 4 `</rubro>`{=html} Obligatorio - -
`</otrosRubrosTerceros>`{=html} Obligatorio - - `</factura>`{=html}
Obligatorio - -

ANEXO 9 - FORMATOS XML FACTURA SUSTITUTIVA DE GUÍA DE REMISIÓN APLICADO
EN LAS VERSIONES 2.0.0 y 2.1.0 Incluyen los campos requeridos
exclusivamente para la factura sustitutiva de guía de remisión, caso
contrario se deberá utilizar los formatos de factura establecidos en el
anexo 1 y anexo 3 según corresponda14.

FACTURA VERSIÓN 2.0.0 TIPO DE LONGITUD / ETIQUETAS O TAGS CARACTER CAMPO
FORMATO `<?xml version="1.0" encoding="UTF-8"?>`{=html} Obligatorio - -
`<factura id="comprobante" version="2.0.0">`{=html} Obligatorio - -
`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1`</ambiente>`{=html} Numérico 1 conforme tabla 4
Obligatorio, `<tipoEmision>`{=html}1`</tipoEmision>`{=html} Numérico 1
conforme tabla 2 `<razonSocial>`{=html}PRUEBA`</razonSocial>`{=html}
Obligatorio Alfanumérico Max 300 Obligatorio,
`<nombreComercial>`{=html}PRUEBA 2`</nombreComercial>`{=html} cuando
Alfanumérico Max 300 corresponda
`<ruc>`{=html}1760013210001`</ruc>`{=html} Obligatorio Numérico 13
Obligatorio,
`<claveAcceso>`{=html}2203201601176001321000110010010000000101234567812`</claveAcceso>`{=html}
conforme tabla Numérico 49 1 Obligatorio,
`<codDoc>`{=html}01`</codDoc>`{=html} Numérico 2 conforme tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}001`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000010`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}SALINAS`</dirMatriz>`{=html} Obligatorio
Alfanumérico Max 300 `</infoTributaria>`{=html} Obligatorio - -
`<infoFactura>`{=html} Obligatorio - -
`<fechaEmision>`{=html}22/03/2016`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio,
`<dirEstablecimiento>`{=html}PÁEZ`</dirEstablecimiento>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio,
`<contribuyenteEspecial>`{=html}12345`</contribuyenteEspecial>`{=html}
Alfanumérico Min 3 Max 13 cuando

14 Resolución NAC-DGERCGC15-00003184, publicada en el Registro Oficial
661 de 4 de enero de 2016

                                                                                                                                  98

------------------------------------------------------------------------

                                                                                       TIPO DE       LONGITUD /
                                  ETIQUETAS O TAGS                  CARACTER
                                                                                       CAMPO          FORMATO
                                                                     corresponda
                                                                     Obligatorio,

`<obligadoContabilidad>`{=html}SI`</obligadoContabilidad>`{=html} cuando
Texto SI/NO corresponda Obligatorio,
`<tipoIdentificacionComprador>`{=html}07`</tipoIdentificacionComprador>`{=html}
Numérico 2 conforme tabla 6 `<razonSocialComprador>`{=html}CONSUMIDOR
FINAL`</razonSocialComprador>`{=html} Obligatorio Alfanumérico Max 300
`<identificacionComprador>`{=html}9999999999999`</identificacionComprador>`{=html}
Obligatorio Numérico Max 13 Obligatorio,
`<direccionComprador>`{=html}salinas y
santiago`</direccionComprador>`{=html} cuando Alfanumérico Max 300
corresponda
`<totalSinImpuestos>`{=html}50.00`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14
`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14 `<totalConImpuestos>`{=html} Obligatorio - -
`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} conforme tabla Numérico 1 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
conforme tabla Numérico Min 1 Max 4 17
`<baseImponible>`{=html}50.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}6.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</totalImpuesto>`{=html} Obligatorio - -
`</totalConImpuestos>`{=html} Obligatorio - -
`<propina>`{=html}0.00`</propina>`{=html} Obligatorio Numérico Max 14
`<importeTotal>`{=html}56.00`</importeTotal>`{=html} Obligatorio
Numérico Max 14 Obligatorio, `<moneda>`{=html}DOLAR`</moneda>`{=html}
cuando Alfanumérico Max 15 corresponda `<pagos>`{=html} Obligatorio - -

`<pago>`{=html} Obligatorio - Obligatorio,
`<formaPago>`{=html}18`</formaPago>`{=html} conforme tabla Numérico 2 24
`<total>`{=html}56,00`</total>`{=html} Obligatorio Numérico Max 14
Obligatorio, `<plazo>`{=html}30`<plazo>`{=html} cuando Numérico Max 14
corresponda Obligatorio,
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} cuando Texto Max 10
corresponda `</pago>`{=html} Obligatorio - - `</pagos>`{=html}
Obligatorio - - `<valorRetIva>`{=html}0.00`</valorRetIva>`{=html}
Opcional Numérico Max 14
`<valorRetRenta>`{=html}0.00`</valorRetRenta>`{=html} Opcional Numérico
Max 14 `</infoFactura>`{=html} Obligatorio - - `<detalles>`{=html}
Obligatorio - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}001`</codigoPrincipal>`{=html} Obligatorio
Alfanumérico Max 25 Obligatorio,
`<codigoAuxiliar>`{=html}0011`</codigoAuxiliar>`{=html} cuando
Alfanumérico Max 25 corresponda
`<descripcion>`{=html}BIEN`</descripcion>`{=html} Obligatorio
Alfanumérico Max 300 `<cantidad>`{=html}1`</cantidad>`{=html}
Obligatorio Numérico Max 14
`<precioUnitario>`{=html}50`</precioUnitario>`{=html} Obligatorio
Numérico Max 14 `<descuento>`{=html}0`</descuento>`{=html} Obligatorio
Numérico Max 14
`<precioTotalSinImpuesto>`{=html}50.00`</precioTotalSinImpuesto>`{=html}
Obligatorio. Numérico Max 14 `<impuestos>`{=html} Obligatorio - -
`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} conforme tabla Numérico 1 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
Numérico Min 1 Max 4 conforme tabla

                                                                                                               99

------------------------------------------------------------------------

                                                                                             TIPO DE       LONGITUD /
                                ETIQUETAS O TAGS                          CARACTER
                                                                                             CAMPO          FORMATO
                                                                               17
                                                                                                           Min 1 Max 4

`<tarifa>`{=html}12.00`</tarifa>`{=html} Obligatorio Numérico / 2
enteros, 2 decimales
`<baseImponible>`{=html}50.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}6.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</impuesto>`{=html} Obligatorio - -
`</impuestos>`{=html} Obligatorio - - `</detalle>`{=html}
Obligatorio - - `</detalles>`{=html} Obligatorio - -
`<infoSustitutivaGuiaRemision>`{=html} Obligatorio - - Obligatorio,
`<dirPartida>`{=html}DIRECCION PARTIDA`</dirPartida>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio,
`<dirDestinatario>`{=html}DESTINATARIO`</dirDestinatario>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio,
`<fechaIniTransporte>`{=html}22/03/2016`</fechaIniTransporte>`{=html}
cuando Fecha dd/mm/aaaa corresponda Obligatorio,
`<fechaFinTransporte>`{=html}22/03/2016`</fechaFinTransporte>`{=html}
cuando Fecha dd/mm/aaaa corresponda Obligatorio,
`<razonSocialTransportista>`{=html}RAZON
SOCIAL`</razonSocialTransportista>`{=html} cuando Alfanumérico Max 300
corresponda Obligatorio, cuando
`<tipoIdentificacionTransportista>`{=html}04`</tipoIdentificacionTransportista>`{=html}
Numérico 2 corresponda conforme tabla 6 Obligatorio,
`<rucTransportista>`{=html}1002576302001`</rucTransportista>`{=html}
cuando Numérico Max 13 corresponda Obligatorio cuando corresponda
`<placa>`{=html}PVB0341`</placa>`{=html} Alfanumérico Max 20 (para la
venta de combustible ver tabla 29) `<destinos>`{=html} Obligatorio - -
`<destino>`{=html} Obligatorio - - Obligatorio,
`<motivoTraslado>`{=html}MOTIVO TRASLADO MERCADERIA
2`</motivoTraslado>`{=html} cuando Alfanumérico Max 300 corresponda
Obligatorio
`<docAduaneroUnico>`{=html}0041324846887`</docAduaneroUnico>`{=html}
cuando Alfanumérico Max 20 corresponda Obligatorio,
`<codEstabDestino>`{=html}001`</codEstabDestino>`{=html} cuando Numérico
3 corresponda Obligatorio, `<ruta>`{=html}Quito - Cayambe-
Otavalo`</ruta>`{=html} cuando Alfanumérico Max 300 corresponda
`</destino>`{=html} Obligatorio - - `<destino>`{=html} Obligatorio - -
Obligatorio, `<motivoTraslado>`{=html}MOTIVO TRASLADO MERCADERIA
3`</motivoTraslado>`{=html} cuando Alfanumérico Max 300 corresponda
Obligatorio
`<docAduaneroUnico>`{=html}0041324846887`</docAduaneroUnico>`{=html}
cuando Alfanumérico Max 20 corresponda Obligatorio,
`<codEstabDestino>`{=html}001`</codEstabDestino>`{=html} cuando Numérico
3 corresponda Obligatorio, `<ruta>`{=html}Quito - Cayambe-
Otavalo`</ruta>`{=html} cuando Alfanumérico Max 300 corresponda
`</destino>`{=html} Obligatorio - - `<destino>`{=html} Obligatorio - -
Obligatorio, `<motivoTraslado>`{=html}MOTIVO TRASLADO MERCADERIA
4`</motivoTraslado>`{=html} cuando Alfanumérico Max 300 corresponda
Obligatorio
`<docAduaneroUnico>`{=html}0041324846887`</docAduaneroUnico>`{=html}
Alfanumérico Max 20 cuando

                                                                                                                     100

------------------------------------------------------------------------

                                                                                                   TIPO DE       LONGITUD /
                                 ETIQUETAS O TAGS                                CARACTER
                                                                                                   CAMPO          FORMATO
                                                                                 corresponda
                                                                                 Obligatorio,

`<codEstabDestino>`{=html}001`</codEstabDestino>`{=html} cuando Numérico
3 corresponda Obligatorio, `<ruta>`{=html}Quito - Cayambe-
Otavalo`</ruta>`{=html} cuando Alfanumérico Max 300 corresponda
`</destino>`{=html} Obligatorio - - `</destinos>`{=html} Obligatorio - -
`</infoSustitutivaGuiaRemision>`{=html} Obligatorio - -
`</factura>`{=html} Obligatorio - -

FACTURA VERSIÓN 2.1.0

En esta versión se podrá utilizar de 2 a 6 decimales en los campos de
cantidad y precio unitario para contribuyentes que lo requieran. TIPO DE
LONGITUD / ETIQUETAS O TAGS CARACTER CAMPO FORMATO
`<?xml version="1.0" encoding="UTF-8"?>`{=html} Obligatorio - -
`<factura id="comprobante" version="2.1.0">`{=html} Obligatorio - -
`<infoTributaria>`{=html} Obligatorio - - Obligatorio,
`<ambiente>`{=html}1`</ambiente>`{=html} Numérico 1 conforme tabla 4
Obligatorio, `<tipoEmision>`{=html}1`</tipoEmision>`{=html} Numérico 1
conforme tabla 2 `<razonSocial>`{=html}PRUEBA`</razonSocial>`{=html}
Obligatorio Alfanumérico Max 300 Obligatorio,
`<nombreComercial>`{=html}PRUEBA 2`</nombreComercial>`{=html} cuando
Alfanumérico Max 300 corresponda
`<ruc>`{=html}1760013210001`</ruc>`{=html} Obligatorio Numérico 13
Obligatorio,
`<claveAcceso>`{=html}2203201601176001321000110010010000000101234567812`</claveAcceso>`{=html}
conforme tabla Numérico 49 1 Obligatorio,
`<codDoc>`{=html}01`</codDoc>`{=html} Numérico 2 conforme tabla 3
`<estab>`{=html}001`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}001`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000010`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}SALINAS`</dirMatriz>`{=html} Obligatorio
Alfanumérico Max 300 `</infoTributaria>`{=html} Obligatorio - -
`<infoFactura>`{=html} Obligatorio - -
`<fechaEmision>`{=html}22/03/2016`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa Obligatorio,
`<dirEstablecimiento>`{=html}PÁEZ`</dirEstablecimiento>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio,
`<contribuyenteEspecial>`{=html}12345`</contribuyenteEspecial>`{=html}
cuando Alfanumérico Min 3 Max 13 corresponda Obligatorio,
`<obligadoContabilidad>`{=html}SI`</obligadoContabilidad>`{=html} cuando
Texto SI/NO corresponda Obligatorio,
`<tipoIdentificacionComprador>`{=html}07`</tipoIdentificacionComprador>`{=html}
Numérico 2 conforme tabla 6 `<razonSocialComprador>`{=html}CONSUMIDOR
FINAL`</razonSocialComprador>`{=html} Obligatorio Alfanumérico Max 300
`<identificacionComprador>`{=html}9999999999999`</identificacionComprador>`{=html}
Obligatorio Numérico Max 13 Obligatorio,
`<direccionComprador>`{=html}salinas y
santiago`</direccionComprador>`{=html} cuando Alfanumérico Max 300
corresponda
`<totalSinImpuestos>`{=html}50.00`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14
`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14 `<totalConImpuestos>`{=html} Obligatorio - -
`<totalImpuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} conforme tabla Numérico 1 16
`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} Obligatorio,
Numérico Min 1 Max 4

                                                                                                                          101

------------------------------------------------------------------------

                                                                           TIPO DE       LONGITUD /
                                  ETIQUETAS O TAGS        CARACTER
                                                                           CAMPO          FORMATO
                                                         conforme tabla
                                                               17

`<baseImponible>`{=html}50.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}6.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</totalImpuesto>`{=html} Obligatorio - -
`</totalConImpuestos>`{=html} Obligatorio - -
`<propina>`{=html}0.00`</propina>`{=html} Obligatorio Numérico Max 14
`<importeTotal>`{=html}56.00`</importeTotal>`{=html} Obligatorio
Numérico Max 14 Obligatorio, `<moneda>`{=html}DOLAR`</moneda>`{=html}
cuando Alfanumérico Max 15 corresponda `<pagos>`{=html} Obligatorio - -
`<pago>`{=html} Obligatorio - Obligatorio, cuando
`<formaPago>`{=html}18`</formaPago>`{=html} corresponda Numérico 2
conforme tabla 24 `<total>`{=html}56,00`</total>`{=html} Obligatorio
Numérico Max 14 Obligatorio, `<plazo>`{=html}30`<plazo>`{=html} cuando
Numérico Max 14 corresponda Obligatorio,
`<unidadTiempo>`{=html}dias`</unidadTiempo>`{=html} cuando Texto Max 10
corresponda `</pago>`{=html} Obligatorio - - `</pagos>`{=html}
Obligatorio - - `<valorRetIva>`{=html}0.00`</valorRetIva>`{=html}
Opcional Numérico Max 14
`<valorRetRenta>`{=html}0.00`</valorRetRenta>`{=html} Opcional Numérico
Max 14 `</infoFactura>`{=html} Obligatorio - - `<detalles>`{=html}
Obligatorio - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}001`</codigoPrincipal>`{=html} Obligatorio
Alfanumérico Max 25 Obligatorio,
`<codigoAuxiliar>`{=html}0011`</codigoAuxiliar>`{=html} cuando
Alfanumérico Max 25 corresponda
`<descripcion>`{=html}BIEN`</descripcion>`{=html} Obligatorio
Alfanumérico Max 300 Max 18, `<cantidad>`{=html}1`</cantidad>`{=html}
Obligatorio Numérico hasta 6 decimales Max 18,
`<precioUnitario>`{=html}50`</precioUnitario>`{=html} Obligatorio
Numérico hasta 6 decimales `<descuento>`{=html}0`</descuento>`{=html}
Obligatorio Numérico Max 14
`<precioTotalSinImpuesto>`{=html}50.00`</precioTotalSinImpuesto>`{=html}
Obligatorio. Numérico Max 14 `<impuestos>`{=html} Obligatorio - -
`<impuesto>`{=html} Obligatorio - - Obligatorio,
`<codigo>`{=html}2`</codigo>`{=html} conforme tabla Numérico 1 16
Obligatorio, `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
conforme tabla Numérico Min 1 Max 4 17 Min 1 Max 4
`<tarifa>`{=html}12.00`</tarifa>`{=html} Obligatorio Numérico / 2
enteros, 2 decimales
`<baseImponible>`{=html}50.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}6.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</impuesto>`{=html} Obligatorio - -
`</impuestos>`{=html} Obligatorio - - `</detalle>`{=html}
Obligatorio - - `</detalles>`{=html} Obligatorio - -
`<infoSustitutivaGuiaRemision>`{=html} Obligatorio - - Obligatorio,
`<dirPartida>`{=html}DIRECCION PARTIDA`</dirPartida>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio,
`<dirDestinatario>`{=html}DESTINATARIO`</dirDestinatario>`{=html} cuando
Alfanumérico Max 300 corresponda Obligatorio,
`<fechaIniTransporte>`{=html}22/03/2016`</fechaIniTransporte>`{=html}
Fecha dd/mm/aaaa cuando

                                                                                                   102

------------------------------------------------------------------------

                                                                                             TIPO DE       LONGITUD /
                                ETIQUETAS O TAGS                          CARACTER
                                                                                             CAMPO          FORMATO
                                                                          corresponda
                                                                           Obligatorio,

`<fechaFinTransporte>`{=html}22/03/2016`</fechaFinTransporte>`{=html}
cuando Fecha dd/mm/aaaa corresponda Obligatorio,
`<razonSocialTransportista>`{=html}RAZON
SOCIAL`</razonSocialTransportista>`{=html} cuando Alfanumérico Max 300
corresponda Obligatorio, cuando
`<tipoIdentificacionTransportista>`{=html}04`</tipoIdentificacionTransportista>`{=html}
Numérico 2 corresponda conforme tabla 6 Obligatorio,
`<rucTransportista>`{=html}1002576302001`</rucTransportista>`{=html}
cuando Numérico Max 13 corresponda Obligatorio cuando corresponda
`<placa>`{=html}PVB0341`</placa>`{=html} Alfanumérico Max 20 (para la
venta de combustible ver tabla 29) `<destinos>`{=html} Obligatorio - -

`<destino>`{=html} Obligatorio - - Obligatorio,
`<motivoTraslado>`{=html}MOTIVO TRASLADO MERCADERIA
1`</motivoTraslado>`{=html} cuando Alfanumérico Max 300 corresponda
Obligatorio, `<codEstabDestino>`{=html}001`</codEstabDestino>`{=html}
cuando Numérico 3 corresponda Obligatorio, `<ruta>`{=html}Quito -
Cayambe- Otavalo`</ruta>`{=html} cuando Alfanumérico Max 300 corresponda
`</destino>`{=html} Obligatorio - - `<destino>`{=html} Obligatorio - -
Obligatorio, `<motivoTraslado>`{=html}MOTIVO TRASLADO MERCADERIA
2`</motivoTraslado>`{=html} cuando Alfanumérico Max 300 corresponda
Obligatorio
`<docAduaneroUnico>`{=html}0041324846887`</docAduaneroUnico>`{=html}
cuando Alfanumérico Max 20 corresponda Obligatorio,
`<codEstabDestino>`{=html}001`</codEstabDestino>`{=html} cuando Numérico
3 corresponda Obligatorio, `<ruta>`{=html}Quito - Cayambe-
Otavalo`</ruta>`{=html} cuando Alfanumérico Max 300 corresponda
`</destino>`{=html} Obligatorio - - `<destino>`{=html} Obligatorio - -
Obligatorio, `<motivoTraslado>`{=html}MOTIVO TRASLADO MERCADERIA
3`</motivoTraslado>`{=html} cuando Alfanumérico Max 300 corresponda
Obligatorio
`<docAduaneroUnico>`{=html}0041324846887`</docAduaneroUnico>`{=html}
cuando Alfanumérico Max 20 corresponda Obligatorio,
`<codEstabDestino>`{=html}001`</codEstabDestino>`{=html} cuando Numérico
3 corresponda Obligatorio, `<ruta>`{=html}Quito - Cayambe-
Otavalo`</ruta>`{=html} cuando Alfanumérico Max 300 corresponda
`</destino>`{=html} Obligatorio - - `<destino>`{=html} Obligatorio - -
Obligatorio, `<motivoTraslado>`{=html}MOTIVO TRASLADO MERCADERIA
4`</motivoTraslado>`{=html} cuando Alfanumérico Max 300 corresponda
Obligatorio
`<docAduaneroUnico>`{=html}0041324846887`</docAduaneroUnico>`{=html}
cuando Alfanumérico Max 20 corresponda Obligatorio,
`<codEstabDestino>`{=html}001`</codEstabDestino>`{=html} cuando Numérico
3 corresponda Obligatorio, `<ruta>`{=html}Quito - Cayambe-
Otavalo`</ruta>`{=html} cuando Alfanumérico Max 300 corresponda
`</destino>`{=html} Obligatorio - - `</destinos>`{=html} Obligatorio - -

                                                                                                                   103

------------------------------------------------------------------------

                                                                                                              TIPO DE        LONGITUD /
                                   ETIQUETAS O TAGS                                      CARACTER
                                                                                                              CAMPO           FORMATO

`</infoSustitutivaGuiaRemision>`{=html} Obligatorio - -

`</factura>`{=html} Obligatorio - -

ANEXO 10 - FORMATO XML DE COMPROBANTE DE RETENCIÓN ATS VERSIÓN 2.0.0
Esta versión de comprobante incluye la información que se reporta a
través del módulo de compras del Anexo Transaccional Simplificado (ATS).

                                                                                                                TIPO DE       LONGITUD /
                               ETIQUETAS O TAGS                                        CARACTER
                                                                                                                CAMPO          FORMATO

```{=html}
<?xml version="1.0" encoding="UTF-8" ?>
```
Obligatorio - -
`<comprobanteRetencion id="comprobante" version="2.0.0">`{=html}
Obligatorio - - `<infoTributaria>`{=html} Obligatorio - - Obligatorio,
conforme `<ambiente>`{=html}1`</ambiente>`{=html} tabla 4 de la Ficha
Numérico 1 Técnica Offline Obligatorio, conforme
`<tipoEmision>`{=html}1`</tipoEmision>`{=html} tabla 2 de la Ficha
Numérico 1 Técnica Offline `<razonSocial>`{=html}Distribuidora de
Suministros Nacional S.A.`</razonSocial>`{=html} Obligatorio
Alfanumérico Max 300 `<nombreComercial>`{=html}Empresa Importadora y
Exportadora de Piezas y Partes de Opcional Alfanumérico Max 300 Equipos
de Oficina`</nombreComercial >`{=html}
`<ruc>`{=html}1792146739001`</ruc>`{=html} Obligatorio Numérico 13
`<claveAcceso>`{=html}2410201107179214673900110020010000000011234567815`</clav
                                                                                       Obligatorio             Numérico              49
eAcceso>`{=html} Obligatorio, conforme
`<codDoc>`{=html}07`</codDoc>`{=html} tabla 3 de la Ficha Numérico 2
Técnica Offline `<estab>`{=html}002`</estab>`{=html} Obligatorio
Numérico 3 `<ptoEmi>`{=html}001`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000001`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}Enrique Guerrero Portilla OE1-34 AV. GALO
PLAZA LASSO`</dirMatriz>`{=html} Obligatorio Alfanumérico Max 300
`</infoTributaria>`{=html} Obligatorio - - `<infoCompRetencion>`{=html}
Obligatorio - -
`<fechaEmision>`{=html}15/01/2012`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa `<dirEstablecimiento>`{=html}Rodrigo Moreno S/N
Francisco García`</dirEstablecimiento >`{=html} Opcional Alfanumérico
Max 300
`<contribuyenteEspecial>`{=html}5368`</contribuyenteEspecial>`{=html}
Opcional Alfanumérico Min 3 Max 13
`<obligadoContabilidad>`{=html}SI`</obligadoContabilidad >`{=html}
Opcional Texto SI/NO Obligatorio, conforme
`<tipoIdentificacionSujetoRetenido>`{=html}04`</tipoIdentificacionSujetoRetenido>`{=html}
tabla 6 de la Ficha Numérico 2 Técnica Offline Obligatorio, conforme
tabla 14 Catalogo ATS. Si el tipo de identificación
`<tipoSujetoRetenido>`{=html}01`</tipoSujetoRetenido>`{=html} Numérico 2
del Sujeto Retenido es igual a IDENTIFICACION DEL EXTERIOR Alfabético:
`<parteRel>`{=html}SI`</parteRel>`{=html} Obligatorio 2 SI/NO
`<razonSocialSujetoRetenido>`{=html}Juan Pablo Chávez Obligatorio
Alfanumérico Max 300 Núñez`</razonSocialSujetoRetenido>`{=html}

                                                                                                                                     104

------------------------------------------------------------------------

                                                                                                             TIPO DE      LONGITUD /
                             ETIQUETAS O TAGS                                       CARACTER
                                                                                                             CAMPO         FORMATO

`<identificacionSujetoRetenido>`{=html}1713328506001`</identificacionSujetoRetenido>`{=html}
Obligatorio Alfanumérico Max 20
`<periodoFiscal>`{=html}03/2012`</periodoFiscal>`{=html} Obligatorio
Fecha mm/aaaa `</infoCompRetencion>`{=html} Obligatorio - -
`<docsSustento>`{=html} Obligatorio - - `<docSustento>`{=html}
Obligatorio Obligatorio, conforme
`<codSustento>`{=html}10`</codSustento>`{=html} Numérico 2 tabla 5
Catálogo ATS Obligatorio, conforme
`<codDocSustento>`{=html}19`</codDocSustento>`{=html} Numérico Min 2,
Max 3 tabla 4 del Catálogo ATS
`<numDocSustento>`{=html}002001000000001`</numDocSustento>`{=html}
Opcional Numérico 15
`<fechaEmisionDocSustento>`{=html}20/01/2012`</fechaEmisionDocSustento>`{=html}
Obligatorio Fecha dd/mm/aaaa
`<fechaRegistroContable>`{=html}15/03/2012`</fechaRegistroContable>`{=html}
Opcional Fecha dd/mm/aaaa
`<numAutDocSustento>`{=html}2110201116`</numAutDocSustento>`{=html}
Opcional Numérico 10 o 37 o 49 Obligatorio, conforme
`<pagoLocExt>`{=html}01`</pagoLocExt>`{=html} tabla 15 del Catálogo
Numérico 2 ATS Obligatorio cuando el campo `<pagoLocExt>`{=html}
`<tipoRegi>`{=html}01`</tipoRegi>`{=html} Numérico 2 sea igual 02. Tabla
19 del Catálogo ATS Se genera cuando el código del campo
`<pagoLocExt>`{=html} sea igual 02, si `<tipoReg>`{=html} es igual 01
registrar el código de la tabla 25 de la Ficha Técnica Offline.
`<paisEfecPago>`{=html}212`</paisEfecPago>`{=html} Si `<tipoReg>`{=html}
es igual 02 Numérico 3o4 registrar el país asociado al paraíso fiscal
tabla 17 Catálogo ATS. Si `<tipoReg>`{=html} es igual 03 escoger códigos
de la tabla 16 del Catálogo ATS, excepto código 593 Obligatorio cuando
el `<aplicConvDobTrib>`{=html}NO`</aplicConvDobTrib>`{=html}
`<pagoLocExt>`{=html} sea igual Texto SI/NO 02 se llena el campo
Obligatorio el campo `<aplicConvDobTrib>`{=html} se
`<pagExtSujRetNorLeg>`{=html}NO`</pagExtSujRetNorLeg>`{=html} Texto
SI/NO haya escogido la opción NO Obligatorio cuando el
`<pagoRegFis>`{=html}SI`</pagoRegFis>`{=html} campo
`<pagoLocExt>`{=html} SI 2 sea igual 02 Obligatorio, si
`<codDocSustento>`{=html} es igual a 41, corresponde a la suma de
`<totalComprobantesReembolso>`{=html}141.01`</totalComprobantesReembolso>`{=html}
Numérico Max 14 `<totalBaseImponibleRee
                                                                                         mbolso>`{=html}
y `<totalImpuestoReembols
                                                                                             o>`{=html}
Obligatorio, si `<codDocSustento>`{=html} es igual a 41, corresponde a
la sumatoria de las
`<totalBaseImponibleReembolso>`{=html}120.75`</totalBaseImponibleReembolso>`{=html}
Numérico Max 14 etiquetas `<baseImponibleReembol
                                                                               so>`{=html},
el cual es mayor o igual a la sumatoria Obligatorio, si
`<codDocSustento>`{=html} es igual a 41, corresponde a la sumatoria de
las
`<totalImpuestoReembolso>`{=html}20.26`</totalImpuestoReembolso>`{=html}
Numérico Max 14 etiquetas `<impuestoReembolso>`{=html}, el cual es mayor
o igual a la sumatoria

                                                                                                                               105

------------------------------------------------------------------------

                                                                                                                       TIPO DE       LONGITUD /
                                ETIQUETAS O TAGS                                               CARACTER
                                                                                                                       CAMPO          FORMATO

`<totalSinImpuestos>`{=html}120.75`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14

`<importeTotal>`{=html}141.01`</importeTotal>`{=html} Obligatorio
Numérico Max 14 `<impuestosDocSustento>`{=html} Obligatorio - -

`<impuestoDocSustento>`{=html} Obligatorio - - Obligatorio, conforme
`<codImpuestoDocSustento>`{=html}2`</codImpuestoDocSustento>`{=html}
tabla 16 de la Ficha Numérico 1 Técnica Offline Obligatorio, conforme
`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} tabla 17 o 18
de la Ficha Numérico Min 1 Max 4 Técnica Offline
`<baseImponible>`{=html}125.90`</baseImponible>`{=html} Obligatorio
Numérico Max 14 Max 3 enteros `<tarifa>`{=html}12`</tarifa>`{=html}
Obligatorio Numérico y 2 decimales
`<valorImpuesto>`{=html}15.11`</valorImpuesto>`{=html} Obligatorio
Numérico Max 14 `</impuestoDocSustento>`{=html} Obligatorio - -
`</impuestosDocSustento>`{=html} Obligatorio - - `<retenciones>`{=html}
Obligatorio - -

`<retencion>`{=html} Obligatorio - - Obligatorio, conforme
`<codigo >`{=html}1`</codigo>`{=html} tabla 19 de la Ficha Numérico 1
Técnica Offline Obligatorio, conforme
`<codigoRetencion>`{=html}312`</codigoRetencion>`{=html} tabla 20 de la
Ficha Numérico Min 1 Max 5 Técnica Offline
`<baseImponible>`{=html}125.90`</baseImponible>`{=html} Obligatorio
Numérico Max 14 Obligatorio, conforme Min 1 Max 5
`<porcentajeRetener>`{=html}1.75`</porcentajeRetener>`{=html} tabla 20
de la Ficha Numérico entre enteros Técnica Offline y decimales Max 12
`<valorRetenido>`{=html}2.20`</valorRetenido>`{=html} Obligatorio
Numérico enteros y 2 decimales Obligatorio cuando la
`<dividendos>`{=html}15 etiqueta `<codSustento>`{=html} - - es igual a
10 Obligatorio cuando la
`<fechaPagoDiv>`{=html}15/03/2012`</fechaPagoDiv>`{=html} etiqueta
`<codSustento>`{=html} Fecha dd/mm/aaaa es igual a 10 Obligatorio cuando
la Max 14 `<imRentaSoc>`{=html}102.54`</imRentaSoc>`{=html} etiqueta
`<codSustento>`{=html} Numérico enteros y 2 es igual a 10 decimales
Obligatorio cuando la
`<ejerFisUtDiv>`{=html}2012`</ejerFisUtDiv>`{=html} etiqueta
`<codSustento>`{=html} Numérico 4 es igual a 10 Obligatorio cuando la
`</dividendos>`{=html} etiqueta `<codSustento>`{=html} - - es igual a 10
Obligatorio cuando `<compraCajBanano>`{=html} - - corresponda
Obligatorio cuando corresponda. Debe desplegarse solamente en el caso de
que el `<numCajBan>`{=html}2012`</numCajBan>`{=html} Numérico Max 7
enteros campo `<codigoRetencion>`{=html} sea igual a 338, 340, 341 y
342; 342A; 342B

15 Para efectos tributarios, se considerarán dividendos y tendrán el
mismo tratamiento tributario todo tipo de participaciones en utilidades,

excedentes, beneficios o similares que se obtienen en razón de los
derechos representativos de capital que el beneficiario mantiene, de
manera directa o indirecta.

                                                                                                                                          106

------------------------------------------------------------------------

                                                                                                       TIPO DE     LONGITUD /
                            ETIQUETAS O TAGS                                       CARACTER
                                                                                                       CAMPO        FORMATO
                                                                                Obligatorio cuando
                                                                               corresponda. Debe
                                                                             desplegarse solamente
                                                                                                                     Max 12
                                                                               en el caso de que el

`<precCajBan>`{=html}2012`</precCajBan>`{=html} Numérico enteros y 2
campo decimales `<codigoRetencion>`{=html} sea igual a 338, 340, 341 y
342; 342A; 342B Obligatorio cuando `</compraCajBanano>`{=html} - -
corresponda `</retencion>`{=html} Obligatorio - -
`</retenciones>`{=html} Obligatorio - - Obligatorio cuando
`<reembolsos>`{=html} `<codDocSustento>`{=html} sea - - igual a 41
`<reembolsoDetalle>`{=html} Obligatorio - - Obligatorio cuando
`<codDocSustento>`{=html} sea
`<tipoIdentificacionProveedorReembolso>`{=html}04`</tipoIdentificacionProveedorReembols
                                                                              igual a 41, conforme tabla Numérico       2
o>`{=html} 6 de la Ficha Técnica Offline Obligatorio cuando
`<identificacionProveedorReembolso>`{=html}1760013210001`</identificacionProveedorRee
                                                                                <codDocSustento>`{=html}
sea Alfanumérico Max 20 mbolso\> igual a 41 Obligatorio cuando
`<codDocSustento>`{=html} sea
`<codPaisPagoProveedorReembolso>`{=html}212`</codPaisPagoProveedorReembolso>`{=html}
igual a 41, conforme la Numérico 3 tabla 25 de la Ficha Técnica Offline
Obligatorio cuando `<codDocSustento>`{=html} sea
`<tipoProveedorReembolso>`{=html}01`</tipoProveedorReembolso>`{=html}
igual a 41, conforme tabla Numérico 2 26 de la Ficha Técnica Offline
Obligatorio cuando `<codDocSustento>`{=html} sea
`<codDocReembolso>`{=html}01`</codDocReembolso >`{=html} igual a 41,
validar Numérico 2 conforme tabla 4 del Catálogo ATS Obligatorio cuando
`<estabDocReembolso>`{=html}001`</estabDocReembolso>`{=html}
`<codDocSustento>`{=html} sea Numérico 3 igual a 41 Obligatorio cuando
`<ptoEmiDocReembolso>`{=html}501`</ptoEmiDocReembolso>`{=html}
`<codDocSustento>`{=html} sea Numérico 3 igual a 41 Obligatorio cuando
`<secuencialDocReembolso>`{=html}000000008`</secuencialDocReembolso>`{=html}
`<codDocSustento>`{=html} sea Numérico 9 igual a 41 Obligatorio cuando
`<fechaEmisionDocReembolso>`{=html}04/03/2013`</fechaEmisionDocReembolso>`{=html}
`<codDocSustento>`{=html} sea Fecha dd/mm/aaaa igual a 41 Obligatorio
cuando
`<numeroAutorizacionDocReemb>`{=html}040320130117922611040011001501000000008
`<codDocSustento>`{=html} sea Numérico 10 o 37 o 49
1234567816`</numeroAutorizacionDocReemb >`{=html} igual a 41 Obligatorio
cuando `<detalleImpuestos>`{=html} `<codDocSustento>`{=html} sea - -
igual a 41 Obligatorio cuando `<detalleImpuesto>`{=html}
`<codDocSustento>`{=html} sea - - igual a 41 Obligatorio cuando
`<codDocSustento>`{=html} sea `<codigo>`{=html}2`</codigo>`{=html}
Numérico 1 igual a 41, tabla 16 de la Ficha Técnica Offline Obligatorio
cuando `<codDocSustento>`{=html} sea
`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} igual a 41,
conforme tabla Numérico Min 1 Max 4 17 o 18 de la Ficha Técnica Offline

                                                                                                                        107

------------------------------------------------------------------------

                                                                                                 TIPO DE      LONGITUD /
                            ETIQUETAS O TAGS                            CARACTER
                                                                                                 CAMPO         FORMATO
                                                                     Obligatorio cuando

`<tarifa>`{=html}12`</tarifa>`{=html} `<codDocSustento>`{=html} sea
Numérico Min 1 Max 4 igual a 41 Obligatorio cuando
`<baseImponibleReembolso>`{=html}125.90`</baseImponibleReembolso>`{=html}
`<codDocSustento>`{=html} sea Numérico Max 14 igual a 41 Obligatorio
cuando `<impuestoReembolso>`{=html}15.11`</impuestoReembolso >`{=html}
`<codDocSustento>`{=html} sea Numérico Max 14 igual a 41 Obligatorio
cuando `</detalleimpuesto>`{=html} `<codDocSustento>`{=html} sea - -
igual a 41 Obligatorio cuando `<detalleImpuesto>`{=html}
`<codDocSustento>`{=html} sea - - igual a 41 Obligatorio cuando
`<codDocSustento>`{=html} sea `<codigo>`{=html}3`</codigo>`{=html}
Numérico 1 igual a 41, tabla 16 de la Ficha Técnica Offline Obligatorio
cuando `<codDocSustento>`{=html} sea
`<codigoPorcentaje>`{=html}3011`</codigoPorcentaje>`{=html} igual a 41,
conforme tabla Numérico Min 1 Max 4 17 o 18 de la Ficha Técnica Offline
Obligatorio cuando `<tarifa>`{=html}0`</tarifa>`{=html}
`<codDocSustento>`{=html} sea Numérico Min 1 Max 4 igual a 41
Obligatorio cuando
`<baseImponibleReembolso>`{=html}0.00`</baseImponibleReembolso>`{=html}
`<codDocSustento>`{=html} sea Numérico Max 14 igual a 41 Obligatorio
cuando `<impuestoReembolso>`{=html}5.15`</impuestoReembolso>`{=html}
`<codDocSustento>`{=html} sea Numérico Max 14 igual a 41 Obligatorio
cuando `</detalleImpuesto>`{=html} `<codDocSustento>`{=html} sea - -
igual a 41 Obligatorio cuando `</detalleImpuestos>`{=html}
`<codDocSustento>`{=html} sea - - igual a 41
`</reembolsoDetalle>`{=html} Obligatorio - - Obligatorio cuando
`</reembolsos>`{=html} `<codDocSustento>`{=html} sea - - igual a 41
`<pagos>`{=html} Obligatorio - - `<pago>`{=html} Obligatorio - -
Obligatorio, conforme `<formapago>`{=html}01`</formapago>`{=html} tabla
13 del Catálogo Numérico 2 ATS `<total>`{=html}500`</total>`{=html}
Obligatorio Numérico Max 14 `</pago>`{=html} Obligatorio - -
`</pagos>`{=html} Obligatorio - - `</docSustento>`{=html}
Obligatorio - - `</docsSustento>`{=html} Obligatorio - -
`<infoAdicional>`{=html} Opcional - - \<campoAdicional Opcional
Alfanumérico 1
nombre="valorpagadoIRsociedaddividendos"\>2000`</campoAdicional>`{=html}
`</infoAdicional>`{=html} Opcional Numérico Min 1 Max 4
`</comprobanteRetencion>`{=html} Obligatorio Numérico Min 1 Max 4

Para registrar los códigos a utilizar, se recomienda revisar las tablas
del catálogo de Anexo Transaccional Simplificado (ATS), publicado en la
página web www.sri.gob.ec: Información sobre impuestos/Cómo declaro mis
impuestos? /

                                                                                                                  108

------------------------------------------------------------------------

Anexos y guías o directamente a través del siguiente link:
http://www.sri.gob.ec/web/guest/formularios-e-instructivos1

Nota: El formato RIDE del comprobante de retención corresponderá al
publicado para la versión 1.0.0.

ANEXO 11 -- REQUISITOS OBLIGATORIOS PARA EL XML DE FACTURA COMERCIAL
NEGOCIABLE Las facturas electrónicas comerciales negociables deberán
contener la siguiente información en la estructura del XML; caso
contrario no podrán ser generadas como negociables:

1.    Dirección comprador:

        <direccionComprador>salinas y santiago</direccionComprador>

2.    Formas de pago:

        <pagos>
             <pago>
              <formaPago>21</formaPago>
              <total>56,00</total>
              <plazo>30</plazo>
              <unidadTiempo>dias</unidadTiempo>
        </pago>
        </pagos>

Para más información respecto a Factura Electrónica Comercial
Negociable, ingrese al siguiente link:
http://www.sri.gob.ec/web/guest/facturacion-
electronica#informaci%C3%B3n

Únicamente para aquellos contribuyentes que se dedican a la negociación
de facturas electrónicas y que requieran realizar la notificación masiva
de las facturas mediante el servicio expuesto en el portal web en la
opción de Comprobantes Electrónicos / Ambientes Pruebas o Producción /
Factura Comercial Negociable, deberán incluir obligatoriamente en la
estructura del archivo XML entre los tags `</detalles>`{=html} e
`<infoAdicional>`{=html} previa autorización del comprobante, la
dirección de correo electrónico del receptor, en los siguientes campos:

     <tipoNegociable>
        <correo>controldecalidad@sriprueba.ad</correo>
     </tipoNegociable>

Si la notificación de las facturas comerciales negociables es de manera
individual, no se registrará la información mencionada.

                                                                                 109

------------------------------------------------------------------------

ANEXO 12 -- REQUISITO OBLIGATORIO PARA EL XML DE FACTURA EN VENTA DE
COMBUSTIBLES LÍQUIDOS DERIVADOS DE HIDROCARBUROS Y BIOCOMBUSTIBLES. Las
facturas electrónicas en venta de combustibles líquidos derivados de
hidrocarburos (CLDH) y biocombustibles deberán contener el tag placa en
la estructura del XML, esto entre los tags `<moneda>`{=html} y formas de
pago para las versiones 1.0.0, 1.1.0, 2.0.0, 2.1.0;

1.     Placa

`<moneda>`{=html}DOLAR`</moneda>`{=html}
`<placa>`{=html}PCM4567`</placa>`{=html} `<pagos>`{=html}

Para mayor información respecto a facturas para ventas de combustibles
líquidos derivados de hidrocarburos y biocombustibles, ingrese al
siguiente link:
http://www.sri.gob.ec/web/guest/facturacion-electronica#informaci%C3%B3n

2.     Llenado del campo Placa

El campo `<placa>`{=html} deberá llenarse considerando las siguientes
especificaciones, según lo dispuesto por el organismo regulador16:

TABLA 29: FORMATO DE LLENADO DEL CAMPO PLACA

                                                                         Campo

Caso Descripción Observaciones `<placa>`{=html} Se deberá ingresar las
letras y 1 Vehículo automotor de transporte terrestre `<ABC1234>`{=html}
números sin ningún espacio Si existen solo tres dígitos se 2 Vehículo
automotor de transporte terrestre `<ABC0123>`{=html} deberá anteponer el
cero sin ningún espacio Las letras "CU" seguido de la parte 3 Cuantía
doméstica `<CU104634>`{=html} numérica de la autorización de la cuantía
doméstica Personas naturales o jurídicas sin vehículo que Se deberá
ingresar tres letras "Z" y 4 adquieran un volumen de despacho inferior a
5 `<ZZZ9999>`{=html} cuatro números nueves (9) galones en provincias no
fronterizas Personas naturales o jurídicas sin vehículo que Se deberá
ingresar tres letras "Z" y 5 adquieran un volumen de despacho inferior a
3 \< ZZZ9999\> cuatro números nueves (9) galones en frontera Para el
caso de venta de combustible a motos, `<AB023C>`{=html} Se deberá
colocar la placa del 6 vehículos diplomáticos, régimen de internación
`<CD0123>`{=html} vehículo asignada por la Agencia temporal y otros que
tienen placa asignada por `<IT0123>`{=html} Nacional de Transito, tal
como

16 Disposiciones sobre el llenado del campo PLACA dadas a los
distribuidores de combustible por la Agencia de Regulación y Control de

Energía y Recursos Naturales No Renovables mediante Oficio Nro.
ARCERNNR-CTRCH-2024-0014-OF del 10 de enero de 2024.

                                                                                                                                110

------------------------------------------------------------------------

                                                        Campo

Caso Descripción Observaciones `<placa>`{=html} la Agencia Nacional de
Tránsito consta en la matrícula. Para el caso de venta de combustibles a
Se deberá colocar la placa 7 `<ABCD0123>`{=html} vehículos extranjeros.
internacional del vehículo. Para el caso de Equipo Caminero, Maquinaria
Se debe ingresar en el campo placa Pesada y Maquinaria Agrícola que
tengan las Letras MAQN, y seguido del 8 `<MAQN99999>`{=html} matrícula
asignada por el Ministerio de número completo de la matrícula Transporte
y Obras Publicas- MTOP. otorgado por el MTOP.

ANEXO 13 -- REQUISITO OBLIGATORIO PARA XML DE COMPROBANTES EMITIDOS
DESDE UNA MÁQUINA FISCAL Los comprobantes factura, nota de crédito, nota
de débito, guía de remisión y comprobante de retención para todas sus
versiones deberán contener los siguientes tags: marca, modelo y serie en
la estructura del XML como se muestra a continuación:

`</detalles>`{=html} `<maquinaFiscal>`{=html}
`<marca>`{=html}SISPAU`</marca>`{=html}
`<modelo>`{=html}ABC1234`</modelo>`{=html}
`<serie>`{=html}CGMC1405`</serie>`{=html} `</maquinaFiscal>`{=html}
`<infoAdicional>`{=html}

ANEXO 14 -- EJEMPLO FIRMA ELECTRÓNICA BAJO ESTÁNDAR XADES_BES
`<?xml 111escrip=”1.0” encoding=”UTF-8”?>`{=html} \<factura
id="comprobante" 111escrip="1.0.0"\> `<infoTributaria>`{=html}
`<ambiente>`{=html}1`</ambiente>`{=html}
`<tipoEmision>`{=html}1`</tipoEmision>`{=html}
`<razonSocial>`{=html}SERVICIO DE RENTAS INTERNAS`</razonSocial>`{=html}
`<nombreComercial>`{=html}LE HACE BIEN AL
PAIS`</nombreComercial>`{=html}
`<ruc>`{=html}1760013210001`</ruc>`{=html}
`<claveAcceso>`{=html}0503201201176001321000110010030009900641234567814`</claveAcceso>`{=html}
`<codDoc>`{=html}01`</codDoc>`{=html}
`<estab>`{=html}001`</estab>`{=html}
`<ptoEmi>`{=html}003`</ptoEmi>`{=html}
`<secuencial>`{=html}000990064`</secuencial>`{=html}
`<dirMatriz>`{=html}AMAZONAS Y ROCA`</dirMatriz>`{=html}
`</infoTributaria>`{=html} `<infoFactura>`{=html}
`<fechaEmision>`{=html}05/03/2012`</fechaEmision>`{=html}
`<dirEstablecimiento>`{=html}SALINAS Y
SANTIAGO`</dirEstablecimiento>`{=html}
`<contribuyenteEspecial>`{=html}12345`</contribuyenteEspecial>`{=html}
`<obligadoContabilidad>`{=html}SI`</obligadoContabilidad>`{=html}
`<tipoIdentificacionComprador>`{=html}05`</tipoIdentificacionComprador>`{=html}
`<razonSocialComprador>`{=html}EGUIGUREN PENARRETA GABRIEL
FERNANDO`</razonSocialComprador>`{=html}
`<identificacionComprador>`{=html}1103029144`</identificacionComprador>`{=html}
`<totalSinImpuestos>`{=html}100.00`</totalSinImpuestos>`{=html}
`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html}

                                                                                                      111

------------------------------------------------------------------------

     <totalConImpuestos>
        <totalImpuesto>
           <112escri>2</112escri>
           <codigoPorcentaje>2</codigoPorcentaje>
           <baseImponible>100.00</baseImponible>
           <valor>12.00</valor>
        </totalImpuesto>
     </totalConImpuestos>
     <propina>0.00</propina>
     <importeTotal>112.00</importeTotal>
     <moneda>DÓLAR</moneda>

`</infoFactura>`{=html} `<detalles>`{=html} `<detalle>`{=html}
`<codigoPrincipal>`{=html}001`</codigoPrincipal>`{=html}
`<codigoAuxiliar>`{=html}001`</codigoAuxiliar>`{=html}
\<112escripción\>SILLA DE MADERA\</112escripción\>
`<cantidad>`{=html}1.00`</cantidad>`{=html}
`<precioUnitario>`{=html}100.00`</precioUnitario>`{=html}
`<descuento>`{=html}0.00`</descuento>`{=html}
`<precioTotalSinImpuesto>`{=html}100.00`</precioTotalSinImpuesto>`{=html}
`<impuestos>`{=html} `<impuesto>`{=html} \<112escri\>2\</112escri\>
`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
`<tarifa>`{=html}12.00`</tarifa>`{=html}
`<baseImponible>`{=html}100.00`</baseImponible>`{=html}
`<valor>`{=html}12.00`</valor>`{=html} `</impuesto>`{=html}
`</impuestos>`{=html} `</detalle>`{=html} `</detalles>`{=html}
`<infoAdicional>`{=html} `<campoAdicional nombre=”Dirección”>`{=html}LOS
PERALES Y AV. ELOY ALFARO`</campoAdicional>`{=html}
`<campoAdicional nombre=”Teléfono”>`{=html}2123123`</campoAdicional>`{=html}
`<campoAdicional nombre=”Email”>`{=html}gfeguiguren@sri.gob.ec`</campoAdicional>`{=html}
`</infoAdicional>`{=html} \<!--INICIO DE LA FIRMA DIGITAL →
`<ds:Signature xmlns:ds=”http://www.w3.org/2000/09/xmldsig#” xmlns:etsi=”http://uri.etsi.org/01903/v1.3.2#”
Id=”Signature620397”>`{=html}
`<ds:SignedInfo Id=”Signature-SignedInfo814463”>`{=html}
\<ds:CanonicalizationMethod
Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-
20010315"\>`</ds:CanonicalizationMethod>`{=html}
`<ds:SignatureMethod Algorithm=”http://www.w3.org/2000/09/xmldsig#rsa-sha1”>`{=html}`</ds:SignatureMethod>`{=html}
\<ds:Reference Id="SignedPropertiesID157683"
Type="http://uri.etsi.org/01903#SignedProperties" URI="#Signature620397-
SignedProperties24123"\>
`<ds:DigestMethod Algorithm=”http://www.w3.org/2000/09/xmldsig#sha1”>`{=html}`</ds:DigestMethod>`{=html}
`<ds:DigestValue>`{=html}\<!--HASH O DIGEST DEL ELEMENTO
`<etsi:SignedProperties>`{=html} →`</ds:DigestValue>`{=html}
`</ds:Reference>`{=html}

`<ds:Reference URI=”#Certificate1562780”>`{=html}
`<ds:DigestMethod Algorithm=”http://www.w3.org/2000/09/xmldsig#sha1”>`{=html}`</ds:DigestMethod>`{=html}
`<ds:DigestValue>`{=html}\<!--HASH O DIGEST DEL CERTIFICADO X509
→`</ds:DigestValue>`{=html} `</ds:Reference>`{=html}
`<ds:Reference Id=”Reference-ID-363558” URI=”#comprobante”>`{=html}
`<ds:Transforms>`{=html}
`<ds:Transform Algorithm=”http://www.w3.org/2000/09/xmldsig#enveloped-signature”>`{=html}`</ds:Transform>`{=html}
`</ds:Transforms>`{=html}
`<ds:DigestMethod Algorithm=”http://www.w3.org/2000/09/xmldsig#sha1”>`{=html}`</ds:DigestMethod>`{=html}
`<ds:DigestValue>`{=html}\<!--HASH O DIGEST DE TODO EL ARCHIVO XML
IDENTIFICADO POR EL id="comprobante"→`</ds:DigestValue>`{=html}
`</ds:Reference>`{=html} `</ds:SignedInfo>`{=html}
`<ds:SignatureValue Id=”SignatureValue398963”>`{=html} \<!--VALOR DE LA
FIRMA (ENCRIPTADO CON LA LLAVE PRIVADA DEL CERTIFICADO DIGITAL) →
`</ds:SignatureValue>`{=html}
`<ds:KeyInfo Id=”Certificate1562780”>`{=html} `<ds:X509Data>`{=html}
`<ds:X509Certificate>`{=html} \<!--CERTIFICADO X509 CODIFICADO EN Base64
→ `</ds:X509Certificate>`{=html} `</ds:X509Data>`{=html}
`<ds:KeyValue>`{=html} `<ds:RSAKeyValue>`{=html} `<ds:Modulus>`{=html}

                                                                                                                  112

------------------------------------------------------------------------

     <!–MODULO DEL CERTIFICADO X509 →

`</ds:Modulus>`{=html} `<ds:Exponent>`{=html}AQAB`</ds:Exponent>`{=html}
`</ds:RSAKeyValue>`{=html} `</ds:KeyValue>`{=html}
`</ds:KeyInfo>`{=html}
`<ds:Object Id=”Signature620397-Object231987”>`{=html}`<etsi:QualifyingProperties
Target=”#Signature620397”>`{=html}\<etsi:SignedProperties
Id="Signature620397-
SignedProperties24123"\>`<etsi:SignedSignatureProperties>`{=html}`<etsi:SigningTime>`{=html}2012-03-05T16:57:32-
05:00`</etsi:SigningTime>`{=html}`<etsi:SigningCertificate>`{=html}`<etsi:Cert>`{=html}`<etsi:CertDigest>`{=html}`<ds:DigestMethod
Algorithm=”http://www.w3.org/2000/09/xmldsig#sha1”>`{=html}`</ds:DigestMethod>`{=html}`<ds:DigestValue>`{=html}xUQewsj7MrjSfyMnhWz5DhQn
WJM=`</ds:DigestValue>`{=html}`</etsi:CertDigest>`{=html}`<etsi:IssuerSerial>`{=html}`<ds:X509IssuerName>`{=html}CN=AC
BANCO CENTRAL DEL ECUADOR,L=QUITO,OU=ENTIDAD DE CERTIFICACION DE
INFORMACION-ECIBCE,O=BANCO CENTRAL DEL
ECUADOR,C=EC`</ds:X509IssuerName>`{=html}`<ds:X509SerialNumber>`{=html}1312833444`</ds:X509SerialNumber>`{=html}`</etsi:IssuerSerial>`{=html}\</
etsi:Cert\>`</etsi:SigningCertificate>`{=html}`</etsi:SignedSignatureProperties>`{=html}`<etsi:SignedDataObjectProperties>`{=html}`<etsi:DataObjectFor
mat ObjectReference=”#Reference-ID-363558”>`{=html}`<etsi:Description>`{=html}contenido
comprobante`</etsi:Description>`{=html}`<etsi:MimeType>`{=html}text/xml`</etsi:MimeType>`{=html}`</etsi:DataObjectFormat>`{=html}`</etsi:SignedDataObject
Properties>`{=html}`</etsi:SignedProperties>`{=html}`</etsi:QualifyingProperties>`{=html}`</ds:Object>`{=html}
`</ds:Signature>`{=html} \<!--FIN DE LA FIRMA DIGITAL →
`</factura>`{=html}

Nota: Los archivos XML de comprobantes electrónicos se encuentran
disponibles en el portal web del SRI.

ANEXO 15 -- COMPATIBILIDAD DISPOSITIVOS PROVISTOS BANCO CENTRAL DEL
ECUADOR

                    Windows          Windows          Red Hat Enterprise           Ubuntu         MAC OS X
                       XP,             Vista,                 5.4                   8.0.x        LION (10.7)
                     Vista, 7            7            (32-bit and 64-bit)           9.0.x
                    (32-bits)        (64-bits)          en kernel 2.6

                                                          CentOS 5.4
                                                      (32-bit and 64-bit)
                                                        en kernel 2.6

                                                    SUSE Linux Enterprise
                                                     11 (32-bit) en kernel
                                                              2.6

                                                      Fedora 12 (32-bit)

                                                     Ubuntu 10.04 (32-bit
                                                     and 64 bit) en kernel
                                                              2.6
    Ikey2032            ✓                ✓                      ×                     ✓                ×
                     (A) (1)          (B) (2)                                      (D) (3)
    Aladin              ✓                ✓                      ✓                     ×               ✓
    etoken PRO       (A) (1)          (B) (2)                (C) (3)                                (E) (5)

• Driver SafeNet AuthenticationClient-x32-8.00.msi provisto por la
página web del B.C.E.

• Driver SafeNet AuthenticationClient-x64-8.00.msi provisto por la
página web del B.C.E.

                                                                                                                    113

------------------------------------------------------------------------

• Driver SafeNetAuthenticationClient_Linux_v8.0.zip provisto por la
página web del B.C.E.

• Driver BSecPKLinux-2.0.0.0007.zip provisto por la página web del
B.C.E.

• Driver eToken_PKI_Client_4_55_Mac.zip provisto por la página web del
B.C.E.

(1) Requiere tener instalado el JRE de java versión 6.x (Java SE 6
    Update 26 o superior)

(2) Requiere tener instalado el JRE de java versión 7.x (Java SE 7u3)

(3) Requiere tener instalada el JRE SE 6.x respectivo a la versión que
    corresponda de Linux

(4) Requiere tener instalada el Java SE 6 correspondiente al MAC OS

ANEXO 16 -- REQUISITO OBLIGATORIO DE LLENADO PARA EL XML DE FACTURA EN
LA VENTA DE COMBUSTIBLES LÍQUIDOS DERIVADOS DE HIDROCARBUROS Y
BIOCOMBUSTIBLES. En la emisión del comprobante de venta tipo factura
realizados por la venta de combustibles líquidos derivados de
hidrocarburos (CLDH) y biocombustibles, en la sección
`<detalles>`{=html}, para el llenado de los campos
`<codigoPrincipal>`{=html} y `<descripción>`{=html} se deberán
considerar la información del combustible conforme al siguiente detalle:

TABLA 30

                                       <codigoPrincipal>            <Descripción>

                                                0103                    SÚPER

                                                0101                    EXTRA

                                                0174            EXTRA CON ETANOL

                                                0121              DIESEL PREMIUM

                                                0104                   DIESEL 2

    *De conformidad con el Oficio Nro. ARCERNNR-CTRCH-2024-0014-OF emitido por la Agencia de Regulación y Control de Energía y
                                                 Recursos Naturales No Renovables


                                                                                                                           114

------------------------------------------------------------------------

    ANEXO 17 – FORMATOS XML LIQUIDACIÓN
    DE COMPRA DE BIENES Y PRESTACIÓN DE
    SERVICIOS EN LAS VERSIONES 1.0.0 Y 1.1.0
    LIQUIDACIÓN DE COMPRA DE BIENES Y PRESTACIÓN DE
    SERVICIOS VERSIÓN 1.0.0
                                                                                                       TIPO DE      LONGITUD /
                           ETIQUETAS O TAGS                                 CARACTER
                                                                                                       CAMPO         FORMATO

```{=html}
<?xml version="1.0" encoding="UTF-8"?>
```
Obligatorio - -
`<liquidacionCompra id="comprobante" versión="1.0.0">`{=html}
Obligatorio - - `<infoTributaria>`{=html} Obligatorio - - Obligatorio,
conforme tabla 4 `<ambiente>`{=html}1`</ambiente>`{=html} Numérico 1 de
la Ficha Técnica Offline Obligatorio, conforme tabla 2
`<tipoEmision>`{=html}1`</tipoEmision>`{=html} Numérico 1 de la Ficha
Técnica Offline
`<razonSocial>`{=html}razonSocial0`</razonSocial>`{=html} Obligatorio
Alfanumérico Max 300
`<nombreComercial>`{=html}nombreComercial0`</nombreComercial>`{=html}
Opcional Alfanumérico Max 300 `<ruc>`{=html}0000000000001`</ruc>`{=html}
Obligatorio Numérico 13
`<claveAcceso>`{=html}0000000000000000000000000000000000000000000000000\<
Obligatorio Numérico 49 /claveAcceso\> Obligatorio, conforme tabla 4
`<codDoc>`{=html}03`</codDoc>`{=html} de la Catálogo Técnica Anexo
Numérico 2 ATS `<estab>`{=html}000`</estab>`{=html} Obligatorio Numérico
3 `<ptoEmi>`{=html}000`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000000`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}dirMatriz0`</dirMatriz>`{=html}
Obligatorio Alfanumérico Max 300 `</infoTributaria>`{=html}
Obligatorio - - -`<infoLiquidacionCompra>`{=html} Obligatorio - -
`<fechaEmision>`{=html}01/01/2000`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa
`<dirEstablecimiento>`{=html}dirEstablecimiento0`</dirEstablecimiento>`{=html}
Opcional Alfanumérico Max 300
`<contribuyenteEspecial>`{=html}contribuyente`</contribuyenteEspecial>`{=html}
Opcional Alfanumérico Min 3 Max 13
`<obligadoContabilidad>`{=html}SI`</obligadoContabilidad>`{=html}
Opcional Texto SI/NO Opcional conforme tabla 6 de la
`<tipoIdentificacionProveedor>`{=html}05`</tipoIdentificacionProveedor>`{=html}
Numérico 2 Ficha Técnica Offline `<razonSocialProveedor>`{=html}EMPRESA
ABC`</razonSocialComprador>`{=html} Obligatorio Alfanumérico Max 300
`<identificacionProveedor>`{=html}1794567890001`</identificacionProveedor>`{=html}
Obligatorio Alfanumérico 20
`<direccionProveedor>`{=html}direccionComprador0`</direccionProveedor>`{=html}
Opcional Alfanumérico Max 300
`<totalSinImpuestos>`{=html}50.00`</totalSinImpuestos>`{=html}
Obligatorio Numérico Max 14
`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} Obligatorio
Numérico Max 14 Obligatorio, si
`<codDocReembolso>`{=html}00`</codDocReembolso>`{=html}
`<codDocReembolso>`{=html} es igual a Numérico Max 2 41. Obligatorio, si
`<codDocReembolso>`{=html} es igual a
`<totalComprobantesReembolso>`{=html}56.00`</totalComprobantesReembolso>`{=html}
41, corresponde a la suma de Numérico Max 14
`<totalBaseImponibleReembolso
                                                                   >`{=html}
y `<totalImpuestoReembolso>`{=html} Obligatorio, si
`<totalBaseImponibleReembolso>`{=html}50.00`</totalBaseImponibleReembolso>`{=html}
Numérico Max 14 `<codDocReembolso>`{=html} es igual a

                                                                                                                         115

------------------------------------------------------------------------

                                                                                              TIPO DE       LONGITUD /
                           ETIQUETAS O TAGS                       CARACTER
                                                                                              CAMPO          FORMATO
                                                          41, corresponde a la suma de
                                                          <BaseImponibleReembolso>
                                                                  Obligatorio, si
                                                         <codDocReembolso> es igual a
                                                         41, corresponde a la sumatoria

`<totalImpuestoReembolso>`{=html}6.00`</totalImpuestoReembolso>`{=html}
Numérico Max 14 de los tags `<impuestoReembolso>`{=html}, el cual es
mayor o igual a la sumatoria. `<totalConImpuestos>`{=html} Obligatorio
`<totalImpuesto>`{=html} Obligatorio Obligatorio, conforme tabla 16
`<codigo>`{=html}2`</codigo>`{=html} Numérico Max 2 de la Ficha Técnica
Offline Obligatorio, conforme tabla 17
`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} Numérico Max 2
de la Ficha Técnica Offline
`<descuentoAdicional>`{=html}0.00`</descuentoAdicional>`{=html} Opcional
Numérico Max 14 `<baseImponible>`{=html}50.00`</baseImponible>`{=html}
Obligatorio Numérico Max 14 Min 1 Max 4 / 2
`<tarifa>`{=html}12`</tarifa>`{=html} Obligatorio Numérico enteros, 2
decimales `<valor>`{=html}6.00`</valor>`{=html} Obligatorio Numérico Max
14 `</totalImpuesto>`{=html} Obligatorio - -
`</totalConImpuestos>`{=html} Obligatorio - - Obligatorio corresponde a
la `<importeTotal>`{=html}56.00`</importeTotal>`{=html} sumatoria de
bases imponibles Numérico Max 14 e impuestos.
`<moneda>`{=html}moneda0`</moneda>`{=html} Obligatorio Alfanumérico Max
14 `<pagos>`{=html} Obligatorio `<pago>`{=html} Obligatorio Obligatorio.
Conforme tabla 24 `<formaPago>`{=html}01`</formaPago>`{=html} Numérico
Max 2 de la Ficha Técnica Offline `<total>`{=html}56.00`</total>`{=html}
Obligatorio Numérico Max 14 `<plazo>`{=html}30`</plazo>`{=html}
Obligatorio Numérico Max 14
`<unidadTiempo>`{=html}unidadTiem`</unidadTiempo>`{=html} Opcional Texto
Max 10 `</pago>`{=html} `</pagos>`{=html} Obligatorio - -
`</infoLiquidacionCompra>`{=html} Obligatorio - - `<detalles>`{=html}
Obligatorio - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}codigoPrincipal0`</codigoPrincipal>`{=html}
Obligatorio Alfanumérico Max 25
`<codigoAuxiliar>`{=html}codigoAuxiliar0`</codigoAuxiliar>`{=html}
Opcional Alfanumérico Max 25
`<descripcion>`{=html}descripcion0`</descripcion>`{=html} Obligatorio
Alfanumérico Max 300
`<unidadMedida>`{=html}unidadMedida0`</unidadMedida>`{=html} Opcional
Alfanumérico Max 50 `<cantidad>`{=html}1`</cantidad>`{=html} Obligatorio
Numérico Max 14 `<precioUnitario>`{=html}50.00`</precioUnitario>`{=html}
Obligatorio Numérico Max 14
`<descuento>`{=html}0.00`</descuento>`{=html} Opcional Numérico Max 14
Obligatorio, debe multiplicar el
`<precioTotalSinImpuesto>`{=html}50.00`</precioTotalSinImpuesto>`{=html}
Numérico Max 14 campo precio por cantidad `<detallesAdicionales>`{=html}
Opcional - - `<detAdicional nombre="nombre0" valor="valor0"/>`{=html}
Opcional Alfanumérico Max 300
`<detAdicional nombre="nombre1" valor="valor1"/>`{=html} Opcional
Alfanumérico Max 300 `</detallesAdicionales>`{=html} Opcional - -

                                                                                                                 116

------------------------------------------------------------------------

                                                                                                              TIPO DE     LONGITUD /
                           ETIQUETAS O TAGS                                         CARACTER
                                                                                                              CAMPO        FORMATO

`<impuestos>`{=html} Obligatorio - - `<impuesto>`{=html} Obligatorio - -
Obligatorio, conforme tabla 16 `<codigo>`{=html}2`</codigo>`{=html}
Numérico Max 2 de la Ficha Técnica Offline Obligatorio, conforme tabla
17 `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} Numérico Max
2 de la Ficha Técnica Offline Min 1 Max 4 / 2
`<tarifa>`{=html}12`</tarifa>`{=html} Obligatorio Numérico enteros, 2
decimales `<baseImponible>`{=html}50.00`</baseImponible>`{=html}
Obligatorio Numérico Max 14 `<valor>`{=html}6.00`</valor>`{=html}
Obligatorio Numérico Max 14 `</impuesto>`{=html} Obligatorio - -
`</impuestos>`{=html} Obligatorio - - `</detalle>`{=html}
Obligatorio - - `</detalles>`{=html} Obligatorio - - Obligatorio cuando
`<reembolsos>`{=html} `<codDocReembolso>`{=html} sea igual - - a 41
Obligatorio cuando `<reembolsoDetalle>`{=html}
`<codDocReembolso>`{=html} sea igual - - a 41 Obligatorio cuando
`<codDocReembolso>`{=html} sea igual
`<tipoIdentificacionProveedorReembolso>`{=html}04`</tipoIdentificacionProveedorRee                 a 41
                                                                                                              Numérico       Max 2
mbolso>`{=html} Validar código de tipo de identificación conforme tabla
6 de la Ficha Técnica Offline Obligatorio cuando
`<codDocReembolso>`{=html} sea igual
`<identificacionProveedorReembolso>`{=html}identificacionProvee`</identificacionPro                a 41
                                                                                                              Numérico       Max 20
veedorReembolso>`{=html} Validar código de tipo de identificación
conforme tabla 26 de la Ficha Técnica Offline Obligatorio cuando
`<codDocReembolso>`{=html} sea igual
`<codPaisPagoProveedorReembolso>`{=html}000`</codPaisPagoProveedorReembolso>`{=html}
a 41 Numérico Max 3 Validar de acuerdo tabla 25 de la Ficha Técnica
Offline Obligatorio cuando `<codDocReembolso>`{=html} sea igual
`<tipoProveedorReembolso>`{=html}01`</tipoProveedorReembolso>`{=html}
Numérico Max 2 a 41, Validar con tabla 26 de la Ficha Técnica Offline
Obligatorio cuando `<codDocReembolso>`{=html} sea igual
`<codDocReembolso>`{=html}00`</codDocReembolso>`{=html} Numérico Max 3 a
41, Validar tabla 4 de Catálogo Anexo ATS Obligatorio cuando
`<estabDocReembolso>`{=html}000`</estabDocReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Numérico Max 3 a 41. Obligatorio
cuando `<ptoEmiDocReembolso>`{=html}000`</ptoEmiDocReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Numérico Max 3 a 41 Obligatorio
cuando
`<secuencialDocReembolso>`{=html}000000000`</secuencialDocReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Numérico Max 9 a 41 Obligatorio
cuando
`<fechaEmisionDocReembolso>`{=html}01/01/2000`</fechaEmisionDocReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Fecha dd/mm/aaaa a 41 Obligatorio
cuando
`<numeroautorizacionDocReemb>`{=html}0000000000`</numeroautorizacionDocRee
                                                                           <codDocReembolso>`{=html}
sea igual Numérico Max 10, 37 ó 49 mb\> a 41

                                                                                                                               117

------------------------------------------------------------------------

                                                                                                       TIPO DE       LONGITUD /
                          ETIQUETAS O TAGS                                   CARACTER
                                                                                                       CAMPO          FORMATO
                                                                          Obligatorio cuando

`<detalleImpuestos>`{=html} `<codDocReembolso>`{=html} sea igual - - a
41 Obligatorio cuando `<detalleImpuesto>`{=html}
`<codDocReembolso>`{=html} sea igual - - a 41 Obligatorio cuando
`<codDocReembolso>`{=html} sea igual
`<codigo>`{=html}2`</codigo>`{=html} Numérico Max 2 a 41. Conforme tabla
16 de la Ficha Técnica Offline Obligatorio cuando
`<codDocReembolso>`{=html} sea igual
`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} Numérico Max 2
a 41, conforme tabla 17 de la Ficha Técnica Offline Obligatorio cuando
`<codDocReembolso>`{=html} sea igual Min 1 Max 4 / 2
`<tarifa>`{=html}12`</tarifa>`{=html} Numérico enteros, 2 a 41, conforme
tabla 17 de la decimales Ficha Técnica Offline Obligatorio cuando
`<baseImponibleReembolso>`{=html}50.00`</baseImponibleReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Numérico Max 14 a 41 Obligatorio
cuando `<impuestoReembolso>`{=html}50.00`</impuestoReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Numérico Max 14 a 41 Obligatorio
cuando `</detalleImpuesto>`{=html} `<codDocReembolso>`{=html} sea
igual - - a 41 Obligatorio cuando `</detalleImpuestos>`{=html}
`<codDocReembolso>`{=html} sea igual - - a 41 Obligatorio cuando
`</reembolsoDetalle>`{=html} `<codDocReembolso>`{=html} sea igual - - a
41 Obligatorio cuando `</reembolsos>`{=html} `<codDocReembolso>`{=html}
sea igual - - a 41 Obligatorio cuando `<maquinaFiscal>`{=html} - -
corresponda Obligatorio cuando `<marca>`{=html}SISPAU`</marca>`{=html}
Alfanumérico Min 1 Max 100 corresponda Obligatorio cuando
`<modelo>`{=html}ABC1234`</modelo>`{=html} Alfanumérico Min 1 Max 100
corresponda Obligatorio cuando `<serie>`{=html}CGMC1405`</serie>`{=html}
Alfanumérico Max 30 corresponda Obligatorio cuando
`</maquinaFiscal>`{=html} - - corresponda `<infoAdicional>`{=html}
Opcional - -
`<campoAdicional nombre="nombre4">`{=html}campoAdicional0`</campoAdicional>`{=html}
Opcional Alfanumérico Max 300
`<campoAdicional nombre="nombre5">`{=html}campoAdicional1`</campoAdicional>`{=html}
Opcional Alfanumérico Max 300 `</infoAdicional>`{=html} Opcional - -

                                                                                                                          118

------------------------------------------------------------------------

    LIQUIDACIÓN DE COMPRA DE BIENES Y PRESTACIÓN DE
    SERVICIOS VERSIÓN 1.1.0
    En esta versión se podrá utilizar de 2 a 6 decimales en los campos de cantidad y
    precio unitario para contribuyentes que lo requieran.

                                                                                                       TIPO DE      LONGITUD /
                           ETIQUETAS O TAGS                                 CARACTER
                                                                                                       CAMPO         FORMATO

```{=html}
<?xml version="1.1.0" encoding="UTF-8"?>
```
Obligatorio - -
`<liquidacionCompra id="comprobante" versión=”1.1.0”>`{=html}
Obligatorio - - `<infoTributaria>`{=html} Obligatorio - - Obligatorio,
conforme tabla 4 `<ambiente>`{=html}1`</ambiente>`{=html} Numérico 1 de
la Ficha Técnica Offline Obligatorio, conforme tabla 2
`<tipoEmision>`{=html}1`</tipoEmision>`{=html} Numérico 1 de la Ficha
Técnica Offline
`<razonSocial>`{=html}razonSocial0`</razonSocial>`{=html} Obligatorio
Alfanumérico Max 300
`<nombreComercial>`{=html}nombreComercial0`</nombreComercial>`{=html}
Opcional Alfanumérico Max 300 `<ruc>`{=html}0000000000001`</ruc>`{=html}
Obligatorio Numérico 13
`<claveAcceso>`{=html}0000000000000000000000000000000000000000000000000\</
Obligatorio Numérico 49 claveAcceso\> Obligatorio, conforme tabla 4
`<codDoc>`{=html}03`</codDoc>`{=html} Numérico 2 del Catálogo ATS
`<estab>`{=html}000`</estab>`{=html} Obligatorio Numérico 3
`<ptoEmi>`{=html}000`</ptoEmi>`{=html} Obligatorio Numérico 3
`<secuencial>`{=html}000000000`</secuencial>`{=html} Obligatorio
Numérico 9 `<dirMatriz>`{=html}dirMatriz0`</dirMatriz>`{=html}
Obligatorio Alfanumérico Max 300 `</infoTributaria>`{=html}
Obligatorio - - `<infoLiquidacionCompra>`{=html} Obligatorio - -
`<fechaEmision>`{=html}01/01/2000`</fechaEmision>`{=html} Obligatorio
Fecha dd/mm/aaaa
`<dirEstablecimiento>`{=html}dirEstablecimiento0`</dirEstablecimiento>`{=html}
Opcional Alfanumérico Max 300
`<contribuyenteEspecial>`{=html}contribuyente`</contribuyenteEspecial>`{=html}
Opcional Alfanumérico Min 3 Max 13
`<obligadoContabilidad>`{=html}SI`</obligadoContabilidad>`{=html}
Opcional Texto SI/NO Opcional conforme tabla 6 de la
`<tipoIdentificacionProveedor>`{=html}05`</tipoIdentificacionProveedor>`{=html}
Numérico 2 Ficha Técnica Offline `<razonSocialProveedor>`{=html}EMPRESA
ABC`</razonSocialProveedor>`{=html} Obligatorio Alfanumérico Max 300
`<identificacionProveedor>`{=html}1750863147`</identificacionProveedor>`{=html}
Obligatorio Alfanumérico Max 20
`<direccionProveedor>`{=html}direccionProveedor`</direccionProveedor>`{=html}
Opcional Alfanumérico Max 300 Obligatorio conforme sumatoria
`<totalSinImpuestos>`{=html}50.00`</totalSinImpuestos>`{=html} de bases
imponibles de Numérico Max 14 Detalles. Opcional conforme sumatoria
`<totalDescuento>`{=html}0.00`</totalDescuento>`{=html} de campos
descuentos de Numérico Max 14 Detalles. Obligatorio, si
`<codDocReembolso>`{=html}00`</codDocReembolso>`{=html}
`<codDocReembolso>`{=html} es igual a Numérico Max 2 41. Obligatorio, si
`<codDocReembolso>`{=html} es igual a
`<totalComprobantesReembolso>`{=html}56.00`</totalComprobantesReembolso>`{=html}
41, corresponde a la suma de Numérico Max 14
`<totalBaseImponibleReembolso
                                                                   >`{=html}
y `<totalImpuestoReembolso>`{=html} Obligatorio, si
`<codDocReembolso>`{=html} es igual a
`<totalBaseImponibleReembolso>`{=html}50.00`</totalBaseImponibleReembolso>`{=html}
Numérico Max 14 41, corresponde a la suma de
`<BaseImponibleReembolso>`{=html}

                                                                                                                         119

------------------------------------------------------------------------

                                                                                              TIPO DE       LONGITUD /
                           ETIQUETAS O TAGS                       CARACTER
                                                                                              CAMPO          FORMATO
                                                                  Obligatorio, si
                                                         <codDocReembolso> es igual a
                                                         41, corresponde a la sumatoria

`<totalImpuestoReembolso>`{=html}6.00`</totalImpuestoReembolso>`{=html}
Numérico Max 14 de los tags `<impuestoReembolso>`{=html}, el cual es
mayor o igual a la sumatoria. `<totalConImpuestos>`{=html}
Obligatorio - - `<totalImpuesto>`{=html} Obligatorio - -

                                                         Obligatorio, conforme tabla 16
                                                                                             Numérico          Max 2

`<codigo>`{=html}2`</codigo>`{=html} de la Ficha Técnica Offline

                                                         Obligatorio, conforme tabla 17

`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} Numérico Max 2
de la Ficha Técnica Offline
`<descuentoAdicional>`{=html}0.00`</descuentoAdicional>`{=html} Opcional
Numérico Max 14 `<baseImponible>`{=html}50.00`</baseImponible>`{=html}
Obligatorio Numérico Max 14 Min 1 Max 4 / 2
`<tarifa>`{=html}12`</tarifa>`{=html} Obligatorio Numérico enteros, 2
decimales `<valor>`{=html}6.00`</valor>`{=html} Obligatorio Numérico Max
14 `</totalImpuesto>`{=html} Obligatorio - -
`</totalConImpuestos>`{=html} Obligatorio - - Obligatorio corresponde a
la `<importeTotal>`{=html}56.00`</importeTotal>`{=html} sumatoria de
bases imponibles Numérico Max 14 e impuestos.
`<moneda>`{=html}moneda0`</moneda>`{=html} Obligatorio Alfanumérico Max
14 `<pagos>`{=html} Obligatorio - - `<pago>`{=html} Obligatorio - -
Obligatorio. Conforme tabla 24
`<formaPago>`{=html}01`</formaPago>`{=html} Numérico Max 2 de la Ficha
Técnica Offline `<total>`{=html}56.00`</total>`{=html} Obligatorio
Numérico Max 14 `<plazo>`{=html}30`</plazo>`{=html} Obligatorio Numérico
Max 14 `<unidadTiempo>`{=html}unidadTiem`</unidadTiempo>`{=html}
Opcional Texto Max 10 `</pago>`{=html} Obligatorio - - `</pagos>`{=html}
Obligatorio - - `</infoLiquidacionCompra>`{=html} Obligatorio - -
`<detalles>`{=html} Obligatorio - - `<detalle>`{=html} Obligatorio - -
`<codigoPrincipal>`{=html}codigoPrincipal0`</codigoPrincipal>`{=html}
Obligatorio Alfanumérico Max 25
`<codigoAuxiliar>`{=html}codigoAuxiliar0`</codigoAuxiliar>`{=html}
Opcional Alfanumérico Max 25
`<descripcion>`{=html}descripcion0`</descripcion>`{=html} Obligatorio
Alfanumérico Max 300
`<unidadMedida>`{=html}unidadMedida0`</unidadMedida>`{=html} Opcional
Alfanumérico Max 50 `<cantidad>`{=html}1.000000`</cantidad>`{=html}
Obligatorio Numérico Max 14
`<precioUnitario>`{=html}50.000000`</precioUnitario>`{=html} Obligatorio
Numérico Max 14 `<descuento>`{=html}0.00`</descuento>`{=html} Opcional
Numérico Max 14 Obligatorio, debe multiplicar el
`<precioTotalSinImpuesto>`{=html}50.00`</precioTotalSinImpuesto>`{=html}
Numérico Max 14 campo precio por cantidad `<detallesAdicionales>`{=html}
Opcional - - `<detAdicional nombre="nombre0" valor="valor0" />`{=html}
Opcional Alfanumérico Max 300
`<detAdicional nombre="nombre1" valor="valor1" />`{=html} Opcional
Alfanumérico Max 300 `</detallesAdicionales>`{=html} Opcional - -
`<impuestos>`{=html} Obligatorio - -

                                                                                                                 120

------------------------------------------------------------------------

                                                                                                              TIPO DE     LONGITUD /
                           ETIQUETAS O TAGS                                         CARACTER
                                                                                                              CAMPO        FORMATO

`<impuesto>`{=html} Obligatorio - - Obligatorio, conforme tabla 16
`<codigo>`{=html}2`</codigo>`{=html} Numérico Max 2 de la Ficha Técnica
Offline Obligatorio, conforme tabla 17
`<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html} Numérico Max 2
de la Ficha Técnica Offline Obligatorio cuando
`<codDocReembolso>`{=html} sea igual Min 1 Max 4 / 2
`<tarifa>`{=html}12`</tarifa>`{=html} Numérico enteros, 2 a 41, conforme
tabla 17 de la decimales Ficha Técnica Offline
`<baseImponible>`{=html}50.00`</baseImponible>`{=html} Obligatorio
Numérico Max 14 `<valor>`{=html}6.00`</valor>`{=html} Obligatorio
Numérico Max 14 `</impuesto>`{=html} Obligatorio - -
`</impuestos>`{=html} Obligatorio - - `</detalle>`{=html}
Obligatorio - - `</detalles>`{=html} Obligatorio - - Obligatorio cuando
`<reembolsos>`{=html} `<codDocReembolso>`{=html} sea igual - - a 41
Obligatorio cuando `<reembolsoDetalle>`{=html}
`<codDocReembolso>`{=html} sea igual - - a 41 Obligatorio cuando
`<codDocReembolso>`{=html} sea igual
`<tipoIdentificacionProveedorReembolso>`{=html}04`</tipoIdentificacionProveedorRee                 a 41
                                                                                                              Numérico       Max 2
mbolso>`{=html} Validar código de tipo de identificación conforme tabla
6 de la Ficha Técnica Offline Obligatorio cuando
`<codDocReembolso>`{=html} sea igual
`<identificacionProveedorReembolso>`{=html}identificacionProvee`</identificacionPro                a 41
                                                                                                              Numérico       Max 20
veedorReembolso>`{=html} Validar código de tipo de identificación
conforme tabla 26 de la Ficha Técnica Offline Obligatorio cuando
`<codDocReembolso>`{=html} sea igual
`<codPaisPagoProveedorReembolso>`{=html}000`</codPaisPagoProveedorReembolso>`{=html}
a 41 Numérico Max 3 Validar de acuerdo tabla 25 de la Ficha Técnica
Offline Obligatorio cuando `<codDocReembolso>`{=html} sea igual
`<tipoProveedorReembolso>`{=html}01`</tipoProveedorReembolso>`{=html}
Numérico Max 2 a 41, Validar con tabla 26 de la Ficha Técnica Offline
Obligatorio cuando `<codDocReembolso>`{=html} sea igual
`<codDocReembolso>`{=html}00`</codDocReembolso>`{=html} Numérico Max 3 a
41, Validar tabla 3 de Ficha Técnica Obligatorio cuando
`<estabDocReembolso>`{=html}000`</estabDocReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Numérico Max 3 a 41, conforme tabla
4 Obligatorio cuando
`<ptoEmiDocReembolso>`{=html}000`</ptoEmiDocReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Numérico Max 3 a 41 Obligatorio
cuando
`<secuencialDocReembolso>`{=html}000000000`</secuencialDocReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Numérico Max 9 a 41 Obligatorio
cuando
`<fechaEmisionDocReembolso>`{=html}01/01/2000`</fechaEmisionDocReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Fecha dd/mm/aaaa a 41 Obligatorio
cuando
`<numeroautorizacionDocReemb>`{=html}0000000000`</numeroautorizacionDocRee
                                                                           <codDocReembolso>`{=html}
sea igual Numérico Max 10, 37 ó 49 mb\> a 41

                                                                                                                               121

------------------------------------------------------------------------

                                                                                                       TIPO DE       LONGITUD /
                          ETIQUETAS O TAGS                                   CARACTER
                                                                                                       CAMPO          FORMATO
                                                                          Obligatorio cuando

`<detalleImpuestos>`{=html} `<codDocReembolso>`{=html} sea igual - - a
41 Obligatorio cuando `<detalleImpuesto>`{=html}
`<codDocReembolso>`{=html} sea igual - - a 41 Obligatorio cuando
`<codigo>`{=html}2`</codigo>`{=html} `<codDocReembolso>`{=html} sea
igual Numérico Max 2 a 41 Obligatorio cuando `<codDocReembolso>`{=html}
sea igual `<codigoPorcentaje>`{=html}2`</codigoPorcentaje>`{=html}
Numérico Max 2 a 41, conforme tabla 17 de la Ficha Técnica Offline
Obligatorio, conforme tabla 17 Min 1 Max 4 / 2
`<tarifa>`{=html}12`</tarifa>`{=html} Numérico enteros, 2 de la Ficha
Técnica Offline decimales Obligatorio cuando
`<baseImponibleReembolso>`{=html}50.00`</baseImponibleReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Numérico Max 14 a 41 Obligatorio
cuando `<impuestoReembolso>`{=html}6.00`</impuestoReembolso>`{=html}
`<codDocReembolso>`{=html} sea igual Numérico Max 14 a 41 Obligatorio
cuando `</detalleImpuesto>`{=html} `<codDocReembolso>`{=html} sea
igual - - a 41 Obligatorio cuando `</detalleImpuestos>`{=html}
`<codDocReembolso>`{=html} sea igual - - a 41 Obligatorio cuando
`</reembolsoDetalle>`{=html} `<codDocReembolso>`{=html} sea igual - - a
41 Obligatorio cuando `</reembolsos>`{=html} `<codDocReembolso>`{=html}
sea igual - - a 41 Obligatorio cuando `<maquinaFiscal>`{=html} - -
corresponda Obligatorio cuando `<marca>`{=html}SISPAU`</marca>`{=html}
Alfanumérico Min 1 Max 100 corresponda Obligatorio cuando
`<modelo>`{=html}ABC1234`</modelo>`{=html} Alfanumérico Min 1 Max 100
corresponda Obligatorio cuando `<serie>`{=html}CGMC1405`</serie>`{=html}
Alfanumérico Max 30 corresponda Obligatorio cuando
`</maquinaFiscal>`{=html} - - corresponda `<infoAdicional>`{=html}
Opcional - -
`<campoAdicional nombre="nombre4">`{=html}campoAdicional0`</campoAdicional>`{=html}
Opcional Alfanumérico Max 300
`<campoAdicional nombre="nombre5">`{=html}campoAdicional1`</campoAdicional>`{=html}
Opcional Alfanumérico Max 300 `</infoAdicional>`{=html} Opcional - -
`</liquidacionCompra>`{=html} Obligatorio - -

                                                                                                                          122

------------------------------------------------------------------------

ANEXO 18 -- REQUISITOS OBLIGATORIOS DE LLENADO EN LA FACTURA ELECTRÓNICA
POR LA ENTREGA DE FUNDAS PLÁSTICAS Aplica para establecimientos de
comercio con tres (3) o más establecimientos abiertos y, al
franquiciador y sus franquiciados, independientemente del número de sus
establecimientos que entreguen fundas o bolsas plásticas tipo acarreo o
camiseta al adquiriente o consumidor, para cargar o llevar los productos
adquiridos.

En la emisión del comprobante de venta tipo factura, en la sección
`<detalles>`{=html} para el llenado de los campos `<cantidad>`{=html},
`<codigoPrincipal>`{=html} y `<descripcion>`{=html} se deberá llenar el
número, código y la descripción de las fundas plásticas gravadas con
ICE, como un producto adicional a los vendidos, conforme el siguiente
detalle:

                        <codigoPrin
    <cantidad>                                           <descripcion>                         <precioUnitario>
                           cipal>
                        ICE-FPN-01                    Funda/bolsa plástica
                                       Funda/bolsa plástica con rebaja 50% (aplicable para

Número de fundas o ICE-FPR-02 fundas biodegradables y compostables).
bolsas plásticas tipo 0,00\* camiseta o acarreo. Funda/bolsa plástica
exenta (aplicable para fundas con ICE-FPE-03 un mínimo de adición del
50% de materia prima reciclada post consumo).

(\*) Es importante recalcar que los agentes de percepción del ICE por
concepto de fundas plásticas no deberán establecer un precio de venta al
público sugerido para este bien, salvo que lo tuvieren.

El ICE corresponderá a la tarifa específica vigente multiplicada por la
cantidad. (Ver Tabla 18 -- TARIFA DEL ICE).

El valor del ICE formará parte de la base imponible del IVA de
conformidad con el artículo 58 de la Ley de Régimen Tributario Interno.

                              Ejemplo de la estructura XML:


                                                                                                            123

------------------------------------------------------------------------

ANEXO 19 -- APLICACIÓN DE LAS AUTORRETENCIONES En el llenado del
comprobante de retención que se emita por concepto de autorretenciones
de conformidad con la normativa correspondiente para cada caso, se
deberá considerar lo siguiente:

     •    Código y porcentaje para llenar en el comprobante de retención

                                                                             Porcentaje de
         Código de     Concepto retención en la fuente de Impuesto a la
                                                                               retención
         retención                         Renta
                                                                           (Desde 01/04/2020)

           350                      Otras autorretenciones                    1,50 ó 1,75

           3481       Autorretenciones Sociedades Grandes Contribuyentes   Varios porcentajes


     •    El comprobante de retención se emite a nombre del mismo agente de
          retención, esto es en el campo <identificacionSujetoRetenido> y
          <razonSocialSujetoRetenido>

     •    En cuanto al campo <codDocSustento> se considerará:

     ➢ En la versión 1.0 del comprobante de retención electrónico se utilizará el
       código de documento 42 (Documento retención presuntiva y retención
       emitida por propio vendedor o por intermediario. (Ver Ejemplo 1 a
       continuación).

     ➢ En la versión 2.0 del comprobante de retención electrónico se utilizará el
       código de documento 42 (Documento retención presuntiva y retención
       emitida por propio vendedor o por intermediario y el código de sustento de la
       operación 12 (Impuestos y retenciones presuntivos). (Ver Ejemplo 2 a
       continuación).

• En el campo `<numDocSustento>`{=html} ubicar el mismo número de
comprobante de retención por la autoretención que se está realizando.

Estas consideraciones aplican debido a que dicha retención no opera
sobre compras a terceros sino sobre sus propios ingresos.

                                                                                                124

------------------------------------------------------------------------

Ejemplo 1 de la estructura XML -- Comprobante de retención código 350:

Ejemplo 2 de la estructura XML -- Comprobante de retención ATS versión
2.0.0 código 350:

                                                                    125

------------------------------------------------------------------------

Ejemplo 1 de la estructura XML -- Comprobante de retención código 3481:

Ejemplo 2 de la estructura XML -- Comprobante de retención ATS versión
2.0.0 código 3481:

ANEXO 20 -- REQUISITO PARA LA APLICACIÓN DE LA DEVOLUCIÓN AUTOMÁTICA DEL
IVA EN EL XML DE FACTURAS, NOTAS DE CRÉDITO Y NOTAS DE DÉBITO.

                                                                         126

------------------------------------------------------------------------

Las facturas, notas de crédito y notas de débito electrónicas deberá
contener la siguiente información en la estructura del XML, cuando
aplique devolución del IVA, cuyo valor deberá ser igual al autorizado
por los servicios web -- DIG, para el caso de las notas de crédito
deberá corresponder al valor que aplique al documento de sustento:

• Campo Devolución IVA en la cabecera del XML:

    <totalConImpuestos>
           <totalImpuesto>
              <codigo>2</codigo>
              <codigoPorcentaje>0</codigoPorcentaje>
              <descuentoAdicional>0.00</descuentoAdicional>
              <baseImponible>50.00</baseImponible>
              <tarifa>12.00</tarifa>
              <valor>6.00</valor>
              <valorDevolucionIva>6.00</valorDevolucionIva>
           </totalImpuesto>

• Validaciones: Las validaciones en comprobantes electrónicos que se
aplicarán al campo son las siguientes:

     ➢ Tipo identificación del comprador o cliente según Tabla 6: Cédula (Código
       05)
     ➢ Si el campo <valorDevolucionIva> es un valor mayor a cero, la clave de
       acceso deberá estar registrada en el control de saldos del beneficiario y el
       monto deberá ser igual al autorizado por el servicio web - DIG.
     ➢ El valor registrado en el campo <valorDevolucionIva> debe ser mayor o igual
       a cero y menor o igual al campo <valor> de la misma sección. En caso de
       que el campo se envíe con valor cero no aplica validación.
     ➢ Los campos que totalizan la factura <importeTotal>, nota de crédito
       <valorModificacion> y débito <valorTotal>, deberán restar el valor
       consignado en el campo <valorDevolucionIva>.
     ➢ Las facturas y notas de débito utilizarán los servicios web - DIG para el
       registro del valor en el campo <valorDevolucionIva>.

ANEXO 21 -- REQUISITO OBLIGATORIO PARA COMPROBANTES ELECTRÓNICOS
EMITIDOS POR CONTRIBUYENTES DESIGNADOS COMO AGENTES DE RETENCIÓN. Los
comprobantes de venta, retención y documentos complementarios
electrónicos deberán contener la leyenda Agente de Retención en la
estructura del XML, conforme las siguientes especificaciones:

                                                                               127

------------------------------------------------------------------------

        •    Agente de retención

            Nombre de la etiqueta:   <agenteRetencion>
            Formato:                 Numérico
            Caracteres:              Máximo 8
                                     Número de la resolución, omitiendo los ceros a la
            Contenido:
                                     izquierda
                                     Entre la etiqueta <regimenMicroempresas> y
            Ubicación:
                                     </infoTributaria>


            Ejemplo 1 – Contribuyente designado Agente de Retención


                             Ejemplo 2 – Formato RIDE

Nota: Se incluirán únicamente las etiquetas que correspondan al
contribuyente.

                                                                                         128

------------------------------------------------------------------------

ANEXO 22 -- REQUISITO OBLIGATORIO PARA COMPROBANTES ELECTRÓNICOS
EMITIDOS POR CONTRIBUYENTES RIMPE. Los comprobantes de venta, retención
y documentos complementarios electrónicos deberán contener la leyenda
CONTRIBUYENTE RÉGIMEN RIMPE o CONTRIBUYENTE NEGOCIO POPULAR - RÉGIMEN
RIMPE, conforme las siguientes especificaciones:

        •     RIMPE

            Nombre de la etiqueta:   <contribuyenteRimpe>
            Formato:                 Texto
            Caracteres:              27 (Incluidos espacios)
            Contenido:               CONTRIBUYENTE RÉGIMEN RIMPE
            Ubicación:               Entre la etiqueta <agenteRetencion> y </infoTributaria>


        Ejemplo 1 – Contribuyente RIMPE y Agente de Retención


                          Ejemplo 2 – Contribuyente RIMPE


                                                                                               129

------------------------------------------------------------------------

         Ejemplo 3 – Formato RIDE Contribuyente RIMPE

• Negocio popular

Nombre de la etiqueta: `<contribuyenteRimpe>`{=html} Formato: Texto
Caracteres: 45 (Incluidos espacios) Contenido: CONTRIBUYENTE NEGOCIO
POPULAR - RÉGIMEN RIMPE Ubicación: Entre la etiqueta
`<agenteRetencion>`{=html} y `</infoTributaria>`{=html}

            Ejemplo 4 – Contribuyente Negocio Popular


                                                                                   130

------------------------------------------------------------------------

       Ejemplo 5 – Formato RIDE Contribuyente Negocio Popular

ANEXO 23 -- REQUISITO OBLIGATORIO EL LLENADO PARA EL XML DE COMPROBANTES
DE VENTA EN LA TRANSFERENCIA LOCAL DE MATERIALES DE CONSTRUCCIÓN. En la
emisión de comprobantes por la transferencia local de materiales de
construcción establecidos en la Resolución No. NAC-DGERCGC24-00000013,
en la sección `<detalles>`{=html}, en el campo `<codigoAuxiliar>`{=html}
se deberá colocar obligatoriamente los siguientes códigos de manera
exacta:

TABLA 31

`<codigoAuxiliar>`{=html} Subcategoría material de construcción VARILLA
LAMINADA CORRUGADA AS42 DE 8MM, 10MM Y 12MM F010101 DE DIÁMETRO F010201
ARCILLA F010202 ARENA F010203 CAL F010204 CALIZA F010205 PÉTROS F010301
HORMIGÓN PREMEZCLADO

                                                                       131

------------------------------------------------------------------------

`<codigoAuxiliar>`{=html} Subcategoría material de construcción F010401
CEMENTO Y SUS DERIVADOS F010402 RESIDUO CEMENTO F010501 CHATARRA FERROSA
F010601 MORTERS F010701 CLINKER F010702 PUZOLANA F010703 YESO F010801
ADOQUÍN F010802 BLOQUES F010803 LADRILLOS F010804 PRODUCTOS DE HORMIGÓN
PREFABRICADO

ANEXO 24 -- REQUISITO OBLIGATORIO PARA COMPROBANTES ELECTRÓNICOS
EMITIDOS POR GRANDES CONTRIBUYENTES. Los comprobantes de venta, notas de
crédito y notas de débito electrónicos deberán contener la leyenda "Gran
Contribuyente" y el número de la resolución mediante la cual fueron
calificados como tal, en la estructura del XML, conforme las siguientes
especificaciones:

        •    Gran Contribuyente

            Nodo:                      <infoAdicional>
            Nombre de tag:             <campoadicional>
            Formato:                   Alfanumérico
            Caracteres:                Máximo 300
            Valor atributo “nombre”:   Leyenda “Gran Contribuyente” y número de resolución
            Ubicación:                 Entre las etiquetas <infoAdicional> y </infoAdicional>


        Ejemplo 1 – Contribuyente designado gran contribuyente


                                                                                                132

------------------------------------------------------------------------

                            Ejemplo 2 – Formato RIDE

ANEXO 25 -- REQUISITOS OBLIGATORIOS DE LLENADO PARA EL XML DE FACTURAS
EMITIDAS POR LAS OPERADORAS Y SUS SOCIOS O ACCIONISTAS, DE TRANSPORTE
COMERCIAL, EXCEPTO TAXIS.

1.  CÓDIGO AUXILIAR

1.1 Códigos de llenado

En las facturas electrónicas emitidas a los clientes por la prestación
de servicios de transporte comercial, excepto taxis, por parte de las
operadoras de transporte debidamente autorizadas, así como en aquellas
emitidas por parte de sus socios o accionistas a la operadora, en la
sección `<detalles>`{=html}, para el llenado del campo
`<codigoAuxiliar>`{=html} se deberá considerar obligatoriamente la
información conforme al siguiente detalle:

TABLA 32

         <codigoAuxiliar>              Caso                        Observación

                                                           Aplica en las facturas emitidas
                                                         por la operadora a sus clientes de
                               Facturas emitidas por        transporte comercial (excepto
             H492001
                              la operadora al cliente.   taxis) debidamente autorizada, por
                                                              la prestación de servicio de
                                                                       transporte.
                                                          Aplica en las facturas emitidas
                              Facturas emitidas por
             H492002                                      por el socio o accionista, a la
                              el socio o accionista       operadora de transporte por sus


                                                                                              133

------------------------------------------------------------------------

                 <codigoAuxiliar>                        Caso                      Observación

                                                  a la operadora de                  servicios.
                                                      transporte.

Los códigos arriba detallados deberán incluirse en la factura
electrónica en el campo `<codigoAuxiliar>`{=html} de cada ítem que
corresponda a la actividad de transporte comercial.

Nota: Este requisito es obligatorio desde el 01 de noviembre de 2025.

2.       PLACA17

    2.1 Requisito

Las facturas electrónicas emitidas por parte de las operadoras de
transporte terrestre comercial, excepto taxis, a los clientes, deberán
incorporar como requisito de llenado obligatorio, el número de placa del
respectivo vehículo con el que se prestó el servicio de transporte.

Para ello se deberá incluir el tag placa en la estructura del XML, entre
los tags moneda y formas de pago para las versiones 1.0.0, 1.1.0, 2.0.0,
2.1.0:

`<moneda>`{=html}DOLAR`</moneda>`{=html}
`<placa>`{=html}PCM4567`</placa>`{=html} `<pagos>`{=html}

2.2 Llenado del campo Placa

El campo `<placa>`{=html} deberá llenarse considerando las siguientes
especificaciones, según corresponda:

TABLA 33: FORMATO DE LLENADO DEL CAMPO PLACA

Caso Nombre de campo Formato llenado Observaciones

                                                                         Se deberán ingresar las letras y números sin
     1                <placa>                         <ABC1234>
                                                                                      ningún espacio.
                                                                            Si existen solo tres dígitos, se deberá
     2                <placa>                         <ABC0123>          colocar el cero sin ningún espacio antes de
                                                                                         los mismos.

Nota: Este requisito es obligatorio a partir de 90 días contados desde
la publicación de este acto normativo en el Registro Oficial.

17 Requisito establecido en la resolución No. NAC-DGERCGC26-00000024

                                                                                                                 134

------------------------------------------------------------------------

ANEXO 26 -- REQUISITO OBLIGATORIO DE INFORMACIÓN DE RUC DE PROVEEDOR DE
SISTEMAS INFORMÁTICOS O SERVICIOS DE FACTURACIÓN ELECTRÓNICA Los
contribuyentes emisores de comprobantes electrónico que utilicen
sistemas de facturación electrónicos de terceros (proveedores detallados
en la resolución 27 18) deberán incluir como requisito de llenado
obligatorio en los comprobantes emitidos, la información del número de
RUC del proveedor. Este requisito se incluirá como campo en la sección
de información adicional, conforme el siguiente detalle:

              Nodo:                              <infoAdicional>
              Nombre tag:                        <CampoAdicional>
              Formato:                           Alfanumérico
              Caracteres:                        Máximo 300
              Valor atributo “nombre”:           “RUC Proveedor”
              Contenido tag campoAdicional:      Número del RUC del proveedor


              Ejemplo 1 – Información adicional – RUC PROVEEDOR


                                Ejemplo 2 – Formato RIDE

Nota: Este requisito es obligatorio en el plazo de 60 días calendario,
contados a partir de la publicación del acto normativo en el Registro
Oficial.

18 Resolución Nro. NAC-DGERCGC26-00000027.

                                                                                135

------------------------------------------------------------------------

15. Glosario de términos ARCHIVOS PLANOS: Son archivos que están
    compuestos únicamente por texto sin formato, sólo caracteres.
    AMPERSAND (&): El signo & (ampersand), deberá incorporarse en los
    comprobantes electrónicos de la siguiente manera "&" caso contrario
    al solicitar la autorización se rechazará con motivo de mal
    estructurado. COMERCIO ELECTRÓNICO: Es toda transacción comercial
    realizada en parte o en su totalidad, a través de redes electrónicas
    de información. DBF: (Data Base File). Es la extensión que
    corresponde a un tipo de fichero de bases de datos, originalmente
    utilizado por el SGBD Dbase, pero que es frecuente encontrar en todo
    tipo de aplicaciones como el Lenguaje de Programación FOX PRO.
    DOCUMENTO ELECTRÓNICO:

Es la emisión mediante mensaje de datos (documentos desmaterializados)
de los comprobantes de venta, retención y documentos complementarios.

ETIQUETAS O TAGS:

Etiqueta en lenguaje marcado. Es una marca con tipo que delimita una
región en los lenguajes basados en XML.

ESQUEMA OFFLINE:

En este esquema el número de autorización es la clave de acceso generada
por el emisor y los archivos XML contendrán únicamente la clave de
acceso (49 dígitos). Normativa: Resolución No. NAC-DGERCGC14-00790.

INTERFACES (Plural de interfaz):

En informática, es un elemento de conexión que facilita el intercambio
de datos. También se lo define como el conjunto de métodos para lograr
interactividad entre un usuario y una computadora.

LOG:

Registro oficial de eventos durante un rango de tiempo en particular. En
seguridad informática es usado para registrar datos o información sobre
quién, qué, cuándo, dónde y por qué un evento ocurre para un dispositivo
en particular o aplicación.

                                                                                136

------------------------------------------------------------------------

MENSAJES DE DATOS:

Es toda información creada, generada, procesada, enviada, recibida,
comunicada o archivada por medios electrónicos, que puede ser
intercambiada por cualquier medio. Serán considerados como mensajes de
datos, sin que esta enumeración limite su definición, los siguientes
documentos electrónicos, registros electrónicos, correo electrónico,
servicios web, telegrama, télex, fax e intercambio electrónico de datos.

MÓDULO:

Componente auto controlado de un sistema, dicho componente posee una
interfaz bien definida hacia otros componentes; algo es modular si está
construido de manera tal que se facilite su ensamblaje, acomodamiento
flexible y reparación de sus componentes.

PASSWORD:

Clave de acceso. Es una forma de autentificación que utiliza información
secreta para controlar el acceso hacia algún recurso.

PKCS:

En criptografía, PKCS se refiere a un grupo de estándares de
criptografía de clave pública concebidos y publicados por los
laboratorios de RSA en California.

RCVRYDC:

Reglamento de Comprobantes de Venta, Retención y Documentos
Complementarios, publicado en el Registro Oficial 247, del 30 de Julio
de 2010 y sus reformas.

SERVICIO ELECTRÓNICO:

Es toda actividad realizada a través de redes electrónicas de
información.

SGBD:

Siglas de Sistema Gestor de Base de Datos; programas que permiten
almacenar y posteriormente acceder a los datos de forma rápida y
estructurada.

SISTEMA DE INFORMACIÓN:

Es todo dispositivo físico o lógico utilizado para crear, generar,
enviar, recibir, procesar, comunicar o almacenar, de cualquier forma,
mensajes de datos.

USERNAME:

Nombre de usuario de un sistema computarizado que obedece a un perfil o
roles asignados por un Administrador.

                                                                                 137

------------------------------------------------------------------------

UTF-8:

UTF-8 (8-bit Unicode Transformation Format) es un formato de
codificación de caracteres Unicode e ISO 10646 utilizando símbolos de
longitud variable, capaz de representar cualquier CARACTER Unicode.

WEB SERVICE:

Un servicio web (en inglés, Web service) es una pieza de software que
utiliza un conjunto de protocolos y estándares que sirven para
intercambiar datos entre aplicaciones. Distintas aplicaciones de
software desarrolladas en lenguajes de programaciones diferentes y
ejecutadas sobre cualquier plataforma pueden utilizar los servicios web
para intercambiar datos en redes de ordenadores como Internet.

XAdES:

Firma electrónica avanzada XML. Es un conjunto de extensiones a las
recomendaciones XML-DSig haciéndolas adecuadas para la firma electrónica
avanzada.

XML:

Siglas en inglés de EXtensible Markup Language (lenguaje de marcas
extensible); es un estándar para el intercambio de información
estructurada entre diferentes plataformas.

XSD:

XML Schema es un lenguaje de esquema utilizado para describir la
estructura y las restricciones de los contenidos de los documentos XML
de una forma muy precisa.

                                                                              138

------------------------------------------------------------------------

     16. Preguntas técnicas frecuentes
              Pregunta                                                  Solución
                                          Hay dos tipos de firmado: uno que firma el archivo completo y otro el
                                          nodo especifico; se debe revisar el archivo XML y verificar que esté
                                          firmado el nodo como en el siguiente ejemplo:

Firma inválida- El nodo comprobante no está firmado.

                                          Se puede validar el firmado con herramientas auxiliares de validación,
                                          como la herramienta XOLIDOSIGN. Link de descarga:

Firma inválida- La estructura de la
http://www.xolido.com/lang/productosxolidosign/xolidosignescritorio
firma es incorrecta.
/modulo/?refbol=xolidosign-escritorio&refsec=xolidosign-
escritorio_descargas

                                          Se puede validar el firmado con herramientas auxiliares de validación,
                                          como la herramienta XOLIDOSIGN. Link de descarga:

                                          http://www.xolido.com/lang/productosxolidosign/xolidosignescritorio

Firma inválida- La firma no
/modulo/?refbol=xolidosign-escritorio&refsec=xolidosign- corresponde con
el contenido del documento. escritorio_descargas Generalmente estos
errores se deben a que en el documento existen caracteres extraños, el
contribuyente debe verificar en los campos de descripción o tipo texto
del XML.

                                          Favor re-enviar todos los comprobantes que no fueron autorizados por
                                          "[Firma inválida. La fecha contenida en la firma es posterior a la
                                          actual]". Al respecto la fecha y hora de nuestros servidores están
                                          configurados con un servidor NTP.

Firma inválida- La fecha de la firma es posterior a la actual. server
0.south-america.pool.ntp.org maxpoll 12 server
1.south-america.pool.ntp.org maxpoll 12 server
2.south-america.pool.ntp.org maxpoll 12

                                          Se puede validar el firmado con herramientas auxiliares de validación,
                                          como la herramienta XOLIDOSIGN. Link de descarga:

                                          http://www.xolido.com/lang/productosxolidosign/xolidosignescritorio

Firma inválida- No existe el RUC en el certificado digital.
/modulo/?refbol=xolidosign-escritorio&refsec=xolidosign-
escritorio_descargas En la herramienta muestra el certificado con el que
fue firmado el archivo.

                                                                                                      139

------------------------------------------------------------------------

Pregunta Solución PASOS para validar:

           1. Seleccionar el archivo, clic en verificar.


           2. Clic en el botón certificado.


           3. Clic en detalles y luego en el tag que contiene el dato del RUC.


                                                                             140

------------------------------------------------------------------------

              Pregunta                                               Solución


                                       Revisar en la página web del SRI si la clave de acceso ya fue

Clave de acceso registrada. autorizada.

                                       Es responsabilidad del emisor controlar la no generación de un mismo
                                       secuencial para un mismo tipo de comprobante (cabe recordar que

Secuencial registrado. estos casos debieron ser detectados y corregidos
en el ambiente de pruebas).

                                       El RUC ingresado en la identificación del receptor no consta en la base

RUC no existe. de RUC, esto se puede validar en la página Web del SRI.

                                       Verificar que todos los datos ingresados para la anulación sean
                                       correctos; debe coincidir con los datos del comprobante a anular, se

No se pueden anular comprobantes. puede consultar en la página WEB del
SRI o en Intranet en la opción de Consultas.

Comprobantes no autorizados por Abrir el XML y revisar que todos los
cálculos estén correctos. error en diferencias.

                                       Validar si el RUC del emisor presenta alertas de Infracciones en la

RUC clausurado. aplicación de RUC o consultar con el área de
Infracciones.

                                     Revisar el uso correcto de las versiones de los archivos XML:

Número de decimales en la estructura del XML del comprobante. Pueden
utilizar dos decimales en la versión 1.0.0 y seis decimales en la
versión 1.1.0.

                                                                                                    141

------------------------------------------------------------------------

             Pregunta                                           Solución
                                     Revisar en las consultas públicas mediante el       portal web

Validar el estado del Comprobante. www.sri.gob.ec, el estado del
comprobante.

                                Un comprobante en estado no autorizado está atado a un mensaje de

Que quiere decir comprobante no rechazo, puede ser cualquiera de los
errores detallados en esta ficha autorizado. técnica. Es importante
notar que pueden existir varias respuestas en estado no autorizado y una
única respuesta en estado autorizado.

                                                                                            142

------------------------------------------------------------------------
