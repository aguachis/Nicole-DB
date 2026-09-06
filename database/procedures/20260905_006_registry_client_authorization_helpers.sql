/* Preflight confirmed the UserCompany -> UserCompanyProfile -> ProfilePermission chain. */
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER FUNCTION dbo.fn_HasEffectivePermission
(
    @UserId uniqueidentifier,
    @CompanyId uniqueidentifier,
    @PermissionCode nvarchar(150)
)
RETURNS bit
AS
BEGIN
    DECLARE @Allowed bit=0;
    IF EXISTS
    (
        SELECT 1
        FROM dbo.AppUser u
        JOIN dbo.UserCompany uc ON uc.UserId=u.UserId AND uc.CompanyId=@CompanyId AND uc.Status='A'
        JOIN dbo.UserCompanyProfile ucp ON ucp.UserCompanyId=uc.UserCompanyId AND ucp.CompanyId=uc.CompanyId AND ucp.Status='A'
        JOIN dbo.Profile pr ON pr.ProfileId=ucp.ProfileId AND pr.CompanyId=uc.CompanyId AND pr.Status='A'
        JOIN dbo.ProfilePermission pp ON pp.ProfileId=pr.ProfileId AND pp.Status='A'
        JOIN dbo.Permission pm ON pm.PermissionId=pp.PermissionId AND pm.Status='A' AND pm.Code=@PermissionCode
        WHERE u.UserId=@UserId AND u.Status='A' AND u.IsBlocked=0
    ) SET @Allowed=1;
    RETURN @Allowed;
END;
GO
