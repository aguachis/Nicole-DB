namespace Nicole.Database.Entities;

public sealed class UserCompany
{
    public Guid UserCompanyId { get; set; }
    public Guid UserId { get; set; }
    public Guid CompanyId { get; set; }
    public string Status { get; set; } = "A";
    public string CreatedBy { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public string? UpdatedBy { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
