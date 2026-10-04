/*
    Resolves and validates an identification type for all identity-creation flows.
    The physical IdentificationTypeId stays internal to the database contract.
*/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Identification_ValidateInput
(
    @IdentificationTypeCode VARCHAR(32),
    @Identification NVARCHAR(64),
    @PersonKind CHAR(1) = NULL,
    @IdentificationTypeId CHAR(2) OUTPUT,
    @NormalizedIdentification NVARCHAR(64) OUTPUT,
    @ResultCode INT OUTPUT,
    @ResultMessage NVARCHAR(250) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Status CHAR(1),
            @MinLength TINYINT,
            @MaxLength TINYINT,
            @IsNumericOnly BIT,
            @AllowsNaturalPerson BIT,
            @AllowsLegalEntity BIT;

    SET @IdentificationTypeCode = NULLIF(UPPER(LTRIM(RTRIM(@IdentificationTypeCode))), '');
    SET @PersonKind = NULLIF(UPPER(LTRIM(RTRIM(@PersonKind))), '');
    SET @IdentificationTypeId = NULL;
    SET @NormalizedIdentification = dbo.fn_NormalizeIdentification(@Identification);
    SET @ResultCode = 0;
    SET @ResultMessage = N'Identification is valid.';

    IF @IdentificationTypeCode IS NULL
    BEGIN
        SET @ResultCode = 1001;
        SET @ResultMessage = N'IdentificationTypeCode is required.';
        RETURN;
    END;

    IF @NormalizedIdentification IS NULL OR @NormalizedIdentification = N''
    BEGIN
        SET @ResultCode = 1001;
        SET @ResultMessage = N'Identification is required.';
        RETURN;
    END;

    IF @PersonKind IS NOT NULL AND @PersonKind NOT IN ('N', 'J')
    BEGIN
        SET @ResultCode = 1001;
        SET @ResultMessage = N'PersonKind is invalid.';
        RETURN;
    END;

    SELECT
        @IdentificationTypeId = it.IdentificationTypeId,
        @Status = it.Status,
        @MinLength = it.MinLength,
        @MaxLength = it.MaxLength,
        @IsNumericOnly = it.IsNumericOnly,
        @AllowsNaturalPerson = it.AllowsNaturalPerson,
        @AllowsLegalEntity = it.AllowsLegalEntity
    FROM dbo.IdentificationType it
    WHERE it.Code = @IdentificationTypeCode;

    IF @IdentificationTypeId IS NULL
    BEGIN
        SET @ResultCode = 1002;
        SET @ResultMessage = N'Identification type is not supported.';
        RETURN;
    END;

    IF @Status <> 'A'
    BEGIN
        SET @ResultCode = 2002;
        SET @ResultMessage = N'Identification type is inactive.';
        SET @IdentificationTypeId = NULL;
        RETURN;
    END;

    IF LEN(@NormalizedIdentification) NOT BETWEEN @MinLength AND @MaxLength
       OR (@IsNumericOnly = 1 AND @NormalizedIdentification LIKE N'%[^0-9]%')
       OR (@PersonKind = 'N' AND @AllowsNaturalPerson = 0)
       OR (@PersonKind = 'J' AND @AllowsLegalEntity = 0)
    BEGIN
        SET @ResultCode = 1001;
        SET @ResultMessage = N'Identification does not satisfy its configured metadata.';
        SET @IdentificationTypeId = NULL;
        RETURN;
    END;
END;
GO
