namespace Nicole.Database.Entities;

public sealed class IdentificationType
{
    public string IdentificationTypeId { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string Status { get; set; } = "A";
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
