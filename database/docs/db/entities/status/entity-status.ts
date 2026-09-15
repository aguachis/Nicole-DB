export interface EntityStatus {
  statusCode: string;
  statusName: string;
  statusDescription: string | null;
  isActive: boolean;
  sortOrder: number;
  createdAt: string;
  updatedAt: string | null;
}
