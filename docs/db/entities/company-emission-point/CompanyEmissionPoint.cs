namespace Nicole.Database.Entities;

public sealed class CompanyEmissionPoint
{
    public Guid CompanyEmissionPointId { get; set; }
    public Guid CompanyBranchId { get; set; }
    public string EmissionPointCode { get; set; } = string.Empty;
    public string? Name { get; set; }
    public string Status { get; set; } = "A";
    public string CreatedBy { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public string? UpdatedBy { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
