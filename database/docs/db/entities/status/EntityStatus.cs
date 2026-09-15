namespace Nicole.Database.Entities;

public sealed class EntityStatus
{
    public string StatusCode { get; set; } = string.Empty;
    public string StatusName { get; set; } = string.Empty;
    public string? StatusDescription { get; set; }
    public bool IsActive { get; set; }
    public byte SortOrder { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
