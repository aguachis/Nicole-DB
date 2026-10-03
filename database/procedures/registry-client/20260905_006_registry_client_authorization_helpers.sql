/* Checks permission only through the profile selected for this session. */
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER FUNCTION dbo.fn_HasEffectivePermission
(
    @UserId uniqueidentifier,
    @CompanyId uniqueidentifier,
    @ProfileId uniqueidentifier,
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
        JOIN dbo.Company c ON c.CompanyId=u.CompanyId AND c.CompanyId=@CompanyId AND c.Status='A'
        JOIN dbo.UserProfile up ON up.UserId=u.UserId AND up.CompanyId=u.CompanyId
            AND up.ProfileId=@ProfileId AND up.Status='A'
        JOIN dbo.Profile pr ON pr.ProfileId=up.ProfileId AND pr.CompanyId=up.CompanyId AND pr.Status='A'
        JOIN dbo.ProfilePermission pp ON pp.ProfileId=pr.ProfileId AND pp.Status='A'
        JOIN dbo.Permission pm ON pm.PermissionId=pp.PermissionId AND pm.Status='A' AND pm.Code=@PermissionCode
        WHERE u.UserId=@UserId AND u.Status='A' AND u.IsBlocked=0
    ) SET @Allowed=1;
    RETURN @Allowed;
END;
GO
