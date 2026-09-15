namespace Nicole.Database.Entities;

public sealed class Company
{
    public Guid CompanyId { get; set; }
    public string Identification { get; set; } = string.Empty;
    public string? TradeName { get; set; }
    public string BusinessName { get; set; } = string.Empty;
    public string? Email { get; set; }
    public bool IsAccountingRequired { get; set; }
    public string? SpecialTaxpayer { get; set; }
    public string Status { get; set; } = "A";
    public Guid? RepresentativeId { get; set; }
    public Guid? ParentCompanyId { get; set; }
    public string? TaxpayerType { get; set; }
    public string? ArtisanQualification { get; set; }
    public string? Environment { get; set; }
    public string? Currency { get; set; }
    public string? Timezone { get; set; }
    public string? LanguageCode { get; set; }
    public string CreatedBy { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public string? UpdatedBy { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
