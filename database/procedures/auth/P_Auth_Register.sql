/*
Script: P_Auth_Register.sql
Stored Procedure: dbo.P_Auth_Register
Objetivo:
    Registrar un nuevo usuario junto con su empresa inicial dentro del ERP.

Flujo:
    1. Busca o crea la persona del usuario
    2. Crea la empresa, sucursal y punto de emision iniciales
    3. Busca o crea el perfil ADMIN de la empresa
    4. Crea permisos base si no existen y los asigna al perfil
    5. Crea el usuario asociado directamente a esa empresa y perfil

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
    - dbo.Profile
    - dbo.Permission
    - dbo.ProfilePermission
    - dbo.UserProfile
    - dbo.UserProfileAudit
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Auth_Register
(
    @Email NVARCHAR(150),
    @PasswordHash NVARCHAR(500),
    @PersonIdentificationTypeCode VARCHAR(32),
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
    DECLARE @ProfileId UNIQUEIDENTIFIER;
    DECLARE @UserProfileId UNIQUEIDENTIFIER;
    DECLARE @CreatedBy NVARCHAR(80);
    DECLARE @ValidatedPersonIdentificationTypeId CHAR(2);
    DECLARE @NormalizedPersonIdentification NVARCHAR(64);
    DECLARE @IdentificationResultCode INT;
    DECLARE @IdentificationResultMessage NVARCHAR(250);

    SET @Email = LOWER(LTRIM(RTRIM(@Email)));
    SET @Username = NULLIF(LTRIM(RTRIM(@Username)), '');
    SET @PersonIdentificationTypeCode = NULLIF(UPPER(LTRIM(RTRIM(@PersonIdentificationTypeCode))), '');
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
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(1001 AS INT) AS result_code,
                   N'Email is required.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF @PasswordHash IS NULL OR LTRIM(RTRIM(@PasswordHash)) = ''
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(1001 AS INT) AS result_code,
                   N'PasswordHash is required.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF @PersonIdentification IS NULL OR @PersonIdentification = ''
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(1001 AS INT) AS result_code,
                   N'PersonIdentification is required.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        EXEC dbo.P_Identification_ValidateInput
            @IdentificationTypeCode = @PersonIdentificationTypeCode,
            @Identification = @PersonIdentification,
            @PersonKind = 'N',
            @IdentificationTypeId = @ValidatedPersonIdentificationTypeId OUTPUT,
            @NormalizedIdentification = @NormalizedPersonIdentification OUTPUT,
            @ResultCode = @IdentificationResultCode OUTPUT,
            @ResultMessage = @IdentificationResultMessage OUTPUT;

        IF @IdentificationResultCode <> 0
        BEGIN
            ROLLBACK TRAN;
            SELECT @IdentificationResultCode AS result_code,
                   @IdentificationResultMessage AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF @PersonName IS NULL OR @PersonName = ''
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(1001 AS INT) AS result_code,
                   N'PersonName is required.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF @CompanyBusinessName IS NULL OR @CompanyBusinessName = ''
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(1001 AS INT) AS result_code,
                   N'CompanyBusinessName is required.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF @CompanyIdentification IS NULL OR @CompanyIdentification = ''
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(1001 AS INT) AS result_code,
                   N'CompanyIdentification is required.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF EXISTS (
            SELECT 1
            FROM dbo.AppUser u
            WHERE u.Email = @Email
        )
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(4001 AS INT) AS result_code,
                   N'Email already exists.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        IF EXISTS (
            SELECT 1
            FROM dbo.Company c
            WHERE c.Identification = @CompanyIdentification
        )
        BEGIN
            ROLLBACK TRAN;
            SELECT CAST(4001 AS INT) AS result_code,
                   N'CompanyIdentification already exists.' AS result_message,
                   CAST(NULL AS NVARCHAR(20)) AS operation;
            RETURN;
        END;

        SELECT @PersonId = pi.PersonId
        FROM dbo.PersonIdentification pi
        WHERE pi.IdentificationTypeId = @ValidatedPersonIdentificationTypeId
          AND pi.NormalizedIdentification = @NormalizedPersonIdentification;

        IF @PersonId IS NULL
        BEGIN
            SET @PersonId = NEWID();

            INSERT INTO dbo.Person
            (
                PersonId,
                PersonKind,
                FirstName,
                MiddleName,
                LastName,
                LegalName,
                TradeName,
                Phone,
                Status,
                CreatedBy,
                CreatedAt
            )
            VALUES
            (
                @PersonId,
                'N',
                @PersonName,
                NULL,
                @PersonLastName,
                CONCAT(@PersonName, CASE WHEN @PersonLastName IS NULL THEN N'' ELSE N' '+@PersonLastName END),
                NULL,
                @PersonPhone,
                'A',
                @CreatedBy,
                SYSDATETIME()
            );

            INSERT dbo.PersonIdentification(PersonId,IdentificationTypeId,Identification,IsPrimary,CreatedByUserId)
            VALUES(@PersonId,@ValidatedPersonIdentificationTypeId,@PersonIdentification,1,NULL);
        END

        SET @UserId = NEWID();

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
            (N'client.deactivate', N'Desactivar clientes', N'Desactiva clientes sin borrarlos', N'client');

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

        SET @UserProfileId = NEWID();

        INSERT INTO dbo.AppUser
        (
            UserId,
            PersonId,
            CompanyId,
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
            @CompanyId,
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

        INSERT INTO dbo.UserProfile
        (
            UserProfileId,
            UserId,
            CompanyId,
            ProfileId,
            Status,
            CreatedBy,
            CreatedAt
        )
        VALUES
        (
            @UserProfileId,
            @UserId,
            @CompanyId,
            @ProfileId,
            'A',
            @CreatedBy,
            SYSDATETIME()
        );

        INSERT INTO dbo.UserProfileAudit
        (
            UserId,
            CompanyId,
            ProfileId,
            OperationCode,
            Actor
        )
        VALUES
        (
            @UserId,
            @CompanyId,
            @ProfileId,
            'ASSIGN',
            @CreatedBy
        );

        COMMIT TRAN;

        SELECT
            CAST(0 AS INT) AS result_code,
            N'User and company registered successfully.' AS result_message,
            N'REGISTER' AS operation;

        SELECT
            @PersonId AS PersonId,
            @UserId AS UserId,
            @CompanyId AS CompanyId,
            @CompanyBranchId AS CompanyBranchId,
            @CompanyEmissionPointId AS CompanyEmissionPointId,
            @ProfileId AS ProfileId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH;
END;
GO
