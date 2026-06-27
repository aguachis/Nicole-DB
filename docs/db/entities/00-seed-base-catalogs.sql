/*
Script: 00-seed-base-catalogs.sql
Objetivo:
    Insertar catalogos base requeridos por las FKs del modelo inicial.

Uso:
    Ejecutar despues de crear EntityStatus, IdentificationType y PersonType,
    y antes de crear datos operativos o ejecutar P_Auth_Register.
*/

SET NOCOUNT ON;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.EntityStatus WHERE StatusCode = 'A')
BEGIN
    INSERT INTO dbo.EntityStatus
    (
        StatusCode,
        StatusName,
        StatusDescription,
        IsActive,
        SortOrder
    )
    VALUES
        ('A', N'Activo', N'Registro habilitado para uso operativo', 1, 1);
END;

IF NOT EXISTS (SELECT 1 FROM dbo.EntityStatus WHERE StatusCode = 'I')
BEGIN
    INSERT INTO dbo.EntityStatus
    (
        StatusCode,
        StatusName,
        StatusDescription,
        IsActive,
        SortOrder
    )
    VALUES
        ('I', N'Inactivo', N'Registro deshabilitado para uso operativo', 0, 2);
END;

IF NOT EXISTS (SELECT 1 FROM dbo.IdentificationType WHERE IdentificationTypeId = '04')
BEGIN
    INSERT INTO dbo.IdentificationType
    (
        IdentificationTypeId,
        Name,
        Description,
        Status
    )
    VALUES
        ('04', N'RUC', N'Ruc', 'A');
END;

IF NOT EXISTS (SELECT 1 FROM dbo.IdentificationType WHERE IdentificationTypeId = '05')
BEGIN
    INSERT INTO dbo.IdentificationType
    (
        IdentificationTypeId,
        Name,
        Description,
        Status
    )
    VALUES
        ('05', N'CEDULA', N'Cedula', 'A');
END;

IF NOT EXISTS (SELECT 1 FROM dbo.IdentificationType WHERE IdentificationTypeId = '06')
BEGIN
    INSERT INTO dbo.IdentificationType
    (
        IdentificationTypeId,
        Name,
        Description,
        Status
    )
    VALUES
        ('06', N'PASAPORTE', N'Pasaporte', 'A');
END;

IF NOT EXISTS (SELECT 1 FROM dbo.IdentificationType WHERE IdentificationTypeId = '07')
BEGIN
    INSERT INTO dbo.IdentificationType
    (
        IdentificationTypeId,
        Name,
        Description,
        Status
    )
    VALUES
        ('07', N'CONSUMIDOR FINAL', N'Consumidor final', 'A');
END;

IF NOT EXISTS (SELECT 1 FROM dbo.IdentificationType WHERE IdentificationTypeId = '08')
BEGIN
    INSERT INTO dbo.IdentificationType
    (
        IdentificationTypeId,
        Name,
        Description,
        Status
    )
    VALUES
        ('08', N'IDENTIFICACION DEL EXTERIOR', N'Identificacion del exterior', 'A');
END;

IF NOT EXISTS (SELECT 1 FROM dbo.PersonType WHERE PersonTypeId = 'N')
BEGIN
    INSERT INTO dbo.PersonType
    (
        PersonTypeId,
        Name,
        Description,
        Status
    )
    VALUES
        ('N', N'Persona natural', N'Persona individual con identidad civil', 'A');
END;

IF NOT EXISTS (SELECT 1 FROM dbo.PersonType WHERE PersonTypeId = 'J')
BEGIN
    INSERT INTO dbo.PersonType
    (
        PersonTypeId,
        Name,
        Description,
        Status
    )
    VALUES
        ('J', N'Persona juridica', N'Entidad legal como empresa o institucion', 'A');
END;
GO
