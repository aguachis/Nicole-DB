namespace Nicole.Database.Entities;

public sealed class CompanyBranch
{
    public Guid CompanyBranchId { get; set; }
    public Guid CompanyId { get; set; }
    public string EstablishmentCode { get; set; } = string.Empty;
    public string? BranchName { get; set; }
    public string? Address { get; set; }
    public string? Phone { get; set; }
    public string? Email { get; set; }
    public int? City { get; set; }
    public string? Province { get; set; }
    public string Status { get; set; } = "A";
    public string CreatedBy { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public string? UpdatedBy { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
