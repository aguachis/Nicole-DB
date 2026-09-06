/*
Script: P_Catalog_Lookup.sql
Stored Procedure: dbo.P_Catalog_Lookup
Objetivo:
    Consultar catalogos comunes usados por selects de la UI mediante una clave funcional estable.

Dependencias:
    - dbo.EntityStatus
    - dbo.IdentificationType
    - dbo.PersonType
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.P_Catalog_Lookup
(
    @CatalogKey NVARCHAR(50),
    @IncludeInactive BIT = 0
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NormalizedKey NVARCHAR(50);

    SET @NormalizedKey = UPPER(NULLIF(LTRIM(RTRIM(@CatalogKey)), ''));
    SET @IncludeInactive = ISNULL(@IncludeInactive, 0);

    IF @NormalizedKey IS NULL
    BEGIN
        SELECT
            CAST(1001 AS INT) AS result_code,
            N'CatalogKey is required.' AS result_message;
        RETURN;
    END;

    IF @NormalizedKey = N'STATUS'
    BEGIN
        SELECT
            CAST(0 AS INT) AS result_code,
            N'Query executed successfully.' AS result_message,
            N'STATUS' AS CatalogKey,
            es.StatusCode AS [Value],
            es.StatusName AS [Label],
            es.StatusDescription AS [Description],
            es.StatusCode AS [Status]
        FROM dbo.EntityStatus es
        WHERE (@IncludeInactive = 1 OR es.IsActive = 1)
        ORDER BY es.SortOrder, es.StatusName, es.StatusCode;

        RETURN;
    END;

    IF @NormalizedKey = N'IDENTIFICATION'
    BEGIN
        SELECT
            CAST(0 AS INT) AS result_code,
            N'Query executed successfully.' AS result_message,
            N'IDENTIFICATION' AS CatalogKey,
            it.IdentificationTypeId AS [Value],
            it.Name AS [Label],
            it.Description AS [Description],
            it.Status AS [Status]
        FROM dbo.IdentificationType it
        WHERE (@IncludeInactive = 1 OR it.Status = 'A')
        ORDER BY it.Name, it.IdentificationTypeId;

        RETURN;
    END;

    IF @NormalizedKey = N'PERSON_TYPE'
    BEGIN
        SELECT
            CAST(0 AS INT) AS result_code,
            N'Query executed successfully.' AS result_message,
            N'PERSON_TYPE' AS CatalogKey,
            pt.PersonTypeId AS [Value],
            pt.Name AS [Label],
            pt.Description AS [Description],
            pt.Status AS [Status]
        FROM dbo.PersonType pt
        WHERE (@IncludeInactive = 1 OR pt.Status = 'A')
        ORDER BY pt.Name, pt.PersonTypeId;

        RETURN;
    END;

    SELECT
        CAST(1001 AS INT) AS result_code,
        N'CatalogKey is not supported.' AS result_message;
END;
GO
