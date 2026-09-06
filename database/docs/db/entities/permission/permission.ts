export interface Permission {
  permissionId: string;
  code: string;
  name: string;
  description: string | null;
  moduleCode: string;
  status: string;
  createdBy: string;
  createdAt: string;
  updatedBy: string | null;
  updatedAt: string | null;
}
