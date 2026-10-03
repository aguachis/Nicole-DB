namespace Nicole.Database.Entities;

public sealed class UserProfile
{
    public Guid UserProfileId { get; set; }
    public Guid UserId { get; set; }
    public Guid CompanyId { get; set; }
    public Guid ProfileId { get; set; }
    public string Status { get; set; } = "A";
    public string CreatedBy { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public string? UpdatedBy { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
