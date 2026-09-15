/* Provider endpoints and credentials belong to backend configuration, never to this table. */
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

MERGE dbo.RegistryProvider AS target
USING (VALUES
    ('SRI_RUC',N'SRI RUC registry',CAST(NULL AS nvarchar(500)),1440),
    ('CIVIL_REGISTRY',N'Civil identity registry',CAST(NULL AS nvarchar(500)),1440)
) AS source(Code,Name,BaseUrl,DefaultCacheMinutes)
ON target.Code=source.Code
WHEN MATCHED THEN UPDATE SET Name=source.Name,BaseUrl=source.BaseUrl,
    DefaultCacheMinutes=source.DefaultCacheMinutes,IsActive=1,UpdatedAt=SYSUTCDATETIME(),UpdatedByUserId=NULL
WHEN NOT MATCHED THEN INSERT(Code,Name,BaseUrl,DefaultCacheMinutes,IsActive,CreatedAt)
    VALUES(source.Code,source.Name,source.BaseUrl,source.DefaultCacheMinutes,1,SYSUTCDATETIME());
GO
