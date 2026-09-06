namespace Nicole.Database.Entities;

public sealed class AppUser
{
    public Guid UserId { get; set; }
    public Guid PersonId { get; set; }
    public string? Username { get; set; }
    public string PasswordHash { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public bool IsBlocked { get; set; }
    public bool RequiresNewPassword { get; set; }
    public bool MustUpdate { get; set; }
    public string Status { get; set; } = "A";
    public string CreatedBy { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public string? UpdatedBy { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
