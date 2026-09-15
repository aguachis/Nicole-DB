namespace Nicole.Database.Entities;

public sealed class ProfilePermission
{
    public Guid ProfilePermissionId { get; set; }
    public Guid ProfileId { get; set; }
    public Guid PermissionId { get; set; }
    public string Status { get; set; } = "A";
    public string CreatedBy { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public string? UpdatedBy { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
