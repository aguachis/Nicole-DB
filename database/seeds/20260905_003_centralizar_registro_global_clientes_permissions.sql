/* Assign client permissions to each active ADMIN profile within its own Company. */
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

DECLARE @CreatedBy nvarchar(80)=N'registry.seed';
DECLARE @Permissions table (Code nvarchar(150) NOT NULL PRIMARY KEY, Name nvarchar(150) NOT NULL, Description nvarchar(250) NOT NULL);
INSERT @Permissions VALUES
 (N'client.read',N'Consultar clientes',N'Consulta clientes y resolución exacta dentro de la empresa autorizada'),
 (N'client.create',N'Crear clientes',N'Crea relaciones cliente por empresa'),
 (N'client.update',N'Actualizar clientes',N'Actualiza datos comerciales locales'),
 (N'client.deactivate',N'Desactivar clientes',N'Desactiva clientes sin borrarlos'),
 (N'client.verify',N'Verificar identidad fiscal',N'Permite persistir o reutilizar verificaciones de registro');

INSERT dbo.Permission(PermissionId,Code,Name,Description,ModuleCode,Status,CreatedBy,CreatedAt)
SELECT NEWID(),p.Code,p.Name,p.Description,N'client','A',@CreatedBy,SYSDATETIME()
FROM @Permissions p
WHERE NOT EXISTS (SELECT 1 FROM dbo.Permission x WHERE x.Code=p.Code);

UPDATE pm SET Name=p.Name,Description=p.Description,ModuleCode=N'client',Status='A',UpdatedBy=@CreatedBy,UpdatedAt=SYSDATETIME()
FROM dbo.Permission pm JOIN @Permissions p ON p.Code=pm.Code;

INSERT dbo.ProfilePermission(ProfilePermissionId,ProfileId,PermissionId,Status,CreatedBy,CreatedAt)
SELECT NEWID(),pr.ProfileId,pm.PermissionId,'A',@CreatedBy,SYSDATETIME()
FROM dbo.Profile pr
CROSS JOIN @Permissions wanted
JOIN dbo.Permission pm ON pm.Code=wanted.Code
WHERE pr.Status='A' AND pr.Name=N'ADMIN'
  AND NOT EXISTS (SELECT 1 FROM dbo.ProfilePermission pp WHERE pp.ProfileId=pr.ProfileId AND pp.PermissionId=pm.PermissionId);

UPDATE pp SET Status='A',UpdatedBy=@CreatedBy,UpdatedAt=SYSDATETIME()
FROM dbo.ProfilePermission pp
JOIN dbo.Profile pr ON pr.ProfileId=pp.ProfileId AND pr.Status='A' AND pr.Name=N'ADMIN'
JOIN dbo.Permission pm ON pm.PermissionId=pp.PermissionId
JOIN @Permissions wanted ON wanted.Code=pm.Code
WHERE pp.Status<>'A';
GO
