/* Required catalog rows for the initial empty database. */
SET NOCOUNT ON;
GO

INSERT dbo.EntityStatus(StatusCode,StatusName,StatusDescription,IsActive,SortOrder)
VALUES ('A',N'Activo',N'Registro habilitado',1,1),('I',N'Inactivo',N'Registro deshabilitado',0,2);

INSERT dbo.IdentificationType
(IdentificationTypeId,Code,Name,Description,MinLength,MaxLength,IsNumericOnly,AllowsNaturalPerson,AllowsLegalEntity,IsBillingAllowed,Status)
VALUES
('04','RUC',N'RUC',N'Registro Unico de Contribuyentes',13,13,1,1,1,1,'A'),
('05','CEDULA',N'CEDULA',N'Cedula ecuatoriana',10,10,1,1,0,1,'A'),
('06','PASAPORTE',N'PASAPORTE',N'Pasaporte',3,20,0,1,0,1,'A'),
('07','CONSUMIDOR_FINAL',N'CONSUMIDOR FINAL',N'Identificacion de consumidor final',13,13,1,1,0,1,'A'),
('08','IDENTIFICACION_EXTERIOR',N'IDENTIFICACION DEL EXTERIOR',N'Identificacion extranjera',3,20,0,1,1,1,'A');

INSERT dbo.PersonType(PersonTypeId,Name,Description,Status)
VALUES ('N',N'Persona natural',N'Persona individual con identidad civil','A'),
       ('J',N'Persona juridica',N'Entidad legal','A');
GO
