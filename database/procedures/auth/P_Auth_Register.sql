/*
Script: P_Auth_Register.sql
Stored Procedure: dbo.P_Auth_Register
Objetivo:
    Registrar un nuevo usuario junto con su empresa inicial dentro del ERP.

Flujo:
    1. Busca o crea la persona del usuario
    2. Crea el usuario en dbo.AppUser
    3. Crea la empresa
    4. Crea sucursal y punto de emision iniciales
    5. Crea la relacion UserCompany
    6. Busca o crea el perfil ADMIN para esa empresa
    7. Crea permisos base si no existen
    8. Asigna permisos base al perfil ADMIN
    9. Asigna el perfil al usuario en la empresa

Reglas:
    - El login oficial es Email
    - Username es un alias opcional
    - El perfil inicial asignado es ADMIN

Dependencias:
    - dbo.Person
    - dbo.AppUser
    - dbo.Company
    - dbo.CompanyBranch
    - dbo.CompanyEmissionPoint
    - dbo.UserCompany
    - dbo.Profile
    - dbo.Permission
    - dbo.ProfilePermission
    - dbo.UserCompanyProfile
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Auth_Register
(
    @Email NVARCHAR(150),
    @PasswordHash NVARCHAR(500),
    @PersonIdentificationType CHAR(2),
    @PersonIdentification NVARCHAR(20),
    @PersonName NVARCHAR(200),
    @PersonLastName NVARCHAR(80) = NULL,
    @PersonPhone NVARCHAR(50) = NULL,
    @CompanyBusinessName NVARCHAR(200),
    @CompanyIdentification NVARCHAR(20),
    @Username NVARCHAR(80) = NULL,
    @EstablishmentCode VARCHAR(10) = '001',
    @EmissionPointCode VARCHAR(10) = '001'
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @PersonId UNIQUEIDENTIFIER;
    DECLARE @UserId UNIQUEIDENTIFIER;
    DECLARE @CompanyId UNIQUEIDENTIFIER;
    DECLARE @CompanyBranchId UNIQUEIDENTIFIER;
    DECLARE @CompanyEmissionPointId UNIQUEIDENTIFIER;
    DECLARE @UserCompanyId UNIQUEIDENTIFIER;
    DECLARE @ProfileId UNIQUEIDENTIFIER;
    DECLARE @CreatedBy NVARCHAR(80);

    SET @Email = LOWER(LTRIM(RTRIM(@Email)));
    SET @Username = NULLIF(LTRIM(RTRIM(@Username)), '');
    SET @PersonIdentification = LTRIM(RTRIM(@PersonIdentification));
    SET @PersonName = LTRIM(RTRIM(@PersonName));
    SET @PersonLastName = NULLIF(LTRIM(RTRIM(@PersonLastName)), '');
    SET @PersonPhone = NULLIF(LTRIM(RTRIM(@PersonPhone)), '');
    SET @CompanyBusinessName = LTRIM(RTRIM(@CompanyBusinessName));
    SET @CompanyIdentification = LTRIM(RTRIM(@CompanyIdentification));
    SET @EstablishmentCode = ISNULL(NULLIF(LTRIM(RTRIM(@EstablishmentCode)), ''), '001');
    SET @EmissionPointCode = ISNULL(NULLIF(LTRIM(RTRIM(@EmissionPointCode)), ''), '001');
    SET @CreatedBy = LEFT(@Email, 80);

    BEGIN TRY
        BEGIN TRAN;

        IF @Email IS NULL OR @Email = ''
            RAISERROR('Email is required.', 16, 1);

        IF @PasswordHash IS NULL OR LTRIM(RTRIM(@PasswordHash)) = ''
            RAISERROR('PasswordHash is required.', 16, 1);

        IF @PersonIdentificationType IS NULL OR LTRIM(RTRIM(@PersonIdentificationType)) = ''
            RAISERROR('PersonIdentificationType is required.', 16, 1);

        IF @PersonIdentification IS NULL OR @PersonIdentification = ''
            RAISERROR('PersonIdentification is required.', 16, 1);

        IF @PersonName IS NULL OR @PersonName = ''
            RAISERROR('PersonName is required.', 16, 1);

        IF @CompanyBusinessName IS NULL OR @CompanyBusinessName = ''
            RAISERROR('CompanyBusinessName is required.', 16, 1);

        IF @CompanyIdentification IS NULL OR @CompanyIdentification = ''
            RAISERROR('CompanyIdentification is required.', 16, 1);

        IF EXISTS (
            SELECT 1
            FROM dbo.AppUser u
            WHERE u.Email = @Email
        )
            RAISERROR('Email already exists.', 16, 1);

        IF EXISTS (
            SELECT 1
            FROM dbo.Company c
            WHERE c.Identification = @CompanyIdentification
        )
            RAISERROR('CompanyIdentification already exists.', 16, 1);

        SELECT @PersonId = pi.PersonId
        FROM dbo.PersonIdentification pi
        WHERE pi.IdentificationTypeId = @PersonIdentificationType
          AND pi.NormalizedIdentification = dbo.fn_NormalizeIdentification(@PersonIdentification);

        IF @PersonId IS NULL
        BEGIN
            SET @PersonId = NEWID();

            INSERT INTO dbo.Person
            (
                PersonId,
                PersonKind,
                LegalName,
                TradeName,
                Status,
                CreatedBy,
                CreatedAt
            )
            VALUES
            (
                @PersonId,
                'N',
                CONCAT(@PersonName, CASE WHEN @PersonLastName IS NULL THEN N'' ELSE N' '+@PersonLastName END),
                NULL,
                'A',
                @CreatedBy,
                SYSDATETIME()
            );

            INSERT dbo.PersonIdentification(PersonId,IdentificationTypeId,Identification,IsPrimary,CreatedByUserId)
            VALUES(@PersonId,@PersonIdentificationType,@PersonIdentification,1,NULL);
        END

        SET @UserId = NEWID();

        INSERT INTO dbo.AppUser
        (
            UserId,
            PersonId,
            Username,
            Email,
            PasswordHash,
            IsBlocked,
            RequiresNewPassword,
            MustUpdate,
            Status,
            CreatedBy,
            CreatedAt
        )
        VALUES
        (
            @UserId,
            @PersonId,
            @Username,
            @Email,
            @PasswordHash,
            0,
            0,
            0,
            'A',
            @CreatedBy,
            SYSDATETIME()
        );

        SET @CompanyId = NEWID();

        INSERT INTO dbo.Company
        (
            CompanyId,
            Identification,
            TradeName,
            BusinessName,
            Email,
            IsAccountingRequired,
            SpecialTaxpayer,
            Status,
            RepresentativeId,
            TaxpayerType,
            CreatedBy,
            CreatedAt
        )
        VALUES
        (
            @CompanyId,
            @CompanyIdentification,
            @CompanyBusinessName,
            @CompanyBusinessName,
            @Email,
            0,
            NULL,
            'A',
            @PersonId,
            NULL,
            @CreatedBy,
            SYSDATETIME()
        );

        SET @CompanyBranchId = NEWID();

        INSERT INTO dbo.CompanyBranch
        (
            CompanyBranchId,
            CompanyId,
            EstablishmentCode,
            BranchName,
            Email,
            Status,
            CreatedBy,
            CreatedAt
        )
        VALUES
        (
            @CompanyBranchId,
            @CompanyId,
            @EstablishmentCode,
            N'Matriz',
            @Email,
            'A',
            @CreatedBy,
            SYSDATETIME()
        );

        SET @CompanyEmissionPointId = NEWID();

        INSERT INTO dbo.CompanyEmissionPoint
        (
            CompanyEmissionPointId,
            CompanyBranchId,
            EmissionPointCode,
            Name,
            Status,
            CreatedBy,
            CreatedAt
        )
        VALUES
        (
            @CompanyEmissionPointId,
            @CompanyBranchId,
            @EmissionPointCode,
            N'Punto de emision principal',
            'A',
            @CreatedBy,
            SYSDATETIME()
        );

        SET @UserCompanyId = NEWID();

        INSERT INTO dbo.UserCompany
        (
            UserCompanyId,
            UserId,
            CompanyId,
            Status,
            CreatedBy,
            CreatedAt
        )
        VALUES
        (
            @UserCompanyId,
            @UserId,
            @CompanyId,
            'A',
            @CreatedBy,
            SYSDATETIME()
        );

        SELECT @ProfileId = p.ProfileId
        FROM dbo.Profile p
        WHERE p.CompanyId = @CompanyId
          AND p.Name = N'ADMIN';

        IF @ProfileId IS NULL
        BEGIN
            SET @ProfileId = NEWID();

            INSERT INTO dbo.Profile
            (
                ProfileId,
                CompanyId,
                Name,
                Description,
                Status,
                CreatedBy,
                CreatedAt
            )
            VALUES
            (
                @ProfileId,
                @CompanyId,
                N'ADMIN',
                N'Perfil administrador inicial de la empresa',
                'A',
                @CreatedBy,
                SYSDATETIME()
            );
        END

        DECLARE @BasePermissions TABLE
        (
            Code NVARCHAR(150) NOT NULL PRIMARY KEY,
            Name NVARCHAR(150) NOT NULL,
            Description NVARCHAR(250) NULL,
            ModuleCode NVARCHAR(50) NOT NULL
        );

        INSERT INTO @BasePermissions (Code, Name, Description, ModuleCode)
        VALUES
            (N'company.read', N'Consultar empresas', N'Permite consultar datos de empresa', N'company'),
            (N'company.update', N'Actualizar empresa', N'Permite actualizar datos de empresa', N'company'),
            (N'user.read', N'Consultar usuarios', N'Permite consultar usuarios de la empresa', N'user'),
            (N'user.create', N'Crear usuarios', N'Permite crear usuarios en la empresa', N'user'),
            (N'user.update', N'Actualizar usuarios', N'Permite actualizar usuarios', N'user'),
            (N'user.disable', N'Desactivar usuarios', N'Permite desactivar usuarios', N'user'),
            (N'profile.read', N'Consultar perfiles', N'Permite consultar perfiles', N'profile'),
            (N'profile.create', N'Crear perfiles', N'Permite crear perfiles', N'profile'),
            (N'profile.update', N'Actualizar perfiles', N'Permite actualizar perfiles', N'profile'),
            (N'profile.assign', N'Asignar perfiles', N'Permite asignar perfiles a usuarios', N'profile'),
            (N'permission.read', N'Consultar permisos', N'Permite consultar permisos', N'permission'),
            (N'permission.assign', N'Asignar permisos', N'Permite asignar permisos a perfiles', N'permission'),
            (N'client.read', N'Consultar clientes', N'Consulta clientes y registro exacto', N'client'),
            (N'client.create', N'Crear clientes', N'Crea relaciones cliente por empresa', N'client'),
            (N'client.update', N'Actualizar clientes', N'Actualiza datos comerciales locales', N'client'),
            (N'client.deactivate', N'Desactivar clientes', N'Desactiva clientes sin borrarlos', N'client'),
            (N'client.verify', N'Verificar identidad fiscal', N'Permite verificar identidad fiscal', N'client');

        INSERT INTO dbo.Permission
        (
            PermissionId,
            Code,
            Name,
            Description,
            ModuleCode,
            Status,
            CreatedBy,
            CreatedAt
        )
        SELECT
            NEWID(),
            bp.Code,
            bp.Name,
            bp.Description,
            bp.ModuleCode,
            'A',
            @CreatedBy,
            SYSDATETIME()
        FROM @BasePermissions bp
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM dbo.Permission p
            WHERE p.Code = bp.Code
        );

        INSERT INTO dbo.ProfilePermission
        (
            ProfilePermissionId,
            ProfileId,
            PermissionId,
            Status,
            CreatedBy,
            CreatedAt
        )
        SELECT
            NEWID(),
            @ProfileId,
            p.PermissionId,
            'A',
            @CreatedBy,
            SYSDATETIME()
        FROM dbo.Permission p
        INNER JOIN @BasePermissions bp
            ON bp.Code = p.Code
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM dbo.ProfilePermission pp
            WHERE pp.ProfileId = @ProfileId
              AND pp.PermissionId = p.PermissionId
        );

        INSERT INTO dbo.UserCompanyProfile
        (
            UserCompanyProfileId,
            UserCompanyId,
            CompanyId,
            ProfileId,
            Status,
            CreatedBy,
            CreatedAt
        )
        VALUES
        (
            NEWID(),
            @UserCompanyId,
            @CompanyId,
            @ProfileId,
            'A',
            @CreatedBy,
            SYSDATETIME()
        );

        COMMIT TRAN;

        SELECT
            @PersonId AS PersonId,
            @UserId AS UserId,
            @CompanyId AS CompanyId,
            @CompanyBranchId AS CompanyBranchId,
            @CompanyEmissionPointId AS CompanyEmissionPointId,
            @UserCompanyId AS UserCompanyId,
            @ProfileId AS ProfileId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO
